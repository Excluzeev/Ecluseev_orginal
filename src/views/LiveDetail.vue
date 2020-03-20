<template>
  <div class="home">
    <div id="excluzeev_live_page">
      <div class="container-fluid">
        
        <div class="row">
          <div class="inline-list"><a href="#">Communities</a>><a href="#">Bri N Teesh</a>><a href="#"></a>Start an excluzeev live</div>
          <br>
          <br>
        </div>
        
        <div class="row">
          <div class="col-xl-6">
            <div class="watch_live_vedio_section">
              <div class="list-inline ">
                <div class="list-inline d-flex pull-left">
                  <img src="../assets/Images/Copy of Bri N Teesh.png" class="rounded-circle"  style="width: 46px;height: 46px;">
                  <!-- <img class="rounded-circle" :src="video != null ? video.channelImage : ''"   style="width: 46px;height: 46px;"> -->

                  <h3 style="font-size:1em;">
                    <span>
                      BRI N TEESH
                    <!-- {{ video.channelName }} -->
                    </span>Started an excluzeev live...</h3>
                </div>
                <div class="pull-right">
                  <button class="btn btn-end-live" :disabled="showEndLiveProgress" @click="confirmEndLive">End Live</button>
                </div>
              </div>
              <div class="video_section">
                <img src="../assets/Images/video-img.png" class="img-fluid" style="width: 100%">

                <!-- <div v-show="!playerOptions.sources[0].src.isEmpty">
                  <video-player
                    class="video-holder vjs-big-play-centered"
                    width="100%"
                    height="auto"
                    id="player_id"
                    ref="videoPlayer"
                    :options="playerOptions"
                    @ready="playerIsReady"
                    @timeupdate="onPlayerTimeupdate($event)"
                  ></video-player>
                </div> -->

              </div>

              <div class="description_section">
                <h2>
                  Introducing the whole new exciting travel plan for a traveler in Korea.

                  <!-- {{ video.title }} -->
                </h2>
                <p>
                  <!-- {{ video.description }} -->
                  Two best friends who navigate life in Los Angeles, Explore the world and travel to different exciting destinations, experience different cuisines, lifestyle, meet people, learn culture and spread the love and positivity.
                  <!-- <a href="#collapse" class="nav-toggle ">Read Less</a> -->
                </p>
                <!-- <div id="collapse" class="content_text">
                  <p> Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Pharetra et ultrices neque ornare aenean euismod elementum nisi quis. In nulla posuere sollicitudin aliquam ultrices sagittis orci a scelerisque. Sem et tortor consequat id porta nibh.</p>
                  <p> Two best friends who navigate life in Los Angeles, Explore the world and travel to different exciting destinations, experience different cuisines, lifestyle, meet people, learn culture and spread the love and positivity. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Pharetra et ultrices neque ornare aenean euismod elementum nisi quis. In nulla posuere sollicitudin aliquam ultrices sagittis orci a scelerisque. Sem et tortor consequat id porta nibh.</p>
                </div> -->
              </div>
            </div>
          </div>

          <div class="col-xl-6">
					  <!-- <div v-if="!showComments" class="padding">
              <div class="logincomment text-xs-center">
                <p>
                  Please
                  <router-link :to="{ name: 'Login' }" class="quick-sand-font-b">login</router-link>to chat
                </p>
              </div>
            </div> -->
            <!-- <LiveChat v-if="showComments" :videoId="this.video.videoId"/> -->
            <LiveChat  :videoId="23231424"/>

            <div class="trending_vedios_title">
						  <h3 ><span>Trending videos</span></h3>
					  </div>

            <div class="related_video_section">
              <ul class="list-unstyled">
                <li>
                  <a href="#">
                    <div class="row">
                      <div class="col-xl-6">
                        <img src="../assets/Images/related-video.png" class="img-fluid" style="width: 100%">
                      </div>
                      <div class="col-xl-6">
                        <div class="video_title">
                          <h3><span>An amazing day in the land of potatoes</span></h3>
                          <h4>BRI N TEESH</h4>
                          <p>Watch a day spent in the whole garden of potatoes and some chips and fries in the best restaurant.</p>
                        </div>
                      </div>
                    </div>
                  </a>
                </li>
              </ul>
            </div>


          </div>

        
        </div>
      
      
      
      </div>

    </div>

     <v-dialog v-model="endLiveDialog" persistent max-width="320">
      <v-card>
        <v-card-title class="headline">Do you want to End Excluzeev Live?</v-card-title>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="green darken-1" flat @click="endLiveDialog = false">Cancel</v-btn>
          <v-btn color="green darken-1" flat @click="endLive">End</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    
  </div>

    <!--
    <v-layout class="main-holder" xs12 wrap>
      <v-flex xs12 sm12 md8 lg8 class="video-holder padding">
        <div v-show="!playerOptions.sources[0].src.isEmpty">
          <video-player
            class="video-holder vjs-big-play-centered"
            width="100%"
            height="auto"
            id="player_id"
            ref="videoPlayer"
            :options="playerOptions"
            @ready="playerIsReady"
            @timeupdate="onPlayerTimeupdate($event)"
          ></video-player>
        </div>
        <v-layout class="padding" align-center justify-left row fill-height>
          <v-layout class="padding" align-left justify-left column fill-height>
            <div class="title-details--text max-1-lines">{{ video.title }}</div>
            <div class="desc-details--text">{{ video.views }} views</div>
          </v-layout>
          <v-spacer></v-spacer>
          <a>
            <div v-ripple class="like-holder" @click="updateWhat('like')">
              <v-icon v-bind:class="{ active: isUserLiked }">thumb_up</v-icon>
            </div>
          </a>
          <a>
            <div v-ripple class="like-holder" @click="updateWhat('neutral')">
              <v-icon v-bind:class="{ active: isNeutral }">sentiment_dissatisfied</v-icon>
            </div>
          </a>
          <a>
            <div v-ripple class="like-holder" @click="updateWhat('dislike')">
              <v-icon v-bind:class="{ active: isUserDisLiked }">thumb_down</v-icon>
            </div>
          </a>
        </v-layout>
        <v-divider></v-divider>

        <v-layout class="padding" justify-left fill-height>
          <div class="padding">
            <img class="channel-image square" :src="video != null ? video.channelImage : ''">
          </div>

          <v-flex class="padding">
            <v-layout align-center justify-left row>
              <v-layout align-left justify-left column fill-height>
                <h2>{{ video.channelName }}</h2>
                <span class="published--text">Published {{ video.timeAgo }}</span>
              </v-layout>
              <v-spacer></v-spacer>
            </v-layout>

            <\!--Description--\>
            <div class="detail-description">
              <div>{{ video.description }}</div>
            </div>
          </v-flex>
          <div>
            <v-layout row wrap align-end style="align-items: center">
              <v-spacer></v-spacer>
              <v-btn
                class="white--text"
                color="red lighten-1"
                :disabled="showEndLiveProgress"
                @click="confirmEndLive"
              >
                <v-icon>close</v-icon>&nbsp;End Live
              </v-btn>
              <v-progress-circular v-if="showEndLiveProgress" indeterminate color="primary"></v-progress-circular>
            </v-layout>
          </div>
        </v-layout>

        <v-divider></v-divider>

        <\!--Stream Details Section--\>
        <div class="padding" v-if="shouldShowStartStream">
          <v-flex xs6>
            <div class="text-xs-center">
              <v-btn
                class="white--text"
                color="blue lighten-1"
                :loading="processing"
                :disabled="processing"
                @click="
                  loader = 'loading4';
                  createStreamNow();
                "
              >
                Start Stream
                <template v-slot:loader>
                  <span class="custom-loader">
                    <v-icon light>cached</v-icon>
                  </span>
                </template>
              </v-btn>
            </div>
          </v-flex>
        </div>
        <div class="padding" v-if="shouldShowStreamDetails">
          <v-flex xs12>
            <v-text-field
              disabled
              label="Stream Url"
              placeholder="Placeholder"
              value="rtmp://live.mux.com/app/"
              outline
            ></v-text-field>
          </v-flex>
          <v-flex xs12>
            <v-text-field
              :value="video.streamKey"
              :append-icon="showKey ? 'visibility' : 'visibility_off'"
              :type="showKey ? 'text' : 'password'"
              name="input-10-1"
              label="Stream Key"
              @click:append="showKey = !showKey"
              outline
            ></v-text-field>
          </v-flex>
        </div>
      </v-flex>
      <v-flex xs12 sm12 md4 lg4 class="linked-trailers">
        <div style="width: 100%;">
          <div v-if="!showComments" class="padding">
            <div class="logincomment text-xs-center">
              <p>
                Please
                <router-link :to="{ name: 'Login' }" class="quick-sand-font-b">login</router-link>to chat
              </p>
            </div>
          </div>
          <LiveChat v-if="showComments" :videoId="this.video.videoId"/>
        </div>
      </v-flex>
    </v-layout>
    <v-dialog v-model="endLiveDialog" persistent max-width="320">
      <v-card>
        <v-card-title class="headline">Do you want to End Excluzeev Live?</v-card-title>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="green darken-1" flat @click="endLiveDialog = false">Cancel</v-btn>
          <v-btn color="green darken-1" flat @click="endLive">End</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
  -->

</template>

<script>
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import videoModule from "../store/videos/video";
import { fireStore, auth } from "../firebase/init";
import utils from "../firebase/utils";
import axios from "axios";
import LiveChat from "../components/LiveChat";
import moment from "moment";

export default {
  name: "LiveSingle",
  data: () => {
    return {
      video: null,
      processing: false,
      showKey: false,
      shouldShowStreamDetails: false,
      shouldShowStartStream: false,
      endLiveDialog: false,
      playerOptions: {
        overNative: true,
        autoplay: true,
        preload: "auto",
        errorDisplay: false,
        liveui: true,
        controls: true,
        techOrder: ["html5"],
        sourceOrder: true,
        playbackRates: [0.7, 1.0, 1.5, 2.0],
        aspectRatio: "16:9",
        html5: { hls: { withCredentials: false } },
        sources: [
          {
            withCredentials: false,
            type: "application/x-mpegURL",
            src: ""
          }
        ],
        controlBar: {
          timeDivider: false,
          durationDisplay: false
        },
        poster: ""
      },
      isUserLiked: false,
      isUserDisLiked: false,
      isNeutral: false,
      prevWhat: -2
    };
  },
  components: {
    LiveChat
  },
  mixins: [RegisterStoreModule],
  computed: {
    player() {
      return this.$refs.videoPlayer.player;
    },
    showComments() {
      auth.onAuthStateChanged(user => {});
      return auth.currentUser != null;
    }
  },
  mounted() {
    // console.log("this is current player instance object", this.player);
  },
  created() {
    this.registerStoreModule("videos", videoModule);
    this.$store
      .dispatch("videos/fetchVideo", {
        videoId: this.$route.params.videoId
      })
      .then(vData => {
        axios
          .post(
            "https://us-central1-trenstop-2033f.cloudfunctions.net/videoWebHook",
            {
              videoId: vData.videoId,
              playbackId: vData.playbackId
            }
          )
          .then(response => {
            this.video = vData;
            let fUser = JSON.parse(localStorage.getItem("fUser"));
            // if (this.video.userId != auth.currentUser.uid) {
            //   this.$router.replace({ name: "Home" });
            //   return;
            // }

            this.playerOptions.sources[0].src = response.data;
            this.playerOptions.poster = this.video.image;

            if (this.video.userId == auth.currentUser.uid) {
              this.shouldShowStartStream = this.video.later == "later";
              this.shouldShowStreamDetails = this.video.later != "later";
            } else {
              this.shouldShowStreamDetails = false;
              this.shouldShowStartStream = false;
              if (!fUser.subscribedChannels.includes(this.video.channelId)) {
                this.$router.replace({ name: "Home" });
              }
            }

            try {
              if (
                moment(this.video.streamCreatedDate.toDate()).diff(
                  new Date(),
                  "hours"
                ) < -13
              ) {
                this.shouldShowStreamDetails = false;
              }
            } catch (e) {
              // console.log(e);
            }

            // this.shouldShowStreamDetails = moment(this.video.)
          })
          .catch(error => {
            // console.log(error);
          });

        this.getLikes();
      });
  },
  methods: {
    async createStreamNow() {
      let videoData = {
        videoId: this.video.videoId
      };
      axios
        .post(
          "https://us-central1-trenstop-2033f.cloudfunctions.net/createMuxLive",
          videoData
        )
        .then(response => {
          let d = response.data;
          if (d.error) {
            this.showToast(d.message);
          } else {
            this.showToast("Live Created Successfully");
            this.video.streamKey = d.message;
            this.shouldShowStartStream = false;
            this.shouldShowStreamDetails = true;
          }
          this.processing = false;
          // this.shouldShowStreamDetails = moment(this.video.)
        })
        .catch(error => {
          this.processing = false;
          // console.log(error);
        });
    },
    async getLikes() {
      if (auth.currentUser == null) {
        return;
      }
      let userId = auth.currentUser.uid;
      let snap = await fireStore
        .collection(utils.likesCollection)
        .doc(userId + ":" + this.$route.params.videoId + ":v")
        .get();
      if (snap.exists) {
        let data = snap.data();
        this.prevWhat = data.what;
        if (data.what == 0) {
          this.isNeutral = true;
        } else if (data.what == 1) {
          this.isUserLiked = true;
        } else if (data.what == 1) {
          this.isUserDisLiked = true;
        }
      }
    },
    async updateWhat(newWhat) {
      let what = 0;
      if (newWhat == "like") {
        what = 1;
      }
      if (newWhat == "dislike") {
        what = -1;
      }
      if (newWhat == "neutral") {
        what = 0;
      }
      if (auth.currentUser == null) {
        return;
      }
      let userId = auth.currentUser.uid;
      let whatDoc = await fireStore
        .collection(utils.likesCollection)
        .doc(userId + ":" + this.$route.params.videoId + ":t")
        .get();
      if (whatDoc.exists) {
        await whatDoc.ref.update({
          what: what
        });
      } else {
        await whatDoc.ref.set({
          what: what
        });
      }

      if (what == 0) {
        this.isNeutral = true;
        this.isUserDisLiked = false;
        this.isUserLiked = false;
      }

      if (what == 1) {
        this.isNeutral = false;
        this.isUserDisLiked = false;
        this.isUserLiked = true;
      }

      if (what == -1) {
        this.isNeutral = false;
        this.isUserDisLiked = true;
        this.isUserLiked = false;
      }
    },
    showToast(msg) {
      this.$toasted.show(msg, {
        theme: "outline",
        position: "top-right",
        duration: 2000
      });
    },
    async triggerVideoView() {
      let videoRef = fireStore
        .collection(utils.videosCollection)
        .doc(this.video.videoId);
      fireStore
        .runTransaction(transaction => {
          // This code may get re-run multiple times if there are conflicts.
          return transaction.get(videoRef).then(vData => {
            if (!vData.exists) {
              // throw "Document does not exist!";
              return;
            }
            let views = vData.data().views;
            if (views == undefined || views == null) {
              views = 0;
            }
            views = views + 1;

            transaction.update(videoRef, { views: views });
          });
        })
        .then(() => {
          // console.log("Transaction successfully committed!");
        })
        .catch(error => {
          // console.log("Transaction failed: ", error);
        });
    },

    confirmEndLive() {
      this.endLiveDialog = true;
    },
    endLive() {
      this.showEndLiveProgress = true;
      this.endLiveDialog = false;
      //  endLive
      let data = {
        liveId: this.video.muxId,
        videoId: this.video.videoId
      };
      axios
        .post(
          "https://us-central1-trenstop-2033f.cloudfunctions.net/endLive",
          data
        )
        .then(response => {
          // let d = response.data;
          this.$router.push({
            name: "VideoSingle",
            params: { videoId: this.video.videoId }
          });
          // this.shouldShowStreamDetails = moment(this.video.)
        })
        .catch(error => {
          // console.log(error);

          this.showEndLiveProgress = false;
        });
    },
    onPlayerTimeupdate(event) {
      if (
        this.$refs.videoPlayer.player.currentTime() > 5 &&
        !this.isViewTriggered
      ) {
        this.triggerVideoView();
        this.isViewTriggered = true;
      }
    }
  }
};
</script>

<style scoped lang="scss">
.main-holder {
  align-items: flex-start;
}
.channel-image {
  border-radius: 50%;
  object-fit: cover;
}
.square {
  width: 64px;
  height: 64px;
}
.padding {
  padding: 10px;
}
.like-holder {
  padding: 10px;
}
.active {
  color: #42a5f5;
}
.published--text {
  color: rgba(17, 17, 17, 0.6);
}
.detail-description {
}
.linked-trailers {
  padding-left: 10px;
  padding-right: 10px;
}
.v-text-field__details {
  display: none;
}
h3 {
    font-size: -1.3125rem !important;
}
</style>
