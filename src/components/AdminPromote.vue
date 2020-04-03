<template>
    
    <div>
    
         <p class="page-title">Banners</p>
         <div class="pull-right m-2">
          <button class="btn btn-primary btn-sm mr-2" data-toggle="modal" data-target="#bannerModal" id="add">Add new banner</button>

         </div>

         <div class="table-responsive p-20">
            <table class="table">
              <thead>
                <tr>
                  <th class=" bdwT-0">Banner image</th>
                  <th class=" bdwT-0">URL</th>
                  <th class=" bdwT-0">is trailer?</th>
                  <th class=" bdwT-0">Active</th>
                  <th class=" bdwT-0">Actions</th>
                   
                </tr>
              </thead>
              <tbody>

                <tr v-for="banner in promotedBanners">

                    <td>
                        <img :src="banner.image" style="height:120px;"/>
                    </td>
                    <td v-text="banner.url">
                        https://google.com
                    </td>
                    <td v-text="banner.isTrailer">
                        
                    </td>
                    <td v-text="banner.isActive">

                    </td>
                    <td>
                        <button class="btn btn-primary btn-sm mr-2" data-toggle="modal" data-target="#bannerModal" id="edit" v-bind:data-id="banner.id">Edit</button>
                        <button class="btn btn-danger btn-sm" @click="openDeleteConfirm(banner.id)">Delete</button>
                    </td>

                </tr>    
 
              </tbody>
            
            </table>

         </div>



        		 <!-- Modal for sign in -->
		<div class="modal fade bd-example-modal-xl" id="bannerModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-xl modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<!-- <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5> -->
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">Close</span>
						</button>
					</div>
					<div class="modal-body text-center">

                         <div v-if="showInfo" class="row text-center info-message">
                            <div class="col-lg-12">

                                {{ infoMsg }}
                            </div>

                         </div>                  

                         <div v-if="showError" class="row text-center error-message">
                            <div class="col-lg-12">
                                {{ errorMsg }}
                            </div>

                         </div>                  

                        

                         <form class="pt-0" @submit.prevent="addOrUpdate">
                              <div class="row">  
                                   
                                 <div class="col-6">
                                      <div class="form-group">
                                        <label >URL</label>
                                        <input type="text" class="form-control" placeholder="URL" name="url" v-model="bannerUrl">
                                      <span  class="error-message" v-if="this.errors['url']">{{this.errors['url']}}</span>

                                      </div>
                                  </div>

                                 <div class="col-6">
                                      <div>
                                        <label for="pwd">Image</label>
                                         <upload-btn
                                        color="blue--text lighten-1"
                                        style="background-color: #fff !important;"
                                        class="white--text"
                                        title="Upload Thumbnail"
                                        :fileChangedCallback="onImageSelected"
                                        accept="image/*"
                                        round
                                      >
                                        <template slot="icon">
                                          <div style="padding-left:4px">
                                            <v-icon color="blue lighten-1">cloud_upload</v-icon>
                                          </div>
                                        </template>
                                      </upload-btn>

                                  <span  class="error-message" v-if="this.errors['image']">{{this.errors['image']}}</span>

                                      </div>

                                 </div>

                             </div>
                             <div class="row">
                                <div class="col-6">

                                      <v-layout padding justify-center>
                                        <img :src="bannerImageUrl" height="150" v-if="bannerImageUrl" />
                                      </v-layout>

                                </div>

                              </div>
                              <div class="row">  

                                <div class="col-6">

                                  <div class="form-group">
                                    <label>
                                            Is Active?
                                    </label>
                                      <input class="form-control" type="checkbox" value=true v-model="bannerIsActive"> 
                                  </div>

                                </div>

                                <div class="col-6">

                                  <div class="form-group">
                                    <label>
                                            Is trailer?
                                    </label>

                                      <input class="form-control" type="checkbox" value=true v-model="bannerIsTrailer"> 
                                  </div>

                                </div>

                              </div>


                              <div class="row">  

                                <div class="col-6">

                                  <div class="form-group">
                                    <label>
                                            Trailer ID
                                    </label>

                                      <input class="form-control" type="text" placeholder="Trailer ID"  v-model="bannerTrailerId"> 
                                                          <span  class="error-message" v-if="this.errors['trailerId']">{{this.errors['trailerId']}}</span>
                                  </div>

                                </div>

                              </div>


                          <button type="submit" class="btn btn-primary">Submit</button>
                        </form> 


                            
					</div>

				</div>
			</div>
		</div>





        
                <!-- The Modal -->
        <div class="modal" id="deleteConfirmModal">
          <div class="modal-dialog">
            <div class="modal-content">

              <!-- Modal Header -->
              <div class="modal-header">
                <h4 class="modal-title" style="color: blue;">Confirmation</h4>
                <button type="button" class="close" data-dismiss="modal" @click="closeDeleteConfirm">&times;</button>
              </div>

              <!-- Modal body -->
              <div class="modal-body">
                  

                Are you sure, you want to delete this banner?


          </div>

              <!-- Modal footer -->
              <div class="modal-footer">
                    <button type="submit" class="btn btn-primary"  :loading="processing" :disabled="processing" @click="loader = 'loading4'">Proceed</button>
              </div>

            </div>
          </div>
        </div>


             
    </div>
     
</template>

<script>
import { auth, fireStore, firebaseTimestamp } from "../firebase/init";
import utils from "../firebase/utils";
import moment from "moment";
import UploadButton from "vuetify-upload-button";
import { videoStorage,publicStorage } from "../firebase/init";
import axios from "axios";
import channelsModule from "../store/channels/channels";
import RegisterStoreModule from "../mixins/RegisterStoreModule";


export default {
  name: "AdminPromote",
  components:{

      "upload-btn": UploadButton

  },
  mixins: [RegisterStoreModule],
  created() {
    this.registerStoreModule("channels", channelsModule);
  },

  data: () => {
    return {
       infoMsg:"",
       errorMSg:"",
       showInfo: false,
       showError: false,
       errors:{},
       processing: false,
       loader:"",
       bannerId:'',
       bannerUrl: '',

       bannerImage: '',
       bannerImageUrl: '',
       bannerIsTrailer:false,
       bannerIsActive: false,
       bannerTrailerId: '',
       promotedBanners:[

            ]
    };
  },
  mounted() {

         this.$store.dispatch("channels/getAllPromotedBanners").then(data => {
    
                this.promotedBanners=data

            });

        let _vm=this
        $(document).on("click", "#add", function(event){
    
            _vm.resetFormData()        
    
        });

        $(document).on("click", "#edit", function(event){
    
            let ele=event.target
            console.log(ele)
            let id=$(ele).attr("data-id")
            _vm.fillFormData(id)        
    
        });

  },
  methods: {


      onImageSelected(file) {
      
            this.bannerImage = file;
            this.bannerImageUrl = URL.createObjectURL(this.bannerImage);
        
      },


       async addOrUpdate(){
            // Input validations  

            this.errors={}

          let errorFound=false;

          if (this.bannerImageUrl == "") {

            this.errors['image']="Banner image cannot be empty!";
            errorFound=true;

          }
          if (this.bannerUrl == "") {
           this.errors['url']="Trailer/Video URL link cannot be empty!";
            errorFound=true;
          }

          if (this.bannerIsTrailer == true && this.bannerTrailerId == "") {

              this.errors['trailerId']="Trailer ID cannot be empty";
              errorFound=true;
          }

          if(errorFound){
            this.processing=false;
              this.$forceUpdate();
            return false; // if error found

          }


           let bannerId=""
   
          // Call the api to add the data 
          if(this.bannerId == ""){
             bannerId = utils.generateId(); // Generate id
           }else{
              bannerId=this.bannerId

           }
           // Upload Custom Thumbnail
           let videoThumbnailRef = publicStorage
                .ref()
                .child(bannerId)
                .child("banner");


           let bannerImageUrl=''

           if(this.bannerImage != ""){
            try {
              await videoThumbnailRef.put(this.bannerImage, {
                contentType: "image/*"
              });
              bannerImageUrl = await videoThumbnailRef.getDownloadURL();
            } catch (e) {
              console.log(e);
              this.errorMsg="Banner image Upload failed"
              this.showError=true
            }

          }else{

            bannerImageUrl=this.bannerImageUrl

          }
           //console.log("uploaded image url",bannerImageUrl)
           let bannerData={

                id: bannerId,
                image: bannerImageUrl,
                isActive: this.bannerIsActive,
                isTrailer: this.bannerIsTrailer,
                trailerId: this.bannerTrailerId,
                url: this.bannerUrl        
                
            }

         let bannerRef = fireStore
            .collection(utils.bannersCollection)
            .doc(bannerId);
             
             try {
                await bannerRef.set(bannerData);
                this.infoMsg="Banner added successfully"
                this.showInfo=true

              } catch (error) {

                this.errorMsg="Unable to add banner details: "+error
                this.showError=true
              }

       },
       closeDeleteConfirm(){

          $("#deleteConfirmModal").hide()
        },
       openDeleteConfirm(id){
        
          this.bannerId=id
          $("#deleteConfirmModal").show()

       },
       resetFormData(){

           // Reset everything
           this.bannerId=''
           this.bannerUrl=''
           this.bannerImage=''
           this.bannerIsTrailer=''
           this.bannerIsActive=''
           this.bannerTrailerId=''


       },
       delete(id){
        // Delete the selected banner
       },
       fillFormData(id){

           //console.log("Edit called",id,this.promotedBanners.length)
            
           for(let i=0;i < this.promotedBanners.length;i++){
                   
               let banner=this.promotedBanners[i]
             //   console.log(banner.id,id)
                if(banner.id == id){

                       this.bannerId=banner.id
                       this.bannerUrl=banner.url
                       this.bannerImage=""
                       this.bannerImageUrl=banner.image
                       this.bannerIsTrailer=banner.isTrailer
                       this.bannerIsActive=banner.isActive
                       this.bannerTrailerId=banner.trailerId

                      //$("#bannerModal").show()

                    break;
                    
                }                

           }

       }        
  }
};
</script>

<style scoped>

    .modal-content input{

        padding: 8px !important;
color: #29ABE2 !important;
border: 1px solid #979797;
height: 40px;
border-radius: 0 !important;
margin-top: 7px;
font-size: 16px;
    }

    label{
        font-size:1rem;
    }
.error-message{
    font-size: 17px;
    display: block;
    color: #f00;
    text-align: left;
    padding-left: 10px;
    padding-top: 5px;

}

.info-message{
    font-size: 17px;
    display: block;
    color: green;
    text-align: left;
    padding-left: 10px;
    padding-top: 5px;

}

</style>
