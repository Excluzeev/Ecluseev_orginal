<template>
  <v-layout>
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
        <v-btn flat color="red" @click="deleteVideoDialog = true"
          ><v-icon left>delete</v-icon>Delete</v-btn
        >
      </v-card-actions>
    </v-card>
    <v-layout row justify-center>
      <v-dialog v-model="deleteVideoDialog" persistent max-width="320">
        <v-card>
          <v-card-title class="headline">Delete the Video?</v-card-title>
          <v-card-text
            >Hello, <br />
            Do you really want to delete the Video. <br />
            <strong>{{ video.title }}</strong>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn
              color="green darken-1"
              flat
              @click="deleteVideoDialog = false"
              >Dont Delete</v-btn
            >
            <v-btn color="green darken-1" flat @click="deleteVideo"
              >Delete</v-btn
            >
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-layout>
  </v-layout>
</template>

<script>
import { auth } from "../firebase/init";

export default {
  name: "VideosVideoItem",
  props: ["video"],
  data: () => {
    return {
      deleteVideoDialog: false
    };
  },
  computed: {
    showDelete() {
      return this.video.userId == auth.currentUser.uid;
    },
    getLinkTag() {
      return this.video.type == "Live" ? "live" : "video";
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
