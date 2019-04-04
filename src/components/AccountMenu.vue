<template>
  <v-menu offset-y content-class="dropdown-menu" transition="slide-y-transition">
    <v-icon x-large slot="activator" color="blue lighten-1">account_circle</v-icon>
    <v-card>
      <v-list>
        <v-list-tile v-if="!hideSignUpContentCreator">
          <router-link :to="{ name: 'SignUpCC' }">
            <v-list-tile-title>Become a Content Creator</v-list-tile-title>
          </router-link>
        </v-list-tile>
        <!--<v-list-tile v-if="hideSignUpContentCreator">-->
        <!--<router-link :to="{ name: 'CreateChannel' }">-->
        <!--<v-list-tile-title>Create Channel</v-list-tile-title>-->
        <!--</router-link>-->
        <!--</v-list-tile>-->
        <v-list-tile>
          <a @click="logout">
            <v-list-tile-title class="quick-sand-font-b">Sign out</v-list-tile-title>
          </a>
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
  },
  methods: {
    logout() {
      this.$router.push("/logout");
      this.$toasted.show("Sign out successful", {
        theme: "outline",
        position: "top-right",
        duration: 2000
      });
    }
  }
};
</script>

<style></style>
