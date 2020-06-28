<template>
  <v-container >
    <img
            :src="
    'https://firebasestorage.googleapis.com/v0/b/trenstop-public/o/channels%2F' +
    channelId +
    '%2Fcover.jpg?alt=media'
    "
            style="width: 100%; height: 150px; object-fit: 100%;"
            class="img-fluid"
    />
    <v-layout row wrap xs12 text-xs-center class="padding">
      <v-avatar :tile="tile" size="100px" color="grey lighten-4">
        <img
                :src="
        'https://firebasestorage.googleapis.com/v0/b/trenstop-public/o/channels%2F' +
        channel.channelId +
        '%2Fthumbnail.jpg?alt=media'
        "
                alt="avatar"
                class="img-fluid"
        />
      </v-avatar>
      <div class="channel-details padding">
        <h2 class="quick-sand-font-b">{{ channel.title }}</h2>
        <p class="subscribers-count">{{ channel.subscriberCount }} Subscribers</p>
      </div>
      <v-spacer></v-spacer>
      <div class="action-items">

        <router-link
                v-if="!channel.isDeleted"
                :to="{ name: 'UpdateLinks', params: { channelData: channel } }"
        >
          <v-btn  class="btn quick-sand-font-b bg-prim">
            <v-icon left>add</v-icon> Links
          </v-btn>
        </router-link>

        <router-link
                v-if="!channel.isDeleted"
                :to="{ name: 'AddTrailer', params: { channelData: channel } }"
        >
          <v-btn  class="btn quick-sand-font-b bg-prim">
            <v-icon left>add</v-icon>Add Preview
          </v-btn>
        </router-link>
        <router-link
                v-if="!channel.isDeleted && channel.channelType == 'VOD'"
                :to="{ name: 'AddVideo', params: { channelData: channel } }"
        >
          <v-btn  class="btn quick-sand-font-b bg-prim">
            <v-icon left>add</v-icon>Add Video
          </v-btn>
        </router-link>
        <router-link
                v-if="!channel.isDeleted"
                :to="{ name: 'AddExcluzeev', params: { channelData: channel } }"
        >
          <v-btn  class="btn quick-sand-font-b bg-prim">
            <v-icon left>add</v-icon>Excluzeev Live
          </v-btn>
        </router-link>
        <v-btn class="btn quick-sand-font-b bg-prim"
                @click="getSubscribers"
        >Subscribers</v-btn>
        <v-btn
                v-if="!channel.isDeleted"
                color="red"
                class="btn quick-sand-font-b bg-dang"
                center
                @click="deleteDialog = true"
        >
          <v-icon left>delete</v-icon>Remove
        </v-btn>
      </div>
    </v-layout>
    <div v-if="!(trailersList.length == 0)">
      <h1 class="quick-sand-font-b">Preview</h1>
      <br />
      <v-layout xs12 row wrap>
        <v-flex
                class="trailer-item"
                xs12
                sm4
                md3
                lg2
                v-for="trailer in trailersList"
                v-bind:key="trailer.trailerId"
        >
          <TrailerVideoItem :trailer="trailer" v-on:trailerDelete="onTrailerDeleted" />
        </v-flex>
      </v-layout>
    </div>
    <div class="padding"></div>
    <div v-if="!(videosList.length == 0)">
      <h1 class="quick-sand-font-b">Videos</h1>
      <br />
      <v-layout xs12 row wrap>
        <v-flex
                class="video-item"
                xs12
                sm4
                md3
                lg2
                v-for="video in videosList"
                v-bind:key="video.videoId"
        >
          <VideosVideoItem :video="video" v-on:videoDelete="onVideoDeleted" />
        </v-flex>
      </v-layout>
    </div>

    <div v-else class="no-resource-found">
      Oops! No videos published yet to this Channel
    </div>


    <!--<v-layout>-->
    <v-dialog v-model="dialog">
      <v-card>
        <v-card-title class="headline grey lighten-2" primary-title>Subscribers List</v-card-title>
        <v-list two-line v-if="!subscriberLoading && !subscriberEmpty">
          <v-list-tile
                  v-for="(subscriber) in subscribersList"
                  v-bind:key="subscriber.subscriptionId"
          >
            <!--<v-divider v-if="index != 0" :key="index"></v-divider>-->
            <v-list-tile-content>
              <v-list-tile-title>{{ subscriber.email }} ( {{ subscriber.userName }} )</v-list-tile-title>
              <v-list-tile-sub-title>
                <b>{{subscriber.tierName}}</b>
                - {{ subscriber.daysLeft }}
              </v-list-tile-sub-title>
            </v-list-tile-content>
          </v-list-tile>
        </v-list>

        <v-card-text v-if="subscriberEmpty">No Subscribers yet.</v-card-text>

        <v-progress-circular v-if="subscriberLoading" indeterminate color="primary"></v-progress-circular>

        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" flat @click="dialog = false">Close</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <!--</v-layout>-->
    <v-layout row justify-center>
      <v-dialog v-model="deleteDialog" persistent max-width="320">
        <v-card>
          <v-card-title class="headline">Do you want to delete the channel?</v-card-title>
          <v-card-text>
            Do you really want to delete the channel?
            <br />Users will have a 30
            days notice period.
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="primary darken-1" flat @click="deleteDialog = false">Dont Delete</v-btn>
            <v-btn color="primary darken-1" flat @click="deleteChannel">Delete</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-layout>

    <!--Channel promote links -->


    <ChannelPromoteLinks />
    <div class="theme-sec">
      <div class="theme-selection">
        <label>
          <i class="fa fa-cog rotating"></i>&nbsp;&nbsp;&nbsp;Themes
        </label>
      </div>
      <div class="theme-section">
          <label><input type="radio" name="color" value="Defaul">&nbsp;&nbsp;Default</label>
          <label><input type="radio" name="color" value="Darkly">&nbsp;&nbsp;Darkly</label>
          <label><input type="radio" name="color" value="Materia">&nbsp;&nbsp;Materia</label>
          
          <button class="btn btn-theme-save bg-prim ">Save</button>
      </div>
    </div>
  </v-container>
</template>

<script>
  import TrailerVideoItem from "../components/TrailerVideoItem";
  import VideosVideoItem from "../components/VideosVideoItem";
  import RegisterStoreModule from "../mixins/RegisterStoreModule";
  import channelsModule from "../store/channels/channels";
  import {fireStore, firebaseTimestamp, auth} from "../firebase/init";
  import utils from "../firebase/utils";
  import moment from "moment";

  import ChannelPromoteLinks from "../components/ChannelPromoteLinks";

  export default {
    name: "MyChannelDetails",
    components: {
      TrailerVideoItem,
      VideosVideoItem,
      ChannelPromoteLinks
    },
    data: () => {
      return {
        tile: false,
        trailersList: [],
        videosList: [],
        channel: {},
        channelId: "",
        dialog: false,
        subscribersList: [],
        subscriberLoading: true,
        subscriberEmpty: false,
        deleteDialog: false
      };
    },
    mixins: [RegisterStoreModule],
    created() {
      this.registerStoreModule("channels", channelsModule);
    },
    methods: {
      async getSubscribers() {
        this.dialog = true;
        if (this.subscribersList.length > 0) {
          this.subscriberLoading = false;
          return;
        }
        let querySnapshot = await fireStore
                .collection(utils.subscribersCollection)
                .where("isActive", "==", true)
                .where("channelId", "==", this.channel.channelId)
                .get();
        let subscribers = [];
        querySnapshot.forEach(snap => {
          let data = snap.data();
          let days = moment(data.expiryDate.toDate()).diff(moment(), "days");

          if (days < 0) {
            data.daysLeft = "Expired";
          } else {
            data.daysLeft =
                    moment(data.expiryDate.toDate()).diff(moment(), "days") +
                    " Days Left";
          }

          subscribers.push(data);
        });
        this.subscribersList = subscribers;
        this.subscriberLoading = false;
        if (this.subscribersList.length == 0) {
          this.subscriberEmpty = true;
        }
      },
      onVideoDeleted() {
        this.loadVideosData();
      },
      onTrailerDeleted() {
        this.loadTrailersData();
      },
      loadTrailersData() {
        this.$store
                .dispatch("channels/getUserChannelTrailers", {
                  channelId: this.channel.channelId
                })
                .then(data => {
                  this.trailersList = data;
                });
      },
      loadVideosData() {
        this.$store
                .dispatch("channels/getUserChannelVideos", {
                  channelId: this.channel.channelId
                })
                .then(data => {
                  this.videosList = data;
                });
      },
      async deleteChannel() {
        let channelRef = fireStore
                .collection(utils.channelsCollection)
                .doc(this.channel.channelId);
        // let channelDoc = await channelRef.get();
        let delDate = new Date();
        delDate.setMonth(delDate.getMonth() + 1);
        let updateData = {
          isDeleted: true,
          delete: 0,
          deleteOn: firebaseTimestamp.fromDate(delDate)
        };
        await channelRef.update(updateData);

        this.$router.push({name: "MyChannels"});
      },
    },
    async mounted() {
      this.channelId = this.$route.params.channelId;
      let channelDoc = await fireStore
              .collection(utils.channelsCollection)
              .doc(this.$route.params.channelId)
              .get();
      this.channel = channelDoc.data();
      this.loadTrailersData();

      this.loadVideosData();

      // To fetch and display the the promote link of the channel

      this.$root.$emit("fetch_promote_links",this.channelId);


      //Theme FadeIn-out
      $(document).ready(function(){
        $(".theme-selection").click(function(){
          $(".theme-section").slideToggle(300);
        });
      });

    $('input[type=radio]').change(function() {    
        $("img").removeClass();

    if($(this).val() == "Darkly"){   
        $('body').addClass('darkly');
        $('body').removeClass('materia defaul');

        $('body.darkly').css('background-color','#222');
        $('.darkly .nav_section').css('background','#1b3149') ;
        $('.darkly .btn_radius').css('border-radius','4px');
        $('.darkly .channel-details h2').css('color','#FFF');
        $('.darkly .channel-details p').css('color','#FFF');
        $('.darkly .theme-selection label').css('color','#FFF');
        $('.darkly .theme-section label').css('color','#FFF');
        $('.darkly .bg-prim').css({'border-radius':'5px','background-color':'transparent','color':'#29ABE2','border':'1px solid #29ABE2'});
        
        $(".darkly .bg-prim").hover(function(){
          $(this).css({'border-radius':'5px','background-color':'#1b3149','color':'#FFF','border':'1px solid #1b3149'});
          }, function(){
            $(this).css({'border-radius':'5px','background-color':'transparent','color':'#29ABE2','border':'1px solid #29ABE2'});
        });

        $('.darkly .theme--light.red').css({'border-radius':'5px','background-color':'transparent','color':'#f44336','border':'1px solid #f44336'});
        
        $(".darkly .theme--light.red").hover(function(){
          $(this).css({'border-radius':'5px','background-color':'#f44336','color':'#FFF','border':'1px solid #f44336'});
          }, function(){

          $(this).css({'border-radius':'5px','background-color':'transparent','color':'#f44336','border':'1px solid #f44336'});
        });
        

        $('.darkly .promote-links a').css({'border-radius':'5px','background-color':'transparent','color':'#29ABE2','border':'1px solid #29ABE2'});
        $(".darkly .promote-links a").hover(function(){
          $(this).css({'border-radius':'5px','background-color':'#1b3149','color':'#FFF','border':'1px solid #1b3149'});
          }, function(){
            $(this).css({'border-radius':'5px','background-color':'transparent','color':'#29ABE2','border':'1px solid #29ABE2'});
        });


        
        $('.darkly .footer').css('background','#1b3149');
        $('.darkly .footer_section h4').css('color','#FFF');
        $('.darkly .footer_section a').css('color','#FFF');
        $('.darkly .copyright_section p').css('color','#FFF');
        $('.darkly .copyright_section hr').css('border-top','1px solid #FFF');
    }
    else if($(this).val() == "Materia"){
        $('body').addClass('materia');
        $('body').removeClass('darkly defaul');

        $('body.materia').css('background-color','#FFF');
        $('.materia .nav_section').css('background','#2196F3');

        $('.materia .nav_section .search').css({'border':'0','border-bottom':'1px solid #b0dcef','color':'#FFF','border-radius':'0','background':'transparent','box-shadow':'none','-webkit-box-shadow':'none','-moz-box-shadow':'none'});

        $('.materia .has-search .form-control').css({'border':'0','border-bottom':'1px solid #FFF','color':'#FFF','border-radius':'0','background':'transparent','box-shadow':'none','-webkit-box-shadow':'none','-moz-box-shadow':'none'});

        $(".materia .has-search .form-control").focus(function(){
          $(this).css({'border':'0','border-bottom':'1px solid #FFF','color':'#FFF','border-radius':'0','background':'transparent','box-shadow':'none','-webkit-box-shadow':'none','-moz-box-shadow':'none'});
        });

        $('.materia .btn_radius').css({'border-radius':'4px','background':'#fff linear-gradient(180deg, white, #fff) repeat-x','-webkit-box-shadow': 'rgba(0, 0, 0, 0.4) 0px 1px 4px', 'box-shadow': 'rgba(0, 0, 0, 0.4) 0px 1px 4px', '-moz-box-shadow': 'rgba(0, 0, 0, 0.4) 0px 1px 4px', '-webkit-transition':' all 0.4s', 'transition': 'all 0.4s'});

        $('.materia .channel-details h2').css('color','#2196F3');
        $('.materia .channel-details p').css('color','#2196F3');
        $('.materia .theme-selection label').css('color','#2196F3');
        $('.materia .theme-section label').css('color','#2196F3');
        $('.materia .bg-prim').css({'border-radius':'5px','background-color':'#FFF','color':'#29ABE2','border':'1px solid #FFF','box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px','-webkit-box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px','-moz-box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px'});
        
        $("materia .bg-prim").hover(function(){
          $(this).css({'border-radius':'5px','background-color':'rgb(33, 150, 243)','background':'rgb(33, 150, 243)','color':'#29ABE2','border':'1px solid #FFF','box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px','-webkit-box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px','-moz-box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px'});
          }, function(){
            $(this).css({'border-radius':'5px','background-color':'#FFF','color':'#29ABE2','border':'1px solid #FFF','box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px','-webkit-box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px','-moz-box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px'});
        });

        $('.materia .theme--light.red').css({'border-radius':'5px','background-color':'#f44336','color':'#f44336','border':'1px solid #f44336','box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px','-webkit-box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px','-moz-box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px'});
        
        $(".materia .theme--light.red").hover(function(){
          $(this).css({'border-radius':'5px','background-color':'#f44336','color':'#FFF','border':'1px solid #f44336','box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px','-webkit-box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px','-moz-box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px'});
          }, function(){

          $(this).css({'border-radius':'5px','background-color':'#f44336','color':'#f44336','border':'1px solid #f44336','box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px','-webkit-box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px','-moz-box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px'});
        });
        

        $('.materia .promote-links a').css({'border-radius':'5px','background-color':'#FFF','color':'rgb(33, 150, 243)','border':'1px solid #FFF','box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px','-webkit-box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px','-moz-box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px'});

        $(".materia .promote-links a").hover(function(){
          $(this).css({'border-radius':'5px','background-color':'rgb(33, 150, 243)','color':'#FFF','border':'1px solid #FFF','box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px','-webkit-box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px','-moz-box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px'});
          }, function(){
            $(this).css({'border-radius':'5px','background-color':'#FFF','color':'rgb(33, 150, 243)','border':'1px solid #FFF','box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px','-webkit-box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px','-moz-box-shadow':'rgba(0, 0, 0, 0.4) 0px 1px 4px'});
        });


        
        $('.materia .footer').css('background','rgb(33, 150, 243)');
        $('.materia .footer_section h4').css('color','#FFF');
        $('.materia .footer_section a').css('color','#FFF');
        $('.materia .copyright_section p').css('color','#FFF');
        $('.materia .copyright_section hr').css('border-top','1px solid #FFF');

    }
     
    else if($(this).val() == "Defaul"){

        $('body').addClass('defaul');
        $('body').removeClass('darkly materia');

        $('body.defaul').css('background-color','#FFF');
        $('.defaul .nav_section').css('background','#FFF');
        $('.defaul .has-search .form-control').css({'border':'1px solid #29ABE2','color':'#29ABE2','border-radius':'23px','background':'#FFF'});
        $('.create-account-btn').css('color','#29ABE2');
        $('.create-account-btn:hover').css('color','#29ABE2');
        $('.create-account-btn:focus').css('color','#29ABE2');

        $(".defaul .has-search .form-control").focus(function(){
          $(this).css({'border':'1px solid #29ABE2','background':'#FFF'})
        });

        $('.defaul .btn_radius').css({'border-radius':'23px','background':'#fff linear-gradient(180deg, white, #fff) repeat-x','-webkit-box-shadow': 'none', 'box-shadow': 'none', '-webkit-transition':' all 0.4s', 'transition': 'all 0.4s'});
        $('.defaul .channel-details h2').css('color','#294D5D');
        $('.defaul .channel-details p').css('color','#294D5D');
        $('.defaul .theme-selection label').css('color','#294D5D');
        $('.defaul .theme-section label').css('color','#294D5D');
        $('.defaul .theme--light.v-btn:not(.v-btn--icon):not(.v-btn--flat)').css({'border-radius':'15px','background-color':'#FFF','color':'#29ABE2','border':'1px solid #fff','box-shadow':'6px 6px 20px #00000029','-webkit-box-shadow': '6px 6px 20px #00000029','-moz-box-shadow': '6px 6px 20px #00000029'});

        $('.defaul .bg-prim').css({'border-radius':'15px','background-color':'#FFF','color':'#29ABE2','border':'1px solid #fff','box-shadow':'6px 6px 20px #00000029','-webkit-box-shadow': '6px 6px 20px #00000029','-moz-box-shadow': '6px 6px 20px #00000029'});
        
        $(".default .bg-prim").hover(function(){
          $(this).css({'border-radius':'15px','background-color':'#FFF','color':'#29ABE2','border':'1px solid #29abe28a'});
          }, function(){
            $(this).css({'border-radius':'15px','background-color':'#FFF','color':'#29ABE2','border':'1px solid #FFF'});
        });

        $('.defaul .theme--light.red').css({'border-radius':'15px','background-color':'transparent','color':'#f44336','border':'1px solid #f44336'});
        
        $(".defaul .theme--light.red").hover(function(){
          $(this).css({'border-radius':'5px','background-color':'#f44336','color':'#FFF','border':'1px solid #f44336'});
          }, function(){

          $(this).css({'border-radius':'15px','background-color':'transparent','color':'#f44336','border':'1px solid #f44336'});
        });
        

        $('.defaul .promote-links a').css({'border-radius':'13px','background-color':'#FFF','color':'#007bff','border':'1px solid #007bff','box-shadow':'0px 3px 6px #00000029','-webkit-box-shadow': '0px 3px 6px #00000029', '-moz-box-shadow':' 0px 3px 6px #00000029', '-o-box-shadow':' 0px 3px 6px #00000029'}); 

        $(".defaul .promote-links a").hover(function(){
          $(this).css({'border-radius':'13px','background-color':'#FFF','color':'#007bff','border':'1px solid #007bff','box-shadow':'0px 3px 6px #00000029','-webkit-box-shadow': '0px 3px 6px #00000029', '-moz-box-shadow':' 0px 3px 6px #00000029', '-o-box-shadow':' 0px 3px 6px #00000029'});
          }, function(){
            $(this).css({'border-radius':'13px','background-color':'#FFF','color':'#007bff','border':'1px solid #007bff','box-shadow':'0px 3px 6px #00000029','-webkit-box-shadow': '0px 3px 6px #00000029', '-moz-box-shadow':' 0px 3px 6px #00000029', '-o-box-shadow':' 0px 3px 6px #00000029'});
        });


        
        $('.defaul .footer').css('background','#f7f7f7');
        $('.defaul .footer_section h4').css('color','#000');
        $('.defaul .footer_section a').css('color','#294D5D');
        $('.defaul .copyright_section p').css('color','#294D5D');
        $('.defaul .copyright_section hr').css('border-top','1px solid #294D5D');
    }
    




});
    }
  };
</script>

<style scoped>
  .channel-details {
    align-self: center;
    text-align: start;
  }
  .padding {
    padding: 10px;
  }
  .subscribers-count {
    color: gray;
  }
  @media only scree and (max-width:767px){
    .grey.lighten-4{width:80px!important;height:80px!important;}
  }
  .no-resource-found{
    padding: 50px;
    text-align: center;
    font-size: 25px;
  }

  .theme-sec{
    position:absolute;
    right:0px;
    top:20px;
  }
  @keyframes rotating {
  from {
    -ms-transform: rotate(0deg);
    -moz-transform: rotate(0deg);
    -webkit-transform: rotate(0deg);
    -o-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  to {
    -ms-transform: rotate(360deg);
    -moz-transform: rotate(360deg);
    -webkit-transform: rotate(360deg);
    -o-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}
.rotating {
  -webkit-animation: rotating 3s linear infinite;
  -moz-animation: rotating 3s linear infinite;
  -ms-animation: rotating 3s linear infinite;
  -o-animation: rotating 3s linear infinite;
  animation: rotating 3s linear infinite;
}
  .theme-selection i{font-size:24px;}
  .theme-selection,
  .theme-section{
    padding:15px;
    border: 1px solid #DDD;
    border-radius: 5px;
    min-width:150px;
  }
  .theme-selection label{font:24px/22px rubik-regular;color:#294D5D}

  body.darkly {
      background:#222;
  }


</style>
