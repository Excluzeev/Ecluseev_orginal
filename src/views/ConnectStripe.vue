<template>
  <v-content>
    <v-container fluid fill-height>
      <v-layout align-center justify-center>
        <v-progress-circular size="100" width="7" color="primary" indeterminate></v-progress-circular>
      </v-layout>
    </v-container>
  </v-content>
</template>

<script>
import { auth } from "../firebase/init";
import axios from "axios";
import { async } from "q";

export default {
  data: () => {
    return {
      isCalled: false
    };
  },
  components: {},
  async created() {
    auth.onAuthStateChanged(user => {
      // console.log(user);
      if (user) {
        let query = this.$route.query;
        this.$router.push({ name: "Home" });
        if (query.error) {
          this.showToast(query.error_description);
        } else {
          let data = {
            code: query.code,
            uid: user.uid
          };

          console.log(data);

          axios
            .post("https://excluzeev.com/connectS", data)       //FIXME, need to check the current production live code
            .then(async response => {
              // console.log(response);
              if (response.data.error) {
                this.showToast("data error",response.data.message);
                this.$router.push({ name: "Home", params: { done: true } });
              } else {
                this.showToast(response.data.message);
                await this.$store.commit("forceFetchUser", {
                  user: auth.currentUser,
                  force: true
                });
                this.$router.push({
                  name: "Communities",
                  params: { done: true }
                });
              }
            })
            .catch(error => {
              this.showToast("Connecting Failed.",error);
              this.$router.push({ name: "Home", params: { done: true } });
              console.log(error);
            });
          this.isCalled = true;
        }
      } else {
        this.$router.push({ name: "Home" });
      }
    });
  },
  async mounted() {},
  methods: {
    showToast(msg) {
      this.$toasted.show(msg, {
        theme: "outline",
        position: "top-right",
        duration: 2000
      });
    }
  }
};
</script>

<style scoped>
</style>
