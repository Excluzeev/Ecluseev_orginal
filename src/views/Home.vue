<template>
  <div class="home">
    <img alt="Vue logo" src="../assets/logo.png" />
    <HelloWorld msg="Welcome to Your Vue.js App" />
    <CategoriesTrailerVideos />
  </div>
</template>

<script>
// @ is an alias to /src
import HelloWorld from "../components/HelloWorld";
import CategoriesTrailerVideos from "../components/CategoriesTrailerVideos";

export default {
  name: "home",
  components: {
    HelloWorld,
    CategoriesTrailerVideos
  }
};
</script>
