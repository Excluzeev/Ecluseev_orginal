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
              <v-form class="blue--text lighten-1" @submit.prevent="doSignUpContentCreator">
                <v-text-field
                  prepend-icon="person"
                  name="PayPal Email"
                  label="PayPal Email"
                  type="text"
                  v-model="email"
                  :rules="[rules.required, rules.email]"
                ></v-text-field>
                <div style="padding-left:40px;padding-bottom:10px;">
                  <v-checkbox v-model="privacyPolicy" color="blue lighten-1" value="info">
                    <template v-slot:label>
                      <div>
                        I agree
                        <v-tooltip>
                          <template v-slot:activator="{ on }">
                            <a @click="showPrivacyPolicy" v-on="on">Privacy Policy</a>
                          </template>
                        </v-tooltip>
                      </div>
                    </template>
                  </v-checkbox>

                  <v-checkbox v-model="termsCreator" color="blue lighten-1" value="info">
                    <template v-slot:label>
                      <div>
                        I agree
                        <v-tooltip>
                          <template v-slot:activator="{ on }">
                            <a @click="showContentCreatorTerms" v-on="on">Content Creator Terms</a>
                          </template>
                        </v-tooltip>
                      </div>
                    </template>
                  </v-checkbox>
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
    <v-layout row justify-center>
      <v-dialog v-model="dialog" fullscreen hide-overlay transition="dialog-bottom-transition">
        <v-card>
          <v-toolbar dark color="primary">
            <v-btn icon dark @click="dialog = false">
              <v-icon>close</v-icon>
            </v-btn>
            <v-toolbar-title>{{titleDialog}}</v-toolbar-title>
          </v-toolbar>
          <component v-bind:is="componentDialog"></component>
        </v-card>
      </v-dialog>
    </v-layout>
  </v-content>
</template>

<script>
// import store from "../store/index";
import PrivacyPolicy from "../components/PrivacyPolicy";
import ContentCreator from "../components/ContentCreator";
import LicenseAgreement from "../components/LicenseAgreement";
import CommunityAgreement from "../components/CommunityAgreement";

export default {
  data: () => {
    return {
      email: "",
      privacyPolicy: false,
      termsCreator: false,
      dialog: false,
      titleDialog: "",
      componentDialog: null,
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
  components: {
    PrivacyPolicy
  },
  methods: {
    doSignUpContentCreator() {
      if (this.rules.email(this.email) == "Invalid e-mail.") {
        this.showToast("Invalid Email");
      }
      if (!this.privacyPolicy) {
        this.showToast("Please Check Privacy Policy");
        return;
      }
      if (!this.termsCreator) {
        this.showToast("Please Check Content Creator Terms");
        return;
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
            this.$router.push({ name: "MyChannels" });
          }
        });
    },
    showPrivacyPolicy() {
      this.titleDialog = "Privacy Policy";
      this.componentDialog = PrivacyPolicy;
      this.dialog = true;
    },

    showContentCreatorTerms() {
      this.titleDialog = "Terms Of Service For Creators";
      this.componentDialog = ContentCreator;
      this.dialog = true;
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
