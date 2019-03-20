<template>
  <v-container>
    <img
      :src="
        'https://firebasestorage.googleapis.com/v0/b/trenstop-public/o/channels%2F' +
          channelId +
          '%2Fcover.jpg?alt=media'
      "
      style="width: 100%; height: 150px; object-fit: cover;"
    />
    <v-layout row wrap xs12 text-xs-center class="padding">
      <v-avatar :tile="tile" size="100px" color="grey lighten-4">
        <img
          :src="
            'https://firebasestorage.googleapis.com/v0/b/trenstop-public/o/channels%2F' +
              channel.channelId +
              '%2Fthumbnail.jpg?alt=media'
          "
          alt="avatar"
        />
      </v-avatar>
      <div class="channel-details padding">
        <h2 class="quick-sand-font-b">{{ channel.title }}</h2>
        <p class="subscribers-count">
          {{ channel.subscriberCount }} Subscribers
        </p>
      </div>
      <v-spacer></v-spacer>
      <div v-if="!channel.isDeleted">
        <router-link
          :to="{ name: 'AddVideo', params: { channelData: channel } }"
        >
          <v-btn color="primary" class="white--text quick-sand-font-b">
            <v-icon left>add</v-icon>Add Video</v-btn
          >
        </router-link>
        <v-btn
          color="red"
          class="white--text quick-sand-font-b"
          center
          @click="deleteDialog = true"
        >
          <v-icon left>delete</v-icon>Delete</v-btn
        >
        <router-link
          :to="{ name: 'AddExcluzeev', params: { channelData: channel } }"
        >
          <v-btn color="primary" class="white--text  quick-sand-font-b">
            <v-icon left>add</v-icon>Excluzeev Live</v-btn
          >
        </router-link>
        <v-btn
          color="primary"
          class="white--text quick-sand-font-b"
          @click="getSubscribers"
        >
          Subscribers</v-btn
        >
      </div>
    </v-layout>
    <div v-if="!(trailersList.length == 0)">
      <h1 class="quick-sand-font-b">Trailer</h1>
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
      <h1 class="quick-sand-font-b">Videos</h1>
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
    <!--<v-layout>-->
    <v-dialog v-model="dialog">
      <v-card>
        <v-card-title class="headline grey lighten-2" primary-title>
          Subscribers List
        </v-card-title>
        <v-list two-line v-if="!subscriberLoading && !subscriberEmpty">
          <v-list-tile
            v-for="(subscriber, index) in subscribersList"
            v-bind:key="subscriber.subscriptionId"
          >
            <!--<v-divider v-if="index != 0" :key="index"></v-divider>-->
            <v-list-tile-content>
              <v-list-tile-title>{{ subscriber.userName }}</v-list-tile-title>
              <v-list-tile-sub-title>
                {{ subscriber.daysLeft }}
              </v-list-tile-sub-title>
            </v-list-tile-content>
          </v-list-tile>
        </v-list>

        <v-card-text v-if="subscriberEmpty">
          No Subscribers yet.
        </v-card-text>

        <v-progress-circular
          v-if="subscriberLoading"
          indeterminate
          color="primary"
        ></v-progress-circular>

        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" flat @click="dialog = false">
            Close
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <!--</v-layout>-->
    <v-layout row justify-center>
      <v-dialog v-model="deleteDialog" persistent max-width="320">
        <v-card>
          <v-card-title class="headline"
            >Do you want to delete the channel?</v-card-title
          >
          <v-card-text
            >Hello, <br />
            Do you really want to delete the channel, Users will have a 30 days
            notice period.</v-card-text
          >
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="green darken-1" flat @click="deleteDialog = false"
              >Dont Delete</v-btn
            >
            <v-btn color="green darken-1" flat @click="deleteChannel"
              >Delete</v-btn
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
import { fireStore, firebaseTimestamp } from "../firebase/init";
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
      channel: null,
      channelId: "",
      dialog: false,
      subscribersList: [],
      subscriberLoading: true,
      subscriberEmpty: false,
      deleteDialog: false
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
          moment(data.expiryDate.toDate()).diff(moment(), "days") +
          " Days Left";
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
    },
    async deleteChannel() {
      let channelRef = fireStore
        .collection(utils.channelsCollection)
        .doc(this.channel.channelId);
      // let channelDoc = await channelRef.get();
      let delDate = new Date();
      delDate.setMonth(delDate.getMonth() + 1);
      let updateData = {
        isDeleted: true,
        delete: 0,
        deleteOn: firebaseTimestamp.fromDate(delDate)
      };
      await channelRef.update(updateData);

      this.$router.push({ name: "MyChannels" });
    }
  },
  async mounted() {
    this.channelId = this.$route.params.channelId;
    let channelDoc = await fireStore
      .collection(utils.channelsCollection)
      .doc(this.$route.params.channelId)
      .get();
    this.channel = channelDoc.data();
    this.loadTrailersData();

    this.loadVideosData();
  }
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
