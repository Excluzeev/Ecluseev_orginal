<template>
  <router-link
          class="" :to="'/' + getLinkTag + '/' + video.videoId">
    <v-layout class="all-bg padding-top" justify-left row>
      <img :src="video.image" height="94" width="168" />
      <div class="padding">
        <div class="title--text max-2-lines quick-sand-font-b">{{ video.title }}</div>
        <span class="desc--text">{{ video.channelName }}</span>
        <div class="desc--text">
          {{ video.timeAgo }}
        </div>
      </div>
    </v-layout>
  </router-link>
</template>

<script>
export default {
  name: "VideoDetailVideoItem",
  props: ["video"],
  computed: {
    getLinkTag() {
      if (this.video.channelType == "CrowdFunding" && this.video.type != "Live") {
        return "crowd/video";
      }
      return this.video.type == "Live" ? "live" : "video";
    }
  }
};
</script>

<style scoped>
  a {
    text-decoration: none;
  }
  .padding {
    padding: 10px;
  }
  .title--text {
    color: #0a0a0a;
    font-size: 1rem;
    font-weight: 600;
  }
  .desc--text {
    font-size: 0.95rem;
  }
  .padding-top {
    padding-top: 10px;
  }
</style>