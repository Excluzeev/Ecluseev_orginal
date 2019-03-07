<template>
  <div style="height:100%" class="blue lighten-1">
    <v-content>
      <v-container fluid fill-height>
        <v-layout align-center justify-center>
          <v-flex xs12 sm8 md4>
            <img
              style="padding-bottom:3%;padding-left:13%"
              alt="Excluzeev
            logo"
              src="../../assets/excluzeev_white.png"
            />
            <v-card class="elevation-12">
              <v-toolbar dark color="white">
                <v-toolbar-title class="blue--text lighten-1"
                  >Reset Password</v-toolbar-title
                >
              </v-toolbar>
              <v-card-text>
                <v-form
                  class="blue--text lighten-1"
                  @submit.prevent="doSendEmail"
                >
                  <v-text-field
                    prepend-icon="person"
                    name="login"
                    label="Email"
                    type="text"
                    v-model="email"
                    :rules="[rules.required, rules.email]"
                  ></v-text-field>
                  <div class="text-xs-center">
                    <v-btn
                      class="white--text v-btn--round"
                      color="blue lighten-1"
                      type="submit"
                      :loading="processing"
                      :disabled="processing"
                      @click="loader = 'loading4'"
                    >
                      Reset Password
                      <template v-slot:loader>
                        <span class="custom-loader">
                          <v-icon light>cached</v-icon>
                        </span>
                      </template>
                    </v-btn>
                  </div>
                </v-form>
              </v-card-text>
            </v-card>
            <v-snackbar v-model="snackbar" bottom>
              {{ toastText }}
            </v-snackbar>
          </v-flex>
        </v-layout>
      </v-container>
    </v-content>
  </div>
</template>

<script>
import RegisterStoreModule from "../../mixins/RegisterStoreModule";
import authModule from "../../store/auth/auth";

export default {
  data: () => {
    return {
      email: "",
      processing: false,
      rules: {
        required: value => !!value || "Required.",
        email: value => {
          const pattern = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
          return pattern.test(value) || "Invalid e-mail.";
        }
      },
      snackbar: false,

      toastText: "Login Success"
    };
  },
  mixins: [RegisterStoreModule],
  props: {},
  created() {
    this.registerStoreModule("auth", authModule);
  },
  methods: {
    doSendEmail() {
      if (this.rules.email(this.email)) {
        this.processing = true;
        this.$store
          .dispatch("auth/resetPassword", { email: this.email })
          .then(data => {
            if (data.error) {
              this.toastText = data.message;
              this.snackbar = true;
              this.processing = false;
            } else {
              this.toastText = data.message;
              this.snackbar = true;
              this.processing = true;
              this.$router.push("/login");
            }
          });
      } else {
        this.toastText = "Invalid Email";
        this.snackbar = true;
        this.processing = false;
      }
    }
  }
};
</script>
