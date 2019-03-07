<template>
  <v-menu
    offset-y
    content-class="dropdown-menu"
    transition="slide-y-transition"
  >
    <v-icon x-large slot="activator" color="blue lighten-1"
      >account_circle</v-icon
    >
    <v-card>
      <v-list>
        <v-list-tile v-if="!hideSignUpContentCreator">
          <router-link to="/SignUpCC">
            <v-list-tile-title>Sign up as Content Creator</v-list-tile-title>
          </router-link>
        </v-list-tile>
        <v-list-tile>
          <router-link to="/logout">
            <v-list-tile-title>Logout</v-list-tile-title>
          </router-link>
        </v-list-tile>
      </v-list>
    </v-card>
  </v-menu>
</template>

<script>
import store from "../store/index";

export default {
  data() {
    return {};
  },
  computed: {
    hideSignUpContentCreator() {
      return store.getters.getFUser != null
        ? store.getters.getFUser.isContentCreator
        : false;
    }
  }
};
</script>

<style></style>
