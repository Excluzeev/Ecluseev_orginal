<template>
<div id="communities" class="communities">
		<div class="container-fluid d-none d-lg-block d-xl-block">
			<div class="row ">
				<div class="col-xl-12">
					<br>
					<br>
					<h2>Communities</h2>
					<p>Here you’ll find all the communities you created and joined to.</p>
					<br>
					<br>
				</div>
			</div>

			<div class="row ">
				<div class="col-xl-12 col-xs-12 col-sm-12 col-lg-12 col-md-12">
					<h5>My communities</h5>
				</div>
			</div>

			<div class="row ">
				
        
        <div class="col-xl-4 col-lg-6"  v-for="channel in channelsList" v-bind:key="channel.channelId">
					<div class="my_community_section inline">
						<div class="row">
							<div class="col-lg-4 col-md-4">
								<div class="community_circle_image text-center">
                  <img :src="channel.image" alt="avatar" class="rounded-circle img-fluid" v-if="!channel.isDeleted">
                  <div v-if="channel.isDeleted" class="red">
                    <div
                      v-if="channel.isDeleted"
                      class="white--text"
                    >Deletes in {{ getExpiry(channel.deleteOn) }} days</div>
                  </div>

									<!-- <img src="../assets/Images/commu_image.png" class="rounded-circle img-fluid"> -->
								</div>
							</div>
							<div class="col-lg-8 col-md-8">
								<div class="">
									<h5>{{ channel.title }}</h5>
									<p>{{ channel.description }}</p>
									<p>{{ channel.categoryName }}</p>
                    <p class="subscribers-count">{{ channel.subscriberCount }} Subscribers</p>

									<div class="inline-list">
                    <router-link
                      class="btn btn-manage pull-left"
                      :to="{
                        name: 'MyChannelDetails',
                        params: { channelId: channel.channelId }
                      }"
                    >
                    Manage
                    </router-link>
										<button class="btn btn-remove pull-right" @click="confirmDelete(channel.channelId)">Remove</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>


			</div>


      <!--  -->

      <div class="row ">
				<div class="col-xl-12 text-center">
					<button class="btn btn-view-all">View all</button>
				</div>
			</div>

			<div class="row ">
				<div class="col-xl-12 col-xs-12 col-sm-12 col-lg-12 col-md-12"><h5>Join communities</h5></div>
			</div>

			<div class="row" v-for="subscription in subscriptionsList" v-bind:key="subscription.channelId">
				<div class="col-xl-4 col-lg-6">
					<div class="my_community_section inline">
						<div class="row">
							<div class="col-lg-4 col-md-4">
								<div class="community_circle_image text-center">
									<!-- <img src="../assets/Images/commu_image.png" > -->

                   <img
                        :src="
              'https://firebasestorage.googleapis.com/v0/b/trenstop-public/o/channels%2F' +
                subscription.channelId +
                '%2Fthumbnail.jpg?alt=media'
            "
                        alt="avatar"
                        class="rounded-circle img-fluid"
                />
								</div>
							</div>
							<div class="col-lg-8 col-md-8">
								<div class="">
								
                  <h5>{{ subscription.title }}</h5>
									<p>{{ subscription.description }}</p>
									<p>{{ subscription.categoryName }}</p>

									<div class="inline-list">
                   <router-link
                      :to="{
                        name: 'SubscribedChannelDetails',
                        params: {
                          channelId: subscription.channelId,
                          subscriptionId: subscription.subscriptionId
                        }
                      }"
                    >
                    Manage
                    </router-link>
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


      <div class="row ">
				<div class="col-xl-12 text-center">
					<button class="btn btn-view-all">View all</button>
				</div>
			</div>
			<!-- <div class="row ">
				<div class=" offset-1  col-10 text-center">
					<p>Here you’ll find all the communities you created and joined to.</p>
				</div>
			</div> -->


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

</template>

<script>
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import channelsModule from "../store/channels/channels";
import { fireStore, firebaseTimestamp } from "../firebase/init";
import utils from "../firebase/utils";
import moment from "moment";

export default {
  name: "Cummunities",
  components: {
  },
  data: () => {
    return {
      channelsList: [],
      subscriptionsList: [],
      deleteDialog:false,
      channel:null,
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

      this.$router.push({ name: "MyChannels" });
    }

   },
  async mounted() {
   

   if (this.$route.query.done) {
      await this.$store.commit("forceFetchUser", {
        user: auth.currentUser,
        force: true
      });
    }
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

</style>
