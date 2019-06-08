<template>
  <v-container grid-list-md text-xs-center>
    <v-layout row wrap>
      <v-flex xs12 sm3 md2>
        <div align="left">
          <div class="padding">
            <v-avatar :tile="tile" size="50px" color="grey lighten-4">
              <img
                alt="avatar"
                class="channel-image"
                :src="trailer != null ? trailer.channelImage : ''"
              >
            </v-avatar>
          </div>
          <div style="font-size:1.4rem" class="quick-sand-font-l">{{ trailer.channelName }}</div>
        </div>
      </v-flex>
      <v-flex xs12 sm9 md10>
        <div align="left">
          <div class="flex display-1 font-weight-normal">{{ trailer.title }}</div>
          <div class="nav-c t1824">{{ trailer.description }}</div>
        </div>
      </v-flex>
    </v-layout>
    <v-layout row></v-layout>
    <v-layout row wrap>
      <v-flex xs12 md8>
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
      </v-flex>
      <v-flex>
        <v-spacer></v-spacer>
      </v-flex>
      <v-flex xs12 md3>
        <v-progress-linear
          color="teal"
          height="5"
          :value="(channel.targetFund * channel.currentFund) / 100"
        ></v-progress-linear>
        <div align="left">
          <div
            style="font-size:1.4rem;"
            class="flex display-1 font-weight-normal teal--text darken-2"
          >US$ {{ channel.currentFund }}</div>
          <p class="nav-c t1824">pledged of US$ {{ channel.targetFund }} goal</p>
          <p
            class="nav-c flex d-flex align-start display-1 font-weight-thin"
          >{{ channel.subscriberCount }}</p>
          <p class="nav-c t1824">backers</p>
          <!--<p class="nav-c flex d-flex align-start display-1 font-weight-thin">-->
          <!--13-->
          <!--</p>-->
          <!--<p class="nav-c t1824">days to go</p>-->
        </div>
        <div xs12 row wrap v-if="channel != null">
          <v-expansion-panel
            class="margin"
            popout
            xs12
            v-for="tier in channel.tiers"
            v-bind:key="tier"
          >
            <v-expansion-panel-content>
              <template v-slot:header class="card-shadow">
                <div class="headline">Join {{tier.tier}}</div>
              </template>
              <v-card color="primary darken-2" class="white--text">
                <v-card-title primary-title>
                  <div>
                    <span>{{tier.description}}</span>
                  </div>
                </v-card-title>
                <v-card-text>
                  <v-btn
                    block
                    class="quick-sand-font-b white--text"
                    color="teal"
                    @click="checkout(tier.price)"
                  >{{tier.tier}} - {{tier.price}}$</v-btn>
                </v-card-text>
              </v-card>
            </v-expansion-panel-content>
          </v-expansion-panel>
        </div>
      </v-flex>
    </v-layout>

    <vue-stripe-checkout
      ref="checkoutRef"
      name="Donate to Community"
      description
      currency="CAD"
      :amount="donateAmount * 100"
      :allow-remember-me="false"
      @done="done"
      @opened="opened"
      @closed="closed"
      @canceled="canceled"
    ></vue-stripe-checkout>

    <v-layout>
      <!--Comments Section-->
      <v-flex xs12>
        <div class="comment-holder padding text-xs-left">
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
                <router-link :to="{ name: 'Login' }" class="quick-sand-font-b">sign in</router-link>to comment
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
import trailerModule from "../store/trailers/trailer";
import { fireStore, auth, firebaseTimestamp } from "../firebase/init";
import utils from "../firebase/utils";
import axios from "axios";
import moment from "moment";
import TrailerDetailVideoItem from "../components/TrailerDetailVideoItem";

export default {
  name: "CrowdFundingTrailer",
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
      donateAmount: 0,
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
    // console.log(
    //   "this is current player instance object " + this.$refs.videoPlayer.player
    // );
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
    async checkout(donate) {
      this.donateAmount = donate;
      // token - is the token object
      // args - is an object containing the billing and shipping address if enabled
      console.log("Checkout");
      const { token, args } = await this.$refs.checkoutRef.open();
      console.log(token);
      console.log(args);
    },
    done({ token, args }) {
      // token - is the token object
      // args - is an object containing the billing and shipping address if enabled
      // do stuff...
      console.log(token);
      console.log(args);
      this.prepareSubscribe(this.donateAmount, token);
    },
    opened() {
      // do stuff
      console.log("opened");
    },
    closed() {
      // do stuff
      console.log("Closed");
    },
    canceled() {
      // do stuff
      console.log("Canceled");
    },
    playerIsReady(player) {
      // TODO(Karthik): Modify the adTagUrl
      // let options = {
      //   id: player.id_,
      //   adTagUrl:
      //     "http://pubads.g.doubleclick.net/gampad/ads?sz=640x480&iu=/124319096/external/ad_rule_samples&ciu_szs=300x250&ad_rule=1&impl=s&gdfp_req=1&env=vp&output=xml_vmap1&unviewed_position_start=1&cust_params=sample_ar%3Dpremidpostpod%26deployment%3Dgmf-js&cmsid=496&vid=short_onecue&correlator="
      // };
      //
      // player.ima(options);
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
    async prepareSubscribe(donate, token) {
      if (auth.currentUser == null) {
        this.$router.push({ name: "Login" });
        return;
      }
      let prepareOptions = {
        channelId: this.trailer.channelId,
        channelName: this.trailer.channelName,
        userId: auth.currentUser.uid,
        isDesktop: true,
        redirectTo: "https://excluzeev.com/my-channels",
        isDonate: true,
        token: token.id
      };
      this.subscribeProcessing = true;
      if (this.showDonateText) {
        prepareOptions.donate = donate;
      }

      axios
        .post(
          "https://us-central1-trenstop-2033f.cloudfunctions.net/chargeAmount",
          prepareOptions
        )
        .then(response => {
          if (response.data.error) {
            this.subscribeProcessing = false;
            this.showToast("Payment Failed Please try later.");

            window.location =
              "https://us-central1-trenstop-2033f.cloudfunctions.net/pagePaymentCanceled?subId=" +
              response.data.subId +
              "&donate=" +
              this.showDonateField +
              "&redirect=https://excluzeev.com/";
          } else {
            window.location =
              "https://us-central1-trenstop-2033f.cloudfunctions.net/pagePaymentSuccess?subId=" +
              response.data.subId +
              "&donate=" +
              this.showDonateField +
              "&redirect=https://excluzeev.com/my-channels";
          }
        })
        .catch(error => {
          this.subscribeProcessing = false;
          // console.log(error);
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
        userPhoto: fUser.userPhoto == undefined ? "" : fUser.userPhoto,
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

<style scoped>
.margin {
  margin: 5px 2px;
}
.card-shadow {
  box-shadow: 0px 3px 3px -2px rgba(0, 0, 0, 0.2),
    0px 3px 4px 0px rgba(0, 0, 0, 0.14), 0px 1px 8px 0px rgba(0, 0, 0, 0.12);
}
</style>
