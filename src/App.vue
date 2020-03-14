<template>
  <!-- eslint-disable -->
  <div id="app">
    <EToolBar v-if="isNavBar"/>

    <keep-alive>
      <v-content>
        <router-view :key="$route.fullPath"></router-view>
      </v-content>
    </keep-alive>
    
    <cookie-law theme="base">
      <div slot="message">
        This site uses cookies to provide you with great user experience. By
        using excluzeev , you accept our
      </div>
    </cookie-law>

    <LoginModal />  
    <RegistrationModal />
    <ForgotPasswordModal />
    <FooterComponent v-if="isNavBar"/>

  </div>
</template>

<script>
import EToolBar from "./components/EToolBar";
import FooterComponent from "./components/FooterComponent";
import CookieLaw from "vue-cookie-law";
import LoginModal from "./components/LoginModal";
import ForgotPasswordModal from "./components/ForgotPasswordModal";
import RegistrationModal from "./components/RegistrationModal";


export default {
  name: "App",
  metaInfo: {
    title: "Excluzeev - Stream. Crowdfunding. Social Network",
    titleTemplate: "%s | Excluzeev"
  },
  title: "Excluzeev - Stream. Crowdfunding. Social Network",
  components: {
    FooterComponent,
    EToolBar,
    CookieLaw,
    LoginModal,
    ForgotPasswordModal,
    RegistrationModal
  },
  methods: {
   
  },
  computed: {
    isNavBar() {
      return this.$route.meta.showNav != false;
    }
  }
};



</script>

<style>

@import url("https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css");
@import url("https://fonts.googleapis.com/css?family=Rubik:300,400,500,500i&display=swap");
@import url("https://fonts.googleapis.com/css?family=Quicksand:400,500&display=swap");
@import url("https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css");

@import 'assets/css/style.css';
@import 'assets/css/responsive-style.css';

</style>
