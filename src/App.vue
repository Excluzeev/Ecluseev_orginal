<template>
  <v-app>
    <EToolBar v-if="isNavBar" />
    <v-content>
      <router-view :key="$route.fullPath"></router-view>
    </v-content>
    <!--<FooterComponent />-->
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
@import url("https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700");
@import url("https://fonts.googleapis.com/css?family=Quicksand:400,500,700");

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
body {
  background-color: #fafafa;
  font-family: "Source Sans Pro", sans-serif !important;
}
.application {
  font-family: "Source Sans Pro", sans-serif !important;
}
.all-bg {
  background-color: #fafafa;
}
main {
  background-color: #fafafa;
}
.desc--text {
  color: #606060;
  font-size: 0.9rem;
}

.desc-details--text {
  color: #606060;
  font-size: 1.2rem;
}
.title-details--text {
  color: #0a0a0a;
  font-size: 1.4rem;
  font-weight: bold;
}
.max-2-lines {
  display: block; /* or inline-block */
  text-overflow: ellipsis;
  word-wrap: break-word;
  overflow: hidden;
  max-height: 2.4em;
  line-height: 1.2em;
  white-space: normal;
  -webkit-line-clamp: 2;
}
.max-1-lines {
  display: block; /* or inline-block */
  text-overflow: ellipsis;
  word-wrap: break-word;
  overflow: hidden;
  max-height: 1.2em;
  line-height: 1.2em;
  white-space: normal;
  -webkit-line-clamp: 2;
}
.quick-sand-font-b {
  font-family: "Quicksand", sans-serif;
  font-weight: 700;
}
.quick-sand-font {
  font-family: "Quicksand", sans-serif;
  font-weight: 500;
}
</style>
