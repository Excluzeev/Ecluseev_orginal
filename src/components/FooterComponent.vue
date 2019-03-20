<template>
  <v-footer class="margin padding bg text-xs-center" height="auto">
    <v-card flat tile class="bg white--text text-xs-center full-width">
      <v-card-text class="white--text pt-0">
        <a @click="showExcluzeevTerms">
          Excluzeev Terms
        </a>
        —
        <a @click="showCreatorTerms">
          Content Creator Terms
        </a>
        —
        <a @click="showPrivacyPolicy">
          Privacy Policy
        </a>
        —
        <a @click="showCookiePolicy">
          Cookie Policy
        </a>
      </v-card-text>

      <v-card-text class="white--text">
        &copy;2019 — <strong>Excluzeev</strong>
      </v-card-text>
    </v-card>
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
