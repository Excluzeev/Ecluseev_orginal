<template>
  <v-flex>
    <v-card elevation="0" class="all-bg">
      <router-link :to="'/' + getLinkTag + '/' + trailer.trailerId">
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
              <v-list-tile @click="openReportDialog(trailer.trailerId)">
                <v-list-tile-title>Report</v-list-tile-title>
              </v-list-tile>
            </v-list>
          </v-menu>
          <v-img :src="trailer.image" height="118px"></v-img>
        </v-flex>
        <div class="padding">
          <v-layout row>
            <div class="title--text max-2-lines quick-sand-font-n">{{ trailer.title }}</div>
          </v-layout>
          <span class="desc--text">{{ trailer.channelName }}</span>
          <div class="desc--text">{{ trailer.views }} views • {{ trailer.timeAgo }}</div>
        </div>
      </router-link>
    </v-card>

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
          <v-btn color="blue darken-1" flat @click="updateAndCloseReportDialog">Save</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-flex>
</template>

<script>
import { auth, fireStore } from "../firebase/init";
import utils from "../firebase/utils";
export default {
  name: "TrailerVideoItem",
  props: ["trailer"],
  data: () => {
    return {
      reportDialog: false,
      reportReasons: [],
      otherReason: "",
      reportTraileId: "",
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
    getLinkTag() {
      return this.trailer.channelType == "CrowdFunding" ? "crowd" : "trailer";
    }
  },
  methods: {
    navigateToDetailTrailer() {
      let path = "/" + this.getLinkTag + "/" + this.trailer.trailerId;
      this.$router.push({ path: `${path}` });
    },
    openReportDialog(trailerId) {
      this.reportTraileId = trailerId;
      this.reportDialog = true;
    },
    closeReportDialog() {
      this.reportReasons = [];
      this.reportDialog = false;
      this.otherReason = "";

      this.reportTraileId = "";
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
        id: this.reportTraileId,
        type: "trailer",
        userName: user.displayName,
        userId: user.uid,
        reasons: this.reportReasons
      };
      let reportId = utils.generateId();

      let reportRef = fireStore.collection("reports").doc(reportId);

      console.log(reasonUpdateData);
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
</style>
