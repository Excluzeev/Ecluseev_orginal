<template xmlns:v-slot="http://www.w3.org/1999/XSL/Transform">

    <div class="container">
		<div class="row">
			<div class="offset-md-1 col-md-10 offset-sm-0 col-sm-12">
				<div class="purpose-section">
					<div class="title-section text-center">
						<h3>Keep in Touch with Us </h3>
						<!-- <p>Descrtiption about careers with excluzeev</p> -->

					</div>
					<form>

                      <div
                      v-if="successMessage"
                      class="success-message"
                      v-text="successMessage"></div>
                      <div
                      v-if="errorMessage"
                      class="error-message"
                      v-text="errorMessage"
                      />


						<br>
						<h5 style="text-align:center">Please Enter Your Details</h5>
						<br>
						<div class="form-row">
							<div class="form-group col-md-6">
								<label>First Name <span style="color:red ">*</span></label>
								<input type="name" :class="errors.first_name?'form-control input-border-error':'form-control'" id="firstName" placeholder="Please enter first name" v-model="first_name">
								<div v-if="errors.first_name" class="label-error"><i class="fa fa-info-cirle"></i>&nbsp;{{errors.first_name}}</div>

							</div>
							<div class="form-group col-md-6">
								<label>Last Name <span style="color:red">*</span></label>
								<input type="name" :class="errors.last_name?'form-control input-border-error':'form-control'" id="lastName" placeholder="Please enter last name" v-model="last_name">
								<div v-if="errors.last_name" class="label-error"><i class="fa fa-info-cirle"></i>&nbsp;{{errors.last_name}}</div>

							</div>

						</div>
						<div class="form-row">
							<div class="form-group col-md-12">
								<label>Email <span style="color:red">*</span></label>
								<input type="email" :class="errors.email?'form-control input-border-error':'form-control'" id="email" placeholder="Please enter email address" v-model="email">
								<div v-if="errors.email" class="label-error"><i class="fa fa-info-cirle"></i>&nbsp;{{errors.email}}</div>

							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-md-12">
								<label>Message <span style="color:red"></span></label>
								<textarea v-model="message" :class="errors.message?'form-control input-border-error':'form-control'" id="description" placeholder="Message" rows="5"></textarea>
								<div v-if="errors.message" class="label-error"><i class="fa fa-info-cirle"></i>&nbsp;{{errors.message}}</div>

							</div>


						</div>
						<div class="form-row">

							<div class="form-group col-md-12 text-right">
								&nbsp;&nbsp;
								<button :disabled="isMailProcessing" type="button" class="btn btn-windowSignUp btn-create" @click="sendSupportMail">
									   <template v-if="isMailProcessing">
										  <i style="font-size:20px;" class="fa fa-circle-o-notch fa-spin"></i>Processing
									  </template>
									  <template v-else>
										  Submit
									  </template>
								</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>


</template>

<script>

export default {
  data: () => {
    return {
      	title: "Contact support",
      	errors:{},
	  	first_name:"",
	  	last_name:"",
	  	email:"",
		message:"",
		successMessage:null,
		errorMessage:null,
		isMailProcessing:false,
    };
  },
  created() {

  },
  computed: {

  },
  mounted() {

  },
  methods: {

  	reset_form(){
  		this.first_name=""
		this.last_name=""
		this.email=""
		this.message=""
		this.successMessage=null
		this.errorMessage=null
	},
	sendSupportMail() {

		this.errors=[]
  		console.log("Send email started");
  		//Validation

		let isError=false
		if(this.first_name == ""){
			this.errors['first_name']="This field is required";
			isError=true
		}

		if(this.last_name == ""){
			this.errors['last_name']="This field is required";
			isError=true
		}

		if(this.email == ""){
			this.errors['email']="This field is required";
			isError=true
		}

		if(this.message == ""){
			this.errors['message']="This field is required";
			isError=true
		}

		if(isError){
			this.isMailProcessing=false
			this.$forceUpdate()
			return;
		}


  		this.isMailProcessing=true


        try{
			var queryParams="dest="+this.email
				queryParams+="&subject=Support"
				queryParams+="&username="+this.first_name+" "+this.last_name
				queryParams+="&message="+this.message



            this.$store.dispatch("sendEmail",queryParams).then((resp) => {

                console.log("Signout successful",resp)
				this.isMailProcessing=false

				this.successMessage="Thanks, Successfully sent email to suppot team."

				setTimeout(()=>{
					this.successMessage=null
					this.reset_form()
				},3000)

            }).catch((error,data)=>{
            	 console.log("Error: ",error)
				this.isMailProcessing=false

				this.errorMessage="Sorry, unable to send email. Something went wrong !!!"

				setTimeout(()=>{
					this.errorMessage=null

				},3000)

			})


          }catch(err){
            console.log("Error: ",err)
			this.errorMessage="Sorry, unable to send email. Internal error !!!"

				setTimeout(()=>{
					this.errorMessage=null
				},3000)
          }




    },
  }
};
</script>

<style scoped>
	.btn,.btn:hover,.btn:focus{
			border-radius: 0;
			font-size: 16px;
			box-shadow: 4px 6px 7px #00000029;
			-webkit-box-shadow: 4px 6px 7px #00000029;
			-moz-box-shadow: 4px 6px 7px #00000029;
		}
		.purpose-section{
			border:2px solid #DDD;
			border-radius: 5px;
			margin-bottom: 25px;
		}
		label{color: #29abe2}
		form{padding: 15px;}
		.title-section{
			padding: 15px;
			background-color: #29abe2;
			border-radius: 5px 5px 0 0;
			border:1px solid #29abe2;
		}


    .success-message, .error-message{
        /*padding: 5px;*/
        text-align: center;
        font-size: 16px;
        /*border: 1px solid #f9f9f9;*/
        /*margin-bottom: 5px;*/
    }

    .success-message{
        color:green;
    }
    .error-message{

        color:red;

    }
    .input-error{

        font-size: 1.1rem;
        padding: 5px;
        color: red;

    }
    .input-border-error{
        border-color: red !important;
    }
    .label-error{
        color: red!important;
        font: 16px lato-regular!important;
    }
</style>
