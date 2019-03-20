<template>
  <router-link
          class="" :to="'/trailer/' + trailer.trailerId">
    <v-layout class="all-bg padding-top" justify-left row>
      <img :src="trailer.image" height="94" width="168" />
      <div class="padding">
        <div class="title--text">{{ trailer.title }}</div>
        <span class="desc--text">{{ trailer.channelName }}</span>
        <div class="desc--text">
          {{ trailer.views }} views • {{ trailer.timeAgo }}
        </div>
      </div>
    </v-layout>
  </router-link>
</template>

<script>
export default {
  name: "TrailerVideoItem",
  props: ["trailer"]
};
</script>

<style scoped>
a {
  text-decoration: none;
}
.padding {
  padding: 10px;
}
.title--text {
  color: #0a0a0a;
  font-size: 1rem;
  font-weight: 600;
}
.desc--text {
  font-size: 0.95rem;
}
  .padding-top {
    padding-top: 10px;
  }
</style>
