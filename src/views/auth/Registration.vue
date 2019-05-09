<template>
  <div style="height:100%" class>
    <v-container text-xs-center fill-height>
      <v-layout align-center row wrap justify-center>
        <v-flex xs12 sm8 md6>
          <v-card class="elevation-5 signup-holder text-xs-center">
            <img
              style="width: 30%;"
              alt="Excluzeev
            logo"
              src="../../assets/excluzeev_bottom_text.png"
            >
            <div class="signup-text quick-sand-font">Sign up</div>
            <div class="signup-continue-text">Continue to Excluzeev</div>
            <v-card-text>
              <v-form class="lighten-1" @submit.prevent="isHuman">
                <v-layout row>
                  <v-text-field
                    style="margin-right: 5px;"
                    name="firstname"
                    label="FirstName"
                    type="text"
                    v-model="firstName"
                    :rules="[rules.required, rules.name]"
                  ></v-text-field>
                  <v-text-field
                    style="margin-left: 5px;"
                    name="lastname"
                    label="LastName"
                    type="text"
                    v-model="lastName"
                    :rules="[rules.required, rules.name]"
                  ></v-text-field>
                </v-layout>
                <v-text-field
                  name="login"
                  label="Email"
                  type="text"
                  v-model="email"
                  :rules="[rules.required, rules.email]"
                ></v-text-field>
                <v-layout row>
                  <v-text-field
                    style="margin-right: 5px;"
                    id="password"
                    name="password"
                    label="Password"
                    type="password"
                    v-model="password"
                    :rules="[rules.required, rules.password]"
                  ></v-text-field>
                  <v-text-field
                    style="margin-left: 5px;"
                    id="cpassword"
                    name="cpassword"
                    label="Confirm Password"
                    type="password"
                    v-model="cPassword"
                    :rules="[rules.required, rules.password]"
                  ></v-text-field>
                </v-layout>

                <div class="text-xs-left grey--text" style="font-size: 12px"></div>

                <vue-programmatic-invisible-google-recaptcha
                  ref="invisibleRecaptcha2"
                  sitekey="6LcAGZoUAAAAAM5ZzNmJBStSpLk1nL3Y1pbQN6Co"
                  elementId="invisibleRecaptcha2"
                  badgePosition="'left'"
                  showBadgeMobile="false"
                  showBadgeDesktop="false"
                  @recaptcha-callback="recaptchaCallback"
                ></vue-programmatic-invisible-google-recaptcha>

                <div class="text-xs-right quick-sand-font-b" style="padding: 0px;">
                  <v-btn
                    class="white--text quick-sand-font-b"
                    color="blue lighten-1"
                    type="submit"
                    :loading="processing"
                    :disabled="processing"
                    @click="loader = 'loading4'"
                  >
                    Sign up
                    <template v-slot:loader>
                      <span class="custom-loader">
                        <v-icon light>cached</v-icon>
                      </span>
                    </template>
                  </v-btn>
                </div>
              </v-form>
              <div class="padding"></div>
              <div class="text-xs-left quick-sand-font">
                Have an account? &nbsp;
                <a>
                  <span class color="blue lighten-1" @click="goLogin">Sign in</span>
                </a>
              </div>
            </v-card-text>
          </v-card>
          <div class="text-xs-right" style="padding-right: 20px;padding-top: 10px;">
            <a @click="showExcluzeevTerms">Terms</a>

            <a @click="showPrivacyPolicy" style="padding-left: 20px;">Privacy</a>

            <a
              href="mailto:support@excluzeev.com?subject=Need%20Help"
              style="padding-left: 20px;"
            >Help</a>
          </div>
        </v-flex>
      </v-layout>
      <!-- <v-snackbar v-model="snackbar" bottom>
        {{ toastText }}
      </v-snackbar>-->
    </v-container>
    <v-dialog v-model="termsDialog" fullscreen hide-overlay transition="dialog-bottom-transition">
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

export default {
  data: () => {
    return {
      firstName: "",
      lastName: "",
      email: "",
      password: "",
      cPassword: "",
      termsDialog: false,
      titleDialog: "",
      componentDialog: null,
      rules: {
        name: value => {
          const pattern = /^[a-zA-Z ]*$/;
          return pattern.test(value) || "Name cannot contain number";
        },
        required: value => !!value || "Required.",
        counter: value =>
          value.length >= 8 || "Password should be greater than 8 characters",
        email: value => {
          const pattern = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
          return pattern.test(value) || "Invalid e-mail.";
        },
        password: value => {
          const pattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
          return (
            pattern.test(value) ||
            "Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character"
          );
        }
      },
      processing: false,
      toastText: "Registration Success"
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
    doSignUp() {
      if (this.rules.email(this.email) == "Invalid e-mail.") {
        this.showToast("Invalid Email");
        this.processing = false;
        return;
      }
      if (this.firstName.isEmpty || this.firstName == "") {
        this.showToast("Invalid First Name");
        this.processing = false;
        return;
      }
      if (this.lastName.isEmpty || this.lastName == "") {
        this.showToast("Invalid Last Name");
        this.processing = false;
        return;
      }
      if (this.password.isEmpty || this.password.length < 8) {
        this.showToast("Password must be greater than 8 digits");
        this.processing = false;
        return;
      }
      if (this.password != this.cPassword) {
        this.showToast("Passwords doesn't match.");
        this.processing = false;
        return;
      }

      this.$store
        .dispatch("auth/signUpUser", {
          email: this.email,
          password: this.password,
          firstName: this.firstName,
          lastName: this.lastName
        })
        .then(data => {
          if (data.error) {
            this.showToast(data.message);
            this.processing = false;
          } else {
            this.$store.dispatch("auth/checkUser").then(userRecord => {
              if (userRecord.exists) {
                this.showToast("Registration successful");
                this.$router.push("/");
              } else {
                this.showToast("Unknown error please try again.");
                this.processing = false;
              }
            });
          }
        });
    },
    goLogin() {
      this.$router.replace({ name: "Login" });
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
            this.doSignUp();
          } else {
            this.showToast("Sign up Failed");

            this.processing = false;
          }
        })
        .catch(() => {
          this.processing = false;
        });
    },
    isHuman() {
      if (this.rules.email(this.email) == "Invalid e-mail.") {
        this.showToast("Invalid Email");
        this.processing = false;
        return;
      }
      if (this.firstName.isEmpty || this.firstName == "") {
        this.showToast("Invalid First Name");
        this.processing = false;
        return;
      }
      if (this.lastName.isEmpty || this.lastName == "") {
        this.showToast("Invalid Last Name");
        this.processing = false;
        return;
      }
      if (this.password.isEmpty || this.password.length < 8) {
        this.showToast("Password must be greater than 8 digits");
        this.processing = false;
        return;
      }
      if (this.password != this.cPassword) {
        this.showToast("Passwords doesn't match.");
        this.processing = false;
        return;
      }

      this.$refs.invisibleRecaptcha2.execute();
    }
  }
};
</script>

<style scoped>
.padding {
  padding: 10px;
}
.signup-holder {
  padding: 20px;
}
.signup-continue-text {
  font-size: 16px;
  font-weight: 400;
  letter-spacing: 0.1px;
  line-height: 1.5;
}
.signup-text {
  color: #202124;
  padding-bottom: 0;
  font-family: "Google Sans", "Noto Sans Myanmar UI", arial, sans-serif;
  font-size: 24px;
  font-weight: 400;
  line-height: 1.3333;
  margin-bottom: 0;
  margin-top: 0;
}

.quick-sand-font-b {
  font-family: "Quicksand", sans-serif;
  font-weight: 700;
}
.quick-sand-font {
  font-family: "Quicksand", sans-serif;
  font-weight: 500;
}
</style>
