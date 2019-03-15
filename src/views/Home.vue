<template>
  <div class="home">
    <div style="padding-top:25px"></div>
    <FeaturedItem />
    <!--<HomeMenu />-->
    <CategoriesTrailerVideos />
  </div>
</template>

<script>
// @ is an alias to /src
import FeaturedItem from "../components/FeaturedItem";
import HomeMenu from "../components/HomeMenu";
import CategoriesTrailerVideos from "../components/CategoriesTrailerVideos";

export default {
  name: "Home",
  components: {
    FeaturedItem,
    HomeMenu,
    CategoriesTrailerVideos
  }
};
</script>
