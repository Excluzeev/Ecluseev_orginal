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
    </v-layout>
    <div v-if="trailersList != null && !trailersList.isEmpty">
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
    <div v-if="videosList != null && !videosList.isEmpty">
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
          <VideosVideoItem :video="video" />
        </v-flex>
      </v-layout>
    </div>
  </v-container>
</template>

<script>
import TrailerVideoItem from "../components/TrailerVideoItem";
import VideosVideoItem from "../components/VideosVideoItem";
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import channelsModule from "../store/channels/channels";

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
      videosList: []
    };
  },
  mixins: [RegisterStoreModule],
  created() {
    this.registerStoreModule("channels", channelsModule);
  },
  mounted() {
    this.$store
      .dispatch("channels/getUserChannelTrailers", {
        channelId: this.channel.channelId
      })
      .then(data => {
        this.trailersList = data;
        console.log(data);
      });

    this.$store
      .dispatch("channels/getUserChannelVideos", {
        channelId: this.channel.channelId
      })
      .then(data => {
        this.videosList = data;
        console.log(data);
      });
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
