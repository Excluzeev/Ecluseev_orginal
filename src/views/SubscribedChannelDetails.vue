<template>
  <v-container v-if="channel != null">
    <img
            :src="
        'https://firebasestorage.googleapis.com/v0/b/trenstop-public/o/channels%2F' +
          channel.channelId +
          '%2Fcover.jpg?alt=media'
      "
            style="width: 100%; height: 150px; object-fit: cover;"
    />
    <v-layout row wrap xs12 text-xs-center class="padding">
      <v-avatar :tile="tile" size="100px" color="grey lighten-4">
        <img
          :src="
            'https://firebasestorage.googleapis.com/v0/b/trenstop-public/o/channels%2F' +
              subscription.channelId +
              '%2Fthumbnail.jpg?alt=media'
          "
          alt="avatar"
        />
      </v-avatar>
      <div class="channel-details padding">
        <h2 class="quick-sand-font-b">{{ channel.title }}</h2>
        <p class="subscribers-count">
          {{
            channel.subscriberCount == undefined ? 0 : channel.subscriberCount
          }}
          Subscribers
        </p>
      </div>
      <v-spacer></v-spacer>
      <v-btn
        class="white--text quick-sand-font-b"
        color="blue lighten-1"
        :loading="processing"
        :disabled="processing"
        @click="cancelSubscription"
      >
        <v-icon light>close</v-icon> Cancel Subscription
        <template v-slot:loader>
          <span class="custom-loader">
            <v-icon light>cached</v-icon>
          </span>
        </template>
      </v-btn>
    </v-layout>
    <div v-if="!(trailersList.length == 0)">
      <h1 class=" quick-sand-font-b">Trailer</h1>
      <br />
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
          <TrailerVideoItem :trailer="trailer" />
        </v-flex>
      </v-layout>
    </div>
    <div class="padding"></div>
    <div v-if="!(videosList.length == 0)">
      <h1 class=" quick-sand-font-b">Videos</h1>
      <br />
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
          <VideosVideoItem :video="video" v-on:videoDelete="onVideoDeleted" />
        </v-flex>
      </v-layout>
    </div>
    <v-layout row justify-center>
      <v-dialog v-model="dialog" persistent max-width="290">
        <v-card>
          <v-card-title class="headline"
            >Do you want to cancel the subscription?</v-card-title
          >
          <v-card-text
            >Hello, <br />
            Do you really want to cancel the subscription, You still have
            <strong>{{ getExpiryToNow }}</strong></v-card-text
          >
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="green darken-1" flat @click="dialog = false"
              >Cancel</v-btn
            >
            <v-btn color="green darken-1" flat @click="cancelSubscriptionAgree"
              >Accept</v-btn
            >
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-layout>
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
      subscriptionId: null,
      dialog: false,
      trailersList: [],
      videosList: [],
      channel: null,
      subscription: null
    };
  },
  mixins: [RegisterStoreModule],
  created() {
    this.registerStoreModule("channels", channelsModule);
  },
  computed: {
    getExpiryToNow() {
      return (
              moment(this.subscription.expiryDate.toDate()).diff(new Date(), "days") +
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
          console.log(data);
        });
    },
    loadVideosData() {
      this.$store
        .dispatch("channels/getUserChannelVideos", {
          channelId: this.channel.channelId
        })
        .then(data => {
          this.videosList = data;
          console.log(data);
        });
    },
    async cancelSubscription() {
      this.dialog = true;
    },
    async cancelSubscriptionAgree() {
      this.processing = true;
      this.dialog = false;
      let subRef = fireStore
        .collection(utils.subscribersCollection)
        .doc(this.subscriptionId);

      let channelRef = fireStore
        .collection(utils.channelsCollection)
        .doc(this.channel.channelId);

      let updateData = {
        isCanceled: true,
        isActive: false,
        expiryDate: firebaseTimestamp.fromDate(new Date())
      };

      let subDoc = await subRef.get();
      if (subDoc.exists) {
        await subRef.update(updateData);
        let channelDoc = await channelRef.get();

        let userRef = fireStore.collection("users").doc(auth.currentUser.uid);
        let userDoc = await userRef.get();
        if (userDoc.exists) {
          let subscribedChannels = userDoc.data().subscribedChannels;
          let filteredSubscribedChannels = subscribedChannels.filter(
            (value, index, arr) => {
              return value != this.channel.channelId;
            }
          );

          await channelRef.update({
            subscriberCount: channelDoc.data().subscriberCount - 1
          });
          await userRef.update({
            subscribedChannels: filteredSubscribedChannels
          });
        }
        this.$router.push({ name: "MySubscriptions" });
      } else {
        this.$router.push({ name: "MySubscriptions" });
      }
      let user = auth.currentUser;
      this.$store.dispatch("fetchUser", { user: user, force: true });
      this.processing = false;
    },
    async loadChannel() {
      this.subscriptionId = this.$route.params.subscriptionId;
      let channelDoc = await fireStore
        .collection(utils.channelsCollection)
        .doc(this.$route.params.channelId)
        .get();
      this.channel = channelDoc.data();

      let subDoc = await fireStore
        .collection(utils.subscribersCollection)
        .doc(this.subscriptionId)
        .get();

      this.subscription = subDoc.data();

      console.log(this.channel);
      this.loadTrailersData();

      this.loadVideosData();
    }
  },
  mounted() {
    this.loadChannel();
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
</style>
