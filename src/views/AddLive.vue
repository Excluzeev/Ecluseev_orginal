<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">
  <div id="create_community_page">
  
    <div class="container-fluid">

        <div class="row">
          <div class="col-xl-12">
            <div class="create_community_page_title_section">
              <h2>Create an Excluzeev Live</h2>
              <p>Start Excluzeev live!</p>
            </div>
          </div>
        </div>
   
        <form @submit.prevent="doUploadVideo">

			    <div class="row">
				    <div class="col-xl-6">
					    <div class="create_form_section">

							  <div class="form-row">
								  <div class="form-group col-md-12">
									  <label for="name">Title<i class="fa fa-info"></i></label>
									  <input v-model="videoTitle" type="name" class="form-control" id="" aria-describedby="title" placeholder="Title">
                    <span  class="error-message" v-if="this.errors['title']">{{this.errors['title']}}</span>
							  	</div>
                </div>

                <div class="form-row">
								  <div class="form-group col-md-12">
									  <label for="name">Description<i class="fa fa-info"></i></label>
									  <textarea v-model="description"  class="form-control" id="" aria-describedby="description" placeholder="Description"></textarea>
                    <span  class="error-message" v-if="this.errors['description']">{{this.errors['description']}}</span>
							  	</div>
                </div>

                <div class="form-row" >
                  <div class="form-group col-md-12">
									  <label for="Category">Channel<i class="fa fa-info"></i></label>
								  	<select   v-model="selectedChannel" class="form-control" id="selectedChannel" placeholder="Choose a channel">
									  	<option v-for="ch in channelsList" v-text="ch.title" v-bind:value="ch.channelId" v-bind:key="ch.id"></option>
								  	</select>
                    <span  class="error-message" v-if="this.errors['channel']">{{this.errors['channel']}}</span>
							  	</div>
                </div>

              </div>
            </div>

            <div class="col-xl-6 col-lg-6">
              
                <div class="form-row" >
                  <div class="form-group col-md-8">
                          
                    <v-radio-group v-model="timePublish" :mandatory="true" row v-on:change="timeUpdate">
                      <v-radio label="Now" value="now"></v-radio>
                      <v-radio label="Schedule" value="later"></v-radio>
                    </v-radio-group>

                
                    <!-- <span  class="error-message" v-if="this.errors['channel']">{{this.errors['channel']}}</span> -->
							  	</div>
                </div>

                

                <div class="form-row"  v-if="showDateTime">
                  <div class="form-group col-md-8">
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
                        <v-btn flat color="primary" @click="dateModal = false">Cancel</v-btn>
                        <v-btn flat color="primary" @click="$refs.datedialog.save(date)">OK</v-btn>
                      </v-date-picker>
                    </v-dialog>
                  
                  </v-flex>

                
                    <!-- <span  class="error-message" v-if="this.errors['channel']">{{this.errors['channel']}}</span> -->
							  	</div>
              </div>

              
              <div class="form-row" v-if="showDateTime">
                <div class="form-group col-md-8">

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
                        <v-btn flat color="primary" @click="timeModal = false">Cancel</v-btn>
                        <v-btn flat color="primary" @click="$refs.timedialog.save(time)">OK</v-btn>
                      </v-time-picker>
                    </v-dialog>
                  </v-flex>
        
        
                  <!-- <span  class="error-message" v-if="this.errors['channel']">{{this.errors['channel']}}</span> -->
							  </div>
              </div>

                 <div class="form-row" >
                <div class="form-group col-md-8">
                    <button type="submit" class="btn btn-publish-video" :loading="processing" :disabled="processing" @click="loader = 'loading4'">Start Live</button>

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
      <v-layout v-if="showAddLive" align-center justify-center>
        <v-flex xs12 sm8 md4>
          <v-card class="elevation-9">
            <v-toolbar dark color="blue lighten-1">
              <v-toolbar-title>Excluzeev Live</v-toolbar-title>
            </v-toolbar>
            <v-card-text>
              <v-form class="blue--text lighten-1" @submit.prevent="doUploadVideo">
                <v-text-field
                  v-model="videoTitle"
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

                <v-select
                  v-if="getChannel && channelsList.length > 0"
                  v-model="selectedChannel"
                  hint="Select Channel"
                  :items="channelsList"
                  item-text="title"
                  label="Select Channel"
                  persistent-hint
                  return-object
                  single-line
                ></v-select>

                <v-radio-group v-model="timePublish" :mandatory="true" row v-on:change="timeUpdate">
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
                        <v-btn flat color="primary" @click="dateModal = false">Cancel</v-btn>
                        <v-btn flat color="primary" @click="$refs.datedialog.save(date)">OK</v-btn>
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
                        <v-btn flat color="primary" @click="timeModal = false">Cancel</v-btn>
                        <v-btn flat color="primary" @click="$refs.timedialog.save(time)">OK</v-btn>
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
                    <v-btn class="white--text" color="grey lighten-1" @click="$router.back()">Cancel</v-btn>
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
                  @click="checkStreamStatus()"
                >Next</v-btn>
                <v-progress-circular v-if="checkingStream" indeterminate color="primary"></v-progress-circular>
              </v-flex>
            </v-card-text>
          </v-card>
        </v-flex>
      </v-layout>
    </v-container>
  </v-content>
  -->

</template>

<script>
import { auth, firebaseTimestamp, fireStore } from "../firebase/init";
import utils from "../firebase/utils";
import axios from "axios";
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import channelsModule from "../store/channels/channels";
import moment from "moment";

export default {
  data: () => {
    return {
      title: "Excluzeev Live",
      videoTitle: "",
      channelsList: [],
      selectedChannel: null,
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
      },
      errors:{},
    };
  },
  mixins: [RegisterStoreModule],
  props: ["channelData"],
  created() {
    this.registerStoreModule("channels", channelsModule);
  },
  computed: {
    getChannel() {
      return this.channelData == null;
    }
  },
  mounted() {
    if (this.getChannel) {
      this.$store.dispatch("channels/getChannels").then(data => {
        data.forEach(d => {
          if (d.isDeleted != true) {
            this.channelsList.push(d);
          }
        });
      });
    }
  },
  methods: {
    timeUpdate(pub) {
      if (pub == "later") {
        this.showDateTime = true;
      } else {
        this.showDateTime = false;
      }
    },
    getChannelData(){
      for(let i=0;i<this.channelsList.length;i++){
        if(this.channelsList[i].channelId == this.selectedChannel){
          return this.channelsList[i]
        }
      }
      return false
    },
    async doUploadVideo() {
      
      let errorFound=false;

      if (this.videoTitle == "") {
        this.errors['title']="Title cannot be empty";
        errorFound=true;
      }

      if (this.description == "") {
        this.errors['description']="Description cannot be empty";
        errorFound=true;
      }

      if (this.selectedChannel ==null) {
        this.errors['channel']="Please select a channel";
        
        errorFound=true;
      }


      if(errorFound){
        
        this.processing = false;
        this.$forceUpdate();
        return false; // if error found

      }

      let channelData=this.getChannelData()

      if(channelData == false){
        this.errors['channel']="Unable to fetch channel data"
        this.processing = false;
        this.$forceUpdate();
        return false;
      }

      this.processing = true;

      let videoId = utils.generateId();

      let channelD;
      if (this.getChannel) {
        
        channelD = channelData;
      } else {
        channelD = this.channelData;
      }

      // For testing
      //this.$router.replace("/live/" + videoId);
      //return

      let videoData = {
        videoId: videoId,
        categoryName: channelD.categoryName,
        categoryId: channelD.categoryId,
        userId: auth.currentUser.uid,
        channelId: channelD.channelId,
        channelName: channelD.title,
        title: this.videoTitle,
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
      this.checkingStream = true;
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
