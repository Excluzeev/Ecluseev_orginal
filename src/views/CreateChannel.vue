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
              <v-form class="blue--text lighten-1" @submit.prevent="doCreateChannel">
                <v-select
                  v-model="categorySelected"
                  v-on:change="onCategorySelected"
                  :items="categories"
                  label="Select Category"
                  item-text="name"
                  item-value="id"
                  return-object
                ></v-select>
                <v-text-field
                  name="Channel Name"
                  label="Channel Name"
                  type="text"
                  counter
                  v-model="channelName"
                  :rules="[rules.required, rules.counter]"
                ></v-text-field>
                <v-textarea
                  class="blue--text"
                  name="Description"
                  label="Description"
                  v-model="description"
                  :rules="[rules.required]"
                ></v-textarea>
                <v-select
                  v-model="selectedTierType"
                  v-on:change="onTierTypeSelected"
                  :items="tierTypes"
                  label="Channel Tier"
                ></v-select>
                <v-text-field
                  v-if="this.selectedChannelType == 'VOD'"
                  v-model="price"
                  label="Price"
                  :value="price"
                  type="number"
                  :min="minPrice"
                  :max="maxPrice"
                  prefix="$"
                  :rules="[rules.required, this.selectedTierType == 'Tier 1' ? rules.priceCheck : rules.priceCheck2]"
                ></v-text-field>
                <v-text-field
                  v-if="this.selectedChannelType != 'VOD'"
                  v-model="targetFund"
                  label="Target Fund"
                  prefix="$"
                  type="number"
                  :rules="[rules.required]"
                ></v-text-field>

                <p>
                  <a href="/excluzeev-charges" target="_blank">Learn more about pricing here.</a>
                </p>
                <upload-btn
                  color="blue--text lighten-1"
                  style="background-color: #fff !important;"
                  class="white--text"
                  title="Add Thumbnail"
                  :fileChangedCallback="thumbnailChanged"
                  accept="image/*"
                  :uniqueId="unique"
                  round
                >
                  <template slot="icon">
                    <div style="padding-left:4px">
                      <v-icon color="blue lighten-1">cloud_upload</v-icon>
                    </div>
                  </template>
                </upload-btn>

                <v-layout padding justify-center>
                  <img :src="thumbnail" height="150" v-if="thumbnail">
                </v-layout>

                <upload-btn
                  color="blue--text lighten-1"
                  style="background-color: #fff !important;"
                  class="white--text"
                  title="Add Cover Image"
                  :fileChangedCallback="coverChanged"
                  accept="image/*"
                  :uniqueId="unique"
                  round
                >
                  <template slot="icon">
                    <div style="padding-left:4px">
                      <v-icon color="blue lighten-1">cloud_upload</v-icon>
                    </div>
                  </template>
                </upload-btn>

                <v-layout padding justify-center>
                  <img :src="cover" height="150" v-if="cover">
                </v-layout>

                <div class="text-xs-center">
                  <v-btn
                    class="white--text"
                    color="blue lighten-1"
                    type="submit"
                    :loading="processing"
                    :disabled="processing"
                    @click="loader = 'loading4'"
                  >
                    Add Channel
                    <template v-slot:loader>
                      <span class="custom-loader">
                        <v-icon light>cached</v-icon>
                      </span>
                    </template>
                  </v-btn>
                </div>
                <div class="text-xs-center">
                  <v-btn class="white--text" color="grey lighten-1" @click="$router.back()">Cancel</v-btn>
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
import {
  publicStorage,
  auth,
  firebaseTimestamp,
  fireStore
} from "../firebase/init";
import utils from "../firebase/utils";

export default {
  components: {
    "upload-btn": UploadButton
  },
  data: () => {
    return {
      categorySelected: null,
      channelName: "",
      description: "",
      thumbnail: null,
      thumbnailFile: null,
      cover: null,
      coverFile: null,
      categories: [],
      selectedChannelType: "VOD",
      tierTypes: ["Tier 1", "Tier 2"],
      selectedTierType: "Tier 1",
      price: null,
      targetFund: null,
      minPrice: 1,
      maxPrice: 10.0,
      unique: true,
      processing: false,
      rules: {
        required: value => !!value || "Required.",
        priceCheck: value => {
          let number = Number(value);
          return (
            (number >= 1 && number <= 10) ||
            "Price must be between 0.99 and 10.0"
          );
        },
        priceCheck2: value => {
          let number = Number(value);
          return number >= 10 || "Price must be greater than 10.0";
        },
        counter: value => value.length <= 32 || "Maximum 32 characters",
        email: value => {
          const pattern = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
          return pattern.test(value) || "Invalid e-mail.";
        }
      }
    };
  },
  created() {
    this.$store.dispatch("fetchCategories").then(cats => {
      this.categories = cats;
    });
  },
  methods: {
    thumbnailChanged(file) {
      this.thumbnailFile = file;
      this.thumbnail = URL.createObjectURL(this.thumbnailFile);
    },
    coverChanged(file) {
      this.coverFile = file;
      this.cover = URL.createObjectURL(this.coverFile);
    },
    onTierTypeSelected(selected) {},
    onCategorySelected(selected) {
      if (selected.name == "Call-to-Action") {
        this.selectedChannelType = "CrowdFunding";
      } else {
        this.selectedChannelType = "VOD";
      }
    },
    async doCreateChannel() {
      if (this.categorySelected == null || this.categorySelected.isEmpty) {
        this.showToast("Please select Channel Category");
        return;
      }
      if (this.channelName == "") {
        this.showToast("Channel Name cannot be empty");
        return;
      }
      if (this.description == "") {
        this.showToast("Channel Description cannot be empty");
        return;
      }

      if (this.selectedChannelType == "VOD") {
        if (!(this.price > 0.0 && this.price <= 10.0)) {
          this.showToast("Price cannot be less than 0 or greater than 10");
          return;
        }
      } else {
        if (this.targetFund <= 0) {
          this.showToast("TargetFund  cannot be less than 0");
          return;
        }
      }

      if (this.thumbnailFile == null) {
        this.showToast("Please select Thumbnail");
        return;
      }

      if (this.coverFile == null) {
        this.showToast("Please select Cover");
        return;
      }

      this.processing = true;

      const metadata = {
        contentType: "image/*"
      };

      let channelId = utils.generateId();
      let thumbnailRef = publicStorage
        .ref()
        .child("channels")
        .child(channelId)
        .child("thumbnail.jpg");
      let coverRef = publicStorage
        .ref()
        .child("channels")
        .child(channelId)
        .child("cover.jpg");
      let thumbnailUrl = "";
      let coverUrl = "";
      try {
        await thumbnailRef.put(this.thumbnailFile, metadata);
        thumbnailUrl = await thumbnailRef.getDownloadURL();
      } catch (e) {
        // console.log(e);
      }
      try {
        await coverRef.put(this.coverFile, metadata);
        coverUrl = await coverRef.getDownloadURL();
      } catch (e) {
        // console.log(e);
      }

      let channelData = {
        channelId: channelId,
        categoryName: this.categorySelected.name,
        categoryId: this.categorySelected.id,
        userId: auth.currentUser.uid,
        createdBy: auth.currentUser.displayName,
        channelType: this.selectedChannelType,
        title: this.channelName,
        image: thumbnailUrl,
        coverImage: coverUrl,
        tier: this.selectedTierType,
        createdDate: firebaseTimestamp.fromDate(new Date()),
        subscriberCount: 0,
        price: this.selectedChannelType == "CrowdFunding" ? 0 : this.price,
        targetFund: this.targetFund,
        currentFund: 0,
        percentage: 0.0
      };

      let channelRef = fireStore
        .collection(utils.channelsCollection)
        .doc(channelId);
      try {
        await channelRef.set(channelData);
        this.showToast("Channel Created Successfully");
        this.$router.push({
          name: "AddTrailer",
          params: {
            channelData: channelData
          }
        });
      } catch (error) {
        // console.log(error);
        this.showToast("Channel Creation failed.");
      }
      this.processing = false;
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
.padding {
  padding: 10px;
}
</style>
