<template>
  <v-toolbar app class="white">
    <v-toolbar-title class="headline text-uppercase">
      <img alt="Excluzeev logo" src="../assets/excluzeev.png" height="50px" />
    </v-toolbar-title>
    <v-spacer></v-spacer>
    <NotificationsMenu v-if="isNavBar" />
    <AccountMenu v-if="isNavBar" />
    <router-link to="/login" v-if="!isNavBar">
      <v-btn flat>
        <span class="mr-2">Login</span>
      </v-btn>
    </router-link>
  </v-toolbar>
</template>

<script>
import AccountMenu from "./AccountMenu.vue";
import NotificationsMenu from "./NotificationsMenu.vue";

export default {
  components: {
    AccountMenu,
    NotificationsMenu
  },
  computed: {
    isNavBar() {
      return this.$route.meta.showNav == undefined ||
        this.$route.meta.showNav == false
        ? true
        : false;
    }
  }
};
</script>

<style></style>
