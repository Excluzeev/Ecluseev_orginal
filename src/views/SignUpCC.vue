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
              <v-form class="blue--text lighten-1">
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
                    v-model="ex4"
                    label="Agree to privacy policy"
                    color="blue lighten-1"
                    value="info"
                    hide-details
                  ></v-checkbox>
                  <v-checkbox
                    v-model="ex4"
                    label="Agree to Content Creator Terms"
                    color="blue lighten-1"
                    value="info"
                    hide-details
                  ></v-checkbox>
                  <v-checkbox
                    v-model="ex4"
                    label="Agree to Terms"
                    color="blue lighten-1"
                    value="info"
                    hide-details
                  ></v-checkbox>
                </div>
                <div class="text-xs-center">
                  <v-btn class="white--text v-btn--round" color="blue lighten-1"
                    >Proceed</v-btn
                  >
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
export default {
  data: () => {
    return {
      email: "",
      rules: {
        required: value => !!value || "Required.",
        email: value => {
          const pattern = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
          return pattern.test(value) || "Invalid e-mail.";
        }
      }
    };
  }
};
</script>

<style></style>
