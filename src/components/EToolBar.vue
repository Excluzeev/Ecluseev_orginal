<template>
  <v-toolbar app class="white">
    <v-toolbar-title class="headline text-uppercase">
      <img alt="Excluzeev logo" src="../assets/excluzeev.png" height="50px" />
    </v-toolbar-title>
    <v-spacer></v-spacer>
    <NotificationsMenu v-if="!showLogin" />
    <AccountMenu v-if="!showLogin" />
    <router-link to="/login" v-if="showLogin">
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
    }
  },
  data: () => {
    return {};
  }
};
</script>

<style></style>
