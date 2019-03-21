<template>
  <div class="home">
    <v-layout class="main-holder" xs12>
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
          >
          </video-player>
        </div>
        <v-layout class="padding" align-center justify-left row fill-height>
          <v-layout class="padding" align-left justify-left column fill-height>
            <div class="title-details--text max-1-lines quick-sand-font-b">
              {{ trailer.title }}
            </div>
            <div class="desc-details--text">{{ trailer.views }} views</div>
          </v-layout>
          <v-spacer></v-spacer>
          <a>
            <div v-ripple class="like-holder" @click="updateWhat('like')">
              <v-icon v-bind:class="{ active: isUserLiked }">thumb_up</v-icon>
            </div>
          </a>
          <a>
            <div v-ripple class="like-holder" @click="updateWhat('neutral')">
              <v-icon v-bind:class="{ active: isNeutral }"
                >sentiment_dissatisfied</v-icon
              >
            </div>
          </a>
          <a>
            <div v-ripple class="like-holder" @click="updateWhat('dislike')">
              <v-icon v-bind:class="{ active: isUserDisLiked }"
                >thumb_down</v-icon
              >
            </div>
          </a>
        </v-layout>
        <v-divider></v-divider>

        <div v-if="showSubscribeButton && showDonateText">
          <v-progress-linear
            color="error"
            height="20"
            :value="(channel.targetFund * channel.currentFund) / 100"
          ></v-progress-linear>
        </div>

        <v-layout class="padding" justify-left fill-height>
          <div class="padding">
            <img
              class="channel-image square"
              :src="trailer != null ? trailer.channelImage : ''"
            />
          </div>
          <v-flex class="padding">
            <v-layout align-center justify-left row>
              <v-layout align-left justify-left column fill-height>
                <h2 class="quick-sand-font-b">{{ trailer.channelName }}</h2>
                <span class="published--text"
                  >Published {{ trailer.timeAgo }}</span
                >
              </v-layout>
              <v-spacer></v-spacer>

              <!--Subscribe and Donate Buttons-->
              <div>
                <v-layout row wrap align-end>
                  <v-spacer></v-spacer>
                  <v-btn
                    class="white--text"
                    color="blue lighten-1"
                    :loading="subscribeProcessing"
                    :disabled="subscribeProcessing"
                    @click="prepareSubscribe"
                    v-if="showSubscribeButton && !showDonateText"
                  >
                    Subscribe &nbsp;<strong> ${{ channel.price }}</strong>
                    <template v-slot:loader>
                      <span class="custom-loader">
                        <v-icon light>cached</v-icon>
                      </span>
                    </template>
                  </v-btn>

                  <v-btn
                    class="white--text"
                    color="blue lighten-1"
                    :loading="donate5Processing"
                    :disabled="donate5Processing"
                    @click="prepareSubscribe(5)"
                    v-if="showSubscribeButton && showDonateText"
                  >
                    <v-icon left light>attach_money</v-icon> Donate 5$
                    <template v-slot:loader>
                      <span class="custom-loader">
                        <v-icon light>cached</v-icon>
                      </span>
                    </template>
                  </v-btn>

                  <v-btn
                    class="white--text"
                    color="blue lighten-1"
                    :loading="donate10Processing"
                    :disabled="donate10Processing"
                    @click="prepareSubscribe(10)"
                    v-if="showSubscribeButton && showDonateText"
                  >
                    <v-icon left light>attach_money</v-icon> Donate 10$
                    <template v-slot:loader>
                      <span class="custom-loader">
                        <v-icon light>cached</v-icon>
                      </span>
                    </template>
                  </v-btn>
                </v-layout>
              </div>
            </v-layout>

            <!--Description-->
            <div class="detail-description">
              <div>{{ trailer.description }}</div>
            </div>
          </v-flex>
        </v-layout>

        <v-divider></v-divider>

        <!--Comments Section-->
        <div class="comment-holder padding">
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
      <v-flex xs12 sm12 md4 lg4 class="linked-trailers">
        <div style="width: 100%;">
          <h2 class="quick-sand-font-n" style="padding-top: 5px;">
            Related Trailers
          </h2>
          <TrailerDetailVideoItem
            v-for="trailer in catTrailersList"
            v-bind:key="trailer.trailerId"
            :trailer="trailer"
          />
        </div>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import trailerModule from "../store/trailers/trailer";
import { fireStore, auth, firebaseTimestamp } from "../firebase/init";
import utils from "../firebase/utils";
import axios from "axios";
import TrailerDetailVideoItem from "../components/TrailerDetailVideoItem";
import moment from "moment";
import "videojs-ima/dist/videojs.ima";
import "videojs-ima/dist/videojs.ima.css";

export default {
  name: "CategoryTrailers",
  data: () => {
    return {
      trailer: null,
      channel: null,
      catTrailersList: null,
      showSubscribeButton: false,
      showDonateText: false,
      isViewTriggered: false,
      subscribeProcessing: false,
      donate5Processing: false,
      donate10Processing: false,
      commentsList: [],
      commentText: "",
      playerOptions: {
        overNative: true,
        controls: true,
        autoplay: true,
        errorDisplay: false,
        preload: "auto",
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
    TrailerDetailVideoItem
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
    console.log(
      "this is current player instance object " + this.$refs.videoPlayer.player
    );
  },
  created() {
    this.registerStoreModule("trailers", trailerModule);
    this.$store
      .dispatch("trailers/fetchTrailer", {
        trailerId: this.$route.params.trailerId
      })
      .then(data => {
        this.trailer = data;

        this.$store
          .dispatch("trailers/fetchChannel", {
            channelId: this.trailer.channelId
          })
          .then(data => {
            this.channel = data;
            this.showDonateText = data.channelType != "VOD";
          });

        this.$store
          .dispatch("trailers/fetchCategoryTrailersTop10", {
            categoryId: this.trailer.categoryId
          })
          .then(catTrailersList => {
            this.catTrailersList = catTrailersList;
          });

        this.playerOptions.sources[0].src = this.trailer.videoUrl;
        this.playerOptions.poster = this.trailer.image;
        let fUser = localStorage.getItem("fUser");
        let user = null;
        if (data != null) {
          try {
            user = JSON.parse(fUser);
          } catch (e) {
            user = null;
          }
        }
        if (user != null && user.subscribedChannels != undefined) {
          this.showSubscribeButton = !user.subscribedChannels.includes(
            this.trailer.channelId
          );
        } else {
          this.showSubscribeButton = true;
        }

        if (user != null && user.uid == this.trailer.userId) {
          this.showSubscribeButton = false;
        }
        this.getLikes();
        this.getComments();
      });
  },
  methods: {
    playerIsReady(player) {
      // TODO(Karthik): Modify the adTagUrl
      let options = {
        id: player.id_,
        adTagUrl:
          "http://pubads.g.doubleclick.net/gampad/ads?sz=640x480&iu=/124319096/external/ad_rule_samples&ciu_szs=300x250&ad_rule=1&impl=s&gdfp_req=1&env=vp&output=xml_vmap1&unviewed_position_start=1&cust_params=sample_ar%3Dpremidpostpod%26deployment%3Dgmf-js&cmsid=496&vid=short_onecue&correlator="
      };

      player.ima(options);
    },
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
      if (auth.currentUser == null) {
        this.$router.push({ name: "Login" });
        return;
      }
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
    },
    async prepareSubscribe(donate) {
      if (auth.currentUser == null) {
        this.$router.push({ name: "Login" });
        return;
      }
      let prepareOptions = {
        channelId: this.trailer.channelId,
        channelName: this.trailer.channelName,
        userId: auth.currentUser.uid,
        isDesktop: true,
        redirectTo: "https://excluzeev.com/my-channels"
      };
      this.subscribeProcessing = true;
      if (this.showDonateText) {
        prepareOptions.donate = donate;
      }

      axios
        .post(
          "https://us-central1-trenstop-2033f.cloudfunctions.net/generatePayKey",
          prepareOptions
        )
        .then(response => {
          console.log(response.data);
          if (response.data.responseEnvelope.ack != "Success") {
            this.subscribeProcessing = false;
            this.showToast("Payment Failed Please try later.");
          } else {
            window.location =
              "https://www.sandbox.paypal.com/webapps/adaptivepayment/flow/pay?paykey=" +
              response.data.payKey;
          }
        })
        .catch(error => {
          this.subscribeProcessing = false;
          console.log(error);
        });
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
        .collection(utils.trailerCollection)
        .doc(this.trailer.trailerId);
      fireStore
        .runTransaction(transaction => {
          // This code may get re-run multiple times if there are conflicts.
          return transaction.get(videoRef).then(vData => {
            if (!vData.exists) {
              // throw "Document does not exist!";
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

      if (fUser == null) {
      }

      let commentId = utils.generateId();

      let data = {
        comment: this.commentText,
        userPhoto: fUser.userPhoto,
        createdDate: firebaseTimestamp.fromDate(new Date()),
        channelName: this.channel.title,
        channelId: this.channel.channelId,
        userId: fUser.uid,
        userName: fUser.firstName + " " + fUser.lastName,
        vtId: this.trailer.trailerId,
        commentId: commentId
      };

      let commentRef = fireStore
        .collection(utils.videosCollection)
        .doc(this.trailer.trailerId)
        .collection(utils.commentsCollections)
        .doc(commentId);

      await commentRef.set(data);

      this.commentText = "";
    },
    async getComments() {
      let commentRef = fireStore
        .collection(utils.videosCollection)
        .doc(this.trailer.trailerId)
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
/*@media only screen and (min-width: 768px) {*/
/*.video-holder {*/
/*min-height: 50%;*/
/*}*/
/*.video-js {*/
/*min-height: 50%;*/
/*}*/
/*}*/
</style>
