<template>
<!-- model for sign up start-->
		<div class="modal fade bd-example-modal-lg" id="signUpModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<!-- <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5> -->
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true" class="d-none d-md-block">Close</span>
              <v-icon class="d-sm-block d-md-none">close</v-icon>
						</button>
					</div>
					<div class="modal-body text-center">
						<div class="inline-list text-center">
							<!--<h2>Join</h2>-->
							<div class="modal-title_section">
								<img src="../assets/Images/logo_window.png" class="register-logo img-fluid">
                <!--<sup>TM</sup>-->
							</div>
						</div>
						<div class="clearfix"></div>
						<p>Register to create or join communities, and to explore the popular and upcoming excluzeev communities and interact with the fans/stars.</p>

						<form @submit.prevent="isHuman">
							<div class="form-row " v-if="this.errors['error']">
								<div class="form-group col-md-12 non-specific-error-cont">
                <span  class="non-specific-error" id="non-specific-error"  >{{this.errors['error']}}</span>
								</div>
							</div>

							<div class="form-row " v-if="this.showInfo">
								<div class="form-group col-md-12 non-specific-message-cont">
                <span  class="non-specific-message" id=""  >{{this.toastText}}</span>
								</div>
							</div>
							<div class="form-row">
								<div class="form-group col-md-6">
                <span class="head"></span>
                          <span class="body"></span>
									<input v-model="firstName"  type="name" class="form-control" id="firstName" placeholder="Please enter first name">
									<span  class="error-message" id="firstname_err" v-if="this.errors['firstname']">{{this.errors['firstname']}}</span>
              	</div>
								<div class="form-group col-md-6">
							<span class="head"></span>
                          <span class="body"></span>
									<input v-model="lastName"  type="name" class="form-control" id="lastName" placeholder="Please enter last name">
									<span  class="error-message" id="lastname_err" v-if="this.errors['lastname']">{{this.errors['lastname']}}</span>
						
            		</div>

							</div>
							<div class="form-row">
								<div class="form-group col-md-12">
									<span><i class="fa fa-envelope"></i></span>
									<input v-model="email"  type="email" class="form-control" id="email" placeholder="Please enter email address">
									<span  class="error-message" id="email_err"  v-if="this.errors['email']">{{this.errors['email']}}</span>
							
              	</div>
							</div>
							<div class="form-row">
								<div class="form-group col-md-6">
									<span><i class="fa fa-lock"></i></span>
									<input v-model="password" type="password" class="form-control" id="inputPassword" placeholder="Password">
									<span  class="error-message" id="password_err"  v-if="this.errors['password']">{{this.errors['password']}}</span>
							
              	</div>
								<div class="form-group col-md-6">
									<span><i class="fa fa-lock"></i></span>
									<input v-model="cPassword"  type="password" class="form-control" id="inputConfirmPassword" placeholder="Confirm Password">
									<span  class="error-message" id="cpassword_err"  v-if="this.errors['cpassword']">{{this.errors['cpassword']}}</span>
							
              	</div>

							</div>
							<div class="form-row terms-items-cont">

                <div class="terms-text">
    									<p>By clicking on “Sign Up” button, I agree to</p>

                </div>
								<div class="form-group col-md-6 col-sm-6 col-xs-12 text-left terms-items d-flex">

                      <input class="" v-model="checkAll" type="checkbox" name="" id="" value="true">
                  <label>
                      <a @click="showExcluzeevTerms">Terms</a>
                      <a @click="showPrivacyPolicy">Privacy Policy</a>
                      <a @click="showCallToActionTerms">Call to Action Terms</a>
                      <a @click="showCommunityAgreement">Community Member Agreement</a>    
                  </label>
								</div>
                
								<div class="form-group col-md-6 col-sm-6 col-xs-12  signup-btn-section">
									<button type="submit" class="btn btn-windowSignUp" :loading="processing" :disabled="processing">Sign Up</button>
								</div>
							</div>
						</form>

						<p class="already-have-an-account">Already have an account? 
              
              <a href="#" @click="goLogin">Sign in now!</a></p>

					</div>

				</div>
			</div>

      <v-dialog v-model="termsDialog" fullscreen hide-overlay transition="dialog-bottom-transition">
        <v-card>
          <v-toolbar dark color="primary">
            <v-btn icon dark @click="termsDialog = false">
            <v-icon>close</v-icon>
							<!--<span aria-hidden="true">Close</span>-->
            </v-btn>
            <v-toolbar-title>{{ titleDialog }}</v-toolbar-title>
          </v-toolbar>
          <component v-bind:is="componentDialog"></component>
        </v-card>
      </v-dialog>
      

		</div>
		<!-- End -->
		
		
</template>

<script>
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import authModule from "../store/auth/auth";

import LicenseAgreement from "../components/LicenseAgreement";
import CallToActionTerms from "../components/CallToActionTerms";
import CommunityAgreement from "../components/CommunityAgreement";
import PrivacyPolicy from "../components/PrivacyPolicy";
import axios from "axios";

export default {
  data: () => {
    return {
      firstName: "",
      lastName: "",
      email: "",
      password: "",
      cPassword: "",
      termsDialog: false,
      titleDialog: "",
      componentDialog: null,
      checkAll:false,
      errors:{},
      rules: {
        name: value => {
          const pattern = /^[a-zA-Z ]*$/;
          return pattern.test(value) || "Name cannot contain number";
        },
        required: value => !!value || "Required.",
        counter: value =>
          value.length >= 8 || "Password should be greater than 8 characters",
        email: value => {
          const pattern = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
          return pattern.test(value) || "Invalid e-mail.";
        },
        password: value => {
          const pattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
          return (
            pattern.test(value) ||
            "Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character"
          );
        }
      },
      processing: false,
      toastText: "Registration Success",
      showInfo:false,
    };
  },
  mixins: [RegisterStoreModule],
  props: {},
  created() {
    this.registerStoreModule("auth", authModule);
  },
  beforeDestroy: function() {},
  methods: {
    showToast(msg) {
      this.$toasted.show(msg, {
        theme: "outline",
        position: "top-right",
        duration: 2500
      });
    },
    resetErr(){
      this.errors={};
    },
    doSignUp() {
      
      console.log("Do signup called")
      this.resetErr(); // Reset form validation errors
      let errorFound=false;

      if (this.firstName.isEmpty || this.firstName == "") {
        this.errors['firstname']="Firstname is required";
        errorFound=true;
        this.processing = false;
      }
       if (this.lastName.isEmpty || this.lastName == "") {
        this.errors['lastname']="lastname is required";
        errorFound=true;
        this.processing = false;
      }
      if (this.rules.email(this.email) == "Invalid e-mail.") {
        this.errors['firstname']="Invalid email address";
        errorFound=true;
        this.processing = false;
      }
     
      if (this.password.isEmpty || this.password.length < 8) {
        this.processing = false;
        errorFound=true;
        this.errors['password']="Password must be greater than 8 digits";
      }
      if (this.password != this.cPassword) {
        this.processing = false;
        errorFound=true;
        this.errors['cpassword']="Password doesn't match";
      }

      if (this.checkAll == false) {
        this.processing = false;
        errorFound=true;
        this.errors['error']="Please Agree to our terms and policies!!";
      }

      if(errorFound == true){
        return;
      }

      this.$store
        .dispatch("auth/signUpUser", {
          email: this.email,
          password: this.password,
          firstName: this.firstName,
          lastName: this.lastName
        })
        .then(data => {
          if (data.error) {
            this.errors['error']=data.message;
            // this.showToast(data.message);
            this.processing = false;
          } else {
            this.$store.dispatch("auth/checkUser").then(userRecord => {
              if (userRecord.exists) {

                this.showInfo=true
                this.toastText="A verification link sent to your email account. Please verify your email address."
                
                setTimeout(function(){
                    $("#signUpModal").modal("hide"); // Hide the signin modal box
                    this.showToast("Registration successful and verification email sent!!");
                    this.$router.push("/");
                },2000)

              } else {
                // this.showToast("Unknown error please try again.");
                this.errors['error']="Unknown error please try again.";
                this.processing = false;
              }
            });
          }
        });
    },
    goLogin() {
      //this.$router.replace({ name: "Login" });
      $("#signUpModal").modal("hide"); // Hide the signup modal box
      setTimeout(() => {
          // this.$router.push({ name: "Home" });
          $("#signInModal").modal("show"); // Show the signin modal box
      }, 1000);

    },
    showPrivacyPolicy() {
      this.titleDialog = "Privacy Policy";
      this.componentDialog = PrivacyPolicy;
      this.termsDialog = true;
    },
    showExcluzeevTerms() {
      console.log("Called show excluzeev terms");
      this.titleDialog = "Excluzeev Terms";
      this.componentDialog = LicenseAgreement;
      this.termsDialog = true;
    },
    showCallToActionTerms() {
      this.titleDialog = "Excluzeev Call To Action Terms";
      this.componentDialog = CallToActionTerms;
      this.termsDialog = true;
    },
    showCommunityAgreement() {
      this.titleDialog = "Excluzeev Community Member Agreement";
      this.componentDialog = CommunityAgreement;
      this.termsDialog = true;
    },
    recaptchaCallback(token) {
      this.processing = true;
      // Disabled for testing purpose
      //this.doSignUp(); // Signup without recaptcha //FIXME

      
      axios
        .post(
          "https://us-central1-trenstop-2033f.cloudfunctions.net/checkCaptcha",
          {
            token: token
          }
        )
        .then(response => {
          if (!response.data.error) {
            this.doSignUp();
          } else {
            this.showToast("Sign up Failed");

            this.processing = false;
          }
        })
        .catch(() => {
          this.processing = false;
          this.showToast("Sign up Failed");

        });
       
    },
    isHuman() {
      this.resetErr(); // Reset form validation errors
      let errorFound=false;
      if (this.firstName.isEmpty || this.firstName == "") {
        this.errors['firstname']="Firstname is required";
        errorFound=true;
        this.processing = false;
      }
       if (this.lastName.isEmpty || this.lastName == "") {
        this.errors['lastname']="lastname is required";
        errorFound=true;
        this.processing = false;
      }
      if (this.rules.email(this.email) == "Invalid e-mail.") {
        this.errors['firstname']="Invalid email address";
        errorFound=true;
        this.processing = false;
      }
     
      if (this.password.isEmpty || this.password.length < 8) {
        this.processing = false;
        errorFound=true;
        this.errors['password']="Password must be greater than 8 digits";
      }
      if (this.password != this.cPassword) {
        this.processing = false;
        errorFound=true;
        this.errors['cpassword']="Password doesn't match";
      }

      if(errorFound== true){
        console.log("Error occurred")
        return;
      }
        console.log("Recaptcha requested")
        this.$parent.executeRecaptcha('registerComp');

      

    }
  }
};
</script>

<style scoped>
.padding {
  padding: 10px;
}
.signup-holder {
  padding: 20px;
}
.signup-continue-text {
  font-size: 16px;
  font-weight: 400;
  letter-spacing: 0.1px;
  line-height: 1.5;
}
.signup-text {
  color: #202124;
  padding-bottom: 0;
  font-family: "Google Sans", "Noto Sans Myanmar UI", arial, sans-serif;
  font-size: 24px;
  font-weight: 400;
  line-height: 1.3333;
  margin-bottom: 0;
  margin-top: 0;
}

.quick-sand-font-b {
  font-family: "Quicksand", sans-serif;
  font-weight: 700;
}
.quick-sand-font {
  font-family: "Quicksand", sans-serif;
  font-weight: 500;
}

.terms-items-cont{
  display: flex;
  align-items: center;
  padding-left:20px;
}
.terms-text{
font-size: 17px;  
}
.terms-items{
      padding: 0 !important;
    margin: 0 !important;
}
.terms-items a{ 
  font-size: 14px;
  
}
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

.non-specific-message-cont{
    padding: 5px;
    color: green;
}
.non-specific-error{

}
.btn-windowSignUp,.btn-windowSignUp:hover,.btn-windowSignUp:focus
{
  font-size: 23px;
}
</style>
