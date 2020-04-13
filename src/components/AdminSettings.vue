<template>

      <div>

         <p class="page-title">Settings</p>

		
	
          <form @submit.prevent="update_settings">
        
		  <div v-if="showInfo" class="row text-center info-message">
                            <div class="col-lg-12">

                                {{ infoMsg }}
                            </div>

                         </div>

                         <div v-if="showError" class="row text-center error-message">
                            <div class="col-lg-12">
                                {{ errorMsg }}
                            </div>

                         </div>

	

	    <div class="row mT-30">
       
            <div class="col-lg-6">
        

                <div class="form-title">Stripe settings</div> 


                  <div class="form-group">
                    <label >Stripe Live Public key</label>
                    <input type="text" class="form-control" placeholder="Stripe Live public key" name="stripe_live_public_key" v-model="settings.stripe_live_public_key">
		    <span  class="error-message" v-if="this.errors['stripe_live_public_key']">{{this.errors['stripe_live_public_key']}}</span>


                  </div>

                  <div class="form-group">
                    <label >Stripe Live Secret key</label>
                    <input type="text" class="form-control" placeholder="Stripe Live secret key" name="stripe_live_secret_key" v-model="settings.stripe_live_secret_key">
		    <span  class="error-message" v-if="this.errors['stripe_live_secret_key']">{{this.errors['stripe_live_secret_key']}}</span>
                  </div>

                  <div class="form-group">
                    <label >Stripe Test Public key</label>
                    <input type="text" class="form-control" placeholder="Stripe Test public key" name="stripe_test_public_key" v-model="settings.stripe_test_public_key">
		            <span  class="error-message" v-if="this.errors['stripe_test_public_key']">{{this.errors['stripe_test_public_key']}}</span>
                  </div>

                  <div class="form-group">
                    <label >Stripe Test Secret key</label>
                    <input type="text" class="form-control" placeholder="Stripe Test secret key" name="stripe_test_secret_key" v-model="settings.stripe_test_secret_key">

        		    <span  class="error-message" v-if="this.errors['stripe_test_secret_key']">{{this.errors['stripe_test_secret_key']}}</span>

                  </div>


                   
                  <div class="form-group">
                    <label >Stripe Live client ID</label>
                    <input type="text" class="form-control" placeholder="Stripe Live Client ID" name="stripe_live_client_id" v-model="settings.stripe_live_client_id">
		            <span  class="error-message" v-if="this.errors['stripe_live_client_id']">{{this.errors['stripe_live_client_id']}}</span>
                  </div>

                  <div class="form-group">
                    <label >Stripe Test client ID</label>
                    <input type="text" class="form-control" placeholder="Stripe Test Client ID" name="stripe_test_client_id" v-model="settings.stripe_test_client_id">

        		    <span  class="error-message" v-if="this.errors['stripe_test_client_id']">{{this.errors['stripe_test_client_id']}}</span>
                  </div>




                  <div class="form-group">

                    <label>Live Mode</label>
                    <select classs="form-control" v-model="settings.is_stripe_live">
                        <option value=true>yes</option>
                        <option value=false>No</option>

                    </select>
                  </div>


                  <button type="submit" class="btn btn-primary" :disabled="processing">Save</button>

            </div>


            
            <div class="col-lg-6">
        

                <div class="form-title">Banner settings</div>

                  <div class="form-group">
                    <label>Auto slider interval(milliseconds)</label>
                    <input type="number" min=100 max=2000 class="form-control" placeholder="" name="slider_interval" v-model="settings.auto_slider_interval">

		
            		    <span  class="error-message" v-if="this.errors['auto_slider_interval']">{{this.errors['auto_slider_interval']}}</span>

                  </div>


                  <div class="form-group">

                    <label>Auto slider</label>
                    <select classs="form-control" v-model="settings.is_auto_slider_enabled">
                        <option value=true>yes</option>
                        <option value=false>No</option>

                    </select>
                  </div>


                <div class="form-title">Basic settings</div>

                  <div class="form-group">
                    <label>Site Base URL</label>

                    <input type="text" class="form-control" placeholder="Site Base URL" name="sitebase_url" v-model="settings.site_base_url">

		    <span  class="error-message" v-if="this.errors['site_base_url']">{{this.errors['site_base_url']}}</span>

                  </div>


            </div>


    
        </div>

      </form>


  </div>
  
</template>

<script>
import { auth, fireStore, firebaseTimestamp } from "../firebase/init";
import utils from "../firebase/utils";
import moment from "moment";

export default {
  name: "AdminSettings",
  data: () => {
    return {

       infoMsg:"",
       errorMSg:"",
       showInfo: false,
       showError: false,
       errors:{},
       settings_id:null,
       processing: false,

        settings: {
		auto_slider_interval: 300,
		is_stripe_live: false,
		site_base_url: "",
		stripe_live_public_key: "",
		stripe_live_secret_key: "",
		stripe_test_public_key: "",
		stripe_test_secret_key: "",

		stripe_live_client_id: "",
		stripe_test_client_id: "",

	},
        
    };
  },
  mounted() {
        
        // Fetch particular setting from site_settings
	
	/*
	this.$store.dispatch("fetchSettings",{key: 'site_base_url'}).then(settings => {
		console.log("Settings from store",settings)
	});
	*/


         fireStore
            .collection(utils.settingsCollection)
	    .limit(1)
	    .get()
	    .then(querySnapshot =>{

		  querySnapshot.forEach(snapShot => {
			
			console.log("ID",snapShot.id)
			this.settings=snapShot.data()
			this.settings_id=snapShot.id
	

		  });


		});




  },
  methods: {

    async update_settings(){

	// Form validation goes here
	this.errors={}

	let errorFound=false;

	if(this.settings.is_stripe_live && this.settings.stripe_live_public_key == "" && this.settings.stripe_live_secret_key == ""){

		this.errors["stripe_live_public_key"]="It is required"

		this.errors["stripe_live_secret_key"]="It is required"
		errorFound=true;
	}
	
	if(this.settings.is_stripe_live != true && this.settings.stripe_test_public_key == "" && this.settings.stripe_test_secret_key == ""){

		this.errors["stripe_test_public_key"]="It is required"

		this.errors["stripe_test_secret_key"]="It is required"

		errorFound=true;
	
	}	

	if(this.settings.is_stripe_live && this.settings.stripe_live_client_id == ""){

		this.errors["stripe_live_client_id"]="It is required"

		errorFound=true;
	
	}	


	if(this.settings.is_stripe_live != true && this.settings.stripe_test_client_id == ""){

		this.errors["stripe_test_client_id"]="It is required"

		errorFound=true;
	
	}	



	if(this.settings.site_base_url == ""){


		this.errors["site_base_url"]="It is required"

		errorFound=true;
		

	}	
	

	//console.log("is_stripe_live",this.settings.is_stripe_live)	
	if(errorFound){
            this.processing=false;
            this.$forceUpdate();
            return false; // if error found

          }
	

	
         let settingsRef = await fireStore
            .collection(utils.settingsCollection)
            .doc(this.settings_id)

	            //console.log("settings",settingsRef)	

              try {
                await settingsRef.set(this.settings);
                this.infoMsg="Updated the settings successfully"
                this.showInfo=true

              } catch (error) {

                this.errorMsg="Unable to update settings: "+error
                this.showError=true
              }


	
     

    }

  }
};
</script>

<style scoped>
    .form-title{
        font-size:1.1rem;
        font-weight:bold;
    }

    .error-message{
    font-size: 17px;
    display: block;
    color: #f00;
    text-align: left;
    padding-left: 10px;
    padding-top: 5px;

}

.info-message{
    font-size: 17px;
    display: block;
    color: green;
    text-align: left;
    padding-left: 10px;
    padding-top: 5px;

}
    
</style>
