<template>
  <div class="home">
    <div v-show="!playerOptions.sources[0].src.isEmpty">
      <video-player
        class="vjs-custom-skin"
        ref="videoPlayer"
        :options="playerOptions"
        @timeupdate="onPlayerTimeupdate($event)"
      >
      </video-player>
    </div>
    <v-layout class="padding" align-center justify-left row fill-height>
      <div class="square">
        <img
          class="channel-image square"
          :src="video != null ? video.channelImage : ''"
        />
      </div>
      <v-layout class="padding" align-left justify-left column fill-height>
        <h2>{{ video.title }}</h2>
        <span class="black--text">{{ video.description }}</span>
        <div class="grey--text">
          {{ video.views }} views • {{ video.timeAgo }}
        </div>
      </v-layout>
      <v-spacer></v-spacer>
      <div v-ripple class="like-holder" @click="updateWhat('like')">
        <v-icon x-large v-bind:class="{ active: isUserLiked }">thumb_up</v-icon>
      </div>
      <div v-ripple class="like-holder" @click="updateWhat('neutral')">
        <v-icon x-large v-bind:class="{ active: isNeutral }"
          >sentiment_dissatisfied</v-icon
        >
      </div>
      <div v-ripple class="like-holder" @click="updateWhat('dislike')">
        <v-icon x-large v-bind:class="{ active: isUserDisLiked }"
          >thumb_down</v-icon
        >
      </div>
    </v-layout>
  </div>
</template>

<script>
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import videoModule from "../store/videos/video";
import { fireStore, auth } from "../firebase/init";
import utils from "../firebase/utils";
import axios from "axios";

export default {
  name: "VideoSingle",
  data: () => {
    return {
      video: null,
      playerOptions: {
        overNative: true,
        autoplay: true,
        errorDisplay: false,
        preload: "auto",
        controls: true,
        techOrder: ["html5"],
        sourceOrder: true,
        playbackRates: [0.7, 1.0, 1.5, 2.0],
        html5: { hls: { withCredentials: false } },
        sources: [
          {
            withCredentials: false,
            type: "application/x-mpegURL",
            src: ""
          }
        ],
        poster: ""
      },
      isUserLiked: false,
      isUserDisLiked: false,
      isNeutral: false,
      prevWhat: -2
    };
  },
  components: {},
  mixins: [RegisterStoreModule],
  computed: {
    player() {
      return this.$refs.videoPlayer.player;
    }
  },
  mounted() {
    console.log("this is current player instance object", this.player);
  },
  created() {
    console.log(this.$route.params.videoId);
    this.registerStoreModule("videos", videoModule);
    this.$store
      .dispatch("videos/fetchVideo", {
        videoId: this.$route.params.videoId
      })
      .then(vData => {
        axios
          .post(
            "https://us-central1-trenstop-2033f.cloudfunctions.net/videoWebHook",
            {
              videoId: vData.videoId,
              playbackId: vData.playbackId
            }
          )
          .then(response => {
            this.playerOptions.sources[0].src = response.data;
            this.video = vData;
            this.playerOptions.poster = this.video.image;
          })
          .catch(error => {
            console.log(error);
          });

        this.getLikes();
      });
  },
  methods: {
    async getLikes() {
      if (auth.currentUser == null) {
        return;
      }
      let userId = auth.currentUser.uid;
      let snap = await fireStore
        .collection(utils.likesCollection)
        .doc(userId + ":" + this.$route.params.videoId + ":v")
        .get();
      if (snap.exists) {
        let data = snap.data();
        this.prevWhat = data.what;
        if (data.what == 0) {
          this.isNeutral = true;
        } else if (data.what == 1) {
          this.isUserLiked = true;
        } else if (data.what == 1) {
          this.isUserDisLiked = true;
        }
      }
    },
    async updateWhat(newWhat) {
      let what = 0;
      if (newWhat == "like") {
        what = 1;
      }
      if (newWhat == "dislike") {
        what = -1;
      }
      if (newWhat == "neutral") {
        what = 0;
      }
      if (auth.currentUser == null) {
        return;
      }
      let userId = auth.currentUser.uid;
      let whatDoc = await fireStore
        .collection(utils.likesCollection)
        .doc(userId + ":" + this.$route.params.videoId + ":t")
        .get();
      if (whatDoc.exists) {
        await whatDoc.ref.update({
          what: what
        });
      } else {
        await whatDoc.ref.set({
          what: what
        });
      }

      if (what == 0) {
        this.isNeutral = true;
        this.isUserDisLiked = false;
        this.isUserLiked = false;
      }

      if (what == 1) {
        this.isNeutral = false;
        this.isUserDisLiked = false;
        this.isUserLiked = true;
      }

      if (what == -1) {
        this.isNeutral = false;
        this.isUserDisLiked = true;
        this.isUserLiked = false;
      }
    },
    showToast(msg) {
      this.$toasted.show(msg, {
        theme: "outline",
        position: "top-right",
        duration: 2000
      });
    },

    async triggerVideoView() {
      let videoRef = fireStore
        .collection(utils.videosCollection)
        .doc(this.video.videoId);
      fireStore
        .runTransaction(transaction => {
          // This code may get re-run multiple times if there are conflicts.
          return transaction.get(videoRef).then(vData => {
            if (!vData.exists) {
              return
            }
            let views = vData.data().views;
            if (views == undefined || views == null) {
              views = 0;
            }
            views = views + 1;

            transaction.update(videoRef, { views: views });
          });
        })
        .then(() => {
          // console.log("Transaction successfully committed!");
        })
        .catch(error => {
          // console.log("Transaction failed: ", error);
        });
    },
    onPlayerTimeupdate(event) {
      if (
        this.$refs.videoPlayer.player.currentTime() > 5 &&
        !this.isViewTriggered
      ) {
        this.triggerVideoView();
        this.isViewTriggered = true;
      }
    }
  }
};
</script>

<style scoped lang="scss">
.home {
  background-color: #ffffff;
}
.channel-image {
  border-radius: 50%;
  object-fit: cover;
}
.square {
  width: 64px;
  height: 64px;
}
.padding {
  padding: 10px;
}
.like-holder {
  padding: 10px;
}
.active {
  color: #42a5f5;
}
</style>
