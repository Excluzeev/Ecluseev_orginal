<template>
  <v-layout>
    <v-toolbar app class="white quick-sand-font">
      <router-link to="/">
        <v-toolbar-title class="headline text-uppercase">
          <img
            class="padding-logo"
            alt="Excluzeev logo"
            src="../assets/excluzeev_trailer.png"
            height="50px"
          >
        </v-toolbar-title>
      </router-link>
      <v-spacer></v-spacer>

      <div style="width: 200px; margin-right: 10px;">
        <form @submit.prevent="searchPreviews">
          <v-text-field append-icon="search" v-model="query" label="Search" single-line></v-text-field>
        </form>
      </div>

      <v-menu>
        <template #activator="{ on: menu }">
          <v-tooltip bottom>
            <template #activator="{ on: tooltip }">
              <v-icon v-on="{ ...tooltip, ...menu }">video_call</v-icon>
            </template>
            <span>Add a Video or Create a Live</span>
          </v-tooltip>
        </template>
        <v-list>
          <v-list-tile @click="goLoginContentCreator" v-if="!hideSignUpContentCreator">
            <v-list-tile-title class="quick-sand-font">Become a Content Creator</v-list-tile-title>
          </v-list-tile>
          <v-list-tile @click="goLoginLive" v-if="hideSignUpContentCreator">
            <v-list-tile-avatar>
              <img src="../assets/e.png" width="20">
            </v-list-tile-avatar>
            <v-list-tile-title class="quick-sand-font">Excluzeev live</v-list-tile-title>
          </v-list-tile>
          <v-list-tile @click="goLoginCreate" v-if="hideSignUpContentCreator">
            <v-list-tile-avatar>
              <v-icon>add</v-icon>
            </v-list-tile-avatar>
            <v-list-tile-title class="quick-sand-font">Create Channel</v-list-tile-title>
          </v-list-tile>
        </v-list>
      </v-menu>

      <router-link :to="{ name: 'MySubscriptions' }" v-if="!showLogin">
        <v-btn flat>
          <span class="mr-2">My Communities</span>
        </v-btn>
      </router-link>
      <router-link :to="{ name: 'MyChannels' }" v-if="hideSignUpContentCreator">
        <v-btn flat>
          <span class="mr-2">My Channels</span>
        </v-btn>
      </router-link>
      <!--Notification Component-->
      <!--<NotificationsMenu v-if="!showLogin" />-->
      <!--Account menu-->
      <AccountMenu v-if="!showLogin"/>
      <router-link :to="{ name: 'Login' }" v-if="showLogin">
        <v-btn flat>
          <span class="nav-auth-button">SIGN IN</span>
        </v-btn>
      </router-link>
      <!--<router-link :to="{ name: 'Registration' }" v-if="showLogin">-->
      <!--<v-btn flat>-->
      <!--<span class="mr-2">SignUp</span>-->
      <!--</v-btn>-->
      <!--</router-link>-->

      <v-menu>
        <template #activator="{ on: menu }">
          <v-tooltip bottom>
            <template #activator="{ on: tooltip }">
              <v-icon v-on="{ ...tooltip, ...menu }">more_vert</v-icon>
            </template>
            <span>More</span>
          </v-tooltip>
        </template>
        <v-list>
          <v-list-tile @click="showPrivacyPolicy">
            <v-list-tile-title class="quick-sand-font">Privacy Policy</v-list-tile-title>
          </v-list-tile>
          <v-list-tile @click="showCookiePolicy">
            <v-list-tile-title class="quick-sand-font">Cookie Policy</v-list-tile-title>
          </v-list-tile>
          <v-list-tile @click="showCreatorTerms">
            <v-list-tile-title class="quick-sand-font">Community Member Agreement</v-list-tile-title>
          </v-list-tile>
          <v-list-tile @click="showExcluzeevTerms">
            <v-list-tile-title class="quick-sand-font">Licensing Agreement</v-list-tile-title>
          </v-list-tile>
        </v-list>
      </v-menu>
    </v-toolbar>
    <v-layout row justify-center>
      <v-dialog v-model="dialogt" fullscreen hide-overlay transition="dialog-bottom-transition">
        <v-card>
          <v-toolbar dark color="primary">
            <v-btn icon dark @click="dialogt = false">
              <v-icon>close</v-icon>
            </v-btn>
            <v-toolbar-title>{{ titleDialogt }}</v-toolbar-title>
          </v-toolbar>
          <component v-bind:is="componentDialogt"></component>
        </v-card>
      </v-dialog>
    </v-layout>
  </v-layout>
</template>

<script>
import AccountMenu from "./AccountMenu.vue";
import NotificationsMenu from "./NotificationsMenu.vue";
import store from "../store/index";

import PrivacyPolicy from "../components/PrivacyPolicy";
import CookiePolicy from "../components/CookiePolicy";
import ContentCreator from "../components/ContentCreator";
import LicenseAgreement from "../components/LicenseAgreement";

export default {
  components: {
    AccountMenu,
    NotificationsMenu
  },
  computed: {
    showLogin() {
      return store.getters.getUser == null;
    },
    hideSignUpContentCreator() {
      // console.log(store.getters.getFUser.isContentCreator);
      return store.getters.getFUser != null
        ? store.getters.getFUser.isContentCreator
        : false;
    }
  },
  data: () => {
    return {
      query: "",
      dialogt: false,
      titleDialogt: "",
      componentDialogt: null
    };
  },
  methods: {
    goLoginContentCreator() {
      if (this.showLogin) {
        this.$router.push({ name: "Login" });
        return;
      }
      if (!this.hideSignUpContentCreator) {
        this.$router.push({ name: "SignUpCC" });
        return;
      }
    },
    goLoginLive() {
      if (this.showLogin) {
        this.$router.push({ name: "Login" });
      } else {
        this.$router.push({ name: "AddExcluzeev" });
      }
    },
    goLoginCreate() {
      if (this.showLogin) {
        this.$router.push({ name: "Login" });
      } else {
        this.$router.push({ name: "CreateChannel" });
      }
    },
    searchPreviews() {
      this.$router.push({
        name: "SearchPreviews",
        params: { query: this.query }
      });
    },
    showPrivacyPolicy() {
      this.titleDialogt = "Privacy Policy";
      this.componentDialogt = PrivacyPolicy;
      this.dialogt = true;
    },
    showCookiePolicy() {
      this.titleDialogt = "Cookie Policy";
      this.componentDialogt = CookiePolicy;
      this.dialogt = true;
    },
    showCreatorTerms() {
      this.titleDialogt = "Content Creator Terms";
      this.componentDialogt = ContentCreator;
      this.dialogt = true;
    },
    showExcluzeevTerms() {
      this.titleDialogt = "Excluzeev Terms";
      this.componentDialogt = LicenseAgreement;
      this.dialogt = true;
    }
  }
};
</script>

<style scoped>
.nav-auth-button {
  color: #42a5f5;
  font-weight: bold;
  font-size: 1.2rem;
}
.v-list__tile__avatar {
  min-width: 30px;
}
.v-avatar {
  width: 24px !important;
  height: 24px !important;
}
.padding-logo {
  padding: 5px;
}
</style>
