<template>  

     
    <div id="watch_preview_page">
			<div class="container-fluid">
				<div class="row">

					<div class="col-xl-6">
						<div class="watch_vedio_section">
              <div v-show="!playerOptions.sources[0].src.isEmpty">

                <video id="example_video_1" class="video-js"
                  controls preload="auto" width="100%" height="264">
                </video>

                <!-- <video
                id="my-video"
                class="video-js"
                controls
                preload="auto"
                width="640"
                height="264"
                data-setup="{}"
              >
                <source src="https://stream.mux.com/WBNqLzM7tcxvTJWLhd01VlQguezFkAZuB.m3u8" type="application/x-mpegURL" />
                <p class="vjs-no-js">
                  To view this video please enable JavaScript, and consider upgrading to a
                  web browser that
                  <a href="https://videojs.com/html5-video-support/" target="_blank"
                    >supports HTML5 video</a
                  >
                </p>
              </video> -->
      
                <!-- <video-player
                  class="video-holder vjs-big-play-centered"
                  width="100%"
                  height="auto"
                  id="player_id"
                  ref="videoPlayer"
                  :options="playerOptions"
                  @ready="playerIsReady"
                  @timeupdate="onPlayerTimeupdate($event)"
                ></video-player> -->


              </div>


              <h2 class="d-none d-md-none d-sm-none d-lg-block d-xl-block" v-if="video">{{ video.title }}</h2>
							<div class="list-inline video_content">
								<div class="list-inline d-flex pull-left">
									<img :src="video != null ? video.channelImage : ''" class="rounded-circle"  style="width: 46px;height: 46px;">
									<h5><span v-if="video">{{ video.channelName }}</span><br><span class="sub_title d-block  d-sm-block d-xl-none d-lg-none">Artist/Band/Vlog</span></h5>
								</div>

								<div class="pull-right">
    
                                    <!--
									<div class="btn-group" role="group"  v-if="showSubscribeButton">
            
										<button  type="button" class="btn btn-per-month d-none d-xl-block d-lg-block" ata-toggle="modal" data-target="#joinCommunityModal"><span v-if="channel">${{ channel.price }} </span> per month</button>
										<button type="button" class="btn btn-join-community d-none d-xl-block d-lg-block" data-toggle="modal" data-target="#joinCommunityModal">Join community</button>
									</div>

                                    <div class="btn-group" v-if="!showSubscribeButton">
 
										<span v-if="channel">${{ channel.price }} </span>/Month
                                    </div>
                                    -->
								</div>
								<div class="clearfix"></div>
								<p > <span v-if="video">{{ video.description }}</span>
									<a href="#collapse" class="nav-toggle ">Read Less</a>
								</p>
								<div id="collapse" class="content_text">
								</div>
							</div>

          

              <div v-if="showComments" class="chat_section d-none d-xl-block d-lg-block">
							
              	<h3><span>Comments</span></h3>
                <div>
                  <v-textarea
                    solo
                    label="Add a comment"
                    rows="1"
                    auto-grow
                    v-model="commentText"
                  ></v-textarea>
                  <v-layout>
                    <v-spacer></v-spacer>
                    <v-btn
                      class="white--text quick-sand-font-b"
                      color="blue lighten-1"
                      :disabled="disabelComment"
                      @click="doComment"
                      >Comment</v-btn
                    >
                  </v-layout>
                </div>
                <div v-if="!showComments">
                  <div class="logincomment text-xs-center">
                    <p>
                      Please
                      <a href="javascript://" class="quick-sand-font-b" @click="showLoginForm">sign in</a>
                    to comment
                    </p>
                  </div>
                </div>

            


                <template v-if="commentsList.length > 0">
                  <div class="user_comment_section d-flex"  v-for="comment in commentsList"  v-bind:key="comment.commentId">
                    <div class="user_name_comment">
                      <ul class="list-unstyled">
                        <li class="list-inline">
                          <h3 class="pull-left">{{ comment.userName }}</h3>
                          <div class="posted_time pull-right"><p>{{ comment.timeAgo }}</p></div>
                          <div class="clearfix"></div>
                        </li>
                        <li><p>{{ comment.comment }}</p></li>
                      </ul>
                    </div>
                  </div>
                </template>

                 <v-flex v-else text-xs-center>
                  <div class="nocomment">
                    <p>No comments yet, be the first</p>
                  </div>
                </v-flex>


              </div>


            </div>

            



					</div>     

          <div class="col-xl-6">
						<div class="row ">
							<div class="col-xl-5 col-lg-5 ">
								<div class="start_excluzeev_btn_section d-none d-xl-block d-lg-block">
									<div class=" start_excluzeev_btn_description">
										<p>Start excluzeev live now and interact with the fans. </p>
										<br>
										<p>Just a click away.</p>
									</div>
								</div>
							</div>
							<div class="col-xl-7 col-lg-7">
								<div class="d-none d-xl-block d-lg-block">
									<button class="btn btn-start-excluzeev-live" @click="goLive"><img src="../assets/Images/live-blue.png" style="width: 36px">&nbsp;&nbsp;Start Excluzeev Live</button>
								</div>
							</div>
						</div>
						<div class="clearfix"></div>

            <div class="related_video_section">
							<ul class="list-unstyled">


                      <VideoDetailVideoItem
                        v-for="video in channelVideosList"
                        v-bind:key="video.videoId"
                        :video="video"
                      />
							
							</ul>
            </div>


          </div>


        </div>
			</div>


      <!-- Model for Join Community  -->
		<div class="modal fade bd-example-modal-md" id="joinCommunityModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-md modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header text-center">
						<!-- <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5> -->
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">Close</span>
						</button>
					</div>
					<div class="modal-body text-center">
						<br>
						<br>
						<h2>Join Community</h2>
						<div class="clearfix"></div>
						<p>Join Community and explore the exluzeev videos and intaract with the amazing people behind the community</p>
						<div class="clearfix"></div>
						<br>
						<div class="community_section" style="padding:0 !important;">
							<div class="text-center img_title">
								<div class="list-inline d-flex pull-left">
									<img src="assets/Images/Copy of Bri N Teesh.png" class="rounded-circle"  style="width: 46px;height: 46px;">&nbsp;&nbsp; &nbsp;
									<h3><span v-if="video">{{ video.channelName }}</span></h3>
								</div>
							</div>

							<div class="clearfix"></div>
							<form>
								<div class="form-row">
									<div class="form-group col-md-12">
										<div class="clearfix"></div>
										<br>
										<h2>${{ channel.price }}</h2>
										<br>

									</div>
								</div>
							</form>
							<div class="clearfix"></div>
						</div>
						<button :disabled="subscribeProcessing" :loading="subscribeProcessing" v-if="showSubscribeButton" @click="checkout" class="btn btn-join-via-stripe" >Let's join via Stripe</button>
						<br><br>
						<div class="note_section">
							<p>NOTE: Price are in CAD(Canadian Dollars)</p>
						</div>
						<br><br><br><br><br>
					</div>
				</div>
			</div>
		</div>
		<!-- End -->
		


    </div> 


  


</template>

<script>
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import videoModule from "../store/videos/video";
import { fireStore, auth, firebaseTimestamp } from "../firebase/init";
import utils from "../firebase/utils";
import axios from "axios";
import moment from "moment";
import VideoDetailVideoItem from "../components/VideoDetailVideoItem";

export default {
  name: "VideoSingle",
  data: () => {
    return {
      channel:{},
      video: {},
      commentsList: [],
      channelVideosList: [],
      commentText: "",
      playerOptions: {
        overNative: true,
        autoplay: true,
        errorDisplay: false,
        preload: "auto",
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
        poster: ""
      },
      isUserLiked: false,
      isUserDisLiked: false,
      isNeutral: false,
      prevWhat: -2,
      showSubscribeButton: false,

    };
  },
  components: {
    VideoDetailVideoItem
  },
  mixins: [RegisterStoreModule],
  computed: {
    player() {
      return this.$refs.videoPlayer.player;
    },
    disabelComment() {
      return this.commentText == "";
    },
    showComments() {
      auth.onAuthStateChanged(user => {});
      return auth.currentUser != null;
    }
  },
  mounted() {},
  created() {

    // To detach the attached video play
    var oldPlayer = document.getElementById('example_video_1');
    console.log("oldPlayer",oldPlayer)
    if(oldPlayer)
      videojs(oldPlayer).dispose();
    



    this.registerStoreModule("videos", videoModule);


            this.$store
          .dispatch("trailers/fetchChannel", {
            channelId: this.video.channelId
          })
          .then(data => {
            this.channel = data;
          });


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
            this.playerOptions.sources[0].src = response.data;
            this.video = vData;
            this.playerOptions.poster = this.video.image;


            // console.log("player options",this.playerOptions.sources[0].src)
            let _vm=this
            $(document).ready(function(){

             if(_vm.playerObj == null){
                  _vm.playerObj=videojs("example_video_1",_vm.playerOptions, function(){

                });
             }


             _vm.playerIsReady(this) // Onready

            });





            this.$store
              .dispatch("videos/getUserChannelVideos", {
                channelId: this.video.channelId
              })
              .then(videosList => {
                this.channelVideosList = videosList;
              });
          })
          .catch(error => {
            // console.log(error);
          });

        this.getLikes();

        this.getComments();
      });
  },
  methods: {
    
       showLoginForm(){
    
        this.$root.$emit('openLoginForm');

    },

        goLive(){

      if (this.showLogin) {
        this.$root.$emit('openLoginForm');

      } else {
        this.$router.push({ name: "AddExcluzeev" });
      }


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
    onPlayerTimeupdate(event) {
      if (
        this.$refs.videoPlayer.player.currentTime() > 5 &&
        !this.isViewTriggered
      ) {
        this.triggerVideoView();
        this.isViewTriggered = true;
      }
    },
    async doComment() {
      let fUser = JSON.parse(
        localStorage.getItem("fUser") != null
          ? localStorage.getItem("fUser")
          : {}
      );

      let commentId = utils.generateId();

      let data = {
        comment: this.commentText,
        userPhoto: fUser.userPhoto == undefined ? "" : fUser.userPhoto,
        createdDate: firebaseTimestamp.fromDate(new Date()),
        channelName: this.video.channelName,
        channelId: this.video.channelId,
        userId: fUser.uid,
        userName: fUser.firstName + " " + fUser.lastName,
        vtId: this.video.videoId,
        commentId: commentId
      };

      let commentRef = fireStore
        .collection(utils.videosCollection)
        .doc(this.video.videoId)
        .collection(utils.commentsCollections)
        .doc(commentId);

      await commentRef.set(data);

      this.commentText = "";
    },
    async getComments() {
      let commentRef = fireStore
        .collection(utils.videosCollection)
        .doc(this.$route.params.videoId)
        .collection(utils.commentsCollections)
        .orderBy("createdDate", "desc")
        .limit(50);

      // let commentData = await commentRef.get();

      commentRef.onSnapshot(querySnapshot => {
        let commentsList = [];
        querySnapshot.forEach(function(doc) {
          let d = doc.data();
          d.timeAgo = moment(d.createdDate.toDate()).fromNow();
          commentsList.push(d);
        });
        this.commentsList = commentsList;
      });
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
.video-js{width:100%}
</style>
