<template>
  <v-content>
    <v-container fluid fill-height>
      <v-layout align-center justify-center>
        <v-flex xs12 sm8 md4>
          <v-card class="elevation-9">
            <v-toolbar dark color="blue lighten-1">
              <v-toolbar-title>Sign up as Content Creator</v-toolbar-title>
            </v-toolbar>
            <v-card-text>
              <v-form
                class="blue--text lighten-1"
                @submit.prevent="doSignUpContentCreator"
              >
                <v-text-field
                  prepend-icon="person"
                  name="PayPal Email"
                  label="PayPal Email"
                  type="text"
                  v-model="email"
                  :rules="[rules.required, rules.email]"
                ></v-text-field>
                <div style="padding-left:40px;padding-bottom:10px;">
                  <v-checkbox
                    v-model="privacyPolicy"
                    label="Agree to privacy policy"
                    color="blue lighten-1"
                    value="info"
                    hide-details
                  ></v-checkbox>
                  <v-checkbox
                    v-model="termsCreator"
                    label="Agree to Content Creator Terms"
                    color="blue lighten-1"
                    value="info"
                    hide-details
                  ></v-checkbox>
                  <v-checkbox
                    v-model="terms"
                    label="Agree to Terms"
                    color="blue lighten-1"
                    value="info"
                    hide-details
                  ></v-checkbox>
                </div>
                <div class="text-xs-center">
                  <v-btn
                    class="white--text"
                    color="blue lighten-1"
                    type="submit"
                    :loading="processing"
                    :disabled="processing"
                    @click="loader = 'loading4'"
                  >
                    Proceed
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
        </v-flex>
      </v-layout>
    </v-container>
  </v-content>
</template>

<script>
// import store from "../store/index";

export default {
  data: () => {
    return {
      email: "",
      privacyPolicy: false,
      termsCreator: false,
      terms: false,
      rules: {
        required: value => !!value || "Required.",
        email: value => {
          const pattern = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
          return pattern.test(value) || "Invalid e-mail.";
        }
      },
      processing: false
    };
  },
  methods: {
    doSignUpContentCreator() {
      if (!this.privacyPolicy) {
        this.showToast("Please Check Privacy Policy");
        return;
      }
      if (!this.termsCreator) {
        this.showToast("Please Check Content Creator Terms");
        return;
      }
      if (!this.terms) {
        this.showToast("Please Check Terms");
        return;
      }
      if (!this.rules.email(this.email)) {
        this.showToast("Invalid Email");
      }
      this.processing = true;
      this.$store
        .dispatch("signUpContentCreator", { email: this.email })
        .then(data => {
          if (data.error) {
            this.processing = false;
            this.showToast("Invalid Login. Please Login again");
            this.$router.push({ name: "Login" });
          } else {
            this.processing = false;
            this.showToast("Success");
            this.$router.push("/");
          }
        });
    },
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
.custom-loader {
  animation: loader 1s infinite;
  display: flex;
}
@-moz-keyframes loader {
  from {
    transform: rotate(0);
  }
  to {
    transform: rotate(360deg);
  }
}
@-webkit-keyframes loader {
  from {
    transform: rotate(0);
  }
  to {
    transform: rotate(360deg);
  }
}
@-o-keyframes loader {
  from {
    transform: rotate(0);
  }
  to {
    transform: rotate(360deg);
  }
}
@keyframes loader {
  from {
    transform: rotate(0);
  }
  to {
    transform: rotate(360deg);
  }
}
</style>
