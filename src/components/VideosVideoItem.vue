<template>
  <v-flex xs12>
    <v-card elevation="0" class="all-bg" style="margin-left: 5px;">
      <router-link :to="'/' + getLinkTag + '/' + video.videoId">
        <v-flex>
          <v-menu open-on-hover>
            <template v-slot:activator="{ on }">
              <v-btn
                fab
                small
                absolute
                right
                v-on="on"
                style="background-color:rgba(0, 0, 0, 0.13);box-shadow:0px 0px 0px 0px;"
              >
                <v-icon style="padding: 10px;">more_vert</v-icon>
              </v-btn>
            </template>

            <v-list>
              <v-list-tile @click="openReportDialog(video.videoId)">
                <v-list-tile-title>Report</v-list-tile-title>
              </v-list-tile>
            </v-list>
          </v-menu>
          <div class="item_img">
          <img height="118px" v-bind:src="video.hasCustomThumbnail ? video.customThumbnail : video.image" class="img-fluid" >
        </div>

        </v-flex>
        <div class="padding">
          <div class="title--text max-2-lines quick-sand-font-b">{{ video.title }}</div>
          <span class="desc--text">{{ video.channelName }}</span>
          <div class="desc--text">{{ video.timeAgo }}</div>
        </div>
      </router-link>
      <v-card-actions v-if="showDelete">
        <v-btn flat color="red" @click="deleteVideoDialog = true">
          <v-icon left>delete</v-icon>Delete
        </v-btn>
      </v-card-actions>
    </v-card>
    <v-dialog v-model="deleteVideoDialog" max-width="320">
      <v-card>
        <v-card-title class="headline">Delete the Video?</v-card-title>
        <v-card-text>
          Hello,
          <br />Do you really want to delete the Video.
          <br />
          <strong>{{ video.title }}</strong>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="green darken-1" flat @click="deleteVideoDialog = false">Dont Delete</v-btn>
          <v-btn color="green darken-1" flat @click="deleteVideo">Delete</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

    <v-dialog v-model="reportDialog" scrollable max-width="300px">
      <v-card>
        <v-card-title>Select Reasons</v-card-title>
        <v-divider></v-divider>
        <v-card-text style="height: 300px;">
          <!-- <v-radio-group v-model="reportReasons" column> -->
          <v-container fluid>
            <v-checkbox
              v-for="(reason, index) in reasons"
              v-bind:key="index"
              style="margin-top: 0;     padding-top: 0;"
              v-model="reportReasons"
              :label="reason"
              :value="reason"
            ></v-checkbox>
            <v-flex xs12 v-if="this.reportReasons.indexOf('Other') != -1">
              <v-text-field v-model="otherReason" label="Reason"></v-text-field>
            </v-flex>
          </v-container>
          <!-- </v-checkbox-group> -->
        </v-card-text>
        <v-divider></v-divider>
        <v-card-actions>
          <v-btn color="blue darken-1" flat @click="closeReportDialog">Close</v-btn>
          <v-btn color="blue darken-1" flat @click="updateAndCloseReportDialog">Report</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-flex>
</template>

<script>
import { auth, fireStore } from "../firebase/init";
import utils from "../firebase/utils";

export default {
  name: "VideosVideoItem",
  props: ["video"],
  data: () => {
    return {
      deleteVideoDialog: false,
      reportDialog: false,
      reportReasons: [],
      otherReason: "",
      reportVideoId: "",
      reasons: [
        "Nudity",
        "Violence",
        "Harassment",
        "Suicide",
        "Self Injury",
        "False News",
        "Spam",
        "Unauthorised Sales",
        "Hate Speech",
        "Terrorism",
        "Other"
      ]
    };
  },
  computed: {
    showDelete() {
      return this.video.userId == auth.currentUser.uid;
    },
    getLinkTag() {
      if (
        this.video.channelType == "CrowdFunding" &&
        this.video.type != "Live"
      ) {
        return "crowd/video";
      }
      return this.video.type == "Live" ? "live" : "video";
    }
  },
  methods: {
    deleteVideo() {
      this.$store.dispatch("deleteVideo", { video: this.video }).then(() => {
        this.$emit("videoDelete");
      });
    },
    openReportDialog(videoId) {
      this.reportVideoId = videoId;
      this.reportDialog = true;
    },
    closeReportDialog() {
      this.reportReasons = [];
      this.reportDialog = false;
      this.otherReason = "";
      this.reportVideoId = "";
    },
    async updateAndCloseReportDialog() {
      if (this.reportReasons.indexOf("Other") != -1) {
        this.reportReasons = this.reportReasons.map(reason => {
          if (reason == "Other" && this.otherReason != "") {
            return this.otherReason;
          } else {
            return reason;
          }
        });
      }

      let user = auth.currentUser;

      let displayName = auth.currentUser.displayName;
      if (displayName == "" || displayName == null) {
        let fUser = JSON.parse(localStorage.getItem("fUser"));
        displayName = fUser.firstName + " " + fUser.lastName;
      }
      let reasonUpdateData = {
        id: this.reportVideoId,
        type: "video",
        userName: user.displayName,
        userId: user.uid,
        reasons: this.reportReasons
      };
      let reportId = utils.generateId();

      let reportRef = fireStore.collection("reports").doc(reportId);

      await reportRef.set(reasonUpdateData);

      this.reportReasons = [];
      this.reportDialog = false;

      this.reportTraileId = "";

      this.otherReason = "";
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

  .item_img{

    padding: 1px;
    background: white;
    border-radius: 24px;

}
.item_img img{


    border-radius: 24px;
}
</style>
