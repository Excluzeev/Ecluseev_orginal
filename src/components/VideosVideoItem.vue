<template>
  <v-flex xs12>
    <v-card elevation="0" class="all-bg" style="margin-left: 5px;">
      <router-link :to="'/' + getLinkTag + '/' + video.videoId">
        <v-img :src="video.image" height="118px"> </v-img>
        <div class="padding">
          <div class="title--text max-2-lines">{{ video.title }}</div>
          <span class="desc--text">{{ video.channelName }}</span>
          <div class="desc--text">
            {{ video.views }} views • {{ video.timeAgo }}
          </div>
        </div>
      </router-link>
      <v-card-actions v-if="showDelete">
        <v-btn flat color="red" @click="deleteVideoDialog = true"
          ><v-icon left>delete</v-icon>Delete</v-btn
        >
      </v-card-actions>
    </v-card>
    <v-dialog v-model="deleteVideoDialog" max-width="320">
      <v-card>
        <v-card-title class="headline">Delete the Video?</v-card-title>
        <v-card-text
          >Hello, <br />
          Do you really want to delete the Video. <br />
          <strong>{{ video.title }}</strong>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="green darken-1" flat @click="deleteVideoDialog = false"
            >Dont Delete</v-btn
          >
          <v-btn color="green darken-1" flat @click="deleteVideo">Delete</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-flex>
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
.padding {
  padding: 10px;
}
.title--text {
  color: #0a0a0a;
  font-size: 0.9rem;
  font-weight: 600;
}
</style>
