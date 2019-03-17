<template>
 <div class="padding">
   <v-layout right xs12>
     <v-spacer></v-spacer>
     <router-link right
                  :to="{ name: 'CreateChannel' }"
     >
       <v-btn color="primary" class="white--text" round>
         <v-icon left>add</v-icon>Create Channel</v-btn
       >
     </router-link>
   </v-layout>
   <v-container>
     <v-layout xs12 row wrap>
       <v-flex
               class="channel-item"
               xs6
               sm4
               md3
               lg2
               v-for="channel in channelsList"
               v-bind:key="channel.channelId"
       >
         <router-link :to="{ name: 'MyChannelDetails', params: { channelId: channel.channelId }}">
           <div class="padding text-xs-center" justify-center>
             <v-avatar :tile="tile" size="150px" color="grey lighten-4">
               <img :src="channel.image" alt="avatar" v-if="!channel.isDeleted" />
               <v-icon alt="avatar" v-if="channel.isDeleted" class="red">delete</v-icon>
             </v-avatar>
             <h3 class="padding">
               {{ channel.title }}
             </h3>
             <p class="small-padding subscribers-count">
               {{ channel.subscriberCount }} Subscribers
             </p>
           </div>
         </router-link>
       </v-flex>
     </v-layout>
   </v-container>
 </div>
</template>

<script>
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import channelsModule from "../store/channels/channels";

export default {
  name: "MyChannels",
  data: () => {
    return {
      channelsList: [],
      tile: false
    };
  },
  mixins: [RegisterStoreModule],
  props: {},
  created() {
    this.registerStoreModule("channels", channelsModule);
  },
  mounted() {
    this.$store.dispatch("channels/getChannels").then(data => {
      this.channelsList = data;
    });
  }
};
</script>

<style scoped>
.padding {
  padding: 10px;
}
.subscribers-count {
  color: gray;
}
</style>
