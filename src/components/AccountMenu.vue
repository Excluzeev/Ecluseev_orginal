<template>
  <v-menu offset-y content-class="dropdown-menu" transition="slide-y-transition">
    <p style="padding: 10px; margin-top: 10px;" slot="activator">{{ userName }}</p>
    <!-- <v-icon x-large slot="activator" color="blue lighten-1">account_circle</v-icon> -->
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
import { auth } from "../firebase/init";
import { async } from "q";

export default {
  data() {
    return {
      userName: "User"
    };
  },
  mounted() {
    this.getUserName();
  },
  computed: {
    hideSignUpContentCreator() {
      return store.getters.getFUser != null
        ? store.getters.getFUser.isContentCreator
        : false;
    }
  },
  methods: {
    async getUserName() {
      await auth.onAuthStateChanged(user => {
        this.userName = user.displayName;
      });
      // console.log(user);
      // return store.getters.getFUser != null
      //   ? store.getters.getFUser.firstName +
      //       " " +
      //       store.getters.getFUser.lastName
      //   : "";
    },
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
