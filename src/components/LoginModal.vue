<template>
  
		 <!-- Modal for sign in -->
		<div class="modal fade bd-example-modal-xl" id="signInModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-xl modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<!-- <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5> -->
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">Close</span>
						</button>
					</div>
					<div class="modal-body text-center">
						<h2>Welcome back.</h2>
						<div class="clearfix"></div>
						<p>Sign in to create or join communities, and to explore the popular and upcoming excluzeev communities and interact with the fans/stars.</p>

              	<div class="form-row " v-if="this.errors['error']">
								<div class="form-group col-md-12 non-specific-error-cont">
                <span  class="non-specific-error" id="non-specific-error"  >{{this.errors['error']}}</span>
								</div>
							</div>
							<div class="form-row">
								<div class="form-group col-md-12 margin_bottom_none">
									<div class="form-row margin_bottom_none">
										<div class="form-group col-md-9 margin_bottom_none">
											<div class="form-row margin_bottom_none">
												<div class="form-group col-md-12" >
													<span class="head"></span>
													<span class="body"></span>
													<input type="name" class="form-control" id="userNameOrEmail" v-model="email" placeholder="Please enter email or username" >
                          <span  class="error-message" id="email_err" v-if="this.errors['email']">{{this.errors['email']}}</span>

                      	</div>
												<div class="form-group col-md-12">
													<span><i class="fa fa-lock"></i></span>
													<input type="password" class="form-control" id="userPassword" v-model="password" placeholder="Please enter password" >
																		<span  class="error-message" id="password_err" v-if="this.errors['password']">{{this.errors['password']}}</span>
                   			</div>
											</div>
										</div>
										<div class="form-group col-md-3 text-left">
                      
											<button class="btn btn-windowSignIn" :loading="processing" :disabled="processing"  @click="doLogin()">Sign in</button>
										</div>
									</div>

								</div>
							</div>
						<div class="clearfix"></div>
						<a href="#" class="forgor_psw_link" data-toggle="modal" data-target="#forgotPasswordModal" >Forgot password?</a><br><br>

						<!-- <a href="#" class="forgor_psw_link" @click="goForgotPassword()">Forgot password?</a><br><br> -->

						<div class="clearfix"></div>
						<p>Or sign in with</p><br>
						<div class="clearfix"></div>
						<div class="signIn-btns">
							<a href="javascript://" :loading="processing" :disabled="processing" @click="signInGmail" class="btn-signInWithGoogle"><img src="../assets/Images/google_icon.png">Google</a>
							<a href="javascript://" :loading="processing" :disabled="processing" @click="signInFb" class="btn-signInWithFacebok"><img src="../assets/Images/facebook_icon.svg">Facebook</a>
						</div>
						<br>
						<br>
						<div class="clearfix"></div>
						<p class="already-have-an-account">New to excluzeev? <a href="#" @click="goSignup()">Create an account now!</a></p>
					</div>

				</div>
			</div>
		</div>


</template>

<script>


  import RegisterStoreModule from "../mixins/RegisterStoreModule";
import authModule from "../store/auth/auth";
import LicenseAgreement from "../components/LicenseAgreement";
import PrivacyPolicy from "../components/PrivacyPolicy";
import CallToActionTerms from "../components/CallToActionTerms";
import axios from "axios";

// import { VueReCaptcha } from "vue-recaptcha-v3";
//
// // For more options see below
// Vue.use(VueReCaptcha, {
//   siteKey: "6LcwXpkUAAAAAMRYzY4mULgEmyBwpDnKRt1leWtC",
//   loaderOptions: {
//     useRecaptchaNet: true,
//     autoHideBadge: true
//   }
// });

export default {
  data: () => {
    return {
      email: "",
      password: "",
      termsDialog: false,
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
      toastText: "Login Success",
      errors:{},
    };
  },
  components: {},
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
    goSignup(){
          $("#signInModal").modal("hide"); // Hide the signin modal box      
      setTimeout(() => {
          this.$router.push({ name: "Home" });
        $("#signUpModal").modal("show"); // show the signup modal box

      }, 1000);

    },

    signInFb(){
     
       let loader = this.$loading.show({
          // Pass props by their camelCased names
          canCancel: true, // default false
          color: '#000000',
          width: 64,
          height: 64,
          backgroundColor: '#ffffff',
          opacity: 0.5,
          zIndex: 999,
          loader: "dots"
        },{
          // Pass slots by their names
        });
 
      this.$store.dispatch("auth/signInFb")
          .then(newData => {
            //console.log("Res",newData);
             
            if (newData.error) {
              this.processing = false;
              if (newData.code == "auth/user-not-found") {
                // this.showToast("User not found.");
                this.errors['error']="User not found";
              } else {
                // this.showToast("Email / Password is Invalid");
                this.errors['error']="Email / Password is Invalid";
              }
                
              loader.hide();

            } else {
              this.processing = false;
              this.showToast("Sign in successfully");
              setTimeout(() => {

                loader.hide();

                $("#signInModal").modal("hide"); // Hide the signin modal box
                this.$router.push({ name: "Home" });
              }, 1000);
                
               
            }
                
          });

    },
    signInGmail(){
     
       let loader = this.$loading.show({
          // Pass props by their camelCased names
          canCancel: true, // default false
          color: '#000000',
          width: 64,
          height: 64,
          backgroundColor: '#ffffff',
          opacity: 0.5,
          zIndex: 999,
          loader: "dots"
        },{
          // Pass slots by their names
        });
 
      this.$store.dispatch("auth/signInGmail")
          .then(newData => {
            //console.log("Res",newData);
             
            if (newData.error) {
              this.processing = false;
              if (newData.code == "auth/user-not-found") {
                // this.showToast("User not found.");
                this.errors['error']="User not found";
              } else {
                // this.showToast("Email / Password is Invalid");
                this.errors['error']="Email / Password is Invalid";
              }
                
              loader.hide();

            } else {
              this.processing = false;
              this.showToast("Sign in successfully");
              setTimeout(() => {

                loader.hide();

                $("#signInModal").modal("hide"); // Hide the signin modal box
                this.$router.push({ name: "Home" });
              }, 1000);
                
               
            }
                
          });

    },
    doLogin() {
      console.log("Clicked login");
      this.errors={};
      let errorFound=false;
      if (!this.email) {
        this.errors['email']="Email address is required";
        errorFound=true;
        this.processing = false;
      }
     
      if (!this.password) {
        this.processing = false;
        errorFound=true;
        this.errors['password']="Required password";
      }

      if(errorFound){
        return;
      }

      if (this.email && this.password ) {
        this.processing = true;
        this.$store
          .dispatch("auth/loginUser", {
            email: this.email,
            password: this.password
          })
          .then(newData => {

              
            if (newData.error) {
              this.processing = false;
              if (newData.code == "auth/user-not-found") {
                // this.showToast("User not found.");
                this.errors['error']="User not found";
              } else {
                // this.showToast("Email / Password is Invalid");
                this.errors['error']="Email / Password is Invalid";
              }
            } else {
              this.processing = false;
              this.showToast("Sign in successfully");
              setTimeout(() => {
                $("#signInModal").modal("hide"); // Hide the signin modal box
                this.$router.push({ name: "Home" });
              }, 1000);
            }
            
          });
      } else{
        this.errors['error']="Invalid email/password";
        this.processing=false
      }
    },
    goRegistration() {
      this.$router.replace({ name: "Registration" });
    },
    goForgotPassword() {
      this.$router.push({ name: "ForgotPassword" });
    },
    showPrivacyPolicy() {
      this.titleDialog = "Privacy Policy";
      this.componentDialog = PrivacyPolicy;
      this.termsDialog = true;
    },
    showCallToActionTerms() {
      this.titleDialog = "Excluzeev Call To Action Terms";
      this.componentDialog = CallToActionTerms;
      this.termsDialog = true;
    },
    showExcluzeevTerms() {
      this.titleDialog = "Excluzeev Terms";
      this.componentDialog = LicenseAgreement;
      this.termsDialog = true;
    },
    recaptchaCallback(token) {
      this.processing = true;
      axios
        .post(
          "https://us-central1-trenstop-2033f.cloudfunctions.net/checkCaptcha",
          {
            token: token
          }
        )
        .then(response => {
          // console.log(response);
          if (!response.data.error) {
            this.doLogin();
          } else {
            this.showToast("Sign in Failed");
            this.processing = false;
          }
        })
        .catch(() => {
          this.processing = false;
        });
    },
    isHuman() {
      if (
        this.rules.email(this.email) != "Invalid e-mail." &&
        this.rules.required(this.password) != "Required."
      ) {
        this.processing = true;
        this.$refs.invisibleRecaptcha1.execute();
      } else {
        this.showToast("Invalid Email / Password");
        this.processing = false;
      }
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
</style>
