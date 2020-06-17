<template>

 <div id="upload_videos_previews_page">

  <div class="container-fluid">
    <div class="row">
      <div class="col-12">
        <p>
           <router-link
              :to="{
                      name: 'MyChannels'
                    }"
            >
               My Communities
            </router-link>
          &nbsp;<i class="fa fa-angle-right"></i>
           <router-link
                      :to="{
                      name: 'MyChannelDetails',
                        params: { channelId: channelData.channelId }
                      }"
                      >
                      {{channelData.title}}
                    </router-link>

          <i class="fa fa-angle-right"></i><a href="#">Upload a video</a>
        </p>
      </div>
    </div>
    <form @submit.prevent="doUploadVideo">
      <div class="row">
        <div class="col-sm-6 ">
          <div class="file_upload " style="padding: 0">
            <div class="file_upload_top_section">
              <div class="form-group fileUpload-input vedioUpload-input">
                <label for="videofile">Upload a video<i class="fa fa-info"></i><span>Recommended quality: 1080x720 - 4K</span></label>
                <div class="upload-btn-wrapper">

                  <upload-btn 
                    title="Click to upload your video"
                    style="padding: 0"
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
                </div>

                <span  class="error-message" v-if="this.errors['video']">{{this.errors['video']}}</span>
              </div>
            </div>
          </div>
          <div class="create_form_section">
            
              <div class="form-group" style="width: 100%">
                <label for="name">Title</label>
                <input v-model="title"  type="name" class="form-control" id="videoTitle" aria-describedby="name" placeholder="Please enter a title for the video" style="width: 100%">
                <span  class="error-message" v-if="this.errors['title']">{{this.errors['title']}}</span>
              </div>
          </div>
          <div class="create_form_section">
              <div class="custom-thumbnail-holder">
                <v-checkbox
                  v-bind:key="index"
                  style="margin-top: 0;     padding-top: 0;"
                  v-model="hasCustomThumbnail"
                  label="Upload Custom Thumbnail"
                  :value="checked"
                  >
                </v-checkbox>
              <div class="image-holder" v-if="hasCustomThumbnail" style="width:100%">
                <!-- Custom Thumbnail Image viewing -->
                <upload-btn
                  color="blue--text lighten-1"
                  style="background-color: #fff !important;border-radius:15px"
                  class="white--text"
                  title="Upload Thumbnail"
                  :fileChangedCallback="onCustomThumbnailSelected"
                  accept="image/*"
                  :uniqueId="unique"
                  round
                  >
                  <template slot="icon">
                    <div style="padding-left:4px">
                      <v-icon color="blue lighten-1">cloud_upload</v-icon>
                    </div>
                  </template>
                </upload-btn>
                <span  class="error-message" v-if="this.errors['thumbnail']">{{this.errors['thumbnail']}}</span>
                <v-layout padding justify-center>
                  <img :src="customThumbnailUrl" height="150" v-if="customThumbnailUrl" />
                </v-layout>
              </div>
            </div>
          </div>
        </div>
        <div class="col-sm-6">
          <!-- Video preview -->
            <!-- <div class=" form-group " v-if="videoFile != null">
              <video controls>
                <source :src="videoUrl" type="video/mp4" />Your browser does not support HTML5 video.
              </video>
            </div> -->
          <div class="create_form_section">
            <div class="form-row">
              <div class="form-group tags" style="width: 100%">
                <label for="name">Tags<i class="fa fa-info"></i><span>Add at least 5 tags</span>
                </label>
                <input type="name" class="form-control" id="tagsname" aria-describedby="name" placeholder="Tags here">
                <span  class="error-message" v-if="this.errors['tags']">{{this.errors['tags']}}</span>
              </div>
            </div>
          </div>
          <div class="create_form_section">
            <div class="form-row">
              <div class="form-group " style="width: 100%">
                <label for="longdescription">Long description<i class="fa fa-info"></i></label>
                <textarea v-model="description" class="form-control" id="longDescription" placeholder="Please type long description" rows="11" style="width: 100%"></textarea>
                <span  class="error-message" v-if="this.errors['description']">{{this.errors['description']}}</span>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-12">
          <div class="file_upload_btm_section">
            <div class="row">
              <div class="col-md-6">
                <div class="form-check circle-check">
                  <img src="../assets/Images/circle-check-icon.png" style="width: auto;">
                  <label class="form-check-label" for="defaultCheck1">
                    I agree to the <a href="#"> Privacy policy, Content creator terms <span>&</span> Call to action terms.</a>
                  </label>
                </div>
              </div>
              <div class="col-md-6">
                <div class="submit-btn-sec text-right" >
                  <button type="submit" class="btn btn-publish-video">Publish video now</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </form>
  </div>
</div>
</template>

<script>
  import UploadButton from "vuetify-upload-button";
  import { videoStorage, auth, firebaseTimestamp } from "../firebase/init";
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
        checked: true,

        customThumbnailFile: null,
        hasCustomThumbnail: false,
        customThumbnailUrl: "",
        rules: {
          required: value => !!value || "Required."
        },
        errors:{}
      };
    },
    props: ["channelData"],
    methods: {
      onVideoFileSelected(file) {
        this.videoFile = file;
        this.videoUrl = URL.createObjectURL(this.videoFile);
      },
      onCustomThumbnailSelected(file) {
        this.customThumbnailFile = file;
        this.customThumbnailUrl = URL.createObjectURL(this.customThumbnailFile);
      },
      async doUploadVideo() {

        this.errors={}

        let errorFound=false;

        if (this.title == "") {

          this.errors['title']="Titles cannot be empty!";
          errorFound=true;

        }
        if (this.description == "") {
         this.errors['description']="Description cannot be empty!";
         errorFound=true;
       }
       if (this.videoFile == null) {
        this.errors['video']="Please select a video!";
        errorFound=true;

      }

      if (this.hasCustomThumbnail == true && this.customThumbnailFile == null) {

        this.errors['thumbnail']="Please select a thumbnail!";
        errorFound=true;
      }

      if(errorFound){
        this.processing=false;
        this.$forceUpdate();
        return false; // if error found

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
        // console.log(e);
        this.show("VideoUpload failed.");
      }

      // Upload Custom Thumbnail
      let videoThumbnailRef = videoStorage
      .ref()
      .child(videoId)
      .child("thumbnail");
      let videoThumbnailUrl = "";

      if (this.hasCustomThumbnail == true) {
        try {
          await videoThumbnailRef.put(this.customThumbnailFile, {
            contentType: "image/*"
          });
          videoThumbnailUrl = await videoThumbnailRef.getDownloadURL();
        } catch (e) {
          // console.log(e);
          this.show("Thumbanil Upload failed.");
        }
      }

      let videoData = {
        videoId: videoId,
        categoryName: this.channelData.categoryName,
        categoryId: this.channelData.categoryId,
        userId: auth.currentUser.uid,
        channelId: this.channelData.channelId,
        channelName: this.channelData.title,
        channelType: this.channelData.channelType,
        hasCustomThumbnail: this.hasCustomThumbnail,
        customThumbnail: videoThumbnailUrl,
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
          // console.log(error);
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
  .error-message{
    font-size: 17px;
    display: block;
    color: #f00;
    text-align: left;
    padding-left: 10px;
    padding-top: 5px;

  }
</style>
