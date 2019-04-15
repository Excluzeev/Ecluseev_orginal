<template>
  <nav>
    <v-navigation-drawer app v-model="sideNav">
      <div style="width: 100%; padding: 10px;">
        <form @submit.prevent="searchPreviews">
          <v-text-field
            append-icon="search"
            v-model="query"
            label="Search"
            single-line
            @click:append="searchPreviews"
          ></v-text-field>
        </form>
      </div>
      <v-list style="padding-top: 12px;">
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
        <v-list-tile @click="goToSubscriptions" v-if="!showLogin">
          <v-list-tile-title class="quick-sand-font mr-2">My Communities</v-list-tile-title>
        </v-list-tile>

        <v-list-tile @click="goToMyChannels" v-if="hideSignUpContentCreator">
          <v-list-tile-title class="quick-sand-font mr-2">My Channels</v-list-tile-title>
        </v-list-tile>
        <AccountMenu v-if="!showLogin"/>
        <router-link style="padding-top: 12px;" :to="{ name: 'Login' }" v-if="showLogin">
          <v-btn flat>
            <span class="nav-auth-button">SIGN IN</span>
          </v-btn>
        </router-link>

        <v-list-tile @click="showAboutUs">
          <v-list-tile-title class="quick-sand-font">About Us</v-list-tile-title>
        </v-list-tile>
        <v-list-tile @click="showFAQs">
          <v-list-tile-title class="quick-sand-font">FAQs</v-list-tile-title>
        </v-list-tile>
        <v-list-tile @click="showPrivacyPolicy">
          <v-list-tile-title class="quick-sand-font">Privacy Policy</v-list-tile-title>
        </v-list-tile>
        <!-- <v-list-tile @click="showHowTo">
              <v-list-tile-title class="quick-sand-font">How to</v-list-tile-title>
        </v-list-tile>-->
        <v-list-tile @click="showCreatorTerms">
          <v-list-tile-title class="quick-sand-font">Community Agreement</v-list-tile-title>
        </v-list-tile>
        <v-list-tile @click="showExcluzeevTerms">
          <v-list-tile-title class="quick-sand-font">Licensing Agreement</v-list-tile-title>
        </v-list-tile>
      </v-list>
    </v-navigation-drawer>
    <v-toolbar app class="white quick-sand-font">
      <v-toolbar-side-icon class="hidden-md-and-up" @click.native.stop="sideNav = !sideNav"></v-toolbar-side-icon>

      <v-toolbar-title class="headline text-uppercase">
        <router-link to="/">
          <img
            class="padding-logo"
            alt="Excluzeev logo"
            src="../assets/excluzeev_trailer.png"
            height="50px"
          >
        </router-link>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <v-toolbar-items class="hidden-sm-and-down">
        <div style="width: 200px; margin-right: 10px;">
          <form @submit.prevent="searchPreviews">
            <v-text-field
              append-icon="search"
              v-model="query"
              label="Search"
              single-line
              @click:append="searchPreviews"
            ></v-text-field>
          </form>
        </div>

        <v-menu>
          <template #activator="{ on: menu }">
            <v-tooltip bottom>
              <template #activator="{ on: tooltip }">
                <v-icon style="padding-top: 12px;" v-on="{ ...tooltip, ...menu }">video_call</v-icon>
              </template>
              <span>Add a Video or Create a Live</span>
            </v-tooltip>
          </template>
          <v-list style="padding-top: 12px;">
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

        <router-link style="padding-top: 12px;" :to="{ name: 'MySubscriptions' }" v-if="!showLogin">
          <v-btn flat>
            <span class="mr-2">My Communities</span>
          </v-btn>
        </router-link>
        <router-link
          style="padding-top: 12px;"
          :to="{ name: 'MyChannels' }"
          v-if="hideSignUpContentCreator"
        >
          <v-btn flat>
            <span class="mr-2">My Channels</span>
          </v-btn>
        </router-link>
        <AccountMenu v-if="!showLogin"/>
        <router-link style="padding-top: 12px;" :to="{ name: 'Login' }" v-if="showLogin">
          <v-btn flat>
            <span class="nav-auth-button">SIGN IN</span>
          </v-btn>
        </router-link>

        <v-menu>
          <template #activator="{ on: menu }">
            <v-tooltip bottom>
              <template #activator="{ on: tooltip }">
                <v-icon style="padding-top: 12px;" v-on="{ ...tooltip, ...menu }">more_vert</v-icon>
              </template>
              <span>More</span>
            </v-tooltip>
          </template>
          <v-list>
            <v-list-tile @click="showAboutUs">
              <v-list-tile-title class="quick-sand-font">About Us</v-list-tile-title>
            </v-list-tile>
            <v-list-tile @click="showFAQs">
              <v-list-tile-title class="quick-sand-font">FAQs</v-list-tile-title>
            </v-list-tile>
            <v-list-tile @click="showPrivacyPolicy">
              <v-list-tile-title class="quick-sand-font">Privacy Policy</v-list-tile-title>
            </v-list-tile>
            <!-- <v-list-tile @click="showHowTo">
              <v-list-tile-title class="quick-sand-font">How to</v-list-tile-title>
            </v-list-tile>-->
            <v-list-tile @click="showCreatorTerms">
              <v-list-tile-title class="quick-sand-font">Community Agreement</v-list-tile-title>
            </v-list-tile>
            <v-list-tile @click="showExcluzeevTerms">
              <v-list-tile-title class="quick-sand-font">Licensing Agreement</v-list-tile-title>
            </v-list-tile>
          </v-list>
        </v-menu>
      </v-toolbar-items>
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
  </nav>
  <!-- <v-layout>
    <v-navigation-drawer v-model="sideNav">
      <div style="width: 200px; margin-right: 10px;">
        <form @submit.prevent="searchPreviews">
          <v-text-field append-icon="search" v-model="query" label="Search" single-line></v-text-field>
        </form>
      </div>
    </v-navigation-drawer>
    <v-toolbar class="white quick-sand-font">
      <v-toolbar-side-icon></v-toolbar-side-icon>
      <v-toolbar-side-icon @click.native.stop="sideNav = !sideNav" class></v-toolbar-side-icon>
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
      <AccountMenu v-if="!showLogin"/>
      <router-link :to="{ name: 'Login' }" v-if="showLogin">
        <v-btn flat>
          <span class="nav-auth-button">SIGN IN</span>
        </v-btn>
      </router-link>

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
  </v-layout>-->
</template>

<script>
import AccountMenu from "./AccountMenu.vue";
import store from "../store/index";

import PrivacyPolicy from "../components/PrivacyPolicy";
import CookiePolicy from "../components/CookiePolicy";
import ContentCreator from "../components/ContentCreator";
import LicenseAgreement from "../components/LicenseAgreement";
import AboutUs from "./About";
import FAQs from "./FAQs";

export default {
  components: {
    AccountMenu
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
      componentDialogt: null,
      sideNav: false
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
    goToSubscriptions() {
      this.$router.push({ name: "MySubscriptions" });
    },
    goToMyChannels() {
      this.$router.push({ name: "MyChannels" });
    },
    searchPreviews() {
      this.sideNav = false;
      console.log({ query: this.query });
      this.$router.push({
        name: "SearchPreviews",
        params: { query: this.query }
      });
      console.log("pushed");
    },
    showPrivacyPolicy() {
      this.sideNav = false;
      this.titleDialogt = "Privacy Policy";
      this.componentDialogt = PrivacyPolicy;
      this.dialogt = true;
      this.nullDialog();
    },
    showCookiePolicy() {
      this.sideNav = false;
      this.titleDialogt = "Cookie Policy";
      this.componentDialogt = CookiePolicy;
      this.dialogt = true;
      this.nullDialog();
    },
    showCreatorTerms() {
      this.sideNav = false;
      this.titleDialogt = "Content Creator Terms";
      this.componentDialogt = ContentCreator;
      this.dialogt = true;
      this.nullDialog();
    },
    showExcluzeevTerms() {
      this.sideNav = false;
      this.titleDialogt = "Excluzeev Terms";
      this.componentDialogt = LicenseAgreement;
      this.dialogt = true;
      this.nullDialog();
    },
    showAboutUs() {
      this.sideNav = false;
      this.titleDialogt = "About Us";
      this.componentDialogt = AboutUs;
      this.dialogt = true;
      this.nullDialog();
    },
    showFAQs() {
      this.sideNav = false;
      this.titleDialogt = "FAQs";
      this.componentDialogt = FAQs;
      this.dialogt = true;
      this.nullDialog();
    },
    nullDialog() {
      this.titleDialogt = "";
      this.componentDialogt = null;
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
