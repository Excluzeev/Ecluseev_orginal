<template>

   <div class="container">
        
        <div class="form-row text-center">
            <div class="col-lg-2"></div>
            <div class="col-lg-8 profile-bg">
                 <img src="../assets/Images/commu_image.png" class="rounded-circle" alt="Cinque Terre">  
            </div>

            <div class="col-lg-2"></div>
        </div>
        
        <div class="form-row m-1">
           <div class="col-lg-2"></div>
           <div class="col-lg-4 data-label">
                First Name
           </div>

           <div class="col-lg-4 data-value">
                {{userData.firstName}}
           </div>
        </div>

        <div class="form-row m-1">
           <div class="col-lg-2"></div>
           <div class="col-lg-4 data-label">
                Last Name
           </div>

           <div class="col-lg-4 data-value">
                {{userData.lastName}}
           </div>
        </div>

        <div class="form-row m-1">
           <div class="col-lg-2"></div>
           <div class="col-lg-4 data-label">
                Email
           </div>

           <div class="col-lg-4 data-value">
                {{userData.email}}
           </div>
        </div>

        <div class="form-row m-1">
           <div class="col-lg-2"></div>
           <div class="col-lg-4 data-label">
                Conent Creater
           </div>

           <div class="col-lg-4 data-value">
                <span v-if="userData.isContentCreator" class="badge badge-pill badge-success">Yes</span>
                <span v-else class="badge badge-pill badge-danger">NO</span>                
           </div>
        </div>

        <div class="form-row mt-4">      
           <div class="col-lg-2"></div>
           <div class="col-lg-8 profile-actions text-right">
            <span class="badge badge-pill badge-danger">Reset Password</span>

           
           </div>

           <div class="col-lg-2"></div>
        </div>


    </div> 
  
</template>

<script>

  import store from "../store/index";

  export default {
    name: "MyProfile",
     data: () => {
        return {
            userData: store.getters.getFUser,
        };
     },
    

  };
</script>

<style scoped>

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
    }
    .profile-actions{
        padding-top:10px;
        background: #f7f7f7;
        padding-bottom:10px;
    }
</style>
