<template>
	<!-- Modal for sign in -->
	<div class="modal fade bd-example-modal-md" id="becomeCCModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-md modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<!-- <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5> -->
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">Close</span>
					</button>
				</div>
					<div class="modal-body">
						<h2 class="h2 text-center" >Sign up as Content Creator</h2>
            	<div class="form-row " v-if="this.errors['error']">
    						<div class="form-group col-md-12 non-specific-error-cont">
                  <span  class="non-specific-error" id="non-specific-error"  >{{this.errors['error']}}</span>
    					  </div>
    				  </div>
              <form @submit.prevent="doSignUpContentCreator">
                <br>
                <div class="form-row">
                  <div class="form-group col-md-12 margin_bottom_none">
                    <div class="form-row margin_bottom_none">
                      <div class="form-group col-md-12 margin_bottom_none">
                        <div class="form-row margin_bottom_none">
                          
                          <div class="form-group col-md-12" >
                              <input v-model="termsCreator"  @change="checkSomeCheckUpdated()" type="checkbox" name="" id="" value="true">
                              <a @click="showContentCreatorTerms">Content creater Terms</a>

                          <span  class="error-message" v-if="this.errors['term1']">{{this.errors['term1']}}</span>
                       
                          </div>

                           <div class="form-group col-md-12" >
                              <input v-model="privacyPolicy" @change="checkSomeCheckUpdated()" type="checkbox" name="" id="" value="true">
                             <a @click="showPrivacyPolicy">Privacy Policy</a>
                          <span  class="error-message" v-if="this.errors['term2']">{{this.errors['term2']}}</span>

                          </div>

                           <div class="form-group col-md-12" >
                              <input v-model="termsCallToAction" @change="checkSomeCheckUpdated()" type="checkbox" name="" id="" value="true">
                              <a @click="showCallToActionTerms">Call to Action Terms</a>    
                          <span  class="error-message" v-if="this.errors['term3']">{{this.errors['term3']}}</span>
                          </div>

                        </div>
                      </div>
                      <div class="form-group col-md-12 text-center">
                        
                        <button class="btn btn-windowSignIn" :loading="processing" :disabled="processing"  @click="loader = 'loading4'">Connect Stripe</button>
                      </div>
                    </div>

                  </div>
                </div>
              </form>

						</div>

				</div>
			</div>


        <v-layout row justify-center>
      <v-dialog v-model="dialog" fullscreen hide-overlay transition="dialog-bottom-transition">
        <v-card>
          <v-toolbar dark color="primary">
            <v-btn icon dark @click="dialog = false">
              <v-icon>close</v-icon>
            </v-btn>
            <v-toolbar-title>{{ titleDialog }}</v-toolbar-title>
          </v-toolbar>
          <component v-bind:is="componentDialog"></component>
        </v-card>
      </v-dialog>
    </v-layout>

		</div>


</template>

<script>

import { auth, fireStore, firebaseTimestamp } from "../firebase/init";
import utils from "../firebase/utils";


import PrivacyPolicy from "./PrivacyPolicy";
import ContentCreator from "./ContentCreator";
import LicenseAgreement from "./LicenseAgreement";
import CommunityAgreement from "./CommunityAgreement";

import CallToActionTerms from "./CallToActionTerms";

export default {
  data: () => {
    return {
      privacyPolicy: false,
      termsCreator: false,
      dialog: false,
      termsCallToAction: false,
      checkAll: false,
      titleDialog: "",
      componentDialog: null,
      rules: {
        required: value => !!value || "Required.",
        email: value => {
          const pattern = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
          return pattern.test(value) || "Invalid e-mail.";
        }
      },
      processing: false,
      errors:{},
      clientId:"",
    };
  },
  components: {
    PrivacyPolicy
  },
  created() {
  },
  mounted(){

     fireStore
         .collection(utils.settingsCollection)
        .limit(1)
        .get()
        .then(querySnapshot =>{
          querySnapshot.forEach(snapShot => {
            let settings=snapShot.data()
              console.log('Settings',settings);

             if(settings.is_stripe_live == "true" || settings.is_stripe_live==true){
                 this.clientId=settings.stripe_live_client_id
             }
            else if(settings.is_stripe_live == "false" || settings.is_stripe_live==false){
                 this.clientId=settings.stripe_test_client_id
            }else{
                 this.clientId=settings.stripe_live_client_id
            }
          });

        });

    


  },
  methods: {
    doSignUpContentCreator() {
      // if (this.rules.email(this.email) == "Invalid e-mail.") {
      //   this.showToast("Invalid Email");
      // }
      let errorFound=false
      this.errors={}
      if (!this.privacyPolicy) {
        this.errors['term2']="Please check privacy polciy"
        errorFound=true
      }
      if (!this.termsCreator) {
        this.errors['term1']="Please Check Content Creator Terms"
        errorFound=true
      
      }
      if (!this.termsCallToAction) {
        this.errors['term3']="Please Check Call to Action Terms"
        errorFound=true

      }
      if(errorFound){
                
        this.processing = false;
        this.$forceUpdate();
        return 
      }
      this.processing = true;

      // FIXME it should be configurable from admin page
      // change those to live
      //let connect_client_id="ca_F90HyKuBsdziUICmQ5bW9gSQCY9lMmaY"
      //let connect_client_id="ca_F90HDO14vD97St5ir3scNmlL8b2DXiD1"

      
      window.location = "https://connect.stripe.com/oauth/authorize?response_type=code&client_id="+this.clientId+"&scope=read_write"
      


      // this.$store
      //   .dispatch("signUpContentCreator", { email: this.email })
      //   .then(data => {
      //     if (data.error) {
      //       this.processing = false;
      //       this.showToast("Invalid Login. Please Login again");
      //       this.$router.push({ name: "Login" });
      //     } else {
      //       this.processing = false;
      //       this.showToast("Success");
      //       this.$router.push({ name: "MyChannels" });
      //     }
      //   });
    },
    showPrivacyPolicy() {
      this.titleDialog = "Privacy Policy";
      this.componentDialog = PrivacyPolicy;
      this.dialog = true;
    },
    showCallToActionTerms() {
      this.titleDialog = "Excluzeev Call To Action Terms";
      this.componentDialog = CallToActionTerms;
      this.dialog = true;
    },

    showContentCreatorTerms() {
      this.titleDialog = "Terms Of Service For Creators";
      this.componentDialog = ContentCreator;
      this.dialog = true;
    },
    updateCheckall() {
      console.log(this.checkAll);
      if (this.checkAll == "true") {
        console.log("Inside checkAll if");
        this.privacyPolicy = "true";
        this.termsCreator = "true";
        this.termsCallToAction = "true";
      }
    },
    checkSomeCheckUpdated() {
      if (this.privacyPolicy != "true") {
        this.checkAll = "";
        return;
      }
      if (this.termsCreator != "true") {
        this.checkAll = "";
        return;
      }
      if (this.termsCallToAction != "true") {
        this.checkAll = "";
        return;
      }
      this.checkAll = "true";
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
.error-message{
    font-size: 17px;
    display: block;
    color: #f00;
    text-align: left;
    padding-left: 10px;
    padding-top: 5px;

}
.non-specific-error-cont{
    padding: 5px;
    color: red;
}
.non-specific-error{

}
.h2{
  padding: 0 !important;
  line-height: 1;
  margin-bottom: 0;

}
#becomeCCModal .btn-windowSignIn, 
#becomeCCModal .btn-windowSignIn:hover,
#becomeCCModal .btn-windowSignIn:focus{
  padding:15px 20px;
}
@media only screen and (min-width: 992px){
  #becomeCCModal h2{font-size:30px;}
}
@media only screen and (max-width: 991px){
  #becomeCCModal h2{font-size:26px;}
}
@media only screen and (max-width: 440px){
  #becomeCCModal a{font-size:16px;}
  #becomeCCModal h2{font-size:22px;}
}
</style>
