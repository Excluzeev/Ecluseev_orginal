<template>
  <div style="height:100%;">
    <v-container text-xs-center fill-height>
      <v-layout align-center row wrap justify-center>
        <v-flex xs12 sm8 md5 align-center>
          <v-card class="elevation-5 signin-holder text-xs-center">
            <img
              style="width: 30%;"
              alt="Excluzeev
            logo"
              src="../../assets/excluzeev_bottom_text.png"
            />
            <div class="signin-text quick-sand-font">Sign in</div>
            <div class="signin-continue-text">
              Continue to Excluzeev
            </div>
            <v-card-text>
              <v-form class="lighten-1" @submit.prevent="isHuman">
                <v-text-field
                  name="login"
                  label="Email"
                  type="text"
                  v-model="email"
                  :rules="[rules.required, rules.email]"
                ></v-text-field>
                <v-text-field
                  id="password"
                  name="password"
                  label="Password"
                  type="password"
                  v-model="password"
                  :rules="[rules.required]"
                ></v-text-field>
                <div class="padding"></div>
                <div class="text-xs-left quick-sand-font">
                  <a>
                    <div
                      class="v-btn--round"
                      color="primary lighten-1"
                      @click="goForgotPassword"
                    >
                      Forgot Password?
                    </div>
                  </a>
                </div>
                <div
                  class="text-xs-right quick-sand-font-b"
                  style="padding: 0px;"
                >
                  <v-btn
                    class="white--text quick-sand-font-b"
                    color="primary lighten-1"
                    type="submit"
                    :loading="processing"
                    :disabled="processing"
                    @click="loader = 'loading4'"
                  >
                    Sign in
                    <template v-slot:loader>
                      <span class="custom-loader">
                        <v-icon light>cached</v-icon>
                      </span>
                    </template>
                  </v-btn>
                </div>
              </v-form>
              <div class="padding"></div>
              <v-divider></v-divider>
              <div class="padding"></div>
              <div class="text-xs-center quick-sand-font">
                New to Excluzeev? &nbsp;
                <a>
                  <span
                    class=""
                    color="primary lighten-1"
                    @click="goRegistration"
                  >
                    Sign up!
                  </span>
                </a>
              </div>
            </v-card-text>
          </v-card>
          <div
            class="text-xs-right"
            style="padding-right: 20px;padding-top: 10px;"
          >
            <a @click="showExcluzeevTerms">Terms</a>

            <a @click="showPrivacyPolicy" style="padding-left: 20px;"
              >Privacy</a
            >

            <a
              href="mailto:support@excluzeev.com?subject=Need%20Help"
              style="padding-left: 20px;"
              >Help</a
            >
          </div>
        </v-flex>
      </v-layout>
      <!-- <v-snackbar v-model="snackbar" bottom>
        {{ toastText }}
      </v-snackbar> -->
    </v-container>
    <v-dialog
      v-model="termsDialog"
      fullscreen
      hide-overlay
      transition="dialog-bottom-transition"
    >
      <v-card>
        <v-toolbar dark color="primary">
          <v-btn icon dark @click="termsDialog = false">
            <v-icon>close</v-icon>
          </v-btn>
          <v-toolbar-title>{{ titleDialog }}</v-toolbar-title>
        </v-toolbar>
        <component v-bind:is="componentDialog"></component>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import RegisterStoreModule from "../../mixins/RegisterStoreModule";
import authModule from "../../store/auth/auth";
import LicenseAgreement from "../../components/LicenseAgreement";
import PrivacyPolicy from "../../components/PrivacyPolicy";
import axios from "axios";

import Vue from "vue";
import { VueReCaptcha } from "vue-recaptcha-v3";

// For more options see below
Vue.use(VueReCaptcha, {
  siteKey: "6LcwXpkUAAAAAMRYzY4mULgEmyBwpDnKRt1leWtC",
  loaderOptions: {
    useRecaptchaNet: true,
    autoHideBadge: true
  }
});

export default {
  data: () => {
    return {
      email: "",
      password: "",
      termsDialog: false,
      titleDialog: "Terms and Conditions",
      componentDialog: LicenseAgreement,
      rules: {
        required: value => !!value || "Required.",
        email: value => {
          const pattern = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
          return pattern.test(value) || "Invalid e-mail.";
        }
      },
      processing: false,
      toastText: "Login Success"
    };
  },
  mixins: [RegisterStoreModule],
  props: {},
  created() {
    this.registerStoreModule("auth", authModule);
  },
  beforeDestroy: function() {},
  methods: {
    showToast(msg) {
      this.$toasted.show(msg, {
        theme: "outline",
        position: "top-right",
        duration: 2500
      });
    },
    doLogin() {
      if (
        this.rules.email(this.email) != "Invalid e-mail." &&
        this.rules.required(this.password) != "Required."
      ) {
        this.processing = true;
        this.$store
          .dispatch("auth/loginUser", {
            email: this.email,
            password: this.password
          })
          .then(newData => {
            console.log(newData);
            if (newData.error) {
              this.processing = false;
              console.log(newData.message);
              if (newData.code == "auth/user-not-found") {
                this.showToast("User not found.");
              } else {
                this.showToast("Email / Password is Invalid");
              }
            } else {
              this.processing = false;
              this.showToast("Sign in successfully");
              setTimeout(() => {
                // this.$router.push({ name: "Home" });
              }, 1000);
            }
          });
      } else {
        this.showToast("Invalid Email / Password");
        this.processing = false;
      }
    },
    goRegistration() {
      this.$router.replace({ name: "Registration" });
    },
    goForgotPassword() {
      this.$router.push({ name: "ForgotPassword" });
    },
    showPrivacyPolicy() {
      this.titleDialog = "Privacy Policy";
      this.componentDialog = PrivacyPolicy;
      this.termsDialog = true;
    },
    showExcluzeevTerms() {
      this.titleDialog = "Excluzeev Terms";
      this.componentDialog = LicenseAgreement;
      this.termsDialog = true;
    },
    isHuman() {
      if (
        this.rules.email(this.email) != "Invalid e-mail." &&
        this.rules.required(this.password) != "Required."
      ) {
        this.processing = true;
        this.$recaptcha("login").then(token => {
          axios
            .post(
              "https://us-central1-trenstop-2033f.cloudfunctions.net/checkCaptcha",
              {
                token: token
              }
            )
            .then(response => {
              if (!response.data.error) {
                this.doLogin();
              } else {
                this.showToast("Login Failed");
              }
            });
        });
      } else {
        this.showToast("Invalid Email / Password");
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
.signin-holder {
  padding: 20px;
}
.signin-continue-text {
  font-size: 16px;
  font-weight: 400;
  letter-spacing: 0.1px;
  line-height: 1.5;
}
.signin-text {
  color: #202124;
  padding-bottom: 0;
  font-family: "Google Sans", "Noto Sans Myanmar UI", arial, sans-serif;
  font-size: 24px;
  font-weight: 400;
  line-height: 1.3333;
  margin-bottom: 0;
  margin-top: 0;
}
</style>
