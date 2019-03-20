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
                  >Excluzev Registration</v-toolbar-title
                >
              </v-toolbar>
              <v-card-text>
                <v-form class="blue--text lighten-1" @submit.prevent="doSignUp">
                  <v-text-field
                    prepend-icon="person"
                    name="firstname"
                    label="FirstName"
                    type="text"
                    v-model="firstName"
                    :rules="[rules.required]"
                  ></v-text-field>
                  <v-text-field
                    prepend-icon="person"
                    name="lastname"
                    label="LastName"
                    type="text"
                    v-model="lastName"
                    :rules="[rules.required]"
                  ></v-text-field>
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
                    :rules="[rules.required, rules.counter]"
                  ></v-text-field>
                  <v-text-field
                    id="password"
                    prepend-icon="lock"
                    name="password"
                    label="Confrim Password"
                    type="password"
                    v-model="cPassword"
                    :rules="[rules.required]"
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
                      Sign Up
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
                  <p  style="color: gray;">OR</p>
                  <v-btn
                          flat
                          class="white--text v-btn--round"
                          color="blue lighten-1"
                          @click="goLogin"
                  >
                    Login
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
      firstName: "",
      lastName: "",
      email: "",
      password: "",
      cPassword: "",
      rules: {
        required: value => !!value || "Required.",
        counter: value =>
          value.length >= 8 || "Password should be greater than 8 characters",
        email: value => {
          const pattern = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
          return pattern.test(value) || "Invalid e-mail.";
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
  beforeDestroy: function() {
  },
  methods: {
    showToast(msg) {
      this.$toasted.show(msg, {
        theme: "outline",
        position: "top-right",
        duration: 2500
      });
    },
    doSignUp() {
      if (!this.rules.email(this.email)) {
        this.showToast("Invalid Email");
        this.processing = false;
        return;
      }
      if (this.firstName.isEmpty || this.lastName.isEmpty || this.firstName == "" || this.lastName == "") {
        this.showToast("Invalid First/Last Name");
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
    goLogin () {
      this.$router.replace({ name: "Login" });
    }
  }
};
</script>

<style scoped>
  .padding {
    padding: 10px;
  }
  </style>