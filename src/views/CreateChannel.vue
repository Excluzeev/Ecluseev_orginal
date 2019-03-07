<template>
  <v-content>
    <v-container fluid fill-height>
      <v-layout align-center justify-center>
        <v-flex xs12 sm8 md4>
          <v-card class="elevation-9">
            <v-toolbar dark color="blue lighten-1">
              <v-toolbar-title>Create Channel</v-toolbar-title>
            </v-toolbar>
            <v-card-text>
              <v-form class="blue--text lighten-1">
                <v-overflow-btn
                  :items="dropdown_edit"
                  label="Select Category "
                  editable
                  item-value="text"
                ></v-overflow-btn>
                <v-overflow-btn
                  :items="dropdown_font"
                  label="Channel Type"
                  target="#dropdown-example"
                ></v-overflow-btn>
                <v-text-field
                  name="Channel Name"
                  label="Channel Name   "
                  type="text"
                  v-model="email"
                ></v-text-field>
                <v-text-field
                  name="Description"
                  label="Description"
                  type="text"
                  v-model="email"
                ></v-text-field>
                <v-text-field
                  label="Price"
                  value="0.99"
                  prefix="$"
                ></v-text-field>
                <!-- https://jsfiddle.net/meyubaraj/fLbe7r72/ -->
                <img :src="imageUrl" height="150" v-if="imageUrl" />
                <!-- <v-text-field
                  label="Thumbnail"
                  @click="pickFile"
                  v-model="imageName"
                  prepend-icon="attach_file"
                ></v-text-field>
                <input
                  type="file"
                  style="display: none"
                  ref="image"
                  accept="image/*"
                  @change="onFilePicked"
                />
                <img :src="imageUrl" height="150" v-if="imageUrl" />
                <v-text-field
                  label="Cover Image"
                  @click="pickFile"
                  v-model="imageName"
                  prepend-icon="attach_file"
                ></v-text-field>
                <input
                  type="file"
                  style="display: none"
                  ref="image"
                  accept="image/*"
                  @change="onFilePicked"
                /> -->
                <upload-btn
                  color="blue--text lighten-1"
                  style="background-color: #fff !important;"
                  class="white--text"
                  title="Add Thumnail"
                  round
                >
                  <template slot="icon">
                    <div style="padding-left:4px">
                      <v-icon color="blue lighten-1">cloud_upload</v-icon>
                    </div>
                  </template>
                </upload-btn>
                <upload-btn
                  color="blue--text lighten-1"
                  style="background-color: #fff !important;"
                  class="white--text"
                  title="Add Cover Image"
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
                    >Add Channel</v-btn
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
