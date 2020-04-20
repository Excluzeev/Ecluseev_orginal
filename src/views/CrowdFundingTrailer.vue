<template>

  <div id="croud_funding_page" class="croud-f-trai">
    <div class="container-fluid">
      <div class="row d-none d-xl-block d-lg-block">
        <div class="col-12">
          <div class="inline-list">
            <br>
            <a href="#">Communities</a><i class="fa fa-angle-right"></i><a href="#" v-if="trailer">{{ trailer.channelName }}</a><i class="fa fa-angle-right"></i><a href="#">Crowd Funding</a>
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
          <h2 v-if="trailer"> {{ trailer.title }} </h2>

          <p v-if="trailer"> {{ trailer.description }} </p>

          <div class="chat_section">
            <h3><span>Comments</span></h3>

            <div  v-if="commentsList.length > 0">
              <div class="user_comment_section d-flex" v-for="comment in commentsList" v-bind:key="comment.commentId">
                
                <div class="user_name_comment">
                  <ul class="list-unstyled" >
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

        <ul class="list-unstyled list-inline d-flex share_links d-none d-xl-block d-lg-block" style="margin-left:0!important">
          <li class="d-none d-xl-block d-lg-block"><a href="javascript://" @click="copyUrl"><i class="fa fa-clone" aria-hidden="true"></i>&nbsp;&nbsp;Copy profile link</a></li>
          <li class="d-none d-xl-block d-lg-block">

           <a class='share-btn share-btn-mail' v-bind:href='shareEmail' rel='nofollow' target='_blank' title='via email'>

            <i class="fa fa-envelope" aria-hidden="true"></i>&nbsp;&nbsp;Share via email</a></li>


            <li class="d-none d-xl-block d-lg-block">
              <a class='share-btn share-btn-facebook' v-bind:href='shareFbLink' rel='nofollow' target='_blank'>

               <i class="fa fa-facebook"></i>&nbsp;&nbsp;Share via facebook</a></li>
             </ul>


             <div class="progressbar_section inline-list d-none d-xl-block d-lg-block" style="margin-left:0">
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
            :publishable-key="spublickey"
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
                <button class="btn btn-donate-now pull-right" @click="checkout(tier.price, tier.tier)" :disabled="getIsExpired(trailer.expiry)">Donate now</button>
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
    import trailerModule from "../store/trailers/trailer";
    import { fireStore, auth, firebaseTimestamp } from "../firebase/init";
    import utils from "../firebase/utils";
    import axios from "axios";
    import moment from "moment";
    import TrailerDetailVideoItem from "../components/TrailerDetailVideoItem";

    export default {
      name: "CrowdFundingTrailer",
      data: () => {
        return {
          spublickey:"",
          trailer: {},
          channel: {},
          videoLoaded: false,
          catTrailersList: null,
          showSubscribeButton: false,
          showDonateText: false,
          isViewTriggered: false,
          subscribeProcessing: false,
          donate5Processing: false,
          donate10Processing: false,
          commentsList: [],
          donateAmount: 0,
          tierName: "",
          commentText: "",
          playerOptions: {
            overNative: true,
            controls: true,
            autoplay: true,
            errorDisplay: false,
            preload: "auto",
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
          shareFbLink:'',
          shareEmail:'',
          siteUrl:""
        };
      },
      components: {
        TrailerDetailVideoItem
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
      mounted() {
    // console.log(
    //   "this is current player instance object " + this.$refs.videoPlayer.player
    // );

    
      // Fetch site base url
      this.$store.dispatch("fetchSettings",{key: 'site_base_url'}).then(url => {

        this.siteUrl=url

      });


      fireStore
      .collection(utils.settingsCollection)
      .limit(1)
      .get()
      .then(querySnapshot =>{

        querySnapshot.forEach(snapShot => {

          let settings=snapShot.data()

          if(settings.is_stripe_live){

            this.spublickey=settings.stripe_live_public_key

          }else{


            this.spublickey=settings.stripe_test_public_key
          }


        });


      });





    },
    created() {

       // update share
       this.shareFbLink="https://www.facebook.com/sharer/sharer.php?u="+window.location.href;
       let body_msg="I have contributed to this event. url: "+window.location.href
       this.shareEmail="mailto:?subject=Crowd Funding&amp;amp;body="+body_msg

         // To detach the attached video play
         var oldPlayer = document.getElementById('example_video_1');

         if(oldPlayer != null){
          console.log("Old player",oldPlayer);
          videojs(oldPlayer).dispose();
        }



        this.registerStoreModule("trailers", trailerModule);
        this.$store
        .dispatch("trailers/fetchTrailer", {
          trailerId: this.$route.params.trailerId
        })
        .then(data => {
          this.trailer = data;

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
          this.playerOptions.poster = this.trailer.image;



          // console.log("player options",this.playerOptions.sources[0].src)
          let _vm=this

          if(_vm.playerObj == null){
           _vm.playerObj=videojs("example_video_1",_vm.playerOptions, function(){
                // Player (this) is initialized and ready.
                // console.log("Videjs ininitialized",_vm.playerOptions.sources[0].src)


              });

         }






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

        this.$root.$emit('openLoginForm');

        return;
      }
      // if (auth.currentUser.uid == "8tofk8UcabOsu89X04bOaMwvH2C3") {
      //   this.prepareSubscribe(this.donateAmount, "demo_token");
      // } else {
        const { token, args } = await this.$refs.checkoutRef.open();
      // }
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
    playerIsReady(player) {
      // TODO(Karthik): Modify the adTagUrl
      // let options = {
      //   id: player.id_,
      //   adTagUrl:
      //     "http://pubads.g.doubleclick.net/gampad/ads?sz=640x480&iu=/124319096/external/ad_rule_samples&ciu_szs=300x250&ad_rule=1&impl=s&gdfp_req=1&env=vp&output=xml_vmap1&unviewed_position_start=1&cust_params=sample_ar%3Dpremidpostpod%26deployment%3Dgmf-js&cmsid=496&vid=short_onecue&correlator="
      // };
      //
      // player.ima(options);
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
        this.$root.$emit('openLoginForm');

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
    async prepareSubscribe(donate, tierName, token) {
      if (auth.currentUser == null) {
        this.$root.$emit('openLoginForm');

        return;
      }
      let prepareOptions = {
        channelId: this.trailer.channelId,
        channelName: this.trailer.channelName,
        userId: auth.currentUser.uid,
        isDesktop: true,
        redirectTo: this.siteUrl+"/my-subscriptions",
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
          "&redirect="+this.siteUrl;
        } else {
          window.location =
          "https://us-central1-trenstop-2033f.cloudfunctions.net/pagePaymentSuccess?subId=" +
          response.data.subId +
          "&donate=true" +
          "&redirect="+this.siteUrl+"/my-channels";
        }
      })
      .catch(error => {
        this.subscribeProcessing = false;
          // console.log(error);
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

    if (fUser == null) {
    }

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
    .collection(utils.videosCollection)
    .doc(this.trailer.trailerId)
    .collection(utils.commentsCollections)
    .doc(commentId);

    await commentRef.set(data);

    this.commentText = "";
  },
  async getComments() {
    let commentRef = fireStore
    .collection(utils.videosCollection)
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
    }
  }
};
</script>

<style scoped>
  .video-js{width:100%}
  .margin {
    margin: 5px 2px;
  }
  .card-shadow {
    box-shadow: 0px 3px 3px -2px rgba(0, 0, 0, 0.2),
    0px 3px 4px 0px rgba(0, 0, 0, 0.14), 0px 1px 8px 0px rgba(0, 0, 0, 0.12);
  }
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
  .sub-text {
    font-size: 14px;
  }
  .share_links li{padding:10px 0}
  #croud_funding_page{margin-bottom:50px}
  @media only screen and (max-width:991px){
    #croud_funding_page .btn-donate-now{font-size:16px;}
    #croud_funding_page p{font-size:14px;}
  }
  @media only screen and (max-width:767px){
    #croud_funding_page p{font-size:14px;}
  }

  .user_name_comment,
  #croud_funding_page ul{margin-left:0!important}
</style>
