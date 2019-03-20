<template>
  <v-container class="">
    <div>
      <v-layout xs12>
        <h1 class="quick-sand-font-n">My Channels</h1>
        <v-spacer></v-spacer>
        <router-link right :to="{ name: 'CreateChannel' }">
          <v-btn color="primary" class="white--text quick-sand-font-b">
            <v-icon left>add</v-icon>Create Channel</v-btn
          >
        </router-link>
      </v-layout>
      <v-layout xs12 row wrap>
        <v-flex
          class="channel-item"
          xs12
          sm4
          md3
          lg2
          v-for="channel in channelsList"
          v-bind:key="channel.channelId"
        >
          <v-card style="margin-left: 10px; margin-top: 5px;">
            <router-link
              class="text-xs-center"
              :to="{
                name: 'MyChannelDetails',
                params: { channelId: channel.channelId }
              }"
            >
              <h3 class="padding">
                {{ channel.title }}
              </h3>
              <p class="subscribers-count">
                {{ channel.subscriberCount }} Subscribers
              </p>

              <div class="padding text-xs-center" justify-center>
                <v-avatar :tile="tile" size="150px" color="grey lighten-4" :class="channel.isDeleted ? 'red' : ''">
                  <img
                    :src="channel.image"
                    alt="avatar"
                    v-if="!channel.isDeleted"
                  />
                  <div v-if="channel.isDeleted"  class="red">
                    <div v-if="channel.isDeleted" class="white--text">
                      Deletes in {{ getExpiry(channel.deleteOn) }} days
                    </div>
                  </div>
                </v-avatar>
              </div>
            </router-link>
          </v-card>
        </v-flex>
      </v-layout>
    </div>
  </v-container>
</template>

<script>
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import channelsModule from "../store/channels/channels";
import moment from "moment";

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
  computed: {},
  methods: {
    getExpiry(date) {
      return moment(date.toDate()).diff(Date.now(), "day");
    }
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
