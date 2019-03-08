<template>
  <v-container>
    <v-layout row wrap xs12 text-xs-center class="padding">
      <v-avatar :tile="tile" size="100px" color="grey lighten-4">
        <img :src="channel.image" alt="avatar" />
      </v-avatar>
      <div class="channel-details padding">
        <h2>{{ channel.title }}</h2>
        <p class="subscribers-count">
          {{ channel.subscriberCount }} Subscribers
        </p>
      </div>
      <v-spacer></v-spacer>
      <router-link :to="{ name: 'AddVideo', params: { channelData: channel } }">
        <v-btn color="primary" class="white--text" round>
          <v-icon left>add</v-icon>Add Video</v-btn
        >
      </router-link>
      <v-btn color="primary" class="white--text" round @click="getSubscribers">
        Subscribers</v-btn
      >
    </v-layout>
    <div v-if="!(trailersList.length == 0)">
      <h1>Trailer</h1>
      <br />
      <v-layout xs12 row wrap>
        <v-flex
          class="trailer-item"
          xs12
          sm6
          md6
          lg4
          v-for="trailer in trailersList"
          v-bind:key="trailer.trailerId"
        >
          <TrailerVideoItem :trailer="trailer" />
        </v-flex>
      </v-layout>
    </div>
    <div class="padding"></div>
    <div v-if="!(videosList.length == 0)">
      <h1>Videos</h1>
      <br />
      <v-layout xs12 row wrap>
        <v-flex
          class="video-item"
          xs12
          sm6
          md6
          lg4
          v-for="video in videosList"
          v-bind:key="video.videoId"
        >
          <VideosVideoItem :video="video" v-on:videoDelete="onVideoDeleted" />
        </v-flex>
      </v-layout>
    </div>
    <v-dialog v-model="dialog">
      <v-card>
        <v-card-title class="headline grey lighten-2" primary-title>
          Subscribers List
        </v-card-title>
        <v-list two-line v-if="!subscriberLoading && !subscriberEmpty">
          <template v-for="(subscriber, index) in subscribersList">
            <v-divider
              v-if="index != 0"
              :key="index"
              :inset="item.inset"
            ></v-divider>

            <v-list-tile v-bind:key="subscriber.subscriptionId">
              <v-list-tile-content>
                <v-list-tile-title
                  v-html="subscriber.userName"
                ></v-list-tile-title>
                <v-list-tile-sub-title
                  v-html="subscriber.daysLeft"
                ></v-list-tile-sub-title>
              </v-list-tile-content>
            </v-list-tile>
          </template>
        </v-list>

        <v-card-text v-if="subscriberEmpty">
          No Subscribers yet.
        </v-card-text>

        <v-progress-circular
          v-if="subscriberLoading"
          indeterminate
          color="primary"
        ></v-progress-circular>

        <v-divider></v-divider>

        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" flat @click="dialog = false">
            Close
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script>
import TrailerVideoItem from "../components/TrailerVideoItem";
import VideosVideoItem from "../components/VideosVideoItem";
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import channelsModule from "../store/channels/channels";
import { fireStore } from "../firebase/init";
import utils from "../firebase/utils";
import moment from "moment";

export default {
  name: "MyChannelDetails",
  components: {
    TrailerVideoItem,
    VideosVideoItem
  },
  data: () => {
    return {
      tile: false,
      trailersList: [],
      videosList: [],
      dialog: false,
      subscribersList: [],
      subscriberLoading: true,
      subscriberEmpty: false
    };
  },
  mixins: [RegisterStoreModule],
  created() {
    this.registerStoreModule("channels", channelsModule);
  },
  methods: {
    async getSubscribers() {
      this.dialog = true;
      if (this.subscribersList.length > 0) {
        this.subscriberLoading = false;
        return;
      }
      console.log(this.channel);
      let querySnapshot = await fireStore
        .collection(utils.subscribersCollection)
        .where("isActive", "==", true)
        .where("channelId", "==", this.channel.channelId)
        .get();
      let subscribers = [];
      querySnapshot.forEach(snap => {
        let data = snap.data();
        data.daysLeft =
          moment(data.expiryDate.toDate()).diff(moment(), "days") + " Days Left";
        subscribers.push(data);
      });
      this.subscribersList = subscribers;
      console.log(this.subscribersList);
      this.subscriberLoading = false;
      if (this.subscribersList.length == 0) {
        this.subscriberEmpty = true;
      }
    },
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
    }
  },
  mounted() {
    this.loadTrailersData();

    this.loadVideosData();
  },
  props: ["channel"]
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
