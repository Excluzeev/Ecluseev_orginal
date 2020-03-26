<template>
  <div id="croud_funding_page">
		<div class="container-fluid">
			<div class="row d-none d-xl-block d-lg-block">
				<div class="col-12">
					<div class="inline-list">
						<br>
						<a href="#">Communities</a><i class="fa fa-angle-right"></i><a href="#" v-if="video">{{ video.channelName }}</a><i class="fa fa-angle-right"></i><a href="#">Crowd Funding</a>
						<br><br>
					</div>
				</div>
			</div>


      <div class="row">
				<div class="col-xl-6">
          <div class="watch_vedio_section">


                        <div v-show="!playerOptions.sources[0].src.isEmpty">

                            <video id="example_video_1" class="video-js"
                              controls preload="auto" width="640" height="264"
                              data-setup='{"example_option":true}'>
                            </video>

                        </div>
						<h2 v-if="video">
                            {{ video.title }}
                        </h2>

						<p v-if="video">
                            {{ video.description }}
						</p>

                    <div class="chat_section">
							<h3><span>Comments</span></h3>

                            <div  v-if="commentsList.length > 0">
                                        <div class="user_comment_section d-flex" v-for="comment in commentsList" v-bind:key="comment.commentId">
                        <!--
                                            <img src="../assets/Images/Copy of Bri N Teesh.png" class="rounded-circle img-fluid pull-left" style="width: 25px;height: 25px;" >
    -->
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
                                    
                            </div>

                             <v-flex v-else text-xs-center>
                                <div class="nocomment">
                                  <p>No comments yet, be the first</p>
                                </div>
                              </v-flex>

                            
                        </div>

            				<div class="chat_messege_section">
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<button class="btn btn-user-img" type="button"><img src="assets/Images/Copy of Bri N Teesh.png" class="rounded-circle " style="width: 25px;height: 25px;" ></button>
								</div>
								<input v-model="commentText" type="text" class="form-control" placeholder="Type to comment" id="messageInput" aria-label="" aria-describedby="basic-addon1">
								<div class="input-group-append">
									<button :disabled="disabelComment" class="btn btn-send" type="button" @click="doComment">Send</button>
								</div>
							</div>
						</div>

          </div>


        </div>
        <div class="col-xl-6">
					
          <ul class="list-unstyled list-inline d-flex share_links d-none d-xl-block d-lg-block">
						<li class="d-none d-xl-block d-lg-block"><a href="javascript://" @click="copyUrl"><i class="fa fa-clone" aria-hidden="true"></i>&nbsp;&nbsp;Copy profile link</a></li>
						<li class="d-none d-xl-block d-lg-block">

                         <a class='share-btn share-btn-mail' v-bind:href='shareEmail' rel='nofollow' target='_blank' title='via email'>

                            <i class="fa fa-envelope" aria-hidden="true"></i>&nbsp;&nbsp;Share via email</a></li>


						<li class="d-none d-xl-block d-lg-block">
                            <a class='share-btn share-btn-facebook' v-bind:href='shareFbLink' rel='nofollow' target='_blank'>

                           <i class="fa fa-facebook"></i>&nbsp;&nbsp;Share via facebook</a></li>
					</ul>


          <div class="progressbar_section inline-list d-none d-xl-block d-lg-block">
						<h3><span>Pledged of ${{ channel.targetFund }} goal</span></h3>
						<br>
						<div class="clearfix"></div>
						<div class="list-inline">
							<div class="progress pull-left">


								<div class="progress-bar" role="progressbar" style="width: 55%;" aria-valuenow="55" aria-valuemin="0" aria-valuemax="100"><span>{{(channel.currentFund / channel.targetFund) * 100}}%</span></div>
							</div>
							<h3 class="pull-right"><span>$ {{ channel.currentFund }}</span></h3>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="cad_title d-none d-xl-block d-lg-block"> 
						<h3>More<span> $ {{ channel.targetFund - channel.currentFund }} </span>to go</h3>
					</div>
					<br>
					<p>Join your hand in reaching the goal</p>

                              <vue-stripe-checkout
            ref="checkoutRef"
            :name="'Payment Details'"
            description
            currency="CAD"
            :amount="donateAmount * 100"
            :allow-remember-me="false"
            @done="done"
            @opened="opened"
            @closed="closed"
            @canceled="canceled"
          ></vue-stripe-checkout>

                    <div class=" card_section" v-for="(tier,index) in channel.tiers" v-bind:key="index">
						<div class="list-inline tile_btn"> 
							<h3 class="pull-left"><span>{{tier.tier}} - ${{tier.price}}</span></h3>
							<button class="btn btn-donate-now pull-right" @click="checkout(tier.price, tier.tier)" :disabled="getIsExpired(video.expiry)">Donate now</button>
							<div class="clearfix"></div>
						</div>

						<p>{{tier.description}}</p>
					</div>


				</div>



      </div>
    </div>
  </div>

</template>



<script>
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import videoModule from "../store/videos/video";
import { fireStore,auth, firebaseTimestamp } from "../firebase/init";
import utils from "../firebase/utils";
import axios from "axios";
import moment from "moment";

export default {
  name: "MyCrowdFundings",
  data: () => {
    return {

      showSubscribeButton: false,
      showDonateText: false,
      isViewTriggered: false,
      subscribeProcessing: false,
      donateAmount: 0,
      tierName: "",
      video: {},
      channel: {},
      showDonateText: true,
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
      playerObj: null,
      shareFbLink:'',
      shareEmail:''
    };
  },
  components: {},
  mixins: [RegisterStoreModule],
  computed: {
    player() {
      return this.$refs.videoPlayer.player;
    },
    disabelComment() {
      return this.commentText == "";
    },
    showComments() {
      auth.onAuthStateChanged(() => {});
      return auth.currentUser != null;
    }
  },
  mounted() {
    // console.log("this is current player instance object", this.player);
  },
  created() {

    // update share
    this.shareFbLink="https://www.facebook.com/sharer/sharer.php?u="+window.location.href;
    let body_msg="I have contributed to this event. url: "+window.location.href
    this.shareEmail="mailto:?subject=Crowd Funding&amp;amp;body="+body_msg
    // For testing
    this.$route.params.videoId="0MO1VqbYgzVutXHZD1dX"


     // To detach the attached video play
    var oldPlayer = document.getElementById('example_video_1');
    
    if(oldPlayer != null){
      console.log("Old player",oldPlayer);
      videojs(oldPlayer).dispose();
    }

    this.registerStoreModule("videos", videoModule);
    this.$store
      .dispatch("videos/fetchVideo", {
        videoId: this.$route.params.videoId
      })
      .then(vData => {

        console.log("Vdata",vData);
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

             if(_vm.playerObj == null){
                 _vm.playerObj=videojs("example_video_1",_vm.playerOptions, function(){
                // Player (this) is initialized and ready.
                // console.log("Videjs ininitialized",_vm.playerOptions.sources[0].src)


                });

             }



            
            //let channel_id=this.video.channelID
            let channel_id="0MUWTvM4I15ykTLx0Fx8"
        
            this.$store
              .dispatch("videos/fetchChannel", {
                channelId: channel_id
              })
              .then(data => {
                this.channel = data;
                this.showDonateText = data.channelType == "VOD";
              });

            this.$store
              .dispatch("videos/getUserChannelVideos", {
                channelId: channel_id
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
     copyUrl(){
        
          var dummy = document.createElement('input'),
          text = window.location.href;
          document.body.appendChild(dummy);
          dummy.value = text;
          dummy.select();
          document.execCommand('copy');
          document.body.removeChild(dummy);
          alert('Link copied please open whatsup and paste to send');    

     },
     getIsExpired(date) {
      console.log(date);
      if (date != null && date != undefined) {
        console.log(true);
        return moment(date.toDate()).diff(Date.now()) <= 0;
      } else {
        console.log(false);
        return false;
      }
    },
        async sleep(ms) {
      return new Promise(resolve => setTimeout(resolve, ms));
    },
    async checkout(donate, tierName) {
      this.donateAmount = donate;
      this.tierName = tierName;
      await this.sleep(1000);
      // token - is the token object
      // args - is an object containing the billing and shipping address if enabled
      if (auth.currentUser == null) {
        this.$router.push({ name: "Login" });
        return;
      }
      // if (auth.currentUser.uid == "8tofk8UcabOsu89X04bOaMwvH2C3") {
      //   this.prepareSubscribe(this.donateAmount, "demo_token");
      // } else {
      const { token, args } = await this.$refs.checkoutRef.open();
      // }
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
        .catch(() => {
          // console.log("Transaction failed: ", error);
        });
    },
    done({ token, args }) {
      // token - is the token object
      // args - is an object containing the billing and shipping address if enabled
      // do stuff...

      this.prepareSubscribe(this.donateAmount, this.tierName, token);
    },
    opened() {
      // do stuff
      console.log("opened");
    },
    closed() {
      // do stuff
      console.log("Closed");
    },
    canceled() {
      // do stuff
      console.log("Canceled");
    },
        async prepareSubscribe(donate, tierName, token) {
      if (auth.currentUser == null) {
        this.$router.push({ name: "Login" });
        return;
      }
      let prepareOptions = {
        channelId: this.video.channelId,
        channelName: this.video.channelName,
        userId: auth.currentUser.uid,
        isDesktop: true,
        redirectTo: "https://excluzeev.com/my-subscriptions",
        isDonate: true,
        token: token.id
      };
      this.subscribeProcessing = true;
      if (this.showDonateText) {
        prepareOptions.donate = donate;
        prepareOptions.tierName = tierName;
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
              "&donate=true" +
              "&redirect=https://excluzeev.com/";
          } else {
            window.location =
              "https://us-central1-trenstop-2033f.cloudfunctions.net/pagePaymentSuccess?subId=" +
              response.data.subId +
              "&donate=true" +
              "&redirect=https://excluzeev.com/my-channels";
          }
        })
        .catch(error => {
          this.subscribeProcessing = false;
          // console.log(error);
        });
    },

    onPlayerTimeupdate() {
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
    },
    async prepareSubscribe(donate) {
      if (auth.currentUser == null) {
        this.$router.push({ name: "Login" });
        return;
      }
      let prepareOptions = {
        channelId: this.video.channelId,
        channelName: this.video.channelName,
        userId: auth.currentUser.uid,
        isDesktop: true,
        redirectTo: "https://excluzeev.com/my-channels",
        isDonate: true
      };
      this.subscribeProcessing = true;
      if (this.showDonateText) {
        prepareOptions.donate = donate;
      }

      axios
        .post(
          "https://us-central1-trenstop-2033f.cloudfunctions.net/generatePayKey",
          prepareOptions
        )
        .then(response => {
          if (response.data.responseEnvelope.ack != "Success") {
            this.subscribeProcessing = false;
            this.showToast("Payment Failed Please try later.");
          } else {
            window.location =
              "https://www.sandbox.paypal.com/webapps/adaptivepayment/flow/pay?paykey=" +
              response.data.payKey;
          }
        })
        .catch(error => {
          this.subscribeProcessing = false;
          // console.log(error);
        });
    }
  }
};
</script>




<style scoped>

</style>
