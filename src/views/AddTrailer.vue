<template>
  <v-content>
    <v-container fluid fill-height>
      <v-layout align-center justify-center>
        <v-flex xs12 sm8 md4>
          <v-card class="elevation-9">
            <v-toolbar dark color="blue lighten-1">
              <v-toolbar-title>Add a trailer</v-toolbar-title>
            </v-toolbar>
            <v-card-text>
              <v-form class="blue--text lighten-1">
                <v-text-field
                  name="Title"
                  label="Title"
                  type="text"
                  v-model="email"
                ></v-text-field>
                <v-text-field
                  name="Description"
                  label="Description"
                  type="text"
                  v-model="email"
                ></v-text-field>
                <upload-btn
                  color="blue--text lighten-1"
                  style="background-color: #fff !important;"
                  class="white--text"
                  title="Add trailer  "
                  round
                >
                  <template slot="icon">
                    <div style="padding-left:4px">
                      <v-icon color="blue lighten-1">cloud_upload</v-icon>
                    </div>
                  </template>
                </upload-btn>
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
import UploadButton from "vuetify-upload-button";

export default {
  components: {
    "upload-btn": UploadButton
  },
  data: () => {
    return {};
  }
};
</script>

<style></style>
