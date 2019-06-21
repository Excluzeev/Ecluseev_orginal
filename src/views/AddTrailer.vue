<template>
  <v-content>
    <v-container fluid fill-height>
      <v-layout align-center justify-center>
        <v-flex xs12 sm8 md4>
          <v-card class="elevation-9">
            <v-toolbar dark color="blue lighten-1">
              <v-toolbar-title>Add a preview</v-toolbar-title>
            </v-toolbar>
            <v-card-text>
              <v-form class="blue--text lighten-1" @submit.prevent="doUploadTrailer">
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
                  title="Add preview"
                  :fileChangedCallback="onVideoFileSelected"
                  accept="video/mp4, video/x-m4v, video/*"
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
                    <source :src="videoUrl" type="video/mp4">Your browser does not support HTML5 video.
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
  publicStorage,
  auth,
  firebaseTimestamp,
  fireStore
} from "../firebase/init";
import utils from "../firebase/utils";

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
    async doUploadTrailer() {
      if (this.title == "") {
        this.showToast("Title cannot be empty.");
        return;
      }
      if (this.description == "") {
        this.showToast("Descriptoin cannot be empty");
        return;
      }
      if (this.videoFile == null) {
        this.showToast("Please select Preview Video");
        return;
      }

      this.processing = true;

      let trailerId = utils.generateId();
      let trailerVideoRef = publicStorage
        .ref()
        .child(this.channelData.channelId)
        .child(trailerId)
        .child("original");
      let trailerUrl = "";

      const metadata = {
        contentType: "video/*"
      };

      try {
        await trailerVideoRef.put(this.videoFile, metadata);
        trailerUrl = await trailerVideoRef.getDownloadURL();
      } catch (e) {
        // console.log(e);
        this.show("Preview Upload failed.");
      }

      let trailerData = {
        trailerId: trailerId,
        categoryName: this.channelData.categoryName,
        categoryId: this.channelData.categoryId,
        userId: auth.currentUser.uid,
        channelId: this.channelData.channelId,
        channelName: this.channelData.title,
        channelType: this.channelData.channelType,
        title: this.title,
        description: this.description,
        videoUrl: trailerUrl,
        createdDate: firebaseTimestamp.fromDate(new Date()),
        createdBy: auth.currentUser.displayName
      };
      let trailerRef = fireStore
        .collection(utils.trailerCollection)
        .doc(trailerId);
      try {
        await trailerRef.set(trailerData);
        this.showToast("Preview Uploaded Successfully");
        this.$router.push({ name: "MyChannels" });
      } catch (error) {
        // console.log(error);
        this.showToast("Preview Upload failed.");
      }
      this.processing = false;
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
