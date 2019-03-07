<template>
  <router-link :to="'/video/' + video.videoId">
    <v-card>
      <v-img :src="video.image" height="200px"> </v-img>

      <v-card-title primary-title>
        <div>
          <div class="headline">{{ video.title }}</div>
          <span class="grey--text">{{ video.description }}</span>
          <div class="grey--text">{{ video.timeAgo }}</div>
        </div>
      </v-card-title>
    </v-card>
  </router-link>
</template>

<script>
export default {
  name: "VideosVideoItem",
  props: ["video"]
};
</script>

<style scoped>
a {
  text-decoration: none;
}
</style>
