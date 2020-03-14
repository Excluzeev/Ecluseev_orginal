<template>

  <v-container>
    <div v-if="categories.length > 0">
      <div v-for="category in categories" v-bind:key="category.id">
        <category-trailers :catId="category.id" :catName="category.name"/>
      </div>
    </div>
    <v-container v-else style="padding: 20px;">
      <p class="text-xs-center" style="font-size: 20px;">Now Loading..</p>
    </v-container>
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
