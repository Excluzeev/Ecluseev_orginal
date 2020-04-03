<template>

   <div id="adminHome">
      <!-- #Left Sidebar ==================== -->
      <div class="sidebar">
        <div class="sidebar-inner">
          <!-- ### $Sidebar Header ### -->
          <div class="sidebar-logo">
            <div class="peers ai-c fxw-nw">
              <div class="peer peer-greed">
                <a class="sidebar-link td-n" href="index.html">
                  <div class="peers ai-c fxw-nw">
                    <div class="peer">
                      <div class="logo">
                        <img src="../assets/admin/static/images/logo.png" alt="">
                      </div>
                    </div>
                  </div>
                </a>
              </div>
              <div class="peer">
                <div class="mobile-toggle sidebar-toggle">
                  <a href="" class="td-n">
                    <i class="ti-arrow-circle-left"></i>
                  </a>
                </div>
              </div>
            </div>
          </div>
      
           <!-- ### $Sidebar Menu ### -->
          <ul class="sidebar-menu scrollable pos-r">
            <li class="nav-item mT-30 actived">
              <a class="sidebar-link" href="#">
                <span class="icon-holder">
                  <i class="c-blue-500 ti-home"></i>
                </span>
                <span class="title">Dashboard</span>
              </a>
            </li>
            <li class="nav-item">
              <a class='sidebar-link' href="#">
                <span class="icon-holder">
                  <i class="c-blue-500 ti-settings"></i>
                </span>
                <span class="title">Site settiings</span>
              </a>
            </li>
            <li class="nav-item">
              <a class='sidebar-link' href="#">
                <span class="icon-holder">
                  <i class="c-blue-500 ti-share"></i>
                </span>
                <span class="title">Promote trailers</span>
              </a>
            </li>



            <li class="nav-item">
              <a class='sidebar-link' href="#">
                <span class="icon-holder">
                  <i class="c-blue-500 ti-power-off"></i>
                </span>
                <span class="title">Logout</span>
              </a>
            </li>

          </ul> 

         

        </div> <!-- sidebar inner -->
    
     </div> <!-- sidebar -->

      <!-- #Main ============================ -->
      <div class="page-container">
        <!-- ### $Topbar ### -->
        <div class="header navbar">
          <div class="header-container">
            <ul class="nav-left">
              <li>
                <a id='sidebar-toggle' class="sidebar-toggle" href="javascript:void(0);">
                  <i class="ti-menu"></i>
                </a>
              </li>
            </ul>

          </div> <!-- header container -->
        </div> <!-- header -->


        <!-- ### $App Screen Content ### -->
        <main class='main-content bgc-grey-100'>
          <div id='mainContent'>
                <p class="page-title">Promote Trailers</p> 
                <!-- Sub components goes here -->
                <table id="example" class="table table-striped table-bordered" style="width:100%">
                        <thead>
                            <tr>

                                <th>Trailer Title</th>
                                <th>Channel Name</th>
                                <th>Category</th>
                                <th>Creator Name</th>
                                <th>Released Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="trailer in promotedTrailers">
                                <td v-text="trailer.title"></td>
                                <td v-text="trailer.channelName"></td>
                                <td v-text="trailer.categoryName"></td>
                                <td v-text="trailer.createdBy"></td>
                                <td v-text="getDate(trailer.createdDate.seconds)">12/12/2019</td>
                                <td >
                                    <button class="btn btn-primary">Promote</button>
                                </td>
                            </tr>
                    </tbody>
                    <tfoot>
                        <tr>

                            <th>Trailer Title</th>
                            <th>Channel Name</th>
                            <th>Category</th>
                            <th>Creator Name</th>
                            <th>Released Date</th>
                            <th>Actions</th>

                        </tr>
                    </tfoot>
                </table>
  
          </div> <!-- main Content  -->
        </main>



    
      </div> <!-- page container -->



 </div>

  
</template>

<script>
    import CategoriesTrailerVideos from "../components/CategoriesTrailerVideos";
    import RegisterStoreModule from "../mixins/RegisterStoreModule";
    import store from "../store/index";
    import trailersModule from "../store/trailers/trailer";
  
  export default {
    name: "AdminHome",
    components: {
    CategoriesTrailerVideos,
  },
  data: () => {
    return {
        promotedTrailers:[],
    };
  },
  mixins: [RegisterStoreModule],
  created() {
    this.registerStoreModule("trailers", trailersModule);

  },
 computed: {
  },

  methods: {
            getDate(timestamp){
          //console.log(timestamp);
          var date = new Date(timestamp*1000);
          return [
            ("0" + date.getDate()).slice(-2),           // Get day and pad it with zeroes
            ("0" + (date.getMonth()+1)).slice(-2),      // Get month and pad it with zeroes
            date.getFullYear()                          // Get full year
          ].join('/');                                  // Glue the pieces together
        },

        
  },


    mounted (){
    
          this.$store.dispatch("trailers/getPromotedTrailers").then(data => {

            this.promotedTrailers = data;

        });

    }
  };
</script>

<style scoped>
    
        @import "../assets/admin/css/adminstyle.css";


</style>
