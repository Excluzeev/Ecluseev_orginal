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
      <v-flex xs12 sm3 md2>
        <div align="center">
          <div align="center">
            <h3 class="nav-c quick-sand-font-b">EXPLORE</h3>

            <h3 @click="showAbout" class="light-blue--text quick-sand-font">About</h3>
            <a href="mailto:support@excluzeev.com?subject=Support%20Query">
              <h3 class="light-blue--text quick-sand-font">Support</h3>
            </a>
            <h3 @click="showFAQs" class="light-blue--text quick-sand-font">FAQs</h3>
          </div>
        </div>
      </v-flex>
      <v-flex xs12 sm3 md2>
        <div align="top center">
          <div align="center">
            <h3 class="nav-c quick-sand-font-b">LEGAL</h3>
            <h3 class="light-blue--text quick-sand-font" @click="showPrivacyPolicy">Privacy Policy</h3>
            <h3 class="light-blue--text quick-sand-font" @click="showCookiePolicy">Cookie Policy</h3>
          </div>
        </div>
      </v-flex>
      <v-flex xs12 sm3 md2>
        <div align="top center">
          <div align="center">
            <h3 class="nav-c quick-sand-font-b">FOLLOW US</h3>

            <a href="https://www.facebook.com/excluzeev">
              <h3 class="light-blue--text quick-sand-font">Facebook</h3>
            </a>
            <a href="https://www.instagram.com/excluzeev/">
              <h3 class="light-blue--text quick-sand-font">Instagram</h3>
            </a>
          </div>
        </div>
      </v-flex>
      <v-flex xs12 md3>
        <h3 class="nav-c quick-sand-font-b">APPS</h3>
        <img
          style="width: 120px;height: 40px;"
          alt="Download_on_the_App_Store"
          src="../assets/Download_on_the_App_Store.svg"
        >
        <a href="https://play.google.com/store/apps/details?id=com.trenstop.mobile">
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
