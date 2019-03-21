<template>
  <v-toolbar app class="white quick-sand-font">
    <router-link to="/">
      <v-toolbar-title class="headline text-uppercase">
        <img
          class="padding-logo"
          alt="Excluzeev logo"
          src="../assets/excluzeev_trailer.png"
          height="50px"
        />
      </v-toolbar-title>
    </router-link>
    <v-spacer></v-spacer>

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
        <v-list-tile
          @click="goLoginContentCreator"
          v-if="!hideSignUpContentCreator"
        >
          <v-list-tile-title class="quick-sand-font"
            >Become content creator</v-list-tile-title
          >
        </v-list-tile>
        <v-list-tile @click="goLoginLive" v-if="hideSignUpContentCreator">
          <v-list-tile-avatar>
            <img src="../assets/e.png" width="20" />
          </v-list-tile-avatar>
          <v-list-tile-title class="quick-sand-font"
            >Excluzeev live</v-list-tile-title
          >
        </v-list-tile>
        <v-list-tile @click="goLoginCreate" v-if="hideSignUpContentCreator">
          <v-list-tile-avatar>
            <v-icon>add</v-icon>
          </v-list-tile-avatar>
          <v-list-tile-title class="quick-sand-font"
            >Create Channel</v-list-tile-title
          >
        </v-list-tile>
      </v-list>
    </v-menu>

    <router-link :to="{ name: 'MySubscriptions' }" v-if="!showLogin">
      <v-btn flat>
        <span class="mr-2">My Subscriptions</span>
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
    <AccountMenu v-if="!showLogin" />
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
  </v-toolbar>
</template>

<script>
import AccountMenu from "./AccountMenu.vue";
import NotificationsMenu from "./NotificationsMenu.vue";
import store from "../store/index";

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
    return {};
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
