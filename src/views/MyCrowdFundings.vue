<template>
  <div id="communities" class="communities">
		<div class="container-fluid ">
      <div class="row ">
        <div class="col-xl-12">
          <br>
          <br>
          <h2>Crowd Fundings</h2>
          <p>Here you’ll find all the crowd fundings</p>
          <br>
          <br>
        </div>
      </div>

			<div class="row ">
				<div class="col-xl-12 col-xs-12 col-sm-12 col-lg-12 col-md-12">
					<h5>My crowd fundings</h5>
				</div>
			</div>

			<div class="row" v-if="trailers.length != 0">
        <div class="col-xl-4 col-lg-6"  v-for="trailer in trailers" v-bind:key="trailer.trailerId">

          <router-link :to="'/crowd/' + trailer.trailerId">
            <div class="item_img">
              <img height="118px" v-bind:src="trailer.hasCustomThumbnail ? trailer.customThumbnail :  trailer.image" class="img-fluid" >
            </div>
            <h6>{{ trailer.title }}</h6>
            <p>{{ trailer.channelName }}</p>
            <p><i class="fa fa-tripadvisor" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;{{ trailer.timeAgo }}</p>

             <div class="red--text" v-show="getIsExpired(trailer.expiry)">
                <p danger>Expired</p>
             </div>
          </router-link>
	      </div>
      </div>

      <div class="row" v-else>
        <div class="col-xl-12 col-lg-12 text-center">
            <p> You have no crowd fundings!!! </p>
        </div>
      </div>

		</div>

  </div>

</template>

<script>
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import store from "../store/index";
import channelsModule from "../store/channels/channels";
import videoModule from "../store/videos/video";
import trailerModule from "../store/trailers/trailer";

import { fireStore, firebaseTimestamp } from "../firebase/init";
import utils from "../firebase/utils";
import moment from "moment";


export default {
  name: "Communities",
  components: {
  },
  data: () => {
    return {
      channelsList: [],
      trailers:[],
      channel:null,
    };
  },
  mixins: [RegisterStoreModule],
  created() {
    this.registerStoreModule("channels", channelsModule);
    this.registerStoreModule("videos", videoModule);
    this.registerStoreModule("trailers", trailerModule);

  },
  methods: {

      getIsExpired(date) {
      if (date != null && date != undefined) {
        return moment(date.toDate()).diff(Date.now()) <= 0;
      } else {
        return false;
      }
    },

    getChannel(channelId){
      for(let i=0;i<this.channelsList.length;i++){
        let channel=this.channelsList[i]
        if(channel.channelId == channelId){
          return channel
        }
      }
      return false
    }
   },
  async mounted() {

   if (this.$route.query.done) {
      await this.$store.commit("forceFetchUser", {
        user: auth.currentUser,
        force: true
      });
    }
    this.$store.dispatch("videos/getUserCrowdFundingChannels").then(data => {
      this.channelsList = data;
    });

    this.$store.dispatch("trailers/getUserCrowdFundingTrailers").then(data => {
      this.trailers = data;
    });

    if (this.$route.query.done) {
      await this.$store.commit("forceFetchUser", {
        user: auth.currentUser,
        force: true
      });
    }



  }
};
</script>

<style scoped>
  @media only screen and (max-width:991px){
    .communities h2{font-size:30px;}
  }
</style>
