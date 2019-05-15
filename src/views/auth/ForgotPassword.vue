<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">
  <div style="height:100%">
    <v-container fluid fill-height>
      <v-layout align-center justify-center>
        <v-flex xs12 sm8 md4>
          <v-card class="elevation-5 forgotpassword-holder text-xs-center">
            <img
              style="width: 30%;"
              alt="Excluzeev
            logo"
              src="../../assets/excluzeev_bottom_text.png"
            >

            <v-card-text>
              <v-form class="lighten-1" @submit.prevent="isHuman">
                <v-text-field
                  name="login"
                  label="Email"
                  type="text"
                  v-model="email"
                  :rules="[rules.required, rules.email]"
                ></v-text-field>

                <vue-programmatic-invisible-google-recaptcha
                  ref="invisibleRecaptcha1"
                  sitekey="6LcwXpkUAAAAAMRYzY4mULgEmyBwpDnKRt1leWtC"
                  elementId="'invisibleRecaptcha1'"
                  badgePosition="'left'"
                  showBadgeMobile="false"
                  showBadgeDesktop="false"
                  @recaptcha-callback="recaptchaCallback"
                ></vue-programmatic-invisible-google-recaptcha>

                <div class="text-xs-center">
                  <v-btn
                    class="white--text"
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

              <div class="padding"></div>
              <div class="text-xs-center quick-sand-font">
                Got the Password? &nbsp;
                <a>
                  <span class color="blue lighten-1" @click="goLogin">Log in</span>
                </a>
              </div>
            </v-card-text>
          </v-card>
          <v-snackbar v-model="snackbar" bottom>{{ toastText }}</v-snackbar>
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
import RegisterStoreModule from "../../mixins/RegisterStoreModule";
import authModule from "../../store/auth/auth";
import axios from "axios";

import Vue from "vue";
// import { VueReCaptcha } from "vue-recaptcha-v3";

// // For more options see below
// Vue.use(VueReCaptcha, {
//   siteKey: "6LcwXpkUAAAAAMRYzY4mULgEmyBwpDnKRt1leWtC",
//   loaderOptions: {
//     useRecaptchaNet: true,
//     autoHideBadge: true
//   }
// });

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
      if (this.rules.email(this.email) != "Invalid e-mail.") {
        this.processing = true;
        this.$store
          .dispatch("auth/resetPassword", { email: this.email })
          .then(data => {
            if (data.error) {
              this.toastText =
                "An password reset email has been sent to your email";
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
    },
    goLogin() {
      this.$router.back();
    },
    recaptchaCallback(token) {
      this.processing = true;
      axios
        .post(
          "https://us-central1-trenstop-2033f.cloudfunctions.net/checkCaptcha",
          {
            token: token
          }
        )
        .then(response => {
          if (!response.data.error) {
            this.doSendEmail();
          } else {
            this.showToast("Verification failed");
            this.processing = false;
          }
        })
        .catch(() => {
          this.processing = false;
        });
    },
    isHuman() {
      if (this.rules.email(this.email) != "Invalid e-mail.") {
        this.$refs.invisibleRecaptcha1.execute();
        this.processing = true;
      } else {
        this.toastText = "Invalid Email";
        this.snackbar = true;
        this.processing = false;
      }
    }
  }
};
</script>

<style scoped>
.padding {
  padding: 10px;
}
.forgotpassword-holder {
  padding: 20px;
}
</style>
