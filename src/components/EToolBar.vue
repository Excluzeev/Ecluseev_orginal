<template>
  <v-toolbar app class="white">
    <v-toolbar-title class="headline text-uppercase">
      <img alt="Excluzeev logo" src="../assets/excluzeev.png" height="50px" />
    </v-toolbar-title>
    <v-spacer></v-spacer>
    <NotificationsMenu />
    <AccountMenu />
    <!-- <v-btn
        flat
        href="https://github.com/vuetifyjs/vuetify/releases/latest"
        target="_blank"
      >
        <span class="mr-2">Latest Release</span>
      </v-btn> -->
  </v-toolbar>
</template>

<script>
import AccountMenu from "./AccountMenu.vue";
import NotificationsMenu from "./NotificationsMenu.vue";

export default {
  components: {
    AccountMenu,
    NotificationsMenu
  }
};
</script>

<style></style>
