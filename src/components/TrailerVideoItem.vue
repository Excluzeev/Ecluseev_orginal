<template>
  <router-link :to="'/trailer/' + trailer.trailerId">
    <v-card elevation="0" class="all-bg">
      <v-img :src="trailer.image" height="118px"> </v-img>
      <div class="padding">
        <div class="title--text max-2-lines">{{ trailer.title }}</div>
        <span class="desc--text">{{ trailer.channelName }}</span>
        <div class="desc--text"> {{ trailer.views }} views • {{ trailer.timeAgo }}</div>
      </div>
    </v-card>
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
    font-size: .9rem;
    font-weight: 600;
  }

</style>
