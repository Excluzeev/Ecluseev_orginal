<template>
  <v-footer class="white" height="auto">
    <v-flex xs3>
      <div align="center">
        <img
          style="width: 50%;"
          alt="Excluzeev
            logo"
          src="../assets/excluzeev_bottom_text.png"
        />
        <!-- <div class="light-blue--text quick-sand-font-b">
          &copy; 2019 Excluzeev
        </div> -->
      </div>
    </v-flex>
    <v-flex xs2>
      <div align="center">
        <div align="left">
          <h3 class="nav-c quick-sand-font-b">EXPLORE</h3>

          <h3 class="light-blue--text quick-sand-font">About</h3>
          <a href="mailto:support@excluzeev.com?subject=Support%20Query"><h3 class="light-blue--text quick-sand-font">Support</h3></a>
          <h3 class="light-blue--text quick-sand-font">Contact us</h3>
        </div>
      </div>
    </v-flex>
    <v-flex xs2>
      <div align="top center">
        <div align="left">
          <h3 class="nav-c quick-sand-font-b">LEGAL</h3>

          <h3 class="light-blue--text quick-sand-font" @click="showExcluzeevTerms">
            Terms and conditions
          </h3>
          <h3 class="light-blue--text quick-sand-font" @click="showPrivacyPolicy">Privacy Policy</h3>
          <h3 class="light-blue--text quick-sand-font" @click="showCookiePolicy">Cookie Policy</h3>
        </div>
      </div>
    </v-flex>
    <v-flex xs2>
      <div align="top center">
        <div align="left">
          <h3 class="nav-c quick-sand-font-b">FOLLOW US</h3>

          <h3 class="light-blue--text quick-sand-font">Facebook</h3>
          <h3 class="light-blue--text quick-sand-font">Instagram</h3>
          <h3 class="light-blue--text quick-sand-font">Twitter</h3>
        </div>
      </div>
    </v-flex>
    <v-flex xs3>
      <h3 class="nav-c quick-sand-font-b">APPS</h3>
      <img
        style="width: 120px;height: 40px;"
        alt="Download_on_the_App_Store"
        src="../assets/Download_on_the_App_Store.svg"
      />
      <img
        style="width: 120px;height: 40px;"
        alt="google-play-badge"
        src="../assets/google-play-badge.png"
      />
    </v-flex>
    <v-layout row justify-center>
      <v-dialog
        v-model="dialog"
        fullscreen
        hide-overlay
        transition="dialog-bottom-transition"
      >
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
import ContentCreator from "./ContentCreator";
import LicenseAgreement from "./LicenseAgreement";
import CookiePolicy from "./CookiePolicy";

export default {
  name: "FooterComponent",
  data: () => {
    return {
      dialog: false
    };
  },
  methods: {
    showPrivacyPolicy() {
      this.titleDialog = "Privacy Policy";
      this.componentDialog = PrivacyPolicy;
      this.dialog = true;
    },
    showCreatorTerms() {
      this.titleDialog = "Content Creator Terms";
      this.componentDialog = ContentCreator;
      this.dialog = true;
    },
    showExcluzeevTerms() {
      this.titleDialog = "Excluzeev Terms";
      this.componentDialog = LicenseAgreement;
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
