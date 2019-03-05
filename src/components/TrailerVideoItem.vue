<template>
  <router-link :to="'/trailer/' + trailer.trailerId">
    <v-card>
      <v-img :src="trailer.image" height="200px"> </v-img>

      <v-card-title primary-title>
        <div>
          <div class="headline">{{ trailer.title }}</div>
          <span class="grey--text">{{ trailer.description }}</span>
          <div class="grey--text">{{ trailer.timeAgo }}</div>
        </div>
      </v-card-title>
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
</style>
