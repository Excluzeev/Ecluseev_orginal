<template>
  <v-content>
    <v-container fluid fill-height>
      <v-layout align-center justify-center>
        <v-flex xs12 sm8 md4>
          <v-card class="elevation-9">
            <v-toolbar dark color="blue lighten-1">
              <v-toolbar-title>Add a video</v-toolbar-title>
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
                <upload-btn
                  color="blue--text lighten-1"
                  style="background-color: #fff !important;"
                  class="white--text"
                  title="Add video"
                  :fileChangedCallback="onVideoFileSelected"
                  accept="video/*"
                  :uniqueId="unique"
                  round
                >
                  <template slot="icon">
                    <div style="padding-left:4px">
                      <v-icon color="blue lighten-1">cloud_upload</v-icon>
                    </div>
                  </template>
                </upload-btn>
                <div class="video-holder" v-if="videoFile != null">
                  <video controls>
                    <source :src="videoUrl" type="video/mp4" />
                    Your browser does not support HTML5 video.
                  </video>
                </div>
                <div class="text-xs-center">
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
                </div>
                <div class="text-xs-center">
                  <v-btn
                    class="white--text"
                    color="grey lighten-1"
                    @click="$router.back()"
                  >
                    Cancel
                  </v-btn>
                </div>
              </v-form>
            </v-card-text>
          </v-card>
        </v-flex>
      </v-layout>
    </v-container>
  </v-content>
</template>

<script>
import UploadButton from "vuetify-upload-button";
import {
  videoStorage,
  auth,
  firebaseTimestamp,
  fireStore
} from "../firebase/init";
import utils from "../firebase/utils";
import axios from "axios";

export default {
  components: {
    "upload-btn": UploadButton
  },
  data: () => {
    return {
      title: "",
      description: "",
      videoFile: null,
      videoUrl: "",
      processing: false,
      unique: true,
      rules: {
        required: value => !!value || "Required."
      }
    };
  },
  props: ["channelData"],
  methods: {
    onVideoFileSelected(file) {
      this.videoFile = file;
      this.videoUrl = URL.createObjectURL(this.videoFile);
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
      if (this.videoFile == null) {
        this.showToast("Please select Video");
        return;
      }

      this.processing = true;

      let videoId = utils.generateId();
      let videoVideoRef = videoStorage
        .ref()
        .child(videoId)
        .child("original");
      let videoUrl = "";

      const metadata = {
        contentType: "video/*"
      };

      try {
        await videoVideoRef.put(this.videoFile, metadata);
        videoUrl = await videoVideoRef.getDownloadURL();
      } catch (e) {
        console.log(e);
        this.show("VideoUpload failed.");
      }

      let videoData = {
        videoId: videoId,
        categoryName: this.channelData.categoryName,
        categoryId: this.channelData.categoryId,
        userId: auth.currentUser.uid,
        channelId: this.channelData.channelId,
        channelName: this.channelData.title,
        channelType: this.channelData.channelType,
        title: this.title,
        description: this.description,
        type: "VOD",
        videoUrl: videoUrl,
        createdDate: firebaseTimestamp.fromDate(new Date()),
        createdBy: auth.currentUser.displayName,
        sDate: ""
      };

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
            this.showToast("Video Created Successfully");
            this.$router.replace({
              name: "VideoSingle",
              params: { videoId: videoId }
            });
            this.processing = false;
          }
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
