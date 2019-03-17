<template>
  <div class="home">
    <div v-show="!playerOptions.sources[0].src.isEmpty">
      <video-player
        class="vjs-custom-skin"
        id="player_id"
        ref="videoPlayer"
        :options="playerOptions"
        @ready="playerIsReady"
        @timeupdate="onPlayerTimeupdate($event)"
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
        <div class="grey--text">
          {{ trailer.views }} views • {{ trailer.timeAgo }}
        </div>
      </v-layout>
      <v-spacer></v-spacer>
      <a>
        <div v-ripple class="like-holder" @click="updateWhat('like')">
          <v-icon x-large v-bind:class="{ active: isUserLiked }">thumb_up</v-icon>
        </div>
      </a>
      <a>
        <div v-ripple class="like-holder" @click="updateWhat('neutral')">
          <v-icon x-large v-bind:class="{ active: isNeutral }"
          >sentiment_dissatisfied</v-icon
          >
        </div>
      </a>
      <a>
        <div v-ripple class="like-holder" @click="updateWhat('dislike')">
          <v-icon x-large v-bind:class="{ active: isUserDisLiked }"
          >thumb_down</v-icon
          >
        </div>
      </a>
    </v-layout>
    <div v-if="showSubscribeButton && showDonateText">
      <v-progress-linear
        color="error"
        height="20"
        :value="(channel.targetFund * channel.currentFund) / 100"
      ></v-progress-linear>
    </div>
    <div>
      <v-layout row wrap align-end>
        <v-spacer></v-spacer>
        <v-btn
                class="white--text v-btn--round"
                color="blue lighten-1"
                :loading="subscribeProcessing"
                :disabled="subscribeProcessing"
                @click="prepareSubscribe"
                v-if="showSubscribeButton && !showDonateText"
        >
          <v-icon left light>add_to_queue</v-icon> Subscribe
          <template v-slot:loader>
          <span class="custom-loader">
            <v-icon light>cached</v-icon>
          </span>
          </template>
        </v-btn>

        <v-btn
          color="primary"
          class="white--text"
          round
          @click="prepareSubscribe(5)"
          v-if="showSubscribeButton && showDonateText"
        >
          <v-icon left>add_to_queue</v-icon>Donate 5$</v-btn
        >
        <v-btn
          color="primary"
          class="white--text"
          round
          @click="prepareSubscribe(10)"
          v-if="showSubscribeButton && showDonateText"
        >
          <v-icon left>add_to_queue</v-icon>Donate 10$</v-btn
        >
      </v-layout>
    </div>
  </div>
</template>

<script>
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import trailerModule from "../store/trailers/trailer";
import { fireStore, auth } from "../firebase/init";
import utils from "../firebase/utils";
import axios from "axios";

import "videojs-ima/dist/videojs.ima";
import "videojs-ima/dist/videojs.ima.css";

export default {
  name: "CategoryTrailers",
  data: () => {
    return {
      trailer: null,
      channel: null,
      showSubscribeButton: false,
      showDonateText: false,
      isViewTriggered: false,
      subscribeProcessing: false,
      playerOptions: {
        overNative: true,
        controls: true,
        autoplay: true,
        errorDisplay: false,
        preload: "auto",
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

        if(user != null && user.uid == this.trailer.userId) {
          this.showSubscribeButton = false;
        }
        this.getLikes();
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
