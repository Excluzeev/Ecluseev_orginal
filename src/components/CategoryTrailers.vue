<template>
  <v-container v-show="categoryTrailers.length > 0">
    <v-layout text-xs wrap>
      <v-flex xs12>
        <div v-for="item in categoryTrailers" v-bind:key="item.catId">
          <h1>{{ item.catName }}</h1>
          <br />
          <v-layout xs12 row wrap>
            <v-flex
              class="trailer-item"
              xs12
              sm6
              md6
              lg4
              v-for="trailer in item.trailers"
              v-bind:key="trailer.trailerId"
            >
              <TrailerVideoItem :trailer="trailer" />
            </v-flex>
          </v-layout>
        </div>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import trailerModule from "../store/trailers/trailer";

import TrailerVideoItem from "./TrailerVideoItem";

export default {
  name: "CategoryTrailers",
  components: {
    TrailerVideoItem
  },
  data: () => {
    return {
      categoryTrailers: []
    };
  },
  props: ["catId", "catName"],
  mixins: [RegisterStoreModule],
  computed: {},
  created() {
    this.registerStoreModule("trailers", trailerModule);
    const cat = {
      categoryId: this.$props.catId,
      categoryName: this.$props.catName
    };
    this.$store.dispatch("trailers/fetchCategoryTrailers", cat).then(data => {
      this.categoryTrailers.push(data);
    });
  },
  methods: {}
};
</script>

<style scoped>
.trailer-item {
  padding-top: 10px;
  padding-bottom: 10px;
  padding-right: 10px;
}
</style>
