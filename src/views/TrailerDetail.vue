<template>
  <div class="home">
    <div v-show="!playerOptions.sources[0].src.isEmpty">
      <video-player
        class="vjs-custom-skin"
        ref="videoPlayer"
        :options="playerOptions"
      >
      </video-player>
    </div>
    <v-layout class="padding" align-center justify-left row fill-height>
      <div class="square">
        <img class="channel-image square" :src="trailer.channelImage" />
      </div>
      <v-layout class="padding" align-left justify-left column fill-height>
        <h2>{{trailer.title}}</h2>
        <span class="black--text">{{ trailer.description }}</span>
        <div class="grey--text">{{ trailer.timeAgo }}</div>
      </v-layout>
    </v-layout>
  </div>
</template>

<script>
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import trailerModule from "../store/trailers/trailer";

export default {
  name: "CategoryTrailers",
  data: () => {
    return {
      trailer: null,
      playerOptions: {
        overNative: true,
        autoplay: false,
        controls: true,
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
      }
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
    console.log("this is current player instance object", this.player);
  },
  created() {
    this.registerStoreModule("trailers", trailerModule);
    this.$store
      .dispatch("trailers/fetchTrailer", {
        trailerId: this.$route.params.trailerId
      })
      .then(data => {
        this.trailer = data;
        this.playerOptions.sources[0].src = this.trailer.videoUrl;
        this.playerOptions.poster = this.trailer.image;
      });
  },
  methods: {}
};
</script>

<style scoped>
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
</style>
