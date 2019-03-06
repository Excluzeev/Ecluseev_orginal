<template>
  <div style="height:100%" class="blue lighten-1">
    <v-content>
      <v-container fluid fill-height>
        <v-layout style="padding-top:8%" align-center justify-center>
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
                      class="white--text"
                      color="blue lighten-1"
                      type="submit"
                      >Sign up</v-btn
                    >
                  </div>
                </v-form>
              </v-card-text>
            </v-card>
          </v-flex>
        </v-layout>
        <v-snackbar v-model="snackbar" bottom>
          {{ toastText }}
        </v-snackbar>
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
      snackbar: false,
      toastText: "Registration Success"
    };
  },
  mixins: [RegisterStoreModule],
  props: {},
  created() {
    this.registerStoreModule("auth", authModule);
  },
  methods: {
    doSignUp() {
      if (!this.rules.email(this.email)) {
        this.toastText = "Invalid Email";
        this.snackbar = true;
        return;
      }
      if (this.firstName.isEmpty || this.lastName.isEmpty) {
        this.toastText = "Invalid First/Last Name";
        this.snackbar = true;
        return;
      }
      if (this.password.isEmpty || this.password.length < 8) {
        this.toastText = "Password must be greater than 8 digits";
        this.snackbar = true;
        return;
      }
      if (this.password != this.cPassword) {
        this.toastText = "Passwords doesn't match.";
        this.snackbar = true;
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
            this.toastText = data.message;
            this.snackbar = true;
          } else {
            this.$store.dispatch("auth/checkUser").then(userRecord => {
              if (userRecord.exists) {
                this.$router.push("/");
              } else {
                this.toastText = "UnKnow error please try again.";
                this.snackbar = true;
              }
            });
          }
        });
    }
  }
};
</script>
