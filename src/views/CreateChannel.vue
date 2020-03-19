<template>
<div id="create_community_page">
	<div class="container-fluid">
			<div class="row">
				<div class="col-xl-12">
					<div class="create_community_page_title_section">
						<h2>Create a community</h2>
						<p>Add content, upload preview, connect stripe and go excluzeev!</p>
					</div>
				</div>
			</div>
			
      <form @submit.prevent="doCreateChannel">
			    <div class="row">

				    <div class="col-xl-8">
					    <div class="create_form_section">
							  <div class="form-row">
								  <div class="form-group col-md-6">
									  <label for="name">Name of the community<i class="fa fa-info"></i></label>
									  <input v-model="channelName" type="name" class="form-control" id="nameOfCommunity" aria-describedby="name" placeholder="Please enter a community name">
                    <span  class="error-message" v-if="this.errors['channelName']">{{this.errors['channelName']}}</span>

							  	</div>
								  <div class="form-group col-md-6">
									  <label for="Category">Category<i class="fa fa-info"></i></label>
                
								  	<select  v-on:change="onCategorySelected" v-model="categorySelected" class="form-control" id="selectCategory" placeholder="Choose a community category">
									  	<option v-for="cat in categories" v-text="cat.name" v-bind:value="cat.id" v-bind:key="cat.id"></option>
								  	</select>
                    <span  class="error-message" v-if="this.errors['category']">{{this.errors['category']}}</span>

							  	</div>
								  <!-- <div class="form-group col-md-12">
									<label for="description">Community’s short description<i class="fa fa-info"></i></label>
									<textarea v-model="description" class="form-control" id="communityDescription" placeholder="Please type short description" rows="2" ></textarea>
								  </div> -->

                  <div v-if="this.selectedChannelType == 'VOD'" class="form-group col-md-12">
								  	<label for="longdescription">Price $<i class="fa fa-info"></i></label>
									  <input type="number" v-model="price" class="form-control" placeholder="Price" />
                    <span  class="error-message" v-if="this.errors['price']">{{this.errors['price']}}</span>

								  </div>

                  <!-- Target fund if Channel Type is Crowdfunding -->
                  <div v-if="this.selectedChannelType != 'VOD'" class="form-group col-md-12">
									  <label for="longdescription">Target Fund<i class="fa fa-info"></i></label>
									  <input type="number" v-model="targetFund" class="form-control" placeholder="Price" />
                    <span  class="error-message" v-if="this.errors['targetFund']">{{this.errors['targetFund']}}</span>

								  </div>
              
							
                  <!-- Only if channelType is CrowdFunding -->
                  <div v-if="this.selectedChannelType != 'VOD'" class="form-group col-md-12">
									  <label for="longdescription">Expiry Date<i class="fa fa-info"></i></label>
									  <input type="date" v-model="expiryDate" class="form-control" placeholder="Expiry date" />
                     <span  class="error-message" v-if="this.errors['expiryDate']">{{this.errors['expiryDate']}}</span>

								  </div>
              
                  <div class="form-group col-md-12">
									  <label for="longdescription">Long description<i class="fa fa-info"></i></label>
									  <textarea v-model="description" class="form-control" id="longDescription" placeholder="Please type long description" rows="5"></textarea>
                    <span  class="error-message" v-if="this.errors['description']">{{this.errors['description']}}</span>

								  </div>


                  <div class="form-group col-md-12" v-if="this.errors['tier']">
                      <span  class="error-message" >{{this.errors['tier']}}</span>
                  </div>

                  <div v-if="this.selectedChannelType != 'VOD'" class="tier1 form-group col-md-12" >
                    <v-checkbox
                      v-model="selectedTiers[0]"
                      color="lighten-1"
                      :value="selectedTiers[0]"
                      label="Tier 1"
                    >
                    </v-checkbox>
                    <!-- V-if tier 1 selected -->
                    <div v-if="selectedTiers[0]">
                      <!-- Tier 1 Price -->
                  
                      <div class="form-group col-md-12">
                        <label for="longdescription">Tier 1 price $<i class="fa fa-info"></i></label>
                        <input type="number" v-model="tierPrices[0]" class="form-control"  placeholder="Price" />
                        <span  class="error-message" v-if="this.errors['tier1_price']">{{this.errors['tier1_price']}}</span>

                      </div>

                      <!-- Tier 1 Description -->
                      <div class="form-group col-md-12">
                        <label for="longdescription">Long description<i class="fa fa-info"></i></label>
                        <textarea v-model="tierDescriptions[0]" class="form-control" id="longDescription" placeholder="Please type long description" rows="5"></textarea>
                        <span  class="error-message" v-if="this.errors['tier1_desc']">{{this.errors['tier1_desc']}}</span>





                      </div>
                      
                    </div>
                  </div>
                  

                  <div v-if="this.selectedChannelType != 'VOD'" class="tier2 form-group col-md-12" >
                    <v-checkbox
                      v-model="selectedTiers[1]"
                      color="lighten-1"
                      :value="selectedTiers[1]"
                      label="Tier 2"
                    >
                    </v-checkbox>
                    <!-- V-if tier 2 selected -->
                    <div v-if="selectedTiers[1]">
                      <!-- Tier 2 Price -->
                  
                      <div class="form-group col-md-12">
                        <label for="longdescription">Tier 2 price $<i class="fa fa-info"></i></label>
                        <input type="number" v-model="tierPrices[1]" class="form-control"  placeholder="Price" />
                                                <span  class="error-message" v-if="this.errors['tier2_price']">{{this.errors['tier2_price']}}</span>
                      </div>

                      <!-- Tier 2 Description -->
                      <div class="form-group col-md-12">
                        <label for="longdescription">Long description<i class="fa fa-info"></i></label>
                        <textarea v-model="tierDescriptions[1]" class="form-control" id="longDescription" placeholder="Please type long description" rows="5"></textarea>
                                             <span  class="error-message" v-if="this.errors['tier2_desc']">{{this.errors['tier2_desc']}}</span>
                      </div>
                      
                    </div>
                  </div>
                  



                  <div v-if="this.selectedChannelType != 'VOD'" class="tier3 form-group col-md-12" >
                    <v-checkbox
                      v-model="selectedTiers[2]"
                      color="lighten-1"
                      :value="selectedTiers[2]"
                      label="Tier 3"
                    >
                    </v-checkbox>
                    <!-- V-if tier 3 selected -->
                    <div v-if="selectedTiers[2]">
                      <!-- Tier 3 Price -->
                  
                      <div class="form-group col-md-12">
                        <label for="longdescription">Tier 3 price $<i class="fa fa-info"></i></label>
                        <input type="number" v-model="tierPrices[2]" class="form-control"  placeholder="Price" />
                        <span  class="error-message" v-if="this.errors['tier3_price']">{{this.errors['tier3_price']}}</span>

                      </div>

                      <!-- Tier 3 Description -->
                      <div class="form-group col-md-12">
                        <label for="longdescription">Long description<i class="fa fa-info"></i></label>
                        <textarea v-model="tierDescriptions[2]" class="form-control" id="longDescription" placeholder="Please type long description" rows="5"></textarea>
                                   <span  class="error-message" v-if="this.errors['tier3_desc']">{{this.errors['tier3_desc']}}</span>
                      </div>
                      
                    </div>
                  </div>
                  
                  
                  <div v-if="this.selectedChannelType != 'VOD'" class="tier1 form-group col-md-12" >
                    <v-checkbox
                      v-model="selectedTiers[3]"
                      color="lighten-1"
                      :value="selectedTiers[3]"
                      label="Tier 4"
                    >
                    </v-checkbox>
                    <!-- V-if tier 1 selected -->
                    <div v-if="selectedTiers[3]">
                      <!-- Tier 1 Price -->
                  
                      <div class="form-group col-md-12">
                        <label for="longdescription">Tier 4 price $<i class="fa fa-info"></i></label>
                        <input type="number" v-model="tierPrices[3]" class="form-control"  placeholder="Price" />
                        <span  class="error-message" v-if="this.errors['tier4_price']">{{this.errors['tier4_price']}}</span>
                      </div>

                      <!-- Tier 4 Description -->
                      <div class="form-group col-md-12">
                        <label for="longdescription">Long description<i class="fa fa-info"></i></label>
                        <textarea v-model="tierDescriptions[3]" class="form-control" id="longDescription" placeholder="Please type long description" rows="5"></textarea>
                         <span  class="error-message" v-if="this.errors['tier4_desc']">{{this.errors['tier4_desc']}}</span>
                      </div>
                      
                    </div>
                  </div>
                  
                
                  <div v-if="this.selectedChannelType != 'VOD'" class="tier1 form-group col-md-12" >
                    <v-checkbox
                      v-model="selectedTiers[4]"
                      color="lighten-1"
                      :value="selectedTiers[4]"
                      label="Tier 5"
                    >
                    </v-checkbox>
                    <!-- V-if tier 5 selected -->
                    <div v-if="selectedTiers[4]">
                      <!-- Tier 5 Price -->
                  
                      <div class="form-group col-md-12">
                        <label for="longdescription">Tier 1 price $<i class="fa fa-info"></i></label>
                        <input type="number" v-model="tierPrices[4]" class="form-control"  placeholder="Price" />
                        <span  class="error-message" v-if="this.errors['tier5_price']">{{this.errors['tier5_price']}}</span>
                      </div>

                      <!-- Tier 5 Description -->
                      <div class="form-group col-md-12">
                        <label for="longdescription">Long description<i class="fa fa-info"></i></label>
                        <textarea v-model="tierDescriptions[4]" class="form-control" id="longDescription" placeholder="Please type long description" rows="5"></textarea>
                        <span  class="error-message" v-if="this.errors['tier5_desc']">{{this.errors['tier5_desc']}}</span>

                      </div>
                      
                    </div>
                  </div>
                  
                 
							</div>
						</div>

				    </div>          

					  <div class="col-xl-4 col-lg-6">

              <div class="form-group col-md-12">
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

                <span  class="error-message" v-if="this.errors['thumbnailFile']">{{this.errors['thumbnailFile']}}</span>

                <!-- Thumnail Image viewing -->
                <v-layout padding justify-center>
                  <img :src="thumbnail" height="150" v-if="thumbnail" />
                </v-layout>

              </div>
              <div class="form-group col-md-12">
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
                <span  class="error-message" v-if="this.errors['coverFile']">{{this.errors['coverFile']}}</span>
                
                <!-- Cover Image viewing -->
                <v-layout padding justify-center>
                  <img :src="cover" height="150" v-if="cover" />
                </v-layout>

              </div>
						<!-- <div class="file_upload ">
							<div class="file_upload_top_section">
								<div class="form-group fileUpload-input ">
									<label for="ProfilePicture">Profile Picture<i class="fa fa-info"></i></label>

									<div class="upload-btn-wrapper">
										<button class="btn btn-file-upload"><img src="../assets/Images/upload.png" style="width: auto;"> <br> Click to upload profile picture</button>
										<input type="file" class="form-control-file rounded-circle" id="profilePicture" name="myfile">
									</div>
								</div>

							</div> -->

						  <div class="file_upload_btm_section">
							  <div class="form-check circle-check">
								<img src="../assets/Images/circle-check-icon.png" style="width: auto;">
								<label class="form-check-label" for="defaultCheck1" style="font-size: 20px;">
									By clicking the button “Continue” below I agree to the <a href="#"> Privacy policy, Content creator terms <span>&</span> Call to action terms.</a>
								</label>
				  			</div>

                  <div class="form-group m-0" v-if="this.errors['error']">
                      <span  class="error-message" >{{this.errors['error']}}</span>
                  </div>
          
					  		<button loading="processing" :disabled="processing" @click="loader = 'loading4'" type="submit" class="btn btn-Continue">Continue</button>

						  </div>
					  </div>
				</div>

    </form>
	</div>

</div>
  <!--
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
                <\!-- Channel Category --\>
                <v-select
                  v-model="categorySelected"
                  v-on:change="onCategorySelected"
                  :items="categories"
                  label="Select Category"
                  item-text="name"
                  item-value="id"
                  return-object
                ></v-select>
                <\!-- Channel Name --\>
                <v-text-field
                  :name="this.selectedChannelType == 'VOD' ? 'Channel Name' : 'Title'"
                  :label="this.selectedChannelType == 'VOD' ? 'Channel Name' : 'Title'"
                  type="text"
                  counter
                  v-model="channelName"
                  :rules="[rules.required, rules.counter]"
                ></v-text-field>
                <\!-- Channel Description --\>
                <v-textarea
                  class="blue--text"
                  name="Description"
                  label="Description"
                  v-model="description"
                  :rules="[rules.required]"
                ></v-textarea>
                <\!-- Channel Price if Channel Type is VOD --\>
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
                <\!-- Target fund if Channel Type is Crowdfunding --\>
                <v-text-field
                  v-if="this.selectedChannelType != 'VOD'"
                  v-model="targetFund"
                  label="Target Fund"
                  prefix="$"
                  type="number"
                  :rules="[rules.required]"
                ></v-text-field>
                <\!-- Navigate to charages graph --\>
                <\!-- <p>
                  <a href="/excluzeev-charges" target="_blank">Learn more about pricing here.</a>
                </p>--\>
                <\!-- Only if channelType is CrowdFunding --\>
                <div v-if="this.selectedChannelType != 'VOD'">
                  <div class="calltoactionclass">
                    <v-dialog
                      ref="dialog"
                      v-model="expiryModal"
                      :return-value.sync="expiryDate"
                      persistent
                      lazy
                      full-width
                      width="290px"
                    >
                      <template v-slot:activator="{ on }">
                        <v-text-field
                          v-model="expiryDate"
                          label="Select Expiry Date"
                          readonly
                          v-on="on"
                        ></v-text-field>
                      </template>
                      <v-date-picker v-model="expiryDate" dark scrollable :min="minDate">
                        <v-spacer></v-spacer>
                        <v-btn flat color="primary" @click="expiryModal = false">Cancel</v-btn>
                        <v-btn flat color="primary" @click="$refs.dialog.save(expiryDate)">OK</v-btn>
                      </v-date-picker>
                    </v-dialog>
                  </div>
                  
                  <\!-- Tier 1 --\>
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
                    <\!-- V-if tier 1 selected --\>
                    <div v-if="selectedTiers[0]">
                      <\!-- Tier 1 Price --\>
                      <v-text-field
                        v-model="tierPrices[0]"
                        label="Tier 1 Price"
                        :value="tierPrices[0]"
                        type="number"
                        :min="minPrice"
                        prefix="$"
                        :rules="[rules.required]"
                      ></v-text-field>
                      <\!-- Tier 1 Description --\>
                      <v-textarea
                        class="blue--text"
                        name="Tier 1 Description"
                        label="Tier 1 Description"
                        v-model="tierDescriptions[0]"
                        :rules="[rules.required]"
                      ></v-textarea>
                    </div>
                  </div>
                  <\!-- Tier 2 --\>
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
                    <\!-- V-if tier 2 selected --\>
                    <div v-if="selectedTiers[1]">
                      <\!-- Tier 2 Price --\>
                      <v-text-field
                        v-model="tierPrices[1]"
                        label="Tier 2 Price"
                        :value="tierPrices[1]"
                        type="number"
                        :min="minPrice"
                        prefix="$"
                        :rules="[rules.required]"
                      ></v-text-field>
                      <\!-- Tier 2 Description --\>
                      <v-textarea
                        class="blue--text"
                        name="Tier 2 Description"
                        label="Tier 2 Description"
                        v-model="tierDescriptions[1]"
                        :rules="[rules.required]"
                      ></v-textarea>
                    </div>
                  </div>
                  <\!-- Tier 3 --\>
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
                    <\!-- V-if tier 3 selected --\>
                    <div v-if="selectedTiers[2]">
                      <\!-- Tier3 Price --\>
                      <v-text-field
                        v-model="tierPrices[2]"
                        label="Tier 3 Price"
                        :value="tierPrices[2]"
                        type="number"
                        :min="minPrice"
                        prefix="$"
                        :rules="[rules.required]"
                      ></v-text-field>
                      <\!-- Tier 3 Description --\>
                      <v-textarea
                        class="blue--text"
                        name="Tier 3 Description"
                        label="Tier 3 Description"
                        v-model="tierDescriptions[2]"
                        :rules="[rules.required]"
                      ></v-textarea>
                    </div>
                  </div>
                  <\!-- Tier 4 --\>
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
                    <\!-- V-if tier 4 selected --\>
                    <div v-if="selectedTiers[3]">
                      <\!-- Tier4 Price --\>
                      <v-text-field
                        v-model="tierPrices[3]"
                        label="Tier 4 Price"
                        :value="tierPrices[3]"
                        type="number"
                        :min="minPrice"
                        prefix="$"
                        :rules="[rules.required]"
                      ></v-text-field>
                      <\!-- Tier4 Description --\>
                      <v-textarea
                        class="blue--text"
                        name="Tier 4 Description"
                        label="Tier 4 Description"
                        v-model="tierDescriptions[3]"
                        :rules="[rules.required]"
                      ></v-textarea>
                    </div>
                  </div>
                  <\!-- Tier 5 --\>
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
                    <\!-- V-if tier 5 selected --\>
                    <div v-if="selectedTiers[4]">
                      <\!-- Tier5 Price --\>
                      <v-text-field
                        v-model="tierPrices[4]"
                        label="Tier 5 Price"
                        :value="tierPrices[4]"
                        type="number"
                        :min="minPrice"
                        prefix="$"
                        :rules="[rules.required]"
                      ></v-text-field>
                      <\!-- Tier4 Description --\>
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

                <\!-- Thumbnail Upload Button --\>
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
                <\!-- Thumnail Image viewing --\>
                <v-layout padding justify-center>
                  <img :src="thumbnail" height="150" v-if="thumbnail" />
                </v-layout>
                <\!-- Cover Image Upload Button --\>
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
                <\!-- Cover Image viewing --\>
                <v-layout padding justify-center>
                  <img :src="cover" height="150" v-if="cover" />
                </v-layout>

                <div class="text-xs-center">
                  <\!-- Add Channel Button with loading --\>
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
                <\!-- Cancel Adding channel Button --\>
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
  -->
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
      expiryDate: null,
      minDate: undefined,
      expiryModal: false,
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
          return number >= 1.99 || "Price must be greater than 1.99$";
        },
        counter: value => value.length <= 32 || "Maximum 32 characters",
        email: value => {
          const pattern = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
          return pattern.test(value) || "Invalid e-mail.";
        }
      },
      errors:{},
    };
  },
  created() {
    this.minDate = new Date().toISOString();
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
    fetchCategoryName(){

      for(let i=0;i<this.categories.length;i++){
        if(this.categories[i].id == this.categorySelected){
          return this.categories[i]
        }
      }

      return false

    },
    onCategorySelected(selected) {
      
      selected=this.fetchCategoryName()
      if(selected){ 

        console.log("Selected name",selected.name);
        if (selected.name == "Call-to-Action") {
          this.selectedChannelType = "CrowdFunding";
        } else {
          this.selectedChannelType = "VOD";
        }
      }
      
      
    },
    async doCreateChannel() {
      
      this.errors={};
      let errorFound=false;

      if (this.selectedChannelType != "VOD") {
        if (this.selectedTiers.indexOf(true) == -1) {
          // this.showToast("Please select atleast one tier");
          this.errors['tier']="Please select atlease on tier";
          return;
        } else {
          for (let i = 0; i < this.selectedTiers.length; i++) {
            let tier = i + 1;
            if (this.selectedTiers[i]) {
              if (this.tierPrices[i] == null && this.tierPrices[i] < 1.0) {
                // this.showToast("Tier " + tier + " price cannot be lessthan 1");
                this.errors['tier'+tier+"_price"] ="Tier " + tier + " price cannot be lessthan 1";
                errorFound=true;
              }
              if (this.tierDescriptions[i] == "") {
                // this.showToast("Tier " + tier + " description cannot be empty");
                this.errors['tier'+tier+"_desc"]="Tier " + tier + " description cannot be empty";
                errorFound=true;
              }
            }
          }
        }
      }

      if (this.categorySelected == null || this.categorySelected.isEmpty) {
        this.errors['category']="Please select Channel Category";
        errorFound=true;
       }
      if (this.channelName == "") {
        this.errors['channelName']="Channel name cannot be empty";
        errorFound=true;
      }
      if (this.description == "") {
        // this.showToast("Channel Description cannot be empty");
        this.errors['description']="Channel Description cannot be empty";
        errorFound=true;
      }

      if (this.selectedChannelType == "VOD") {
        if (!(this.price >= 1.0)) {
          this.errors['price']="Price cannot be less than 1 or greater than 10";
          errorFound=true;
        }
      } else {
        if (this.targetFund <= 1) {
          this.errors['targetFund']="TargetFund  cannot be less than 1";
          errorFound=true;
        }
        if (this.expiryDate == null) {
          this.errors['expiryDate']="Please select end Date";
          errorFound=true;     
        }
      }

      if (this.thumbnailFile == null) {
        this.errors['thumbnailFile']="Please upload Thumbnail image";
        errorFound=true;

      }

      if (this.coverFile == null) {
        this.errors['coverFile']="Please upload Cover image";
        errorFound=true;
      }


      if(errorFound){
        this.processing = false;
        this.$forceUpdate();
        return false; // if error found

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
      let expiry = "";
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
        expiry = firebaseTimestamp.fromDate(new Date(this.expiryDate));
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
        expiry: expiry,
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
        // this.showToast("Channel Creation failed.");

        this.errors['error']="Channel creation failed";
        this.$forceUpdate();


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

.error-message{
    font-size: 17px;
    display: block;
    color: #f00;
    text-align: left;
    padding-left: 10px;
    padding-top: 5px;

}
.form-check-label{
  font-size:20px;
}
</style>
