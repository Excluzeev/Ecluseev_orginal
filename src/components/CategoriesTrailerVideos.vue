<template>
  <v-container>
    <div v-for="category in categories" v-bind:key="category.id">
      <category-trailers :catId="category.id" :catName="category.name" />
    </div>
  </v-container>
</template>

<script>
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import categoriesModule from "../store/categories/categories";
import CategoryTrailers from "./CategoryTrailers";

export default {
  name: "CategoriesTrailerVideos",
  data: () => {
    return {
      categories: []
    };
  },
  components: {
    CategoryTrailers
  },
  mixins: [RegisterStoreModule],
  created() {
    this.registerStoreModule("categories", categoriesModule);
    this.$store.dispatch("categories/fetchCategories").then(data => {
      this.categories = data;
    });
    // this.fetchCategoryTrailers("VGf1Xq2czICWnIHdg6Pz", "Comedy");
  }
};
</script>

<style scoped>
  .padding {
    padding-left: 20px;
    padding-right: 20px;
  }
</style>
