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
              <a class="sidebar-link" href="#" @click="openPage('dashboard')">
                <span class="icon-holder">
                  <i class="c-blue-500 ti-home"></i>
                </span>
                <span class="title">Dashboard</span>
              </a>
            </li>
            <li class="nav-item">
              <a class='sidebar-link' href="#" @click="openPage('settings')">
                <span class="icon-holder">
                  <i class="c-blue-500 ti-settings"></i>
                </span>
                <span class="title">Site settiings</span>
              </a>
            </li>
            <li class="nav-item">
              <a class='sidebar-link' href="#" @click="openPage('promote')">
                <span class="icon-holder">
                  <i class="c-blue-500 ti-share"></i>
                </span>
                <span class="title">Banners</span>
              </a>
            </li>



            <li class="nav-item">
              <a class='sidebar-link' href="#" @click="logout">
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
                
                <Promote v-if="currentPage == 'promote'" />

                <Settings v-if="currentPage == 'settings'" />
  
          </div> <!-- main Content  -->
        </main>



    
      </div> <!-- page container -->



 </div>

  
</template>

<script>

    import Promote from "../components/AdminPromote";

    import Settings from "../components/AdminSettings";

    import RegisterStoreModule from "../mixins/RegisterStoreModule";
    import store from "../store/index";
    import trailersModule from "../store/trailers/trailer";
     
    export default {
        name: "AdminHome",
        components: {
            Promote,
            Settings 
        },
        data: () => {
    
            return {
                currentPage: "settings",
            };
    
        },
        mixins: [RegisterStoreModule],
        created() {

        },
        computed: {
    
        },
        methods: {

            openPage(page){

                console.log("Current page",page)
                this.currentPage=page
                 
            },
            logout(){
            // Do the logout stuffs
            }       
         
        },
        mounted (){
    
        }
    };
</script>

<style scoped>
    
        @import "../assets/admin/css/adminstyle.css";


</style>
