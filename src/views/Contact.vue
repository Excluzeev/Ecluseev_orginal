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
						<br>
						<h5 style="text-align:center">Please Enter Your Details</h5>
						<br>
						<div class="form-row">
							<div class="form-group col-md-6">
								<label>First Name <span style="color:red ">*</span></label>
								<input type="name" class="form-control" id="firstName" placeholder="Please enter first name" v-model="first_name">
							</div>
							<div class="form-group col-md-6">
								<label>Last Name <span style="color:red">*</span></label>
								<input type="name" class="form-control" id="lastName" placeholder="Please enter last name" v-model="last_name">
							</div>

						</div>
						<div class="form-row">
							<div class="form-group col-md-12">
								<label>Email <span style="color:red">*</span></label>
								<input type="email" class="form-control" id="email" placeholder="Please enter email address" v-model="email">
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-md-12">
								<label>Message <span style="color:red"></span></label>
								<textarea v-model="message" class="form-control" id="description" placeholder="Message" rows="5"></textarea>

							</div>


						</div>
						<div class="form-row">

							<div class="form-group col-md-12 text-right">
								&nbsp;&nbsp;
								<button type="button" class="btn btn-windowSignUp btn-create" @click="sendSupportMail">Submit</button>
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
		message:""
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

	},
	sendSupportMail() {



        try{
			var queryParams="dest="+this.email
				queryParams+="&subject=Support"
				queryParams+="&username="+this.first_name+" "+this.last_name
				queryParams+="&message="+this.message



            this.$store.dispatch("sendEmail",queryParams).then((resp) => {

                console.log("Signout successful",resp)

            }).catch((error,data)=>{
            	 console.log("Error: ",error)
			})


          }catch(err){
            console.log("Error: ",err)
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
</style>
