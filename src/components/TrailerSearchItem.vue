<template>
  <router-link :to="'/' + getLinkTag + '/' + trailer.trailerId">
    <v-card elevation="0" class="all-bg margin">
      <v-layout row>
        <v-flex xs3>
          <v-img :src="trailer.image" height="118px"></v-img>
        </v-flex>
        <v-flex xs9>
          <div class="padding">
            <div class="title--text max-2-lines quick-sand-font-n">{{ trailer.title }}</div>
            <span
              class="desc--text"
            >{{ trailer.channelName }} • {{ trailer.views }} views • {{ trailer.timeAgo }}</span>
            <div class="desc--text only-desp">{{ trailer.description }}</div>
          </div>
        </v-flex>
      </v-layout>
    </v-card>
  </router-link>
</template>

<script>
export default {
  name: "TrailerSearchItem",
  props: ["trailer"],
  computed: {
    getLinkTag() {
      return this.trailer.channelType == "CrowdFunding" ? "crowd" : "trailer";
    }
  }
};
</script>

<style scoped>
a {
  text-decoration: none;
}
.margin {
  margin: 10px;
}
.padding {
  padding: 10px;
}
.title--text {
  color: #0a0a0a;
  font-size: 1.2rem;
  font-weight: 600;
}
.desc--text {
  font-size: 0.9rem;
}
.only-desp {
  padding: 10px 0px;
  font-size: 1rem;
}
</style>
