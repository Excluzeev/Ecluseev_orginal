<template>
  <div class="home">
    <div style="padding-top:25px"></div>
    <!--<FeaturedItem />-->
    <CategoriesTrailerVideos />
  </div>
</template>

<script>
// @ is an alias to /src
// import FeaturedItem from "../components/FeaturedItem";
import CategoriesTrailerVideos from "../components/CategoriesTrailerVideos";

export default {
  name: "Home",
  components: {
    // FeaturedItem,
    CategoriesTrailerVideos
  }
};
</script>
