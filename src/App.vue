<template>
  <!-- eslint-disable -->
  <div id="app">

    <EToolBar v-if="isNavBar"/>
    <EToolBarPreview v-if="isPreviewsPage"/>

    <keep-alive>
      <v-content>
        <router-view :key="$route.path"></router-view>
      </v-content>
    </keep-alive>
    
    <cookie-law theme="base">
      <div slot="message">
        This site uses cookies to provide you with great user experience. By
        using excluzeev , you accept our
      </div>
    </cookie-law>

    <LoginModal ref="loginComp"/>  
    <RegistrationModal ref="registerComp"/>
    <ForgotPasswordModal ref="forgotComp"/>
    <BecomeCC />
    <FooterComponent v-if="isNavBar"/>
    <FooterComponentPreview v-if="isPreviewsPage"/>


     <vue-programmatic-invisible-google-recaptcha
                  ref="invisibleRecaptcha1"
                  sitekey="6LcwXpkUAAAAAMRYzY4mULgEmyBwpDnKRt1leWtC"
                  elementId="'invisibleRecaptcha1'"
                  badgePosition="'left'"
                  :showBadgeMobile="false"
                  :showBadgeDesktop="true"
                  @recaptcha-callback="recaptchaCallback"
                ></vue-programmatic-invisible-google-recaptcha>

  </div>
</template>

<script>
import EToolBar from "./components/EToolBar";
import EToolBarPreview from "./components/EToolBarPreview";
import FooterComponent from "./components/FooterComponent";
import FooterComponentPreview from "./components/FooterComponentPreview";
import CookieLaw from "vue-cookie-law";
import LoginModal from "./components/LoginModal";
import ForgotPasswordModal from "./components/ForgotPasswordModal";
import RegistrationModal from "./components/RegistrationModal";
import BecomeCC from "./components/BecomeCC";

import { videoStorage, auth, firebaseTimestamp } from "./firebase/init";


export default {
  name: "App",
  metaInfo: {
    title: "Excluzeev - Stream. Crowdfunding. Social Network",
    titleTemplate: "%s | Excluzeev"
  },
  data: () => {
    return{
        fromComp:'',
    };
  },
  title: "Excluzeev - Stream. Crowdfunding. Social Network",
  components: {
    FooterComponent,
    FooterComponentPreview,
    EToolBar,
    EToolBarPreview,
    CookieLaw,
    LoginModal,
    ForgotPasswordModal,
    RegistrationModal,
    BecomeCC
  },
  methods: {
        recaptchaCallback(token) {
            console.log("recaptchaCallback");
    
            if(this.fromComp == "forgotComp"){
    
                 this.$refs.forgotComp.recaptchaCallback(token);                
            }
            else if(this.fromComp == "registerComp"){
           
                 this.$refs.registerComp.recaptchaCallback(token);                
            } 
            else if(this.fromComp == "loginComp"){
           
                 this.$refs.loginComp.recaptchaCallback(token);                
            } 
        },
        executeRecaptcha(name){
            this.fromComp=name
            console.log("From component",name)
            this.$refs.invisibleRecaptcha1.execute();
        } 
  },
  computed: {
    isNavBar() {
        
      return this.$route.meta.showNav != false;
    },
    isPreviewsPage() {
      return this.$route.meta.isPreviewPage == true ;
    }
  },
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
