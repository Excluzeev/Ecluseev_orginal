<template>
  <v-container grid-list-md text-xs-center>
    <v-layout row>
      <v-flex xs2>
        <div align="left">
          <v-icon color="teal darken-2" x-large dark>account_circle</v-icon>
          <div style="font-size:1.4rem" class="quick-sand-font-l">
            VJ Pranay
          </div>
        </div>
      </v-flex>
      <v-flex xs10>
        <div align="left">
          <div class="flex display-1 font-weight-normal">
            Free software is vital! Its more then human right!!
          </div>
          <div class="nav-c t1824">
            The free software movement (FSM) or free/open-source software
            movement (FOSSM) or free/libre open-source software movement
            (FLOSSM)
          </div>
        </div>
      </v-flex>
      <v-flex xs3> </v-flex>
    </v-layout>
    <v-layout row> </v-layout>
    <v-layout row>
      <v-flex xs8>
        <iframe
          src="https://player.vimeo.com/video/153239711"
          width="750"
          height="480"
          frameborder="0"
          webkitallowfullscreen
          mozallowfullscreen
          allowfullscreen
        ></iframe>
      </v-flex>
      <v-flex>
        <v-spacer></v-spacer>
      </v-flex>
      <v-flex xs4>
        <v-progress-linear
          color="teal"
          height="5"
          value="30"
        ></v-progress-linear>
        <div align="left">
          <div
            style="font-size:1.4rem;"
            class="flex display-1 font-weight-normal teal--text darken-2"
          >
            US$ 278,418
          </div>
          <p class="nav-c t1824">pledged of US$ 250,000 goal</p>
          <p class="nav-c flex d-flex align-start display-1 font-weight-thin">
            7,268
          </p>
          <p class="nav-c t1824">backers</p>
          <p class="nav-c flex d-flex align-start display-1 font-weight-thin">
            13
          </p>
          <p class="nav-c t1824">days to go</p>
          <v-btn block class="quick-sand-font-b white--text" color="teal"
            >Donate 25$</v-btn
          >
          <v-btn block class="quick-sand-font-b white--text" color="teal"
            >Donate 50$</v-btn
          >
          <v-btn block class="quick-sand-font-b white--text" color="teal"
            >Donate 100$</v-btn
          >
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
  name: "CrowdFunding",
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
        userPhoto: fUser.userPhoto,
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
