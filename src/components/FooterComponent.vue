<template>
  <v-footer class="white" height="auto">
    <v-layout wrap align-center class="text-xs-center">
      <v-flex xs12 sm3 md3>
        <div align="center">
          <img
            style="width: 50%;"
            alt="Excluzeev
            logo"
            src="../assets/excluzeev_bottom_text.png"
          >
          <!-- <div class="light-blue--text quick-sand-font-b">
          &copy; 2019 Excluzeev
          </div>-->
        </div>
      </v-flex>
      <v-flex xs12 sm3 md3>
        <div align="center">
          <div align="center">
            <h3 class="nav-c quick-sand-font-b">EXPLORE</h3>

            <!-- <h3 @click="showAbout" class="light-blue--text quick-sand-font">About</h3> -->
            <a href="https://excluzeev.typeform.com/to/s3gTOy" target="_blank">
              <h3 class="light-blue--text quick-sand-font">Support</h3>
            </a>
            <a href="https://excluzeev.typeform.com/to/A3Mu8b" target="_blank">
              <h3 class="light-blue--text quick-sand-font">Contact Us</h3>
            </a>
            <h3 @click="showFAQs" class="light-blue--text quick-sand-font">FAQs</h3>
          </div>
        </div>
      </v-flex>
      <v-flex xs12 sm3 md3>
        <div align="top center">
          <div align="center">
            <h3 class="nav-c quick-sand-font-b">LEGAL</h3>
            <h3 class="light-blue--text quick-sand-font" @click="showPrivacyPolicy">Privacy Policy</h3>
            <h3 class="light-blue--text quick-sand-font" @click="showCookiePolicy">Cookie Policy</h3>
            <h3
              class="light-blue--text quick-sand-font"
              @click="showLicenseAgreement"
            >License Agreement</h3>
          </div>
        </div>
      </v-flex>
      <v-flex xs12 md3>
        <v-layout wrap align-center class="text-xs-center">
          <v-spacer></v-spacer>
          <a style="padding-right:5px;" href="https://www.facebook.com/excluzeev">
            <h3 class="black--text quick-sand-font">
              <font-awesome-icon :icon="['fab', 'facebook']" size="2x"/>
            </h3>
          </a>
          <a style="padding-left:5px;" href="https://www.instagram.com/excluzeev/">
            <h3 class="black--text quick-sand-font">
              <font-awesome-icon :icon="['fab', 'instagram']" size="2x"/>
            </h3>
          </a>

          <v-spacer></v-spacer>
        </v-layout>
        <a href="https://itunes.apple.com/bt/app/excluzeev/id1457995935?mt=8" target="_blank">
          <img
            style="width: 120px;height: 40px;"
            alt="Download_on_the_App_Store"
            src="../assets/Download_on_the_App_Store.svg"
          >
        </a>
        <br>
        <a href="https://play.google.com/store/apps/details?id=com.trenstop.mobile" target="_blank">
          <img
            style="width: 120px;height: 40px;"
            alt="google-play-badge"
            src="../assets/google-play-badge.png"
          >
        </a>
      </v-flex>
    </v-layout>
    <v-layout row justify-center>
      <v-dialog v-model="dialog" fullscreen hide-overlay transition="dialog-bottom-transition">
        <v-card>
          <v-toolbar dark color="primary">
            <v-btn icon dark @click="dialog = false">
              <v-icon>close</v-icon>
            </v-btn>
            <v-toolbar-title>{{ titleDialog }}</v-toolbar-title>
          </v-toolbar>
          <component v-bind:is="componentDialog"></component>
        </v-card>
      </v-dialog>
    </v-layout>
  </v-footer>
</template>

<script>
import PrivacyPolicy from "./PrivacyPolicy";
import CookiePolicy from "./CookiePolicy";
import About from "./About";
import FAQs from "./FAQs";

import LicenseAgreement from "./LicenseAgreement";

export default {
  name: "FooterComponent",
  data: () => {
    return {
      dialog: false,
      privacyPolicy: false,
      termsCreator: false,
      terms: false,
      dialog: false,
      titleDialog: "",
      componentDialog: null
    };
  },
  methods: {
    showPrivacyPolicy() {
      this.titleDialog = "Privacy Policy";
      this.componentDialog = PrivacyPolicy;
      this.dialog = true;
    },
    showAbout() {
      this.titleDialog = "About Us";
      this.componentDialog = About;
      this.dialog = true;
    },
    showFAQs() {
      this.titleDialog = "FAQs";
      this.componentDialog = FAQs;
      this.dialog = true;
    },
    showCookiePolicy() {
      this.titleDialog = "Cookie Policy";
      this.componentDialog = CookiePolicy;
      this.dialog = true;
    },

    showLicenseAgreement() {
      this.titleDialog = "License Agreement";
      this.componentDialog = LicenseAgreement;
      this.dialog = true;
    }
  }
};
</script>

<style scoped>
a {
  color: white;
}
footer {
  width: 100%;
  padding-bottom: 20px;
}
.quick-sand-font {
  padding-top: 10px;
}
.bg {
  background-color: #42a5f5;
}
.margin {
  margin-top: 60px;
}
.padding {
  padding: 20px;
}
.full-width {
  width: 100%;
}
</style>
