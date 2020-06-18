<template>
  <div id="upload_videos_previews_page">
    <div class="container-fluid">
      <div class="row">
        <div class="col-12">
          <p>
             <router-link
              :to="{
                      name: 'MyChannels'
                    }"
            >
               My Communities
            </router-link>
          &nbsp;<i class="fa fa-angle-right"></i>
           <router-link
                      :to="{
                      name: 'MyChannelDetails',
                        params: { channelId: channelData.channelId }
                      }"
                      >
                      {{channelData.title}}
                    </router-link>
            &nbsp;<i class="fa fa-angle-right"></i><a href="#">Links</a>
          </p>
       </div>
      </div>
      <form @submit.prevent="updateChannelPromoteLinks">
        <div class="row">
          <div class="col-md-6 col-12">


            <div class="create_form_section">
              <div class="form-group ">
                <label for="name">Facebook Link</label>
                <input v-model="data_obj.facebook_link"  type="text" class="form-control"  placeholder="Please enter the Facebook link">
                <span  class="error-message" v-if="this.errors['facebook_link']">{{this.errors['facebook_link']}}</span>
              </div>
            </div>


            <div class="create_form_section">
              <div class="form-group ">
                <label for="name">Instagram Link</label>
                <input v-model="data_obj.instagram_link"  type="text" class="form-control" placeholder="Please enter Instagram link">
                <span  class="error-message" v-if="this.errors['instagram_link']">{{this.errors['instagram_link']}}</span>
              </div>
            </div>
            <div class="create_form_section">
              <div class="form-group ">
                <label for="name">Website Link</label>
                <input v-model="data_obj.website_link"  type="text" class="form-control" placeholder="Please enter website link">
                <span  class="error-message" v-if="this.errors['website_link']">{{this.errors['website_link']}}</span>
              </div>
            </div>

            <div class="create_form_section">
              <div class="form-group ">
                <label for="name">Merchandise Link</label>
                <input v-model="data_obj.merchandise_link"  type="text" class="form-control" placeholder="Please enter Merchandise link">
                <span  class="error-message" v-if="this.errors['merchandise_link']">{{this.errors['merchandise_link']}}</span>
              </div>
            </div>


          </div>
          <div class="col-md-6 col-12">
            <div class="create_form_section">
              <div class="form-group tags">
                <label >Other Site Name</label>
                <input v-model="data_obj.other_site_name" type="text" class="form-control"  placeholder="Enter other site name">
                <span  class="error-message" v-if="this.errors['other_site_name']">{{this.errors['other_site_link']}}</span>
              </div>

            </div>

              <div class="create_form_section">
              <div class="form-group tags">
                <label >Other Site Link</label>
                <input v-model="data_obj.other_site_link" type="text" class="form-control"  placeholder="Enter other site link">
                <span  class="error-message" v-if="this.errors['other_site_link']">{{this.errors['other_site_link']}}</span>
              </div>

            </div>


            <div class="create_form_section">


                      <div
                      v-if="successMessage"
                      class="success-message"
                      v-text="successMessage">

                      </div>
                      <div
                      v-if="errorMessage"
                      class="error-message"
                      v-text="errorMessage"
                      />

               <div class="form-group">



                  <div class="submit-btn-sec" >
                    <button type="submit" class="btn btn-publish-video" :loading="processing" :disabled="processing" @click="loader = 'loading4'">Update</button>
                  </div>
              </div>
            </div>

            


          </div>

        </div>
      </form>
    </div>
  </div>



</template>

<script>
  import UploadButton from "vuetify-upload-button";
  import {
    publicStorage,
    auth,
    firebaseTimestamp,
    fireStore
  } from "../firebase/init";
  import utils from "../firebase/utils";

  export default {
    components: {
      "upload-btn": UploadButton
    },
    data: () => {
      return {
        		successMessage:"",
		errorMessage:null,

        data_obj:{
          facebook_link: "",
          instagram_link:"",
          website_link:"",
          merchandise_link:"",
          other_site_name:"",
          other_site_link:"",

        },
        processing: false,
        unique: true,
        rules: {
          required: value => !!value || "Required."
        },
        errors:{}
      };
    },
    props: ["channelData"],
    methods: {
                 /* Fetch promote links of the channel */
            fetch_promote_links(){

                this.$store.dispatch("fetchLinks",{channelId: this.channelData.channelId})
                .then((links) => {

                  if (links) {

                    for (let i = 0; i < links.length; i++) {
                      let obj=links[i];

                      if (obj.display_name == "Facebook") {
                        this.data_obj.facebook_link=obj.link
                      }
                      else if (obj.display_name == "Instagram") {
                        this.data_obj.instagram_link=obj.link

                      }
                      else if (obj.display_name == "Website") {
                        this.data_obj.website_link=obj.link

                      }
                      else if (obj.display_name == "Merchandise") {
                        this.data_obj.merchandise_link=obj.link

                      }else{
                        this.data_obj.other_site_name=obj.display_name
                        this.data_obj.other_site_link=obj.link
                      }

                    }
                  }

                })
                .catch((error, data) => {

                     console.log("Promote links error",error);

                })

            },

      async updateChannelPromoteLinks(){

        this.errors={}

                 let promote_links=[
                ];


          if (this.data_obj.facebook_link.trim() != "") {

                    promote_links.push( {
                        'display_name': "Facebook",
                        'link': this.data_obj.facebook_link
                    })

          }

          if (this.data_obj.instagram_link.trim() != "") {
                  promote_links.push(
                    {
                        'display_name': "Instagram",
                        'link': this.data_obj.instagram_link
                    })

          }

          if (this.data_obj.website_link.trim() != "") {

                promote_links.push(
                     {
                        'display_name': "Website",
                        'link': this.data_obj.website_link
                    })

          }

          if (this.data_obj.merchandise_link.trim() != "") {

                promote_links.push(
                     {
                        'display_name': "Merchandise",
                        'link': this.data_obj.merchandise_link
                    })


          }

          if (this.data_obj.other_site_link.trim() != "") {

                 promote_links.push(
                    {
                        'display_name': this.data_obj.other_site_name,
                        'link': this.data_obj.other_site_link
                    }
                    )
           }


        this.errorMessage=null
        this.successMessage=null


         this.processing=true;
          let channelRef = fireStore
          .collection(utils.channelsCollection)
          .doc(this.channelData.channelId);
          try {
            let data = {
              links: promote_links,
            };
            await channelRef.update(data);
            this.processing=false;

            this.successMessage="Successfully updated the channel links!!!"

				setTimeout(()=>{
					this.successMessage=null

				},3000)

          }catch(err){
            this.processing=false;

            this.errorMessage="Sorry, unable to update channel links !!!"

				setTimeout(()=>{
					this.errorMessage=null

				},3000)

          }

        }
      },
    mounted() {

      this.fetch_promote_links()

    }


  };
</script>

<style scoped>


      .success-message, .error-message{
            /* padding: 5px; */
    text-align: left;
    font-size: 20px;
    /* border: 1px solid #f9f9f9; */
    /* margin-bottom: 5px; */
    margin-left: 10px;
    }

    .success-message{
        color:green;
    }
    .error-message{

        color:red;

    }
</style>
