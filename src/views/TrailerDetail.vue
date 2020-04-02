<template>
  
    <div id="watch_preview_page">
			<div class="container-fluid">
				<div class="row">

					<div class="col-xl-6">
						<div class="watch_vedio_section">
              <div v-show="!playerOptions.sources[0].src.isEmpty">

                <video id="example_video_1" class="video-js"
                  controls preload="auto" width="640" height="264">
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


              <h2 class="d-none d-md-none d-sm-none d-lg-block d-xl-block" v-if="trailer">{{ trailer.title }}</h2>
							<div class="list-inline video_content">
								<div class="list-inline d-flex pull-left">
									<img :src="trailer != null ? trailer.channelImage : ''" class="rounded-circle"  style="width: 46px;height: 46px;">
									<h5><span v-if="trailer">{{ trailer.channelName }}</span><br><span class="sub_title d-block  d-sm-block d-xl-none d-lg-none">Artist/Band/Vlog</span></h5>
								</div>

								<div class="pull-right">
									<div class="btn-group" role="group"  v-if="showSubscribeButton">
            
										<button  type="button" class="btn btn-per-month d-none d-xl-block d-lg-block" ata-toggle="modal" data-target="#joinCommunityModal"><span v-if="channel">${{ channel.price }} </span> per month</button>
										<button type="button" class="btn btn-join-community d-none d-xl-block d-lg-block" data-toggle="modal" data-target="#joinCommunityModal">Join community</button>
									</div>

                                    <div class="btn-group" v-if="!showSubscribeButton">
 
										<span v-if="channel">${{ channel.price }} </span>/Month
                                    </div>

								</div>
								<div class="clearfix"></div>
								<p > <span v-if="trailer">{{ trailer.description }}</span>
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
                      <router-link :to="{ name: 'Login' }" class="quick-sand-font-b"
                        >sign in</router-link
                      >to comment
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
                <TrailerDetailVideoItem
                v-for="trailer in catTrailersList"
                v-bind:key="trailer.trailerId"
                :trailer="trailer"
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
                                                                        <img :src="trailer != null ? trailer.channelImage : ''" class="rounded-circle"  style="width: 46px;height: 46px;">

									<h3><span v-if="trailer">{{ trailer.channelName }}</span></h3>
								</div>
							</div>

							<div class="clearfix"></div>
							<form>
								<div class="form-row">
									<div class="form-group col-md-12">
										<div class="clearfix"></div>
										<br>
										<h2 class="m-0 p-0">${{ channel.price }}</h2>
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
		

        <vue-stripe-checkout
          ref="checkoutRef"
          name="Payment Details"
          description
          currency="CAD"
          :amount="channel.price * 100"
          :allow-remember-me="false"
          @done="done"
          @opened="opened"
          @closed="closed"
          @canceled="canceled"
        ></vue-stripe-checkout>


    </div> 
   <!--
  <div class="home">
    <vue-headful
      :title="trailer.title"
      :description="trailer.description"
      :image="trailer.image"
      :url="'https://excluzeev.com' + this.$route.path"
    />
    <v-layout class="main-holder" xs12 wrap v-if="videoLoaded">
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
            <div class="title-details--text max-1-lines quick-sand-font-b">
              {{ trailer.title }}
            </div>
            <!\--<div class="desc-details--text">{{ trailer.views }} views</div>--\>
          </v-layout>
          <v-spacer></v-spacer>
          <a>
            <div v-ripple class="like-holder" @click="updateWhat('like')">
              <v-icon v-bind:class="{ active: isUserLiked }">thumb_up</v-icon>
            </div>
          </a>
          <a>
            <div v-ripple class="like-holder" @click="updateWhat('neutral')">
              <v-icon v-bind:class="{ active: isNeutral }"
                >sentiment_dissatisfied</v-icon
              >
            </div>
          </a>
          <a>
            <div v-ripple class="like-holder" @click="updateWhat('dislike')">
              <v-icon v-bind:class="{ active: isUserDisLiked }"
                >thumb_down</v-icon
              >
            </div>
          </a>
        </v-layout>
        <v-divider></v-divider>

        <!\-- <div v-if="showSubscribeButton && showDonateText">
          <v-progress-linear
            color="error"
            height="20"
            :value="(channel.targetFund * channel.currentFund) / 100"
          ></v-progress-linear>
        </div>--\>

        <v-layout class="padding" justify-left fill-height>
          <div class="padding">
            <img
              class="channel-image square"
              :src="trailer != null ? trailer.channelImage : ''"
            />
          </div>
          <v-flex class="padding">
            <v-layout align-center justify-left row>
              <v-layout align-left justify-left column fill-height>
                <h2 class="quick-sand-font-b">{{ trailer.channelName }}</h2>
                <span class="published--text"
                  >Published {{ trailer.timeAgo }}</span
                >
              </v-layout>
              <v-spacer></v-spacer>
            </v-layout>
            <div class="detail-description">
              <div>{{ trailer.description }}</div>
            </div>
          </v-flex>
        </v-layout>

        <div>
          <v-layout row wrap>
            <v-btn
              block
              class="white--text"
              color="blue lighten-1"
              :loading="subscribeProcessing"
              :disabled="subscribeProcessing"
              @click="checkout"
              v-if="showSubscribeButton"
            >
              Join this Community &nbsp;
              <strong>${{ channel.price }}</strong> &nbsp; per month
              <template v-slot:loader>
                <span class="custom-loader">
                  <v-icon light>cached</v-icon>
                </span>
              </template>
            </v-btn>
          </v-layout>

          <v-layout row wrap>
            <v-flex xs12>
              <v-btn
                style="margin: 10px"
                block
                class="white--text"
                color="blue lighten-1"
                @click="startDonate"
                v-if="!showSubscribeButton && !showDonateField"
                >Donate</v-btn
              >
            </v-flex>

            <v-flex xs12 md5 v-if="showDonateField">
              <v-text-field
                label="Donate Amount(in Dollar's)"
                placeholder="Donate Amount"
                outline
                v-model="donateAmount"
              ></v-text-field>
            </v-flex>

            <v-spacer></v-spacer>
            <v-flex xs12 md3 v-if="showDonateField" style="margin: 10px">
              <v-btn
                block
                class="white--text"
                color="blue lighten-1"
                @click="startDonatePayment"
                >Donate</v-btn
              >
            </v-flex>
            <v-spacer></v-spacer>
            <v-flex xs12 md3 v-if="showDonateField" style="margin: 10px">
              <v-btn
                block
                class="white--text"
                color="blue lighten-1"
                @click="cancelDonate"
                >Cancel</v-btn
              >
            </v-flex>
          </v-layout>
        </div>

        <vue-stripe-checkout
          ref="checkoutRef"
          name="Payment Details"
          description
          currency="CAD"
          :amount="channel.price * 100"
          :allow-remember-me="false"
          @done="done"
          @opened="opened"
          @closed="closed"
          @canceled="canceled"
        ></vue-stripe-checkout>

        <v-divider></v-divider>

        <div class="comment-holder padding">
          <div v-if="showComments">
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
                <router-link :to="{ name: 'Login' }" class="quick-sand-font-b"
                  >sign in</router-link
                >to comment
              </p>
            </div>
          </div>
          <v-flex class="padding" v-if="commentsList.length > 0">
            <div
              class="comment"
              v-for="comment in commentsList"
              v-bind:key="comment.commentId"
            >
              <h4>{{ comment.userName }}</h4>
              <div>{{ comment.comment }}</div>
              <p class="grey--text">{{ comment.timeAgo }}</p>
            </div>
          </v-flex>
          <v-flex v-else text-xs-center>
            <div class="nocomment">
              <p>No comments yet, be the first</p>
            </div>
          </v-flex>
        </div>
      </v-flex>
      <v-flex xs12 sm12 md4 lg4 class="linked-trailers">
        <div style="width: 100%;">
          <h2 class="quick-sand-font-n" style="padding-top: 5px;">
            Related Previews
          </h2>
          <TrailerDetailVideoItem
            v-for="trailer in catTrailersList"
            v-bind:key="trailer.trailerId"
            :trailer="trailer"
          />
        </div>
      </v-flex>
    </v-layout>
    <v-container v-else style="padding: 20px;">
      <p class="text-xs-center" style="font-size: 20px;">Now Loading..</p>
    </v-container>
  </div>
  -->

</template>

<script>


import RegisterStoreModule from "../mixins/RegisterStoreModule";
import store from "../store/index";
import trailerModule from "../store/trailers/trailer";
import { fireStore, auth, firebaseTimestamp } from "../firebase/init";
import utils from "../firebase/utils";
import axios from "axios";
import TrailerDetailVideoItem from "../components/TrailerDetailVideoItem";
import moment from "moment";
import "videojs-ima/dist/videojs.ima";
import "videojs-ima/dist/videojs.ima.css";

import Vue from "vue";
import VueStripeCheckout from "vue-stripe-checkout";

//FIXME it should not be hard coded, need to add this in admin configuration
Vue.use(VueStripeCheckout, "pk_test_cf1l5xJI5WKEBPCKbYRRKnLB00FKzaOcN5");

//Vue.use(VueStripeCheckout, "pk_live_s20gmEBa8ovLkyFvYBSWMxDJ00LGR5TSeG");

export default {
  name: "TrailerDetails",
  data: () => {
    return {
      videoTriggerThreshold: Math.floor(Math.random() * (15 - 5 + 1) + 5),
      showDonateField: false,
      donateAmount: 0,
      videoLoaded: false,
      trailer: {},
      channel: {},
      catTrailersList: null,
      showSubscribeButton: false,
      showDonateText: false,
      isViewTriggered: false,
      subscribeProcessing: false,
      donate5Processing: false,
      donate10Processing: false,
      commentsList: [],
      commentText: "",
      playerObj:null,
      playerOptions: {
        overNative: true,
        controls: true,
        autoplay: false, //FIXME for testing purpose
        errorDisplay: false,
        preload: "auto",
        techOrder: ["html5"],
        sourceOrder: true,
        playbackRates: [0.7, 1.0, 1.5, 2.0],
        aspectRatio: "16:9",
        html5: { hls: { withCredentials: false } },
        
        sources: [
          
          {
            // type: "video/mp4",
            // src: "",
            // withCredentials: false,
            type: "application/x-mpegURL",
            src: ""
          }
        ],
        poster: ""
      },
      isUserLiked: false,
      isUserDisLiked: false,
      isNeutral: false,
      prevWhat: -2
    };
  },
  components: {
    TrailerDetailVideoItem
  },
  mixins: [RegisterStoreModule],
  computed: {

     showLogin() {
      return store.getters.getUser == null;
    },

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
  mounted() {
    // console.log(
    //   "this is current player instance object " + this.$refs.videoPlayer.player
    // );

  },
  created() {

    // To detach the attached video play
    var oldPlayer = document.getElementById('example_video_1');
    console.log("oldPlayer",oldPlayer)
    if(oldPlayer)
      videojs(oldPlayer).dispose();

    this.registerStoreModule("trailers", trailerModule);
    this.$store
      .dispatch("trailers/fetchTrailer", {
        trailerId: this.$route.params.trailerId
      })
      .then(data => {
        this.trailer = data;

        this.title = this.trailer.title;

        this.$store
          .dispatch("trailers/fetchChannel", {
            channelId: this.trailer.channelId
          })
          .then(data => {
            this.channel = data;
            this.showDonateText = data.channelType != "VOD";
          });

        this.$store
          .dispatch("trailers/fetchCategoryTrailersTop10", {
            categoryId: this.trailer.categoryId
          })
          .then(catTrailersList => {
            this.catTrailersList = catTrailersList;
          });

        this.playerOptions.sources[0].src = this.trailer.videoUrl;
        //console.log(this.trailer.videoUrl)
        this.playerOptions.poster = this.trailer.image;


        // console.log("player options",this.playerOptions.sources[0].src)
        let _vm=this
        $(document).ready(function(){
         
         if(_vm.playerObj == null){
              _vm.playerObj=videojs("example_video_1",_vm.playerOptions, function(){

            });
         }

       
         _vm.playerIsReady(this) // Onready 

        });


        let fUser = localStorage.getItem("fUser");
        let user = null;
        if (data != null) {
          try {
            user = JSON.parse(fUser);
          } catch (e) {
            user = null;
          }
        }
        if (user != null && user.subscribedChannels != undefined) {
          this.showSubscribeButton = !user.subscribedChannels.includes(
            this.trailer.channelId
          );
        } else {
          this.showSubscribeButton = true;
        }

        if (user != null && user.uid == this.trailer.userId) {
          this.showSubscribeButton = false;
        }
        this.videoLoaded = true;
        this.getLikes();
        this.getComments();
      });
  },
  methods: {
    goLive(){

      if (this.showLogin) {
        this.$router.push({ name: "Login" });
      } else {
        this.$router.push({ name: "AddExcluzeev" });
      }

        
    },

    playerIsReady(player) {
      // TODO(Karthik): Modify the adTagUrl
      
      let options = {
        id: player.id_,
        autoPlayAdBreaks: false,
        showCountdown: true,
        showControlsForJSAds: false,
        adTagUrl:
          "http://pubads.g.doubleclick.net/gampad/ads?sz=640x480&iu=/124319096/external/ad_rule_samples&ciu_szs=300x250&ad_rule=1&impl=s&gdfp_req=1&env=vp&output=xml_vmap1&unviewed_position_start=1&cust_params=sample_ar%3Dpremidpostpod%26deployment%3Dgmf-js&cmsid=496&vid=short_onecue&correlator="
      };
      player.ima(options);

      player.ima.setAdBreakReadyListener(() => {
        // console.log("AdBreak");
      });
      console.log("Player is ready");
    },
    async getLikes() {
      if (auth.currentUser == null) {
        return;
      }
      let userId = auth.currentUser.uid;
      let snap = await fireStore
        .collection(utils.likesCollection)
        .doc(userId + ":" + this.$route.params.trailerId + ":t")
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
      if (auth.currentUser == null) {
        this.$router.push({ name: "Login" });
        return;
      }
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
        .doc(userId + ":" + this.$route.params.trailerId + ":t")
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
    async prepareSubscribe(donate, token) {

      //console.log("Called prepare subscribe")

      //FIXME here the redirect url shoud be configurable from admin dashboard
      if (auth.currentUser == null) {
        this.$router.push({ name: "Login" });
        return;
      }
      let prepareOptions = {
        channelId: this.trailer.channelId,
        channelName: this.trailer.channelName,
        userId: auth.currentUser.uid,
        isDesktop: true,
        redirectTo: "https://excluzeev.com/my-channels",
        isDonate: this.showDonateField,
        token: token.id
      };
      this.subscribeProcessing = true;
      if (this.showDonateField) {
        prepareOptions.donate = donate;
      }
      
      axios
        .post(
          "https://us-central1-trenstop-2033f.cloudfunctions.net/chargeAmount",
          prepareOptions
        )
        .then(response => {
          if (response.data.error) {
            this.subscribeProcessing = false;
            this.showToast("Payment Failed Please try later.");
            window.location =
              "https://us-central1-trenstop-2033f.cloudfunctions.net/pagePaymentCanceled?subId=" +
              response.data.subId +
              "&donate=" +
              this.showDonateField +
              "&redirect=https://excluzeev.com/";
          } else {
            window.location =
              "https://us-central1-trenstop-2033f.cloudfunctions.net/pagePaymentSuccess?subId=" +
              response.data.subId +
              "&donate=" +
              this.showDonateField +
              "&redirect=https://excluzeev.com/my-channels";
          }
        })
        .catch(error => {
          this.subscribeProcessing = false;
          console.log(error);
        });
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
        .collection(utils.trailerCollection)
        .doc(this.trailer.trailerId);
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
    onPlayerTimeupdate() {
      if (
        this.$refs.videoPlayer.player.currentTime() >
          this.videoTriggerThreshold &&
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

      // if (fUser == null) {
      // }

      let commentId = utils.generateId();

      let data = {
        comment: this.commentText,
        userPhoto: fUser.userPhoto == undefined ? "" : fUser.userPhoto,
        createdDate: firebaseTimestamp.fromDate(new Date()),
        channelName: this.channel.title,
        channelId: this.channel.channelId,
        userId: fUser.uid,
        userName: fUser.firstName + " " + fUser.lastName,
        vtId: this.trailer.trailerId,
        commentId: commentId
      };

      let commentRef = fireStore
        .collection(utils.trailerCollection)
        .doc(this.trailer.trailerId)
        .collection(utils.commentsCollections)
        .doc(commentId);

      await commentRef.set(data);

      this.commentText = "";
    },
    async getComments() {
      let commentRef = fireStore
        .collection(utils.trailerCollection)
        .doc(this.trailer.trailerId)
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
    },
    async checkout() {
      if (auth.currentUser == null) {
        this.$router.push({ name: "Login" });
        return;
      }
      // token - is the token object
      // args - is an object containing the billing and shipping address if enabled
      const { token, args } = await this.$refs.checkoutRef.open();
    },
    done({ token, args }) {
      // token - is the token object
      // args - is an object containing the billing and shipping address if enabled
      // do stuff...
      this.prepareSubscribe(this.donateAmount, token);
    },
    opened() {
      // do stuff
    },
    closed() {
      // do stuff
    },
    canceled() {
      // do stuff
    },
    startDonate() {
      this.showDonateField = true;
    },
    cancelDonate() {
      this.showDonateField = false;
    },
    startDonatePayment() {
      if (this.donateAmount > 0) {
        this.prepareSubscribe(this.donateAmount);
      } else {
        this.showToast("Invalid amount in donate");
      }
    }
  }
};
</script>

<style scoped >

</style>
