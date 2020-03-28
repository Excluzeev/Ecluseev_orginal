<template>
<!-- model for sign up start-->
		<div class="modal fade bd-example-modal-lg" id="signUpModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<!-- <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5> -->
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">Close</span>
						</button>
					</div>
					<div class="modal-body text-center">
						<div class="inline-list text-center">
							<h2>Join</h2>
							<div class="modal-title_section">
								<img src="../assets/Images/logo_window.svg"><sup>TM</sup>
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
									<input v-model="firstName"  type="name" class="form-control" id="firstName" placeholder="Please enter first name">
									<span  class="error-message" id="firstname_err" v-if="this.errors['firstname']">{{this.errors['firstname']}}</span>
              	</div>
								<div class="form-group col-md-6">
							
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
    									By clicking on “Sign Up” button, I agree to

                </div>
								<div class="form-group col-md-8 text-left terms-items">

                    <input v-model="checkAll" type="checkbox" name="" id="" value="true">
                    <a @click="showExcluzeevTerms">Terms</a>
                    <a @click="showPrivacyPolicy">Privacy Policy</a>
                    <a @click="showCallToActionTerms">Call to Action Terms</a>    

								</div>
                
								<div class="form-group col-md-4 text-right">
                                <!-- 
                                  <vue-programmatic-invisible-google-recaptcha
                                  ref="invisibleRecaptcha1"
                                  sitekey="6LcwXpkUAAAAAMRYzY4mULgEmyBwpDnKRt1leWtC"
                                  elementId="invisibleRecaptcha1"
                                  badgePosition="'left'"
                                  :showBadgeMobile="false"
                                  :showBadgeDesktop="false"
                                  @recaptcha-callback="recaptchaCallback"
                                ></vue-programmatic-invisible-google-recaptcha>
                                -->
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
							<span aria-hidden="true">Close</span>
            </v-btn>
            <v-toolbar-title>{{ titleDialog }}</v-toolbar-title>
          </v-toolbar>
          <component v-bind:is="componentDialog"></component>
        </v-card>
      </v-dialog>
      

		</div>
		<!-- End -->
		
		

<!--
  <div style="height:100%" class>
    <v-container text-xs-center fill-height>
      <v-layout align-center row wrap justify-center>
        <v-flex xs12 sm8 md6>
          <v-card class="elevation-5 signup-holder text-xs-center">
            <img
              style="width: 30%;"
              alt="Excluzeev
            logo"
              src="../../assets/excluzeev_bottom_text.png"
            />
            <div class="signup-text quick-sand-font">Sign up</div>
            <div class="signup-continue-text">Continue to Excluzeev</div>
            <v-card-text>
              <v-form class="lighten-1" @submit.prevent="isHuman">
                <v-layout row>
                  <v-text-field
                    style="margin-right: 5px;"
                    name="firstname"
                    label="FirstName"
                    type="text"
                    v-model="firstName"
                    :rules="[rules.required, rules.name]"
                  ></v-text-field>
                  <v-text-field
                    style="margin-left: 5px;"
                    name="lastname"
                    label="LastName"
                    type="text"
                    v-model="lastName"
                    :rules="[rules.required, rules.name]"
                  ></v-text-field>
                </v-layout>
                <v-text-field
                  name="login"
                  label="Email"
                  type="text"
                  v-model="email"
                  :rules="[rules.required, rules.email]"
                ></v-text-field>
                <v-layout row>
                  <v-text-field
                    style="margin-right: 5px;"
                    id="password"
                    name="password"
                    label="Password"
                    type="password"
                    v-model="password"
                    :rules="[rules.required, rules.password]"
                  ></v-text-field>
                  <v-text-field
                    style="margin-left: 5px;"
                    id="cpassword"
                    name="cpassword"
                    label="Confirm Password"
                    type="password"
                    v-model="cPassword"
                    :rules="[rules.required, rules.password]"
                  ></v-text-field>
                </v-layout>

                <v-layout row>
                  <v-checkbox v-model="checkAll" color="blue lighten-1" value="true">
                    <template v-slot:label>
                      <div>
                        Agree to &nbsp;
                        <a @click="showExcluzeevTerms">Terms</a>,&nbsp;
                        <a @click="showPrivacyPolicy" v-on="on">Privacy Policy</a>,&nbsp;
                        <a @click="showCallToActionTerms" v-on="on">Call to Action Terms</a>&nbsp;
                      </div>
                    </template>
                  </v-checkbox>
                </v-layout>

                <div class="text-xs-left grey--text" style="font-size: 12px"></div>

                <vue-programmatic-invisible-google-recaptcha
                  ref="invisibleRecaptcha2"
                  sitekey="6LcwXpkUAAAAAMRYzY4mULgEmyBwpDnKRt1leWtC"
                  elementId="invisibleRecaptcha2"
                  badgePosition="'left'"
                  showBadgeMobile="false"
                  showBadgeDesktop="false"
                  @recaptcha-callback="recaptchaCallback"
                ></vue-programmatic-invisible-google-recaptcha>

                <div class="text-xs-right quick-sand-font-b" style="padding: 0px;">
                  <v-btn
                    class="white--text quick-sand-font-b"
                    color="blue lighten-1"
                    type="submit"
                    :loading="processing"
                    :disabled="processing"
                    @click="loader = 'loading4'"
                  >
                    Sign up
                    <template v-slot:loader>
                      <span class="custom-loader">
                        <v-icon light>cached</v-icon>
                      </span>
                    </template>
                  </v-btn>
                </div>
              </v-form>
              <div class="padding"></div>
              <div class="text-xs-left quick-sand-font">
                Have an account? &nbsp;
                <a>
                  <span class color="blue lighten-1" @click="goLogin">Sign in</span>
                </a>
              </div>
            </v-card-text>
          </v-card>
          <div
            class="text-xs-right"
            style="padding-right: 20px;padding-top: 10px;font-weight: bolder;"
          >
            <strong>By creating account you agree to &nbsp;&nbsp;</strong>
            <a @click="showExcluzeevTerms">Terms</a>

            <a @click="showPrivacyPolicy" style="padding-left: 20px;">Privacy</a>
            <a @click="showCallToActionTerms" style="padding-left: 20px;">Call to Action Terms</a>

            <a
              href="mailto:support@excluzeev.com?subject=Need%20Help"
              style="padding-left: 20px;"
            >Help</a>
          </div>
        </v-flex>
      </v-layout>
      <!\-- <v-snackbar v-model="snackbar" bottom>
        {{ toastText }}
      </v-snackbar>--\>
    </v-container>
    <v-dialog v-model="termsDialog" fullscreen hide-overlay transition="dialog-bottom-transition">
      <v-card>
        <v-toolbar dark color="primary">
          <v-btn icon dark @click="termsDialog = false">
            <v-icon>close</v-icon>
          </v-btn>
          <v-toolbar-title>{{ titleDialog }}</v-toolbar-title>
        </v-toolbar>
        <component v-bind:is="componentDialog"></component>
      </v-card>
    </v-dialog>
  </div>
  -->
</template>

<script>
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import authModule from "../store/auth/auth";

import LicenseAgreement from "../components/LicenseAgreement";
import CallToActionTerms from "../components/CallToActionTerms";
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
      checkAll:[],
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
          this.$router.push({ name: "Home" });
          $("#signInModal").modal("show"); // Show the signin modal box
      }, 1000);

    },
    showPrivacyPolicy() {
      this.titleDialog = "Privacy Policy";
      this.componentDialog = PrivacyPolicy;
      this.termsDialog = true;
    },
    showExcluzeevTerms() {
      this.titleDialog = "Excluzeev Terms";
      this.componentDialog = LicenseAgreement;
      this.termsDialog = true;
    },
    showCallToActionTerms() {
      this.titleDialog = "Excluzeev Call To Action Terms";
      this.componentDialog = CallToActionTerms;
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
