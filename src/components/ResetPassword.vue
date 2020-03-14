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
            >
            <v-card class="elevation-12">
              <v-toolbar dark color="white">
                <v-toolbar-title class="blue--text lighten-1">Reset Password</v-toolbar-title>
              </v-toolbar>
              <v-card-text>
                <v-form class="blue--text lighten-1">
                  <v-text-field
                    id="password"
                    prepend-icon="lock"
                    name="password"
                    label="Enter New Password"
                    type="password"
                  ></v-text-field>
                  <v-text-field
                    id="password"
                    prepend-icon="lock"
                    name="password"
                    label="Confrim New Password"
                    type="password"
                  ></v-text-field>
                  <div class="text-xs-center">
                    <v-btn
                      class="white--text v-btn--round"
                      color="blue lighten-1"
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
          </v-flex>
        </v-layout>
      </v-container>
    </v-content>
  </div>
</template>

<script>
export default {
  data: () => ({
    drawer: null
  }),

  props: {
    source: String
  }
};
</script>
