<template>
  <v-card>
    <router-link :to="'/' + getLinkTag + '/' + video.videoId">
      <v-img :src="video.image" height="200px"> </v-img>

      <v-card-title primary-title>
        <div>
          <div class="headline">{{ video.title }}</div>
          <span class="grey--text">{{ video.description }}</span>
          <div class="grey--text">{{ video.timeAgo }}</div>
        </div>
      </v-card-title>
    </router-link>
    <v-card-actions v-if="showDelete">
      <v-btn flat color="red" @click="deleteVideo"
        ><v-icon left>delete</v-icon>Delete</v-btn
      >
    </v-card-actions>
  </v-card>
</template>

<script>
import { auth } from "../firebase/init";

export default {
  name: "VideosVideoItem",
  props: ["video"],
  computed: {
    showDelete() {
      return this.video.userId == auth.currentUser.uid;
    },
    getLinkTag() {
      return this.video.type == 'Live' ? 'live' : 'video';
    }
  },
  methods: {
    deleteVideo() {
      this.$store.dispatch("deleteVideo", { video: this.video }).then(() => {
        this.$emit("videoDelete");
      });
    }
  }
};
</script>

<style scoped>
a {
  text-decoration: none;
}
</style>
