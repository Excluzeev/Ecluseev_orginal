<template>
  <nav>
    <v-navigation-drawer app v-model="sideNav">
      <img
        style="margin: 16px;width: 90%;"
        class
        alt="Excluzeev logo"
        src="../assets/excluzeev_trailer.png"
      />
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
      <v-list style="padding-top: 20px;">
        <v-list-tile @click="goLoginContentCreator" v-if="!hideSignUpContentCreator">
          <v-list-tile-title class="quick-sand-font">Become a Content Creator</v-list-tile-title>
        </v-list-tile>
        <v-list-tile @click="goLoginLive" v-if="hideSignUpContentCreator">
          <v-list-tile-avatar>
            <img src="../assets/e.png" width="20" />
          </v-list-tile-avatar>
          <v-list-tile-title class="quick-sand-font">Excluzeev live</v-list-tile-title>
        </v-list-tile>
        <v-list-tile @click="goLoginCreate" v-if="hideSignUpContentCreator">
          <v-list-tile-avatar>
            <v-icon>add</v-icon>
          </v-list-tile-avatar>
          <v-list-tile-title class="quick-sand-font">Create Channel</v-list-tile-title>
        </v-list-tile>

        <v-list-tile @click="goCallToAction">
          <v-list-tile-title class="quick-sand-font mr-2">Call to Action</v-list-tile-title>
        </v-list-tile>

        <v-list-tile @click="goToSubscriptions" v-if="!showLogin">
          <v-list-tile-title class="quick-sand-font mr-2">My Communities</v-list-tile-title>
        </v-list-tile>

        <v-list-tile @click="goToMyChannels" v-if="hideSignUpContentCreator">
          <v-list-tile-title class="quick-sand-font mr-2">My Channels</v-list-tile-title>
        </v-list-tile>
        <!-- <AccountMenu v-if="!showLogin"/> -->
        <router-link style="padding-top: 20px;" :to="{ name: 'Login' }" v-if="showLogin">
          <v-btn flat>
            <span class="nav-auth-button">SIGN IN</span>
          </v-btn>
        </router-link>

        <v-list-tile @click="showHowTo">
          <v-list-tile-title class="quick-sand-font">How to</v-list-tile-title>
        </v-list-tile>
        <v-list-tile @click="showFAQs">
          <v-list-tile-title class="quick-sand-font">FAQs</v-list-tile-title>
        </v-list-tile>
        <v-list-tile @click="showAboutUs">
          <v-list-tile-title class="quick-sand-font">About Us</v-list-tile-title>
        </v-list-tile>
        <v-list-tile @click="showPrivacyPolicy">
          <v-list-tile-title class="quick-sand-font">Privacy Policy</v-list-tile-title>
        </v-list-tile>
        <v-list-tile @click="showCookiePolicy">
          <v-list-tile-title class="quick-sand-font">Cookie Policy</v-list-tile-title>
        </v-list-tile>
        <v-list-tile @click="showCommunityMemberAgreement">
          <v-list-tile-title class="quick-sand-font">Community Member Agreement</v-list-tile-title>
        </v-list-tile>
        <v-list-tile @click="showContentCreatorTerms">
          <v-list-tile-title class="quick-sand-font">Content Creators Terms</v-list-tile-title>
        </v-list-tile>
        <v-list-tile @click="showLicenseAgreement">
          <v-list-tile-title class="quick-sand-font">License Agreement</v-list-tile-title>
        </v-list-tile>
        <v-list-tile @click="logout" v-if="!showLogin">
          <v-list-tile-title class="quick-sand-font">Sign Out</v-list-tile-title>
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
          />
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
                <v-icon style="padding-top: 20px;" v-on="{ ...tooltip, ...menu }">video_call</v-icon>
              </template>
              <span>Add a Video or Create a Live</span>
            </v-tooltip>
          </template>
          <v-list style="padding-top: 20px;">
            <v-list-tile @click="goLoginContentCreator" v-if="!hideSignUpContentCreator">
              <v-list-tile-title class="quick-sand-font">Become a Content Creator</v-list-tile-title>
            </v-list-tile>
            <v-list-tile @click="goLoginLive" v-if="hideSignUpContentCreator">
              <v-list-tile-avatar>
                <img src="../assets/e.png" width="20" />
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

        <router-link
          style="padding-top: 20px;"
          :to="{ name: 'SingleCategory', query: { category: 'Call-to-Action' }}"
        >
          <v-btn flat>
            <span class="mr-2">Call to Action</span>
          </v-btn>
        </router-link>

        <router-link style="padding-top: 20px;" :to="{ name: 'MySubscriptions' }" v-if="!showLogin">
          <v-btn flat>
            <span class="mr-2">My Communities</span>
          </v-btn>
        </router-link>
        <router-link
          style="padding-top: 20px;"
          :to="{ name: 'MyChannels' }"
          v-if="hideSignUpContentCreator"
        >
          <v-btn flat>
            <span class="mr-2">My Channels</span>
          </v-btn>
        </router-link>
        <AccountMenu v-if="!showLogin" />
        <router-link style="padding-top: 20px;" :to="{ name: 'Login' }" v-if="showLogin">
          <v-btn flat>
            <span class="nav-auth-button">SIGN IN</span>
          </v-btn>
        </router-link>

        <v-menu>
          <template #activator="{ on: menu }">
            <v-tooltip bottom>
              <template #activator="{ on: tooltip }">
                <v-icon style="padding-top: 20px;" v-on="{ ...tooltip, ...menu }">more_vert</v-icon>
              </template>
              <span>More</span>
            </v-tooltip>
          </template>
          <v-list>
            <v-list-tile @click="showHowTo">
              <v-list-tile-title class="quick-sand-font">How to</v-list-tile-title>
            </v-list-tile>
            <v-list-tile @click="showFAQs">
              <v-list-tile-title class="quick-sand-font">FAQs</v-list-tile-title>
            </v-list-tile>
            <v-list-tile @click="showAboutUs">
              <v-list-tile-title class="quick-sand-font">About Us</v-list-tile-title>
            </v-list-tile>
            <v-list-tile @click="showPrivacyPolicy">
              <v-list-tile-title class="quick-sand-font">Privacy Policy</v-list-tile-title>
            </v-list-tile>
            <v-list-tile @click="showCookiePolicy">
              <v-list-tile-title class="quick-sand-font">Cookie Policy</v-list-tile-title>
            </v-list-tile>
            <v-list-tile @click="showCommunityMemberAgreement">
              <v-list-tile-title class="quick-sand-font">Community Member Agreement</v-list-tile-title>
            </v-list-tile>
            <v-list-tile @click="showContentCreatorTerms">
              <v-list-tile-title class="quick-sand-font">Content Creators Terms</v-list-tile-title>
            </v-list-tile>

            <v-list-tile @click="showCallToActionTerms">
              <v-list-tile-title class="quick-sand-font">Call to Action Terms</v-list-tile-title>
            </v-list-tile>
            <v-list-tile @click="showLicenseAgreement">
              <v-list-tile-title class="quick-sand-font">License Agreement</v-list-tile-title>
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
</template>

<script>
import AccountMenu from "./AccountMenu.vue";
import store from "../store/index";

import PrivacyPolicy from "../components/PrivacyPolicy";
import CookiePolicy from "../components/CookiePolicy";
import ContentCreator from "../components/ContentCreator";
import CommunityAgreement from "../components/CommunityAgreement";
import LicenseAgreement from "../components/LicenseAgreement";
import AboutUs from "./About";
import FAQs from "./FAQs";
import CommunityAgreementVue from "./CommunityAgreement.vue";
import LicenseAgreementVue from "./LicenseAgreement.vue";
import CallToActionTerms from "./CallToActionTerms";

export default {
  components: {
    AccountMenu
  },
  computed: {
    showLogin() {
      return store.getters.getUser == null;
    },
    hideSignUpContentCreator() {
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
    logout() {
      this.$router.push("/logout");
      this.$toasted.show("Sign out successful", {
        theme: "outline",
        position: "top-right",
        duration: 2000
      });
    },
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
    goCallToAction() {
      this.$router.push({
        name: "SingleCategory",
        query: { category: "Call-to-Action" }
      });
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
      this.$router.push({
        name: "SearchPreviews",
        params: { query: this.query }
      });
    },
    showPrivacyPolicy() {
      this.sideNav = false;
      this.titleDialogt = "Privacy Policy";
      this.componentDialogt = PrivacyPolicy;
      this.dialogt = true;
    },
    showCookiePolicy() {
      this.sideNav = false;
      this.titleDialogt = "Cookie Policy";
      this.componentDialogt = CookiePolicy;
      this.dialogt = true;
    },
    showContentCreatorTerms() {
      this.sideNav = false;
      this.titleDialogt = "Terms Of Service For Creators";
      this.componentDialogt = ContentCreator;
      this.dialogt = true;
    },

    showCallToActionTerms() {
      this.sideNav = false;
      this.titleDialogt = "Excluzeev Call To Action Terms";
      this.componentDialogt = CallToActionTerms;
      this.dialogt = true;
    },
    showCommunityMemberAgreement() {
      this.sideNav = false;
      this.titleDialogt = "Community Member Agreement";
      this.componentDialogt = CommunityAgreement;
      this.dialogt = true;
    },

    showLicenseAgreement() {
      this.sideNav = false;
      this.titleDialogt = "License Agreement";
      this.componentDialogt = LicenseAgreement;
      this.dialogt = true;
    },
    showAboutUs() {
      this.sideNav = false;
      this.titleDialogt = "About Us";
      this.componentDialogt = AboutUs;
      this.dialogt = true;
    },
    showFAQs() {
      this.sideNav = false;
      this.titleDialogt = "FAQs";
      this.componentDialogt = FAQs;
      this.dialogt = true;
    },
    nullDialog() {
      this.titleDialogt = "";
      this.componentDialogt = null;
    },

    showHowTo() {
      this.$router.push({ name: "HowTo" });
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
