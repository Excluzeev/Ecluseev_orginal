<template>

  <div id="upload_videos_previews_page">

		<div class="container-fluid">
			<div class="row">
				<div class="col-12">
					<p><a href="#">My account</a>&nbsp;<i class="fa fa-angle-right"></i><a href="#">{{channelData.title}}</a>&nbsp;<i class="fa fa-angle-right"></i><a href="#">Upload a video</a>
					</p>
					
				</div>

			</div>
      <form @submit.prevent="doUploadTrailer">
        <div class="row">
          
          <div class="col-xl-5 col-lg-5 col-12">
            <div class="file_upload ">
              <div class="file_upload_top_section">
                <div class="form-group fileUpload-input vedioUpload-input">
                  <label for="videofile">Upload a video<i class="fa fa-info"></i><span>Recommended quality: 1080x720 - 4K</span></label>
                  <div class="upload-btn-wrapper">
                      
                
                      <button type="button" class="btn btn-file-upload">
                        <img src="../assets/Images/upload.png" style="width: auto;"> <br><br> Click to upload your video
                     
                         <upload-btn
                        
                        title="Upload"
                        :fileChangedCallback="onVideoFileSelected"
                        accept="video/mp4, video/x-m4v, video/*"
                        :uniqueId="unique"
                        round
                      >

                      </upload-btn>

                      </button>
                       
                      
                      <!-- <input accept="video/mp4, video/x-m4v, video/*" @change="onVideoFileSelected" type="file" class="form-control-file" id="uploadVideoFile" name="myfile"> -->
              
              
                  </div>
                   

                  <span  class="error-message" v-if="this.errors['video']">{{this.errors['video']}}</span>

                </div>


                <div class="create_form_section">
                    <div class="form-group ">
                      <label for="name">Title</label>

                      <input v-model="title"  type="name" class="form-control" id="videoTitle" aria-describedby="name" placeholder="Please enter a title for the video">
                      <span  class="error-message" v-if="this.errors['title']">{{this.errors['title']}}</span>

                    </div>

                </div>
              </div>
            </div>
          </div>
          <div class="col-xl-7 col-lg-7 col-12">

            
                <div class="create_form_section">
                    <div class="form-group tags">
                      <label for="name">Tags<i class="fa fa-info"></i><span>Add at least 5 tags</span></label>
                      <input type="name" class="form-control" id="tagsname" aria-describedby="name" placeholder="Tags here">
                      <span  class="error-message" v-if="this.errors['tags']">{{this.errors['tags']}}</span>
                      

                    </div>
                </div>

            <div class="create_form_section">
                <!-- Video preview -->
                <div class=" form-group " v-if="videoFile != null">
                  <video controls>
                    <source :src="videoUrl" type="video/mp4" />Your browser does not support HTML5 video.
                  </video>
                </div>

            </div>
            <div class="create_form_section">
              <div class="form-row">
                <div class="form-group col-md-12">
                  <label for="longdescription">Long description<i class="fa fa-info"></i></label>
                  <textarea v-model="description" class="form-control" id="longDescription" placeholder="Please type long description" rows="3"></textarea>
                  <span  class="error-message" v-if="this.errors['description']">{{this.errors['description']}}</span>

                </div>
              </div>

              <div class="create_form_section">
                <div class="form-row">
                  <div class="custom-thumbnail-holder">
                    <v-checkbox
                      style="margin-top: 0;     padding-top: 0;"
                      v-model="hasCustomThumbnail"
                      label="Upload Custom Thumbnail"
                      :value="checked"
                    ></v-checkbox>
                  </div>
                  
                  <div class="image-holder" v-if="hasCustomThumbnail">
                    <!-- Custom Thumbnail Image viewing -->
                    <upload-btn
                    color="blue--text lighten-1"
                    style="background-color: #fff !important;"
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

                <div class="file_upload_btm_section">
                  <div class="form-check circle-check">
                    <img src="../assets/Images/circle-check-icon.png" style="width: auto;">
                    <label class="form-check-label" for="defaultCheck1">
                      I agree to the <a href="#"> Privacy policy, Content creator terms <span>&</span> Call to action terms.</a>
                    </label>
                  </div>
                  <button type="submit" class="btn btn-publish-video" :loading="processing" :disabled="processing" @click="loader = 'loading4'">Publish video now</button>
                </div>
            </div>
          </div>
        </div>
      
      </form>

		</div>
	</div>

  <!--
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
                    <source :src="videoUrl" type="video/mp4" />Your browser does not support HTML5 video.
                  </video>
                </div>
                <div class="custom-thumbnail-holder">
                  <v-checkbox
                    v-bind:key="index"
                    style="margin-top: 0;     padding-top: 0;"
                    v-model="hasCustomThumbnail"
                    label="Upload Custom Thumbnail"
                    :value="checked"
                  ></v-checkbox>
                </div>
                <div class="image-holder" v-if="hasCustomThumbnail">
                  <\!-- Custom Thumbnail Image viewing --\>
                  <upload-btn
                    color="blue--text lighten-1"
                    style="background-color: #fff !important;"
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
                  <v-layout padding justify-center>
                    <img :src="customThumbnailUrl" height="150" v-if="customThumbnailUrl" />
                  </v-layout>
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
  -->

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
      checked: true,
      customThumbnailFile: null,
      hasCustomThumbnail: false,
      customThumbnailUrl: "",
      processing: false,
      unique: true,
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
      // console.log('sds',file)
      this.videoUrl = URL.createObjectURL(this.videoFile);
    },
    onCustomThumbnailSelected(file) {
      this.customThumbnailFile = file;
      this.customThumbnailUrl = URL.createObjectURL(this.customThumbnailFile);
    },
    async doUploadTrailer() {
      console.log("Started uploading") 
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

      // Upload Custom Thumbnail
      let trailerThumbnailRef = publicStorage
        .ref()
        .child(this.channelData.channelId)
        .child(trailerId)
        .child("thumbnail");
      let trailerThumbnailUrl = "";

      if (this.hasCustomThumbnail == true) {
        try {
          await trailerThumbnailRef.put(this.customThumbnailFile, {
            contentType: "image/*"
          });
          trailerThumbnailUrl = await trailerThumbnailRef.getDownloadURL();
        } catch (e) {
          // console.log(e);
          this.show("Thumbanil Upload failed.");
        }
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
        hasCustomThumbnail: this.hasCustomThumbnail,
        customThumbnail: trailerThumbnailUrl,
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
.error-message{
    font-size: 17px;
    display: block;
    color: #f00;
    text-align: left;
    padding-left: 10px;
    padding-top: 5px;

}


</style>
