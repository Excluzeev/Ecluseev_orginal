<template>
	<div id="my_ernings_page">

		<div class="container-fluid">
			<div class="row">
				<div class="col-xl-12 ">
					<div class="list-inline my_ernings_title_section d-xl-none d-none d-lg-block d-xl-block">
						<div class="pull-left">
							<h2>My earnings</h2>
							<p style="margin:0;">Earnings from all the communities</p>
                            <div class="form-group">
                                <br>
                                <select class="form-control" v-model="selChannelId">

                                  <option value="">Select a Community</option>
                                  <option v-for="channel in channelsList" v-bind:value="channel.channelId">{{channel.title}}</option>
                                </select>
                            </div>
						</div>
						<div class="pull-right total_erning_section">
							<h3><span>Total earnings $ {{overallEarning}}</span></h3>

                            <button type="button" class="btn btn-withdraw-amount" data-toggle="modal" data-target="#withdrawAmountModal">
                                Withdraw amount
                            </button>
						</div>
						<div class="clearfix"></div>
					</div>	
				</div>
			</div>
			<div class="row">

				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-4 col-xl-4">
               
                </div> 
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 tab_content_panel">
					<div class="tab-content " id="v-pills-tabContent">
						<div class="tab-pane fade show active" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
							<div class="pull-right table_price d-xl-none d-none d-lg-block d-xl-block">
								<h3><span>Total ${{totalEarnings[selChannelId]}}</span></h3>
							</div>
							<table class="table table-borderless" id="dataTable">
								<thead>
									<tr>
										<th scope="col"><h3><span>Date</span></h3></th>
										<th scope="col"><h3><span>Name</span></h3></th>
										<th scope="col"><h3><span>Amount</span></h3></th>
										<th scope="col"><h3><span>Status</span></h3></th>
									</tr>
								</thead>
								<tbody>
									<tr v-for="subscription in subscriptions">
										<td v-text="getDate(subscription.subscribedDate.seconds)"></td>
										<td v-text="subscription.userName">Chriss Joy</td>
										<td>

                                            <span style="color:green;">$ {{subscription.price}}</span>

                                            <!--
                                            <span style="color:red;">$ {{subscription.price}}</span>
                                            -->
                                        </td>
										<td >Received</td>
									</tr>
								</tbody>
							</table>
							<div class="text-center">
								<button class="btn btn-load-more" @click="loadMore">Load more</button>
							</div>
						</div>
						<div class="tab-pane fade" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">...</div>
						<div class="tab-pane fade" id="v-pills-messages" role="tabpanel" aria-labelledby="v-pills-messages-tab">...</div>
						
					</div>
				</div>
			</div>
			
		</div>

        <!-- The Modal -->
        <div class="modal" id="withdrawAmountModal">
          <div class="modal-dialog">
            <div class="modal-content">

              <!-- Modal Header -->
              <div class="modal-header">
                <h4 class="modal-title" style="color: blue;">Withdraw to Bank account</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
              </div>

              <!-- Modal body -->
              <div class="modal-body">

                 <form>
                  <div class="form-group">
                    <input type="number" class="form-control" placeholder="Enter the amount" id="amount">
                  </div>


                </form> 


              </div>

              <!-- Modal footer -->
              <div class="modal-footer">
                    <p style="font-size: 12px;color:red;">Note: Make sure you have connected your bank account with your stripe account.</p>
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Submit</button>
              </div>

            </div>
          </div>
        </div>


    </div>

</template>

<script>
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import store from "../store/index";
import channelsModule from "../store/channels/channels";
import subscriptionsModule from "../store/subscriptions/subscriptions";

import { fireStore, firebaseTimestamp } from "../firebase/init";
import utils from "../firebase/utils";
import moment from "moment";

import authModule from "../store/auth/auth";
import axios from "axios";



  export default {
    name: "MyEarnings",
     data: () => {
        return {
          channelsList: [],
          channel:null,
          userData: store.getters.getFUser,
          subscriptions:[], 
          totalEarnings:{},
          selChannelId:"",
          currentLimit: 5,  
          overallEarning: 0,
        };
      },

    mixins: [RegisterStoreModule],
      created() {
        this.registerStoreModule("channels", channelsModule);

        this.registerStoreModule("subscriptions", subscriptionsModule);
      },
    watch: {
        selChannelId(){
            this.currentLimit=5 // reset load limit
            console.log("Load limit updated")
            this.getSubscriptions()
        }
    },
    computed: {
        
    },
    methods: {
        loadMore(){

            this.currentLimit+=5;
            
            this.getSubscriptions()
        },
        getDate(timestamp){
          //console.log(timestamp);
          var date = new Date(timestamp*1000);
          return [
            ("0" + date.getDate()).slice(-2),           // Get day and pad it with zeroes
            ("0" + (date.getMonth()+1)).slice(-2),      // Get month and pad it with zeroes
            date.getFullYear()                          // Get full year
          ].join('/');                                  // Glue the pieces together
        },
        getTotal(channelId){
            console.log("Total",channelId)            

            this.$store.dispatch("subscriptions/getTotalEarnings",{channelId: channelId}).then(data => {
                this.totalEarnings[channelId]=data

                this.overallEarning+=parseInt(data) // Sum of all the cumminites earnings

                this.$forceUpdate();
       
            });


        },         
        getSubscriptions(){


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

            this.subscriptions=[]
            let channelId=this.selChannelId
            console.log("id",channelId)
            this.$store.dispatch("subscriptions/getChannelSubscriptions",{channelId: channelId,limit: this.currentLimit}).then(data => {

               this.subscriptions=data
               loader.hide()
            });
                
        },
        
    
    },
    async mounted() {

        let channelId=""
        let total=0
        
        this.$store.dispatch("channels/getChannels").then(data => {
            let no_of_channels=data.length
            console.log("no of channels",data.length)
            this.channelsList = data;
            for(let i=0;i<no_of_channels;i++){

                channelId=data[i].channelId
                this.getTotal(channelId);
            }
  
        });
        
      let prepareOptions = {
        stripeId: this.userData.stripeId 
      };
      console.log("Prepared options",prepareOptions)
      axios
        .post(
          "https://us-central1-trenstop-2033f.cloudfunctions.net/myEarnings",
          prepareOptions
        )
        .then(response => {
          if (response.data.error) {
            console.log("Error",response.data)
          } else {

            console.log("response",response.data)
          }
        })
        .catch(error => {
          this.subscribeProcessing = false;
            console.log("Error response",error)
        });


    
    }


  };


</script>

<style scoped>

    .total{
        color:red;
    }
    .tab-content{
        border-radius:22px 22px 22px 22px;
    }
</style>
