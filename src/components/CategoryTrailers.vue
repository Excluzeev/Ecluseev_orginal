<template>
  <v-container>
    <v-layout text-xs-center wrap>
      <v-flex xs12>
        {{ categoriesTrailers }}
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import trailerModule from "../store/trailers/trailer";
import { mapActions } from "vuex";

export default {
  data: () => ({}),
  mixins: [RegisterStoreModule],
  computed: {
    categoriesTrailers() {
      return this.$store.getters.categoriesTrailers;
    }
  },
  created() {
    this.registerStoreModule("trailers", trailerModule);
    this.fetchCategoryTrailers("VGf1Xq2czICWnIHdg6Pz", "Comedy");
    // this.fetchCategoryTrailers("VGf1Xq2czICWnIHdg6Pz", "Comedy");
  },
  methods: {
    ...mapActions("trailers", ["fetchCategoryTrailers"])
  }
};
</script>

<style></style>
