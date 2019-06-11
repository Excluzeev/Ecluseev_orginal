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
                <!-- Channel Category -->
                <v-select
                  v-model="categorySelected"
                  v-on:change="onCategorySelected"
                  :items="categories"
                  label="Select Category"
                  item-text="name"
                  item-value="id"
                  return-object
                ></v-select>
                <!-- Channel Name -->
                <v-text-field
                  :name="this.selectedChannelType == 'VOD' ? 'Channel Name' : 'Title'"
                  :label="this.selectedChannelType == 'VOD' ? 'Channel Name' : 'Title'"
                  type="text"
                  counter
                  v-model="channelName"
                  :rules="[rules.required, rules.counter]"
                ></v-text-field>
                <!-- Channel Description -->
                <v-textarea
                  class="blue--text"
                  name="Description"
                  label="Description"
                  v-model="description"
                  :rules="[rules.required]"
                ></v-textarea>
                <!-- Channel Price if Channel Type is VOD -->
                <v-text-field
                  v-if="this.selectedChannelType == 'VOD'"
                  v-model="price"
                  label="Price"
                  :value="price"
                  type="number"
                  :min="minPrice"
                  :max="maxPrice"
                  prefix="$"
                  :rules="[rules.required, rules.priceCheck]"
                ></v-text-field>
                <!-- Target fund if Channel Type is Crowdfunding -->
                <v-text-field
                  v-if="this.selectedChannelType != 'VOD'"
                  v-model="targetFund"
                  label="Target Fund"
                  prefix="$"
                  type="number"
                  :rules="[rules.required]"
                ></v-text-field>
                <!-- Navigate to charages graph -->
                <p>
                  <a href="/excluzeev-charges" target="_blank">Learn more about pricing here.</a>
                </p>
                <!-- Only if channelType is CrowdFunding -->
                <div v-if="this.selectedChannelType != 'VOD'">
                  <!-- Tier 1 -->
                  <div class="tier1">
                    <v-checkbox
                      v-model="selectedTiers[0]"
                      color="lighten-1"
                      :value="selectedTiers[0]"
                    >
                      <template v-slot:label>
                        <div>Tier 1</div>
                      </template>
                    </v-checkbox>
                    <!-- V-if tier 1 selected -->
                    <div v-if="selectedTiers[0]">
                      <!-- Tier 1 Price -->
                      <v-text-field
                        v-model="tierPrices[0]"
                        label="Tier 1 Price"
                        :value="tierPrices[0]"
                        type="number"
                        :min="minPrice"
                        prefix="$"
                        :rules="[rules.required]"
                      ></v-text-field>
                      <!-- Tier 1 Description -->
                      <v-textarea
                        class="blue--text"
                        name="Tier 1 Description"
                        label="Tier 1 Description"
                        v-model="tierDescriptions[0]"
                        :rules="[rules.required]"
                      ></v-textarea>
                    </div>
                  </div>
                  <!-- Tier 2 -->
                  <div class="tier2">
                    <v-checkbox
                      v-model="selectedTiers[1]"
                      color="lighten-1"
                      :value="selectedTiers[1]"
                    >
                      <template v-slot:label>
                        <div>Tier 2</div>
                      </template>
                    </v-checkbox>
                    <!-- V-if tier 2 selected -->
                    <div v-if="selectedTiers[1]">
                      <!-- Tier 2 Price -->
                      <v-text-field
                        v-model="tierPrices[1]"
                        label="Tier 2 Price"
                        :value="tierPrices[1]"
                        type="number"
                        :min="minPrice"
                        prefix="$"
                        :rules="[rules.required]"
                      ></v-text-field>
                      <!-- Tier 2 Description -->
                      <v-textarea
                        class="blue--text"
                        name="Tier 2 Description"
                        label="Tier 2 Description"
                        v-model="tierDescriptions[1]"
                        :rules="[rules.required]"
                      ></v-textarea>
                    </div>
                  </div>
                  <!-- Tier 3 -->
                  <div class="tier3">
                    <v-checkbox
                      v-model="selectedTiers[2]"
                      color="lighten-2"
                      :value="selectedTiers[2]"
                    >
                      <template v-slot:label>
                        <div>Tier 3</div>
                      </template>
                    </v-checkbox>
                    <!-- V-if tier 3 selected -->
                    <div v-if="selectedTiers[2]">
                      <!-- Tier3 Price -->
                      <v-text-field
                        v-model="tierPrices[2]"
                        label="Tier 3 Price"
                        :value="tierPrices[2]"
                        type="number"
                        :min="minPrice"
                        prefix="$"
                        :rules="[rules.required]"
                      ></v-text-field>
                      <!-- Tier 3 Description -->
                      <v-textarea
                        class="blue--text"
                        name="Tier 3 Description"
                        label="Tier 3 Description"
                        v-model="tierDescriptions[2]"
                        :rules="[rules.required]"
                      ></v-textarea>
                    </div>
                  </div>
                  <!-- Tier 4 -->
                  <div class="tier4">
                    <v-checkbox
                      v-model="selectedTiers[3]"
                      color="lighten-3"
                      :value="selectedTiers[3]"
                    >
                      <template v-slot:label>
                        <div>Tier 4</div>
                      </template>
                    </v-checkbox>
                    <!-- V-if tier 4 selected -->
                    <div v-if="selectedTiers[3]">
                      <!-- Tier4 Price -->
                      <v-text-field
                        v-model="tierPrices[3]"
                        label="Tier 4 Price"
                        :value="tierPrices[3]"
                        type="number"
                        :min="minPrice"
                        prefix="$"
                        :rules="[rules.required]"
                      ></v-text-field>
                      <!-- Tier4 Description -->
                      <v-textarea
                        class="blue--text"
                        name="Tier 4 Description"
                        label="Tier 4 Description"
                        v-model="tierDescriptions[3]"
                        :rules="[rules.required]"
                      ></v-textarea>
                    </div>
                  </div>
                  <!-- Tier 5 -->
                  <div class="tier5">
                    <v-checkbox
                      v-model="selectedTiers[4]"
                      color="lighten-4"
                      :value="selectedTiers[4]"
                    >
                      <template v-slot:label>
                        <div>Tier 5</div>
                      </template>
                    </v-checkbox>
                    <!-- V-if tier 5 selected -->
                    <div v-if="selectedTiers[4]">
                      <!-- Tier5 Price -->
                      <v-text-field
                        v-model="tierPrices[4]"
                        label="Tier 5 Price"
                        :value="tierPrices[4]"
                        type="number"
                        :min="minPrice"
                        prefix="$"
                        :rules="[rules.required]"
                      ></v-text-field>
                      <!-- Tier4 Description -->
                      <v-textarea
                        class="blue--text"
                        name="Tier 5 Description"
                        label="Tier 5 Description"
                        v-model="tierDescriptions[4]"
                        :rules="[rules.required]"
                      ></v-textarea>
                    </div>
                  </div>
                </div>

                <!-- Thumbnail Upload Button -->
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
                <!-- Thumnail Image viewing -->
                <v-layout padding justify-center>
                  <img :src="thumbnail" height="150" v-if="thumbnail">
                </v-layout>
                <!-- Cover Image Upload Button -->
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
                <!-- Cover Image viewing -->
                <v-layout padding justify-center>
                  <img :src="cover" height="150" v-if="cover">
                </v-layout>

                <div class="text-xs-center">
                  <!-- Add Channel Button with loading -->
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
                <!-- Cancel Adding channel Button -->
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
      price: null,
      targetFund: null,
      minPrice: 1,
      maxPrice: 10.0,
      unique: true,
      processing: false,
      selectedTiers: [false, false, false, false, false],
      tierPrices: [null, null, null, null, null],
      tierDescriptions: ["", "", "", "", ""],
      rules: {
        required: value => !!value || "Required.",
        priceCheck: value => {
          let number = Number(value);
          return number >= 1 || "Price must be greater than 1$";
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
    onCategorySelected(selected) {
      if (selected.name == "Call-to-Action") {
        this.selectedChannelType = "CrowdFunding";
      } else {
        this.selectedChannelType = "VOD";
      }
    },
    async doCreateChannel() {
      if (this.selectedChannelType != "VOD") {
        if (this.selectedTiers.indexOf(true) == -1) {
          this.showToast("Please select atleast one tier");
          return;
        } else {
          for (let i = 0; i < this.selectedTiers.length; i++) {
            let tier = i + 1;
            if (this.selectedTiers[i]) {
              if (this.tierPrices[i] == null && this.tierPrices[i] < 1.0) {
                this.showToast("Tier " + tier + " price cannot be lessthan 1");
                return;
              }
              if (this.tierDescriptions[i] == "") {
                this.showToast("Tier " + tier + " description cannot be empty");
                return;
              }
            }
          }
        }
      }

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
        if (!(this.price >= 1.0 && this.price <= 10.0)) {
          this.showToast("Price cannot be less than 1 or greater than 10");
          return;
        }
      } else {
        if (this.targetFund <= 1) {
          this.showToast("TargetFund  cannot be less than 1");
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

      let tierArray = [];
      if (this.selectedChannelType != "VOD") {
        for (let i = 0; i < this.selectedTiers.length; i++) {
          let tier = i + 1;
          if (this.selectedTiers[i]) {
            tierArray.push({
              tier: "Tier " + tier,
              price: this.tierPrices[i],
              description: this.tierDescriptions[i]
            });
          }
        }
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
        createdDate: firebaseTimestamp.fromDate(new Date()),
        subscriberCount: 0,
        price: this.selectedChannelType == "CrowdFunding" ? 0 : this.price,
        targetFund: this.targetFund,
        tiers: tierArray,
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
