<template>
  <div id="communities" class="communities">
    <div class="container-fluid ">
      <div class="row ">
        <div class="col-xl-12">
          <br>
          <h2>Communities</h2>
          <p>Here you’ll find all the communities you created and joined to.</p>
          <br>
        </div>
      </div>

      <div class="row ">
        <div class="col-xl-12 col-xs-12 col-sm-12 col-lg-12 col-md-12">
          <h5>My communities</h5>
        </div>
      </div>

      <div class="row ">
        <div class="col-sm-6 col-xs-12 col-md-6 col-lg-4"  v-for="channel in channelsList" v-bind:key="channel.channelId">
          <div class="my_community_section inline">
            <div class="row">
              <div class=" col-12" style="display:flex">
                <div class="community_circle_image text-center">

                    <router-link
                      :to="{
                      name: 'MyChannelDetails',
                        params: { channelId: channel.channelId }
                      }"
                      >
                  <img :src="channel.image" alt="avatar" class="rounded-circle img-fluid" v-if="!channel.isDeleted">
                  <div v-if="channel.isDeleted" class="red">
                    <div
                    v-if="channel.isDeleted"
                    class="white--text"
                    >Deletes in {{ getExpiry(channel.deleteOn) }} days</div>
                  </div>

                    </router-link>

                </div>

                <div class="community_info">
                  <h5>{{ channel.title }}</h5>
                  <p>{{ channel.description }}</p>
                  <p>{{ channel.categoryName }}</p>
<!--                  <p class="subscribers-count">{{ channel.subscriberCount }} Subscribers</p>-->

                  <div class="">
                    <button v-if="!channel.isDeleted" class="btn btn-remove" @click="confirmDelete(channel.channelId)">Remove</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <br>
      <div class="row ">
        <div class="col-xl-12 col-xs-12 col-sm-12 col-lg-12 col-md-12"><h5>Joined communities</h5></div>
      </div>

      <div class="row" >
        <div class="col-sm-6 col-xs-12 col-md-6 col-lg-4" v-for="subscription in subscriptionsList" v-bind:key="subscription.channelId">
          <div class="my_community_section inline">
            <div class="row">
              <div class="col-12" style="display: flex;">
                <div class="community_circle_image text-center">
                  <!-- <img src="../assets/Images/commu_image.png" > -->
                  <router-link
                    :to="{
                      name: 'SubscribedChannelDetails',
                        params: {
                        channelId: subscription.channelId,
                        subscriptionId: subscription.subscriptionId
                      }
                    }"
                  >
                  <img :src="'https://firebasestorage.googleapis.com/v0/b/trenstop-public/o/channels%2F' + subscription.channelId + '%2Fthumbnail.jpg?alt=media'"alt="avatar"class="rounded-circle img-fluid"/>

                  </router-link>
                </div>

                <div class="community_info">
                  <h5>{{ subscription.channelName }}</h5>
                  <p>{{ subscription.description }}</p>
                  <p>{{ subscription.categoryName }}</p>
                  <div class="inline-list">
                  </div>  
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div v-if="subscriptionsList.length <= 0" class="row text-xs-center">
        <div class=" offset-1  col-10 text-center">

          <p>Join the communities to see them here</p>
        </div>
      </div>
      <br>
      <div class="row ">
        <div class="col-xl-12 col-xs-12 col-sm-12 col-lg-12 col-md-12">
          <h5>Crowd Fundings</h5>
        </div>
      </div>

      <div class="row ">
        <div class="col-sm-6 col-xs-12 col-md-6 col-lg-4"  v-for="channel in crowdFundingchannels" v-bind:key="channel.channelId">
          <div class="my_community_section inline">
            <div class="row">
              <div class="col-12" style="display: flex;">
                <div class="community_circle_image text-center">

                    <router-link
                        :to="{
                        name: 'ChannelDetails',
                          params: { channelId: channel.channelId }
                        }"
                      >
                  <img
                  :src="
                    'https://firebasestorage.googleapis.com/v0/b/trenstop-public/o/channels%2F' +
                      channel.channelId +
                      '%2Fthumbnail.jpg?alt=media'
                  "
                  alt="avatar"
                  class="rounded-circle img-fluid" v-if="!channel.isDeleted"
                  >

			
                    </router-link>

                  <div v-if="channel.isDeleted" class="red">
                    <div
                    v-if="channel.isDeleted"
                    class="white--text"
                    >Deletes in {{ getExpiry(channel.deleteOn) }} days</div>
                  </div>

                  <!-- <img src="../assets/Images/commu_image.png" class="rounded-circle img-fluid"> -->
                </div>
                <div class="community_info">
                  <h5>{{ channel.title }}</h5>
                  <p>{{ channel.description }}</p>
                  <p>{{ channel.categoryName }}</p>
                  <p class="subscribers-count">{{ channel.views }} views</p>

                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

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

    </div>
  </div>
</template>

<script>
  import RegisterStoreModule from "../mixins/RegisterStoreModule";
  import store from "../store/index";
  import channelsModule from "../store/channels/channels";
  import subscriptionsModule from "../store/subscriptions/subscriptions";

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
        subscriptionsList: [],
        deleteDialog:false,
        channel:null,
        crowdFundingchannels:[],
      };
    },
    mixins: [RegisterStoreModule],
    created() {
      this.registerStoreModule("channels", channelsModule);
      this.registerStoreModule("subscriptions", subscriptionsModule);

    },
    methods: {
     getExpiry(date) {
      return moment(date.toDate()).diff(Date.now(), "day");
    },
    getChannel(channelId){
      for(let i=0;i<this.channelsList.length;i++){
        let channel=this.channelsList[i]
        if(channel.channelId == channelId){
          return channel
        }
      }
      return false
    },
    confirmDelete(channelId){
      let channel=this.getChannel(channelId)
      if(channel == false){
        alert("Something went wrong!!")
        return   
      }

      this.channel=channel
      this.deleteDialog=true

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

      this.$router.push({ name: "Communities" });
    }

  },
  async mounted() {


   if (this.$route.query.done) {
    await this.$store.commit("forceFetchUser", {
      user: auth.currentUser,
      force: true
    });
  }

  this.$store.dispatch("channels/getCrowdFundingChannels").then(data => {
    this.crowdFundingchannels = data;
  });


  this.$store.dispatch("channels/getChannels").then(data => {
    this.channelsList = data;
  });

  if (this.$route.query.done) {
    await this.$store.commit("forceFetchUser", {
      user: auth.currentUser,
      force: true
    });
  }

  this.$store.dispatch("subscriptions/getUserSubscriptions").then(data => {
    this.subscriptionsList = data;
  });


}
};
</script>

<style scoped>
  .communities{margin-bottom:70px;}

  @media only screen and (max-width:767px){
    .btn-manage,.btn-remove{font-size:12px;padding:10px 15px}
    h2{font-size:30px;}
    h5,p{font-size:16px;}
    .btn-view-all{font-size:16px;width:100%}
  }
</style>
