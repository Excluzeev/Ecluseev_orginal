<template>
  <v-app>
     <EToolBar v-if="isNavBar"/>
    <v-content>
      <router-view></router-view>
    </v-content>
  </v-app>
</template>

<script>
import EToolBar from "./components/EToolBar";
export default {
  name: "App",
  components: {
    EToolBar
  },
  computed: {
    isNavBar() {
      return this.$route.meta.showNav == undefined ? true : false;
    }
  }
};
</script>
