<template>
  <div class="home">
    <v-layout class="main-holder" xs12 wrap>
      <v-flex xs12 sm12 md8 lg8 class="video-holder padding">
        <div v-show="!playerOptions.sources[0].src.isEmpty">
          <video-player
            class="video-holder vjs-big-play-centered"
            width="100%"
            height="auto"
            id="player_id"
            ref="videoPlayer"
            :options="playerOptions"
            @ready="playerIsReady"
            @timeupdate="onPlayerTimeupdate($event)"
          ></video-player>
        </div>
        <v-layout class="padding" align-center justify-left row fill-height>
          <v-layout class="padding" align-left justify-left column fill-height>
            <div class="title-details--text max-1-lines quick-sand-font-b">{{ video.title }}</div>
            <div class="desc-details--text">{{ video.views }} views</div>
          </v-layout>
          <v-spacer></v-spacer>
          <a>
            <div v-ripple class="like-holder" @click="updateWhat('like')">
              <v-icon v-bind:class="{ active: isUserLiked }">thumb_up</v-icon>
            </div>
          </a>
          <a>
            <div v-ripple class="like-holder" @click="updateWhat('neutral')">
              <v-icon v-bind:class="{ active: isNeutral }">sentiment_dissatisfied</v-icon>
            </div>
          </a>
          <a>
            <div v-ripple class="like-holder" @click="updateWhat('dislike')">
              <v-icon v-bind:class="{ active: isUserDisLiked }">thumb_down</v-icon>
            </div>
          </a>
        </v-layout>
        <v-divider></v-divider>

        <v-layout class="padding" justify-left fill-height>
          <div class="padding">
            <img class="channel-image square" :src="video != null ? video.channelImage : ''">
          </div>
          <v-flex class="padding">
            <v-layout align-center justify-left row>
              <v-layout align-left justify-left column fill-height>
                <h2 class="quick-sand-font-b">{{ video.channelName }}</h2>
                <span class="published--text">Published {{ video.timeAgo }}</span>
              </v-layout>
              <v-spacer></v-spacer>
            </v-layout>

            <!--Description-->
            <div class="detail-description">
              <div>{{ video.description }}</div>
            </div>
          </v-flex>
        </v-layout>

        <v-divider></v-divider>

        <!--Comments Section-->
        <div class="comment-holder padding">
          <div v-if="showComments">
            <v-textarea solo label="Add a comment" rows="1" auto-grow v-model="commentText"></v-textarea>
            <v-layout>
              <v-spacer></v-spacer>
              <v-btn
                class="white--text quick-sand-font-b"
                color="blue lighten-1"
                :disabled="disabelComment"
                @click="doComment"
              >Comment</v-btn>
            </v-layout>
          </div>
          <div v-if="!showComments">
            <div class="logincomment text-xs-center">
              <p>
                Please
                <router-link :to="{ name: 'Login' }" class="quick-sand-font-b">login</router-link>to comment
              </p>
            </div>
          </div>
          <v-flex class="padding" v-if="commentsList.length > 0">
            <div class="comment" v-for="comment in commentsList" v-bind:key="comment.commentId">
              <h4>{{ comment.userName }}</h4>
              <div>{{ comment.comment }}</div>
              <p class="grey--text">{{ comment.timeAgo }}</p>
            </div>
          </v-flex>
          <v-flex v-else text-xs-center>
            <div class="nocomment">
              <p>No comments Yet be the first to comment</p>
            </div>
          </v-flex>
        </div>
      </v-flex>
      <v-flex xs12 sm12 md4 lg4 class="linked-trailers">
        <div style="width: 100%;">
          <h2 class="quick-sand-font-n" style="padding-top: 5px;">Related Videos</h2>
          <VideoDetailVideoItem
            v-for="video in channelVideosList"
            v-bind:key="video.videoId"
            :video="video"
          />
        </div>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import videoModule from "../store/videos/video";
import { fireStore, auth, firebaseTimestamp } from "../firebase/init";
import utils from "../firebase/utils";
import axios from "axios";
import moment from "moment";
import VideoDetailVideoItem from "../components/VideoDetailVideoItem";

export default {
  name: "VideoSingle",
  data: () => {
    return {
      video: null,
      commentsList: [],
      channelVideosList: [],
      commentText: "",
      playerOptions: {
        overNative: true,
        autoplay: true,
        errorDisplay: false,
        preload: "auto",
        controls: true,
        techOrder: ["html5"],
        sourceOrder: true,
        playbackRates: [0.7, 1.0, 1.5, 2.0],
        aspectRatio: "16:9",
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
  components: {
    VideoDetailVideoItem
  },
  mixins: [RegisterStoreModule],
  computed: {
    player() {
      return this.$refs.videoPlayer.player;
    },
    disabelComment() {
      return this.commentText == "";
    },
    showComments() {
      auth.onAuthStateChanged(user => {});
      return auth.currentUser != null;
    }
  },
  mounted() {},
  created() {
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

            this.$store
              .dispatch("videos/getUserChannelVideos", {
                channelId: this.video.channelId
              })
              .then(videosList => {
                this.channelVideosList = videosList;
              });
          })
          .catch(error => {
            // console.log(error);
          });

        this.getLikes();

        this.getComments();
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
              return;
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
    },
    async doComment() {
      let fUser = JSON.parse(
        localStorage.getItem("fUser") != null
          ? localStorage.getItem("fUser")
          : {}
      );

      let commentId = utils.generateId();

      let data = {
        comment: this.commentText,
        userPhoto: fUser.userPhoto == undefined ? "" : fUser.userPhoto,
        createdDate: firebaseTimestamp.fromDate(new Date()),
        channelName: this.video.channelName,
        channelId: this.video.channelId,
        userId: fUser.uid,
        userName: fUser.firstName + " " + fUser.lastName,
        vtId: this.video.videoId,
        commentId: commentId
      };

      let commentRef = fireStore
        .collection(utils.videosCollection)
        .doc(this.video.videoId)
        .collection(utils.commentsCollections)
        .doc(commentId);

      await commentRef.set(data);

      this.commentText = "";
    },
    async getComments() {
      let commentRef = fireStore
        .collection(utils.videosCollection)
        .doc(this.$route.params.videoId)
        .collection(utils.commentsCollections)
        .orderBy("createdDate", "desc")
        .limit(50);

      // let commentData = await commentRef.get();

      commentRef.onSnapshot(querySnapshot => {
        let commentsList = [];
        querySnapshot.forEach(function(doc) {
          let d = doc.data();
          d.timeAgo = moment(d.createdDate.toDate()).fromNow();
          commentsList.push(d);
        });
        this.commentsList = commentsList;
      });
    }
  }
};
</script>

<style scoped lang="scss">
.main-holder {
  align-items: flex-start;
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
.published--text {
  color: rgba(17, 17, 17, 0.6);
}
.detail-description {
}
.linked-trailers {
  padding-left: 10px;
  padding-right: 10px;
}
.v-text-field__details {
  display: none;
}
</style>
