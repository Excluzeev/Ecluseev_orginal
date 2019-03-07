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
                  >Excluzev Login</v-toolbar-title
                >
              </v-toolbar>
              <v-card-text>
                <v-form class="blue--text lighten-1" @submit.prevent="doLogin">
                  <v-text-field
                    prepend-icon="person"
                    name="login"
                    label="Email"
                    type="text"
                    v-model="email"
                    :rules="[rules.required, rules.email]"
                  ></v-text-field>
                  <v-text-field
                    id="password"
                    prepend-icon="lock"
                    name="password"
                    label="Password"
                    type="password"
                    v-model="password"
                    :rules="[rules.required]"
                  ></v-text-field>
                  <div class="text-xs-right">
                    <v-btn
                      flat
                      class="white--text v-btn--round"
                      color="blue lighten-1"
                      @click="goForgotPassword"
                    >
                      Forgot Password?
                    </v-btn>
                  </div>
                  <div class="text-xs-center">
                    <v-btn
                      class="white--text v-btn--round"
                      color="blue lighten-1"
                      type="submit"
                      :loading="processing"
                      :disabled="processing"
                      @click="loader = 'loading4'"
                    >
                      Login
                      <template v-slot:loader>
                        <span class="custom-loader">
                          <v-icon light>cached</v-icon>
                        </span>
                      </template>
                    </v-btn>
                  </div>
                </v-form>
                <div class="padding"></div>
                <div class="text-xs-center">
                  <p style="color: gray;">OR</p>
                  <v-btn
                    flat
                    class="white--text v-btn--round"
                    color="blue lighten-1"
                    @click="goRegistration"
                  >
                    Create an account
                  </v-btn>
                </div>
              </v-card-text>
            </v-card>
          </v-flex>
        </v-layout>
        <!-- <v-snackbar v-model="snackbar" bottom>
          {{ toastText }}
        </v-snackbar> -->
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
      password: "",
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
        theme: "toasted-primary",
        position: "top-right",
        duration: 2500
      });
    },
    doLogin() {
      if (this.rules.email(this.email)) {
        this.processing = true;
        this.$store
          .dispatch("auth/loginUser", {
            email: this.email,
            password: this.password
          })
          .then(data => {
            if (data.error) {
              this.processing = false;
              this.showToast(data.message);
            } else {
              // TODO: Fix it
              this.processing = false;
              // this.showToast("Logged in successfully");
              setTimeout(() => {
                this.$router.push({ name: "Home" });
              }, 1000);
            }
          });
      } else {
        this.showToast("Invalid Email");
        this.processing = true;
      }
    },
    goRegistration() {
      this.$router.replace({ name: "Registration" });
    },
    goForgotPassword() {
      this.$router.push({ name: "ForgotPassword" });
    }
  }
};
</script>

<style scoped>
.padding {
  padding: 10px;
}
</style>
