<template>
  <v-toolbar app class="white">
    <router-link to="/">
      <v-toolbar-title class="headline text-uppercase">
        <img alt="Excluzeev logo" src="../assets/excluzeev.png" height="50px" />
      </v-toolbar-title>
    </router-link>
    <v-spacer></v-spacer>
    <router-link :to="{ name: 'MyChannels' }" v-if="hideSignUpContentCreator">
      <v-btn flat>
        <span class="mr-2">My Channels</span>
      </v-btn>
    </router-link>
    <NotificationsMenu v-if="!showLogin" />
    <AccountMenu v-if="!showLogin" />
    <router-link :to="{ name: 'Login' }" v-if="showLogin">
      <v-btn flat>
        <span class="mr-2">Login</span>
      </v-btn>
    </router-link>
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
  }
};
</script>

<style></style>
