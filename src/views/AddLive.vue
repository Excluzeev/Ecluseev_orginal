<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">
  <v-content>
    <v-container fluid fill-height>
      <v-layout v-if="showAddLive" align-center justify-center>
        <v-flex xs12 sm8 md4>
          <v-card class="elevation-9">
            <v-toolbar dark color="blue lighten-1">
              <v-toolbar-title>Excluzeev Live</v-toolbar-title>
            </v-toolbar>
            <v-card-text>
              <v-form
                class="blue--text lighten-1"
                @submit.prevent="doUploadVideo"
              >
                <v-text-field
                  v-model="title"
                  name="Title"
                  label="Title"
                  type="text"
                  :rules="[rules.required]"
                ></v-text-field>
                <v-text-field
                  v-model="description"
                  name="Description"
                  label="Description"
                  type="text"
                  :rules="[rules.required]"
                ></v-text-field>
                <v-radio-group
                  v-model="timePublish"
                  :mandatory="true"
                  row
                  v-on:change="timeUpdate"
                >
                  <v-radio label="Now" value="now"></v-radio>
                  <v-radio label="Schedule" value="later"></v-radio>
                </v-radio-group>
                <v-layout class="date-time-holder" v-if="showDateTime">
                  <v-flex>
                    <v-dialog
                      ref="datedialog"
                      v-model="dateModal"
                      :return-value.sync="date"
                      persistent
                      lazy
                      full-width
                      width="290px"
                    >
                      <template v-slot:activator="{ on }">
                        <v-text-field
                          v-model="date"
                          label="Select Date"
                          prepend-icon="event"
                          readonly
                          v-on="on"
                        ></v-text-field>
                      </template>
                      <v-date-picker v-model="date" scrollable>
                        <v-spacer></v-spacer>
                        <v-btn flat color="primary" @click="dateModal = false"
                          >Cancel</v-btn
                        >
                        <v-btn
                          flat
                          color="primary"
                          @click="$refs.datedialog.save(date)"
                          >OK</v-btn
                        >
                      </v-date-picker>
                    </v-dialog>
                  </v-flex>
                  <v-flex>
                    <v-dialog
                      ref="timedialog"
                      v-model="timeModal"
                      :return-value.sync="time"
                      persistent
                      lazy
                      full-width
                      width="290px"
                    >
                      <template v-slot:activator="{ on }">
                        <v-text-field
                          v-model="time"
                          label="Select Time"
                          prepend-icon="access_time"
                          readonly
                          v-on="on"
                        ></v-text-field>
                      </template>
                      <v-time-picker v-if="timeModal" v-model="time" full-width>
                        <v-spacer></v-spacer>
                        <v-btn flat color="primary" @click="timeModal = false"
                          >Cancel</v-btn
                        >
                        <v-btn
                          flat
                          color="primary"
                          @click="$refs.timedialog.save(time)"
                          >OK</v-btn
                        >
                      </v-time-picker>
                    </v-dialog>
                  </v-flex>
                </v-layout>
                <v-layout row wrap class="text-xs-center">
                  <v-flex>
                    <v-btn
                      class="white--text"
                      color="blue lighten-1"
                      type="submit"
                      :loading="processing"
                      :disabled="processing"
                      @click="loader = 'loading4'"
                    >
                      Proceed
                      <template v-slot:loader>
                        <span class="custom-loader">
                          <v-icon light>cached</v-icon>
                        </span>
                      </template>
                    </v-btn>
                    <v-btn
                      class="white--text"
                      color="grey lighten-1"
                      @click="$router.back()"
                    >
                      Cancel
                    </v-btn>
                  </v-flex>
                </v-layout>
              </v-form>
            </v-card-text>
          </v-card>
        </v-flex>
      </v-layout>

      <v-layout v-if="showLiveDetails" align-center justify-center>
        <v-flex xs12 sm8 md4>
          <v-card class="elevation-9">
            <v-toolbar dark color="blue lighten-1">
              <v-toolbar-title>Excluzeev Live</v-toolbar-title>
            </v-toolbar>
            <v-card-text>
              <v-flex xs12>
                <v-text-field
                  id="streamUrl"
                  label="Stream Url"
                  placeholder="Stream Url"
                  value="rtmp://live.mux.com/app/"
                  append-icon="file_copy"
                  @click:append="copyStreamData('streamUrl')"
                  outline
                ></v-text-field>
              </v-flex>
              <v-flex xs12>
                <v-text-field
                  :value="streamKey"
                  :append-icon="showKey ? 'visibility' : 'visibility_off'"
                  :type="showKey ? 'text' : 'password'"
                  name="input-10-1"
                  label="Stream Key"
                  @click:append="showKey = !showKey"
                  outline
                ></v-text-field>
              </v-flex>
              <v-flex>
                <v-btn
                        class="white--text"
                        color="blue lighten-1"
                        :loading="processing"
                        :disabled="processing"
                        @click="checkStreamStatus();
                "
                >
                  Next
                </v-btn>
                <v-progress-circular
                        v-if="checkingStream"
                        indeterminate
                        color="primary"
                ></v-progress-circular>
              </v-flex>
            </v-card-text>
          </v-card>
        </v-flex>
      </v-layout>
    </v-container>
  </v-content>
</template>

<script>
import { auth, firebaseTimestamp, fireStore } from "../firebase/init";
import utils from "../firebase/utils";
import axios from "axios";
import moment from "moment";

export default {
  data: () => {
    return {
      title: "",
      description: "",
      videoFile: null,
      date: null,
      dateModal: false,
      timeModal: false,
      time: null,
      processing: false,
      timePublish: "now",
      showDateTime: false,
      unique: true,
      showAddLive: true,
      showLiveDetails: false,
      streamKey: "",
      copyText: "",
      showKey: false,
      checkingStream: false,
      liveId: "",
      videoId: "",
      rules: {
        required: value => !!value || "Required."
      }
    };
  },
  props: ["channelData"],
  methods: {
    timeUpdate(pub) {
      if (pub == "later") {
        this.showDateTime = true;
      } else {
        this.showDateTime = false;
      }
    },
    async doUploadVideo() {
      if (this.title == "") {
        this.showToast("Title cannot be empty.");
        return;
      }
      if (this.description == "") {
        this.showToast("Description cannot be empty");
        return;
      }

      this.processing = true;

      let videoId = utils.generateId();

      let videoData = {
        videoId: videoId,
        categoryName: this.channelData.categoryName,
        categoryId: this.channelData.categoryId,
        userId: auth.currentUser.uid,
        channelId: this.channelData.channelId,
        channelName: this.channelData.title,
        title: this.title,
        description: this.description,
        type: "Live",
        videoUrl: "",
        later: this.timePublish,
        createdDate: firebaseTimestamp.fromDate(new Date()),
        createdBy: auth.currentUser.displayName
      };

      if (this.timePublish == "later") {
        let dateString = this.date + "T" + this.time + ":00";
        videoData.sDate = dateString;
      } else {
        videoData.sDate = "";
      }

      // https://us-central1-trenstop-2033f.cloudfunctions.net/processLiveVideo

      axios
        .post(
          "https://us-central1-trenstop-2033f.cloudfunctions.net/processLiveVideo",
          videoData
        )
        .then(response => {
          let d = response.data;
          if (d.error) {
            this.showToast(d.message);
          } else {
            this.showToast("Live Created Successfully");
            this.streamKey = d.message;
            this.liveId = d.liveId;
            this.videoId = videoId;
            // this.$router.replace("/live/" + videoId);
            this.processing = false;
            this.showAddLive = false;
            this.showLiveDetails = true;
          }
          // this.shouldShowStreamDetails = moment(this.video.)
        })
        .catch(error => {
          this.processing = false;
          console.log(error);
        });
    },
    copyStreamData(copyData) {
      let testingCodeToCopy = document.querySelector("#" + copyData);
      testingCodeToCopy.select();

      try {
        let successful = document.execCommand("copy");
        let msg = successful ? "Successful" : "UnSuccessful";
        this.showToast("Copied " + msg);
      } catch (err) {
        this.showToast("Copied Failed");
      }

      window.getSelection().removeAllRanges();
    },
    checkStreamStatus() {
      console.log(this.liveId);
      this.checkingStream = true;
      console.log("Done");
      //https://us-central1-trenstop-2033f.cloudfunctions.net/getLiveStatus
      let data = {
        liveId: this.liveId
      };
      axios
        .post(
          "https://us-central1-trenstop-2033f.cloudfunctions.net/getLiveStatus",
          data
        )
        .then(response => {
          let d = response.data;
          console.log(d);
          if (d.error) {
            this.showToast(d.message);
          } else {
            if (d.message == "active") {
              this.showToast("Stream is Live");
              this.$router.replace("/live/" + this.videoId);
            } else {
              this.showToast("Please start your stream");
            }
          }
          this.checkingStream = false;
          // this.shouldShowStreamDetails = moment(this.video.)
        })
        .catch(error => {
          this.processing = false;
          console.log(error);
        });
    },
    showToast(msg) {
      this.$toasted.show(msg, {
        theme: "outline",
        position: "top-right",
        duration: 2000
      });
    }
  }
};
</script>

<style scoped>
video {
  width: 100%;
}
.video-holder {
  padding: 10px;
}
</style>
