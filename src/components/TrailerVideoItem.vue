<template>
  <div>

    
      <router-link :to="'/' + getLinkTag + '/' + trailer.trailerId">

        <div class="item_img">
          <img height="118px" v-bind:src="trailer.hasCustomThumbnail ? trailer.customThumbnail :  trailer.image" class="img-fluid" >
        </div>
        <h6>{{ trailer.title }}</h6>
        <p>{{ trailer.channelName }}</p>
        <p><i class="fa fa-tripadvisor" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;{{ trailer.timeAgo }}</p>

         <div class="red--text" v-show="getIsExpired(trailer.expiry)">
            <p danger>Expired</p>
         </div>

      </router-link>

      <div class="bottom-controls">
       
        <button v-if="showDelete" class="cbtn"  @click="deleteTrailerDialog = true">
          <i style="color:white;" class="fa fa-trash" aria-hidden="true"></i>
        </button>

        <button class="cbtn"  @click="openReportDialog(trailer.trailerId)">
          <i style="color:white;" class="fa fa-flag" aria-hidden="true"></i>
        </button>

      </div>


<!--         
    <div class="modal" id="reportModal" tabindex="-1" role="dialog">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Select Reasons</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
                <form>
                  <div class="row" v-for="(reason, index) in reasons">
                      <div class="col-lg-6">
                      <label v-text="reason"></label>
                      </div>
                      <div class="col-lg-6">
                      <input style="height:auto;width:auto;" type="checkbox" class="form-control" v-bind:key="index"  v-model="reportReasons" value="reason" >
                      </div>
                  </div>
                </form>
                
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-primary" @click="updateAndCloseReportDialog">Report</button>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
          </div>
        </div>
      </div>
    </div> -->

    <v-dialog v-model="deleteTrailerDialog" max-width="320">
      <v-card>
        <v-card-title class="headline">Delete the Preview?</v-card-title>
        <v-card-text>
          Hello,
          <br />Do you really want to delete the Preview.
          <br />
          <strong>{{ trailer.title }}</strong>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="green darken-1" flat @click="deleteTrailerDialog = false">Dont Delete</v-btn>
          <v-btn  color="green darken-1" flat @click="deleteTrailer">Delete</v-btn>
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
          
                  <div class="row" v-for="(reason, index) in reasons" v-bind:key="index" >
                      <div class="col-lg-6">
                      <label v-text="reason"></label>
                      </div>
                      <div class="col-lg-6">
                      <input style="height:auto;width:auto;" type="checkbox" class="form-control"  v-model="reportReasons[index]" value="reason" >
                      </div>
                  </div>
              
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
  
     
  </div>
  <!--
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
                style="background-color:transparent;box-shadow:0px 0px 0px 0px;"
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
          <v-img
            :src="trailer.hasCustomThumbnail ? trailer.customThumbnail :  trailer.image"
            height="118px"
          ></v-img>
        </v-flex>
        <div class="padding">
          <v-layout row>
            <div class="title--text max-2-lines quick-sand-font-n">{{ trailer.title }}</div>
          </v-layout>
          <span class="desc--text">{{ trailer.channelName }}</span>
          <div class="desc--text">{{ trailer.timeAgo }}</div>

          <div class="red--text" v-show="getIsExpired(trailer.expiry)">
            <p danger>Expired</p>
          </div>
        </div>
      </router-link>


      <v-card-actions v-if="showDelete">
        <v-btn flat color="red" @click="deleteTrailerDialog = true">
          <v-icon left>delete</v-icon>Delete
        </v-btn>
      </v-card-actions>
    </v-card>

    v-flex>
  -->
</template>

<script>
import { auth, fireStore } from "../firebase/init";
import utils from "../firebase/utils";
import moment from "moment";

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
      ],
      deleteTrailerDialog: false
    };
  },
  computed: {
    showDelete() {
      console.log(this.trailer);
      if (auth.currentUser == null) return false;
      else return this.trailer.userId == auth.currentUser.uid;
    },
    getLinkTag() {
      return this.trailer.channelType == "CrowdFunding" ? "crowd" : "trailer";
    }
  },
  methods: {
    getIsExpired(date) {
      if (date != null && date != undefined) {
        return moment(date.toDate()).diff(Date.now()) <= 0;
      } else {
        return false;
      }
    },
    deleteTrailer() {
      this.$store
        .dispatch("deleteTrailer", { trailer: this.trailer })
        .then(() => {
          this.$emit("trailerDelete");
        });
    },
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

.owl-carousel .owl-item img {
  background-image:url('../assets/Images/curious_img.png');

  height: 200px;
    background-repeat: no-repeat;
    background-size: cover;

}
.bottom-controls .cbtn{
  margin-left:10px;
  margin-right:10px;

}

</style>
