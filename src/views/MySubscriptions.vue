<template>
  <v-container>
    <h1 class="quick-sand-font-n">My Subscriptions</h1>
    <v-layout xs12 row wrap>

      <v-flex
        class="channel-item"
        xs6
        sm4
        md3
        lg2
        v-for="subscription in subscriptionsList"
        v-bind:key="subscription.channelId"
      >
        <SubscribedChannelItem style="margin-left: 5px;margin-right: 5px;margin-top: 5px" :subscription="subscription" />
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import subscriptionsModule from "../store/subscriptions/subscriptions";
import { auth } from "../firebase/init";
import SubscribedChannelItem from "../components/SubscribedChannelItem";

export default {
  name: "MySubscriptions",
  components: {SubscribedChannelItem},
  data: () => {
    return {
      subscriptionsList: [],
      tile: false
    };
  },
  mixins: [RegisterStoreModule],
  props: {},
  async created() {
    console.log(this.$route.query.done);
    console.log(auth.currentUser);

    this.registerStoreModule("subscriptions", subscriptionsModule);
  },
  async mounted() {
    if (this.$route.query.done) {
      await this.$store.commit("fetchUser", { user: auth.currentUser, force: true});
    }
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
