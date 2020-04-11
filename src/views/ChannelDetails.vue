<template>
  <v-container v-if="channel != null">
    <img
      :src="
        'https://firebasestorage.googleapis.com/v0/b/trenstop-public/o/channels%2F' +
          channel.channelId +
          '%2Fcover.jpg?alt=media'
      "
      style="width: 100%; height: 150px; object-fit: cover;"
    >
    <v-layout row wrap xs12 text-xs-center class="padding">
      <v-avatar :tile="tile" size="100px" color="grey lighten-4">
        <img
          :src="
            'https://firebasestorage.googleapis.com/v0/b/trenstop-public/o/channels%2F' +
              channelId +
              '%2Fthumbnail.jpg?alt=media'
          "
          alt="avatar"
        >
      </v-avatar>
      <div class="channel-details padding">
        <h2 class="quick-sand-font-b">{{ channel.title }}</h2>
        <p class="subscribers-count">
          {{
          channel.views == undefined ? 0 : channel.views
          }}
          Views
        </p>
      </div>
      <v-spacer></v-spacer>
    </v-layout>
    <div v-if="!(trailersList.length == 0)">
      <h1 class="quick-sand-font-b">Previews</h1>
      <br>
      <v-layout xs12 row wrap>
        <v-flex
          class="trailer-item"
          xs12
          sm4
          md3
          lg2
          v-for="trailer in trailersList"
          v-bind:key="trailer.trailerId"
        >
          <TrailerVideoItem :trailer="trailer" v-on:trailerDelete="onTrailerDeleted"/>
        </v-flex>
      </v-layout>
    </div>
    <div class="padding"></div>
    <div v-if="!(videosList.length == 0)">
      <h1 class="quick-sand-font-b">Videos</h1>
      <br>
      <v-layout xs12 row wrap>
        <v-flex
          class="video-item"
          xs12
          sm4
          md3
          lg2
          v-for="video in videosList"
          v-bind:key="video.videoId"
        >
          <VideosVideoItem :video="video" v-on:videoDelete="onVideoDeleted"/>
        </v-flex>
      </v-layout>
    </div>
    <v-layout row justify-center>
      <v-dialog v-model="donateDialog" max-width="500">
        <v-card class="donate-dialog">
          <h2 class="quick-sand-font-n" style="padding-top: 5px;">Donate</h2>

          <div xs12 row wrap v-if="channel != null">
            <v-text-field
              v-model="priceDonate"
              label="Donate Amount"
              :value="priceDonate"
              type="number"
              prefix="$"
              :rules="[rules.required]"
            ></v-text-field>
            <v-btn
              class="white--text"
              color="blue lighten-1"
              type="submit"
              @click="checkout(priceDonate)"
            >Doante</v-btn>
            <!-- <v-expansion-panel
              class="margin"
              popout
              xs12
              v-for="(tier,index) in channel.tiers"
              v-bind:key="index"
            >
              <v-expansion-panel-content>
                <template v-slot:header class="card-shadow">
                  <div class="headline">Join {{tier.tier}}</div>
                </template>
                <v-card color class>
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
            </v-expansion-panel>-->
          </div>
        </v-card>
      </v-dialog>
    </v-layout>
    <vue-stripe-checkout
      ref="checkoutRef"
      :name="'Payment Details'"
      description
      currency="CAD"
      :amount="donateAmount * 100"
      :allow-remember-me="false"
      @done="done"
      @opened="opened"
      @closed="closed"
      @canceled="canceled"
    ></vue-stripe-checkout>
  </v-container>
</template>

<script>
import TrailerVideoItem from "../components/TrailerVideoItem";
import VideosVideoItem from "../components/VideosVideoItem";
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import channelsModule from "../store/channels/channels";
import { fireStore, firebaseTimestamp, auth } from "../firebase/init";
import utils from "../firebase/utils";
import moment from "moment";

export default {
  name: "SubscribedChannelDetails",
  components: {
    TrailerVideoItem,
    VideosVideoItem
  },
  data: () => {
    return {
      tile: false,
      processing: false,
      dialog: false,
      trailersList: [],
      videosList: [],
      channel: null,
      donateDialog: false,
      donateAmount: 0,
      priceDonate: null,
      rules: {
        required: value => !!value || "Required."
      },
      channelId:null,
      siteUrl:"",
    };
  },
  mixins: [RegisterStoreModule],
  created() {
    this.registerStoreModule("channels", channelsModule);
  },
  computed: {
    getExpiryToNow() {
      return (
        moment(this.channel.expiryDate.toDate()).diff(new Date(), "days") +
        " Days Left"
      );
    }
  },
  methods: {
    onVideoDeleted() {
      this.loadVideosData();
    },
    loadTrailersData() {
      this.$store
        .dispatch("channels/getUserChannelTrailers", {
          channelId: this.channel.channelId
        })
        .then(data => {
          this.trailersList = data;
        });
    },
    loadVideosData() {
      this.$store
        .dispatch("channels/getUserChannelVideos", {
          channelId: this.channel.channelId
        })
        .then(data => {
          this.videosList = data;
        });
    },
    async loadChannel() {
      this.channelId = this.$route.params.channelId;
      let channelDoc = await fireStore
        .collection(utils.channelsCollection)
        .doc(this.$route.params.channelId)
        .get();
      this.channel = channelDoc.data();

      let subDoc = await fireStore
        .collection(utils.channelsCollection)
        .doc(this.channelId)
        .get();

      this.channel = subDoc.data();

      this.loadTrailersData();

      this.loadVideosData();
    },
    showDonatePop() {
      this.donateDialog = true;
    },
    async sleep(ms) {
      return new Promise(resolve => setTimeout(resolve, ms));
    },
    async checkout(donate) {
      this.donateAmount = donate;
      await this.sleep(1000);
      const { token, args } = await this.$refs.checkoutRef.open();
    },
    done({ token, args }) {
      this.prepareSubscribe(this.donateAmount, token);
    },
    opened() {
      console.log("opened");
    },
    closed() {
      console.log("Closed");
    },
    canceled() {
      console.log("Canceled");
    },
    async prepareSubscribe(donate, token) {
      if (auth.currentUser == null) {

        this.$root.$emit('openLoginForm');

        return;
      }
      let prepareOptions = {
        channelId: this.trailer.channelId,
        channelName: this.trailer.channelName,
        userId: auth.currentUser.uid,
        isDesktop: true,
        redirectTo: this.siteUrl+"/my-channels",
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
              "&donate=true" +
              "&redirect="+this.siteUrl;
          } else {
            window.location =
              "https://us-central1-trenstop-2033f.cloudfunctions.net/pagePaymentSuccess?subId=" +
              response.data.subId +
              "&donate=true" +
              "&redirect="+this.siteUrl+"/my-channels";
          }
        })
        .catch(error => {
          this.subscribeProcessing = false;
        });
    }
  },
  mounted() {
    this.loadChannel();


        // Fetch site base url
    this.$store.dispatch("fetchSettings",{key: 'site_base_url'}).then(url => {

        this.siteUrl=url

    });



  },
  props: []
};
</script>

<style scoped>
.channel-details {
  align-self: center;
  text-align: start;
}
.padding {
  padding: 10px;
}
.subscribers-count {
  color: gray;
}
.donate-dialog {
  padding: 16px;
}
</style>
