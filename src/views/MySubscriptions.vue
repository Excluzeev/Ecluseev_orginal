<template>
  <v-container>
    <v-layout xs12 row wrap>
      <v-flex
        class="channel-item"
        xs6
        sm4
        md3
        lg2
        v-for="channel in subscriptionsList"
        v-bind:key="channel.channelId"
      >
        <router-link
          :to="{
            name: 'SubscribedChannelDetails',
            params: { channel: channel }
          }"
        >
          <div class="padding text-xs-center" justify-center>
            <v-avatar :tile="tile" size="150px" color="grey lighten-4">
              <img
                :src="
                  'https://firebasestorage.googleapis.com/v0/b/trenstop-public/o/channels%2F' +
                    channel.channelId +
                    '%2Fthumbnail.jpg?alt=media'
                "
                alt="avatar"
              />
            </v-avatar>
            <h3 class="padding">
              {{ channel.channelName }}
            </h3>
            <p class="small-padding subscribers-count">
              {{ channel.subscriberCount }} Subscribers
            </p>
          </div>
        </router-link>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import subscriptionsModule from "../store/subscriptions/subscriptions";

export default {
  name: "MySubscriptions",
  data: () => {
    return {
      subscriptionsList: [],
      tile: false
    };
  },
  mixins: [RegisterStoreModule],
  props: {},
  created() {
    this.registerStoreModule("subscriptions", subscriptionsModule);
  },
  mounted() {
    this.$store.dispatch("subscriptions/getUserSubscriptions").then(data => {
      console.log(data);
      this.subscriptionsList = data;
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
