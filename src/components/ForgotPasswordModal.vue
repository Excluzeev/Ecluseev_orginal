<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">

  		<!-- Model for fogot password -->
		<div class="modal fade bd-example-modal-xl" id="forgotPasswordModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-xl modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header text-center">
						<!-- <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5> -->
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">Close</span>
						</button>
					</div>
					<div class="modal-body text-center">
						<h2>Let us revive you!</h2>
						<div class="clearfix"></div>
						<p>We’ll help you reclaim your glory. Just follow the instructions mentioned below.</p>

              <form @submit.prevent="isHuman">

              <div class="form-row" v-if="snackbar">
								<div class="form-group col-md-12 non-specific-error-cont">
                <span  class="non-specific-error" id="non-specific-error"  >{{toastText}}</span>
								</div>
							</div>

							<div class="form-row">
								<div class="form-group col-md-12">
									<span class="head"></span>
									<span class="body"></span>
									<input type="email" class="form-control" v-model="email"   id="userNameOrEmail" placeholder="Please enter email or username">

              		<div class="clearfix"></div>
									<br>
									<br>
									<br>

									<button class="btn btn-send-me-a-revive-link" type="submit" :loading="processing" :disabled="processing" @click="loader = 'loading4'">Send me a revive link</button>
									<br><br><br><br>
								</div>
							</div>
						<div class="clearfix"></div>
              </form>
					</div>

				</div>
			</div>
		</div>
		<!-- End -->



</template>

<script>
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import authModule from "../store/auth/auth";
import axios from "axios";

import Vue from "vue";
// import { VueReCaptcha } from "vue-recaptcha-v3";

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
      processing: false,
      rules: {
        required: value => !!value || "Required.",
        email: value => {
          const pattern = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
          return pattern.test(value) || "Invalid e-mail.";
        }
      },
      snackbar: false,
      toastText: ""
    };
  },
  mixins: [RegisterStoreModule],
  props: {},
  created() {
    this.registerStoreModule("auth", authModule);
  },
  methods: {
    doSendEmail() {
      if (this.rules.email(this.email) != "Invalid e-mail.") {
        this.processing = true;
        this.$store
          .dispatch("auth/resetPassword", { email: this.email })
          .then(data => {
            if (data.error) {
              this.toastText =
                "An password reset email  been sent to your email";
              this.snackbar = true;
              this.processing = false;
            } else {
              this.toastText = data.message;
              this.snackbar = true;
              this.processing = true;
              // Go to home page and prompt for login
              this.goLogin();
              // this.$router.push("/login");
            }
          });
      } else {
        this.toastText = "Invalid Email";
        this.snackbar = true;
        this.processing = false;
      }
    },

    goLogin() {
      $("#signInModal").modal("hide"); // show the signup modal box
      $("#forgotPasswordModal").modal("hide"); // Hide the signin modal box      
      setTimeout(() => {
        this.$router.push({ name: "Home" });
        $("#signInModal").modal("show"); // show the signup modal box

      }, 2000);


      // this.$router.back();
    },
    recaptchaCallback(token) {
      this.processing = true;
      //this.doSendEmail(); // Send forgot password reset email without recaptch //FIXME
      // Disabled for testing purpose
     
      axios
        .post(
          "https://us-central1-trenstop-2033f.cloudfunctions.net/checkCaptcha",
          {
            token: token
          }
        )
        .then(response => {

          console.log("Recaptcha verfication done");
          if (!response.data.error) {
            this.doSendEmail();
          } else {
            this.showToast("Verification failed");
            this.processing = false;
          }
        })
        .catch(() => {
          this.processing = false;
          this.showToast("Something went wrong");
        });
        
    },
    isHuman() {
      if (this.rules.email(this.email) != "Invalid e-mail.") {

        this.$parent.executeRecaptcha('forgotComp');

        this.processing = true;
      } else {
        this.toastText = "Invalid Email";
        this.snackbar = true;
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

</style>
