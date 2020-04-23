<template>
  <div id="my_ernings_page">

    <div class="container-fluid">


      <div class="row">
        <div class="col-xl-12 ">
          <div class="list-inline my_ernings_title_section ">
            <div class="pull-left">
              <h2>My earnings</h2>
              <p style="margin:0;">Earnings from all the communities</p>
              <h3 class="s-balance " style="padding: 5px 0">
                Stripe Account Balance : <span style="color:green"> {{stripeAccountBalance}} {{stripeAccountBalanceCurrency}}</span>
              </h3>
            </div>
            <div class="pull-right total_erning_section">
              <!-- <h3><span>Total earnings </span><span style="color:green;">$ {{overallEarning}}</span></h3> -->
              <button type="button" class="btn btn-withdraw-amount d-xl-none d-md-block d-lg-none d-sm-block d-xs-block" data-toggle="modal" data-target="#withdrawAmountModal">
                $
              </button>
              <button type="button" class="btn btn-withdraw-amount d-xl-block d-md-none d-lg-block d-sm-none d-none d-xs-none" data-toggle="modal" data-target="#withdrawAmountModal">
                Withdraw amount
              </button> 
            </div>
            <div class="clearfix"></div>
          </div> 
          <div class="form-group offset-xs-0 col-xs-12 offset-sm-2 col-sm-8   text-center">
            <select class="form-control" v-model="selChannelId">
              <option value="">Select a Community</option>
              <option v-for="channel in channelsList" v-bind:value="channel.channelId">{{channel.title}}</option>
            </select>
          </div> 
        </div>


        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 tab_content_panel ">
          <div class="tab-content " id="v-pills-tabContent">
            <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
              
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
                    <td> <span style="color:green;">$ {{subscription.price}}</span> <!-- <span style="color:red;">$ {{subscription.price}}</span> --> </td>
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


     
      <div class="row  ">
        <div class="tabs_section">
          <div class="col-xs-12 col-sm-12 col-md-12 " style="padding: 0">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" style="margin-left: 0">
              <li class="nav-item">
                <a class="nav-link active" data-toggle="tab" href="#charges">Charges</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#payouts">Payouts</a>
              </li>
            </ul> 
          </div> 
          <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12 tab_content_panel" style="padding: 25px 15px">
            <div class="tab-content " id="v-pills-tabContent" >
              <div class="pull-right table_price ">

                  <h3><span>Total ${{totalEarnings[selChannelId]}}</span></h3>        

                </div>
              <div class="tab-pane fade show active" id="payouts" role="tabpanel" aria-labelledby="v-pills-home-tab" style="padding: 15px">
                
                <table class="table table-borderless" id="dataTable">
                  <thead>
                    <tr>
                      <th scope="col"><h3><span>Date</span></h3></th>
                      <th scope="col"><h3><span>Amount</span></h3></th>
                      <th scope="col"><h3><span>Description</span></h3></th>
                      <th scope="col"><h3><span>Status</span></h3></th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="payout in payouts">
                      <td v-text="payout.arrival_date"></td>
                      <td > {{payout.amount}} {{payout.currency}}</td>
                      <td v-text="payout.description">

                      </td>
                      <td v-text="payout.status"></td>
                    </tr>
                  </tbody>
                </table>
                <div class="text-center">
                  <button class="btn btn-load-more" @click="loadMorePayouts">Load more</button>
                </div>
              </div>
              <div class="tab-pane fade" id="charges" role="tabpanel" aria-labelledby="v-pills-profile-tab">

                <div class="pull-right table_price ">
                </div>
                <table class="table table-borderless" id="dataTable">
                  <thead>
                    <tr>
                      <th scope="col"><h3><span>Date</span></h3></th>
                      <th scope="col"><h3><span>Amount</span></h3></th>
                      <th scope="col"><h3><span>Description</span></h3></th>
                      <th scope="col"><h3><span>Status</span></h3></th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="charge in charges">
                      <td v-text="getDate(charge.created)"></td>
                      <td > {{charge.amount}} {{charge.currency}}</td>
                      <td v-text="charge.description">

                      </td>
                      <td v-text="charge.status"></td>
                    </tr>
                  </tbody>
                </table>
                <div class="text-center">
                  <button class="btn btn-load-more" @click="loadMoreCharge">Load more</button>
                </div>


              </div>

            </div>
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

          <form @submit.prevent="payout">
            <!-- Modal body -->
            <div class="modal-body">

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

            <div class="form-group">
              <input type="number" class="form-control" v-model="payoutAmount" min=1 placeholder="Enter the amount" id="amount">

              <span  class="error-message" v-if="this.errors['payoutAmount']">{{this.errors['payoutAmount']}}</span>

            </div>

            <div class="form-group">

              <select v-model="payoutCurrency" class="form-control">

                <option value="">Please select currency</option>
                <option value="USD">United States Dollars</option>
                <option value="EUR">Euro</option>
                <option value="GBP">United Kingdom Pounds</option>
                <option value="DZD">Algeria Dinars</option>
                <option value="ARP">Argentina Pesos</option>
                <option value="AUD">Australia Dollars</option>
                <option value="ATS">Austria Schillings</option>
                <option value="BSD">Bahamas Dollars</option>
                <option value="BBD">Barbados Dollars</option>
                <option value="BEF">Belgium Francs</option>
                <option value="BMD">Bermuda Dollars</option>
                <option value="BRR">Brazil Real</option>
                <option value="BGL">Bulgaria Lev</option>
                <option value="CAD">Canada Dollars</option>
                <option value="CLP">Chile Pesos</option>
                <option value="CNY">China Yuan Renmimbi</option>
                <option value="CYP">Cyprus Pounds</option>
                <option value="CSK">Czech Republic Koruna</option>
                <option value="DKK">Denmark Kroner</option>
                <option value="NLG">Dutch Guilders</option>
                <option value="XCD">Eastern Caribbean Dollars</option>
                <option value="EGP">Egypt Pounds</option>
                <option value="FJD">Fiji Dollars</option>
                <option value="FIM">Finland Markka</option>
                <option value="FRF">France Francs</option>
                <option value="DEM">Germany Deutsche Marks</option>
                <option value="XAU">Gold Ounces</option>
                <option value="GRD">Greece Drachmas</option>
                <option value="HKD">Hong Kong Dollars</option>
                <option value="HUF">Hungary Forint</option>
                <option value="ISK">Iceland Krona</option>
                <option value="INR">India Rupees</option>
                <option value="IDR">Indonesia Rupiah</option>
                <option value="IEP">Ireland Punt</option>
                <option value="ILS">Israel New Shekels</option>
                <option value="ITL">Italy Lira</option>
                <option value="JMD">Jamaica Dollars</option>
                <option value="JPY">Japan Yen</option>
                <option value="JOD">Jordan Dinar</option>
                <option value="KRW">Korea (South) Won</option>
                <option value="LBP">Lebanon Pounds</option>
                <option value="LUF">Luxembourg Francs</option>
                <option value="MYR">Malaysia Ringgit</option>
                <option value="MXP">Mexico Pesos</option>
                <option value="NLG">Netherlands Guilders</option>
                <option value="NZD">New Zealand Dollars</option>
                <option value="NOK">Norway Kroner</option>
                <option value="PKR">Pakistan Rupees</option>
                <option value="XPD">Palladium Ounces</option>
                <option value="PHP">Philippines Pesos</option>
                <option value="XPT">Platinum Ounces</option>
                <option value="PLZ">Poland Zloty</option>
                <option value="PTE">Portugal Escudo</option>
                <option value="ROL">Romania Leu</option>
                <option value="RUR">Russia Rubles</option>
                <option value="SAR">Saudi Arabia Riyal</option>
                <option value="XAG">Silver Ounces</option>
                <option value="SGD">Singapore Dollars</option>
                <option value="SKK">Slovakia Koruna</option>
                <option value="ZAR">South Africa Rand</option>
                <option value="KRW">South Korea Won</option>
                <option value="ESP">Spain Pesetas</option>
                <option value="XDR">Special Drawing Right (IMF)</option>
                <option value="SDD">Sudan Dinar</option>
                <option value="SEK">Sweden Krona</option>
                <option value="CHF">Switzerland Francs</option>
                <option value="TWD">Taiwan Dollars</option>
                <option value="THB">Thailand Baht</option>
                <option value="TTD">Trinidad and Tobago Dollars</option>
                <option value="TRL">Turkey Lira</option>
                <option value="VEB">Venezuela Bolivar</option>
                <option value="ZMK">Zambia Kwacha</option>
                <option value="EUR">Euro</option>
                <option value="XCD">Eastern Caribbean Dollars</option>
                <option value="XDR">Special Drawing Right (IMF)</option>
                <option value="XAG">Silver Ounces</option>
                <option value="XAU">Gold Ounces</option>
                <option value="XPD">Palladium Ounces</option>
                <option value="XPT">Platinum Ounces</option>
              </select>

              <span  class="error-message" v-if="this.errors['payoutCurrency']">{{this.errors['payoutCurrency']}}</span>
            </div>



          </div>

          <!-- Modal footer -->
          <div class="modal-footer">
            <p style="font-size: 12px;color:red;">Note: Make sure you have connected your bank account with your stripe account.</p>
            <button type="submit" class="btn btn-primary"  :loading="processing" :disabled="processing" @click="loader = 'loading4'">Submit</button>
          </div>

        </form> 
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
        charges:[],
        payouts:[],
        stripeAccountBalance:0,
        stripeAccountBalanceCurrency:"",
        payoutAmount:0,
        payoutCurrency:"",
        errors:{},
        showInfo:true,
        showError: false,
        infoMsg:"",
        errorMsg: "",
        processing: false, 
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

          payout(){

          // Reset
          this.errors={}
          this.showInfo=false
          this.showError=false
          this.infoMsg=""
          this.errorMsg=""
          this.processing=false

          let errorFound=false

          let prepareOptions = {
            stripeId: this.userData.stripeId,
            amount: this.payoutAmount,
            currency: this.payoutCurrency.toLowerCase()
          };

          //console.log("options",prepareOptions)
          if (this.payoutAmount < 1 ) {
            this.errors['payoutAmount']="Payout amount should not be less than 1";
            errorFound=true;
          }

          if (this.payoutCurrency == "") {
            this.errors['payoutCurrency']="Please select a currency";
            errorFound=true;
          }

          
          if(errorFound){
            this.$forceUpdate();
            
            return
          }
          
          this.processing=true
          axios
          .post(
            "https://us-central1-trenstop-2033f.cloudfunctions.net/stripePayout",
            prepareOptions
            )
          .then(response => {
            if (response.data.error) {
             console.log("errr",response.data.message)

             let emessage=response.data.message

             this.errorMsg=emessage   
             this.showError=true
             this.processing=false

           } else {
            console.log("response",response.data)
            this.infoMsg="Payout request submited successfully"     
            this.showInfo=true
            this.processing=false
          }
        })
          .catch(error => {
           console.log("Error response",error)
           this.errorMsg=error  
           this.showError=true
           this.processing=false
         });


          
          
        },
        loadMorePayouts(){

        },  
        loadMoreCharge(){

        },
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
           alert("Something went wrong!")
         } else {
          console.log("response",response.data)
          let respData=response.data

          this.stripeAccountBalance=respData.balanceObj.available[0].amount
          this.stripeAccountBalanceCurrency=respData.balanceObj.available[0].currency
          
          this.charges=respData.charges.data
          this.payouts=respData.payouts.data
          
          
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
      border-radius: 0px 0px 22px 22px;
    }
    .s-balance{
      color:#666;
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
      color: #f00;
      text-align: left;
      padding-left: 10px;
      padding-top: 5px;

    }
    @media only screen and (max-width: 660px){
      #my_ernings_page .tab-content h3, #my_ernings_page table h3{font-size: 14px;}
    #my_ernings_page .btn-withdraw-amount{
          position: absolute;
    top: -42px;
    right: -10px;
    padding: 5px 10px;
    }
    h2{font-size: 40px;text-align:center}
    #my_ernings_page .my_ernings_title_section p{font-size:14px;text-align:center}
    .my_ernings_title_section div:first-child{float:none}
    }
    #my_ernings_page{margin-bottom:30px}
    .nav-tabs .nav-item{padding:0}

    #withdrawAmountModal select {
    font: 1.25rem rubik-regular;
    padding: 15px 35px;
    color: #29ABE2!important;
    border: 1px solid #FFFFFF;
    height: auto;
    border-radius: 15px!important;
    margin-top: 10px;
    box-shadow: 6px 6px 20px #00000029;
    -webkit-box-shadow: 6px 6px 20px #00000029;
    -moz-box-shadow: 6px 6px 20px #00000029;
}
  </style>
