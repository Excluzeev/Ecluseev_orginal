<template>
  <v-container grid-list-md text-xs-center>
    <v-layout row>
      <v-flex xs2>
        <div align="left">
          <div class="padding">
            <v-avatar tile="false" size="50px" color="grey lighten-4">
              <img
                class="channel-image"
                :src="video != null ? video.channelImage : ''"
              />
            </v-avatar>
          </div>
          <div style="font-size:1.4rem" class="quick-sand-font-l">
            {{ video.channelName }}
          </div>
        </div>
      </v-flex>
      <v-flex xs10>
        <div align="left">
          <div class="flex display-1 font-weight-normal">
            {{ video.title }}
          </div>
          <div class="nav-c t1824">
            {{ video.description }}
          </div>
        </div>
      </v-flex>
      <v-flex xs3> </v-flex>
    </v-layout>
    <v-layout row> </v-layout>
    <v-layout row>
      <v-flex xs8>
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
          >
          </video-player>
        </div>
      </v-flex>
      <v-flex>
        <v-spacer></v-spacer>
      </v-flex>
      <v-flex xs4>
        <v-progress-linear
          color="teal"
          height="5"
          :value="(channel.currentFund / channel.targetFund ) * 100"
        ></v-progress-linear>
        <div align="left">
          <div
            style="font-size:1.4rem;"
            class="flex display-1 font-weight-normal teal--text darken-2"
          >
            US$ {{ channel.currentFund }}
          </div>
          <p class="nav-c t1824">
            pledged of US$ {{ channel.targetFund }} goal
          </p>
          <p class="nav-c flex d-flex align-start display-1 font-weight-thin">
            {{ channel.subscriberCount }}
          </p>
          <p class="nav-c t1824">backers</p>
          <!--<p class="nav-c flex d-flex align-start display-1 font-weight-thin">-->
          <!--13-->
          <!--</p>-->
          <!--<p class="nav-c t1824">days to go</p>-->
          <v-btn
            block
            class="quick-sand-font-b white--text"
            color="teal"
            @click="prepareSubscribe(25)"
            >Donate 25$</v-btn
          >
          <v-btn
            block
            class="quick-sand-font-b white--text"
            color="teal"
            @click="prepareSubscribe(50)"
            >Donate 50$</v-btn
          >
          <v-btn
            block
            class="quick-sand-font-b white--text"
            color="teal"
            @click="prepareSubscribe(100)"
            >Donate 100$</v-btn
          >
        </div>
      </v-flex>
    </v-layout>
    <v-layout>
      <!--Comments Section-->
      <v-flex xs12>
        <div class="comment-holder padding text-xs-left">
          <div v-if="showComments">
            <v-textarea
              solo
              label="Add a comment"
              rows="1"
              auto-grow
              v-model="commentText"
            ></v-textarea>
            <v-layout>
              <v-spacer></v-spacer>
              <v-btn
                class="white--text quick-sand-font-b"
                color="blue lighten-1"
                :disabled="disabelComment"
                @click="doComment"
              >
                Comment
              </v-btn>
            </v-layout>
          </div>
          <div v-if="!showComments">
            <div class="logincomment text-xs-center">
              <p>
                Please
                <router-link :to="{ name: 'Login' }" class="quick-sand-font-b"
                  >sign in</router-link
                >
                to comment
              </p>
            </div>
          </div>
          <v-flex class="padding" v-if="commentsList.length > 0">
            <div
              class="comment"
              v-for="comment in commentsList"
              v-bind:key="comment.commentId"
            >
              <h4>{{ comment.userName }}</h4>
              <div>{{ comment.comment }}</div>
              <p class="grey--text">{{ comment.timeAgo }}</p>
            </div>
          </v-flex>
          <v-flex v-else text-xs-center>
            <div class="nocomment">
              <p>No comments yet, be the first</p>
            </div>
          </v-flex>
        </div>
      </v-flex>
    </v-layout>
  </v-container>
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
  name: "CrowdFundingVideo",
  data: () => {
    return {
      video: null,
      channel: null,
      showDonateText: true,
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
  mounted() {
    console.log("this is current player instance object", this.player);
  },
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
              .dispatch("videos/fetchChannel", {
                channelId: this.video.channelId
              })
              .then(data => {
                this.channel = data;
                this.showDonateText = data.channelType != "VOD";
              });

            this.$store
              .dispatch("videos/getUserChannelVideos", {
                channelId: this.video.channelId
              })
              .then(videosList => {
                this.channelVideosList = videosList;
              });
          })
          .catch(error => {
            console.log(error);
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
      console.log(this.commentText);

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
        console.log(this.commentsList);
      });
    }
  }
};
</script>

<style scoped></style>
