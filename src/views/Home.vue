<template>
  <div class="home">
    <div style="padding-top:25px"></div>
    <FeaturedItem />
    <!--<HomeMenu />-->
    <FooterComponent />
    <CategoriesTrailerVideos />
  </div>
</template>

<script>
// @ is an alias to /src
import FeaturedItem from "../components/FeaturedItem";
import CategoriesTrailerVideos from "../components/CategoriesTrailerVideos";
import FooterComponent from "../components/FooterComponent";

export default {
  name: "Home",
  components: {
    FeaturedItem,
    CategoriesTrailerVideos,
    FooterComponent
  }
};
</script>
