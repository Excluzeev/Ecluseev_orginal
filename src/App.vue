<template>
  <v-app>
    <EToolBar />
    <v-content>
      <div style="padding-top:25px"></div>
      <FeaturedItem />
      <HomeMenu />
    </v-content>
  </v-app>
</template>

<script>
import FeaturedItem from "./components/FeaturedItem";
import EToolBar from "./components/EToolBar";
import HomeMenu from "./components/HomeMenu";

export default {
  name: "App",
  components: {
    FeaturedItem,
    EToolBar,
    HomeMenu
  }
};
</script>
