<template>
  <v-app>
    <EToolBar v-if="isNavBar" />
    <v-content>
      <router-view></router-view>
    </v-content>
    <FooterComponent />
  </v-app>
</template>

<script>
import EToolBar from "./components/EToolBar";
import FooterComponent from "./components/FooterComponent";
export default {
  name: "App",
  title: "Excluzeev - Stream. Crowdfunding. Social Network",
  components: {
    FooterComponent,
    EToolBar
  },
  computed: {
    isNavBar() {
      return this.$route.meta.showNav != false;
    }
  }
};
</script>
<style>
a {
  text-decoration: none;
}
.custom-loader {
  animation: loader 1s infinite;
  display: flex;
}
@-moz-keyframes loader {
  from {
    transform: rotate(0);
  }
  to {
    transform: rotate(360deg);
  }
}
@-webkit-keyframes loader {
  from {
    transform: rotate(0);
  }
  to {
    transform: rotate(360deg);
  }
}
@-o-keyframes loader {
  from {
    transform: rotate(0);
  }
  to {
    transform: rotate(360deg);
  }
}
@keyframes loader {
  from {
    transform: rotate(0);
  }
  to {
    transform: rotate(360deg);
  }
}
</style>
