<template>

 <div class="container " >
  <div class="myProfile_page">
    <div class="form-row text-center m-1">
      <div class="col-lg-1"></div>
      <div class="col-lg-10 profile-bg">
       <img src="../assets/Images/default_user_profile.png" class="rounded-circle profile-img" alt="Cinque Terre">
     </div>

     <div class="col-lg-1"></div>
   </div>

   <div class="form-row m-1">
     <div class="col-lg-1"></div>
       <div class="col-lg-5 ">
         <div class="data-label">
          First Name
        </div>
      </div>

      <div class="col-lg-5">
       <div class="data-value">
        {{userData.firstName}}
      </div>
    </div>
  </div>

  <div class="form-row m-1">
     <div class="col-lg-1"></div>
     <div class="col-lg-5">
       <div class="data-label">
        Last Name
      </div>
    </div>

    <div class="col-lg-5">
      <div class="data-value">
        {{userData.lastName}}
      </div>
    </div>
  </div>

  <div class="form-row m-1">
     <div class="col-lg-1"></div>
     <div class="col-lg-5 ">
      <div class="data-label">
        Email
      </div>
    </div>

    <div class="col-lg-5 ">
      <div class="data-value">
        {{userData.email}}
      </div>
    </div>
  </div>

<div class="form-row m-1">
 <div class="col-lg-1"></div>
 <div class="col-lg-5 ">
   <div class="data-label">
    Content Creater
  </div>
</div>

<div class="col-lg-5 data-value">
  <span v-if="userData.isContentCreator" class="badge badge-pill badge-success">Yes</span>
  <span v-else class="badge badge-pill badge-danger">NO</span>                
</div>
</div>

<div class="form-row m-1">      
 <div class="col-lg-1">
 </div>
 <div class="col-lg-5 profile-actions">

  <span class="response-msg" v-if="snackbar">{{toastText}}</span>
</div>
<div class="col-lg-5 profile-actions text-right">

  <button class="btn btn-primary" :loading="processing" :disabled="processing" @click="sendResetPasswordLink">Reset password</button>

</div>

<div class="col-lg-1"></div>
</div>


<div class="form-row m-1">
 <div class="col-lg-1">
 </div>
 <div class="col-lg-5 profile-actions">

 </div>
 <div class="col-lg-5 profile-actions text-right">


 </div>

 <div class="col-lg-1"></div>
</div>


</div>
</div> 

</template>

<script>

  import store from "../store/index";

  import RegisterStoreModule from "../mixins/RegisterStoreModule";
  import authModule from "../store/auth/auth";
  import axios from "axios";

  export default {
    name: "MyProfile",
    data: () => {
      return {
        userData: store.getters.getFUser,
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
      setTimeout( () =>{
       this.userData=store.getters.getFUser,
       console.log("User dta",this.userData)
     },2000)

      this.registerStoreModule("auth", authModule);
    },

    methods:{

      sendResetPasswordLink(){

        if (this.rules.email(this.userData.email) != "Invalid e-mail.") {
          this.processing = true;

          this.$store
          .dispatch("auth/resetPassword", { email: this.userData.email })
          .then(data => {
            if (data.error) {
              this.toastText =
              "Password reset email  been sent to your email";
              this.snackbar = true;
              this.processing = false;
            } else {
              this.toastText = data.message;
              this.snackbar = true;
              this.processing = false;
            }
          });
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

  .profile-img{
    width: 100px;
    height: 100px;
  }
  .data-label{
    font-size: 25px;
    font-weight: bold;
    border-left: 1px solid #d2c8c8;
  }

  .data-value{

    background: #f7f7f7;
    font-size: 25px;
  }

  .profile-bg{
    background: #f7f7f7;
    padding:25px;
  }
  .profile-actions{
    padding-top:10px;
    background: #f7f7f7;
    padding-bottom:10px;
  }
  .response-msg{
    color: green;
    font-size: 21px;

  }
  @media only screen and (max-width:767px){
    .data-label{font-size:21px;padding:5px }
    .data-value{font-size:21px!important;padding:10px}
  }
  .m-1 .col-lg-1,.m-1 .col-lg-5{padding:0}
  .myProfile_page{margin-bottom: 50px;}
</style>
