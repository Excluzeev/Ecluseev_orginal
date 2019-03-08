<template>
  <div class="home">
    <div v-show="!playerOptions.sources[0].src.isEmpty">
      <video-player
        class="vjs-custom-skin"
        ref="videoPlayer"
        :options="playerOptions"
      >
      </video-player>
    </div>
    <v-layout class="padding" align-center justify-left row fill-height>
      <div class="square">
        <img
          class="channel-image square"
          :src="trailer != null ? trailer.channelImage : ''"
        />
      </div>
      <v-layout class="padding" align-left justify-left column fill-height>
        <h2>{{ trailer.title }}</h2>
        <span class="black--text">{{ trailer.description }}</span>
        <div class="grey--text">{{ trailer.timeAgo }}</div>
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
import trailerModule from "../store/trailers/trailer";
import { fireStore, auth } from "../firebase/init";
import utils from "../firebase/utils";

export default {
  name: "CategoryTrailers",
  data: () => {
    return {
      trailer: null,
      playerOptions: {
        overNative: true,
        autoplay: false,
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
    this.registerStoreModule("trailers", trailerModule);
    this.$store
      .dispatch("trailers/fetchTrailer", {
        trailerId: this.$route.params.trailerId
      })
      .then(data => {
        this.trailer = data;
        this.playerOptions.sources[0].src = this.trailer.videoUrl;
        this.playerOptions.poster = this.trailer.image;
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
        .doc(userId + ":" + this.$route.params.trailerId + ":t")
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
        .doc(userId + ":" + this.$route.params.trailerId + ":t")
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
