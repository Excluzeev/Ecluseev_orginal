<template>
  <v-container>
    <div v-if="categories.length > 0">
      <div v-for="category in categories" v-bind:key="category.id">
        <category-trailers :catName="category"/>
      </div>
    </div>
    <v-container v-else style="padding: 20px;">
      <p class="text-xs-center" style="font-size: 20px;">Now Loading..</p>
    </v-container>
  </v-container>
</template>

<script>
import CategoryTrailers from "../components/CategoryTrailers";

export default {
  name: "SingleCategory",
  data: () => {
    return {
      categories: []
    };
  },
  components: {
    CategoryTrailers
  },
  created() {
    let cat = this.$route.query.category;
    if (cat.includes(",")) {
      cat = cat.split(",");

      this.categories = cat;
    } else {
      this.categories.push(cat);
    }
  }
};
</script>

<style scoped>
.padding {
  padding-left: 20px;
  padding-right: 20px;
}
</style>
