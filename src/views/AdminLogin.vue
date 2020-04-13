<template>
    <div>

        

        <div class="peers ai-s fxw-nw h-100vh login-cont">
          <!--  
          <div class="d-n@sm- peer peer-greed h-100 pos-r bgr-n bgpX-c bgpY-c bgsz-cv" style='background-image: url("../assets/admin/static/images/bg.jpg")'>
            <div class="pos-a centerXY">
              <div class="bgc-white bdrs-50p pos-r" style='width: 120px; height: 120px;'>
                <img class="pos-a centerXY" src="../assets/admin/static/images/logo.png" alt="">
              </div>
            </div>
          </div>
         -->
          <div class="col-12 col-md-4 peer pX-40 pY-80 bgc-white scrollable pos-r" style='min-width: 320px;height:400px;'>
            <h4 class="fw-300 c-grey-900 mB-40 tex-center mt-2">Login</h4>
            <form>

               <div class="form-row " v-if="this.errors['error']">
                    <div class="form-group col-md-12 non-specific-error-cont">
                        <span  class="non-specific-error" id="non-specific-error"  >{{this.errors['error']}}</span>
                    </div>

                </div>



              <div class="form-group">
                <label class="text-normal text-dark">Email</label>
                <input type="email" class="form-control" placeholder="Enter your email address" v-model="email">
                <span  class="error-message" id="email_err" v-if="this.errors['email']">{{this.errors['email']}}</span>
              </div>
              <div class="form-group">
                <label class="text-normal text-dark">Password</label>
                <input type="password" class="form-control" placeholder="Password" v-model="password">
                <span  class="error-message" id="password_err" v-if="this.errors['password']">{{this.errors['password']}}</span>
              </div>
              <div class="form-group">
                <div class="peers ai-c jc-sb fxw-nw text-center">
                  <div class="peer">
                    <button type="button" class="btn btn-primary" loading="processing" :disabled="processing"  @click="doLogin()">Login</button>
                  </div>
                </div>
              </div>
            </form>
          </div>
        </div>



    </div>    
</template>

<script>
  export default {
    name: "AdminLogin",
    data(){

        return{

            email: "",
            password: "",
            errors:[],
            processing: false,
                

        };

    },
    methods:{
    
    showToast(msg) {
      this.$toasted.show(msg, {
        theme: "outline",
        position: "top-right",
        duration: 2500
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
                      }
                      else if(newData.isEmailVerified == false){

                          this.processing = false;
                          this.showToast("Sign in successfully");
                          setTimeout(() => {
                            this.$router.push({ name: "AdminHome" });
                          }, 1000);

                        
                      }
                      else {
                        // this.showToast("Email / Password is Invalid");
                        this.errors['error']="Email / Password is Invalid";
                      }
                    } else {


                      this.processing = false;
                      this.showToast("Sign in successfully");
                      setTimeout(() => {
                        this.$router.push({ name: "AdminHome" });
                      }, 1000);
                    }

              });
        } else{
            this.errors['error']="Invalid email/password";
            this.processing=false
        }

    
       }        


    }
  };



</script>

<style scoped>
    @import "../assets/admin/css/adminstyle.css";

    .login-cont{
        align-items: center;
        justify-content: center;
        background: #f9f9f9;

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


</style>

