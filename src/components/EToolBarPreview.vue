<template>
  <div class="nav_section homepage-nav">
    <nav class="nav-home navbar-expand-lg navbar " id="nav">
      <div class="pull-left d-md-block d-xl-none d-lg-none">
        <div id="mySidenav" class="sidenav" v-show="sideNav">
          <div class="inline-list ">
            <img src="../assets/Images/menu_logo.png">
            <a href="javascript:void(0)" class="closebtn" @click="sideNav = false">&times;</a>
          </div>
          <template v-if="showLogin">
            <h5>Account</h5>
            <a href="javascript://" @click="sideNav = false" data-toggle="modal" data-target="#signUpModal">Create an Account</a>
            <a href="javascript://" @click="sideNav = false" data-toggle="modal" data-target="#signInModal">Login</a>
          </template>

          <template v-if="!showLogin">
            <h5>Account</h5>
            <a href="javascript://" v-if="!hideSignUpContentCreator&!showLogin" @click="goLoginContentCreator">Become Content creator</a>
            <a href="javascript://" v-if="!showLogin" @click="goToCommunities">Communities</a>
              <template v-if="hideSignUpContentCreator">
              <a href="javascript://"  @click="goLoginCreate">Create Community</a>
              <a href="javascript://" @click="goLoginLive">Excluzeev Live</a>
              <a href="javascript://" @click="goToMyProfile">My Profile</a>
              <a href="javascript://" @click="goToMyCrowdFunding">My Crowd Funding</a>
              <a href="javascript://" @click="goToMyEarnings">My Earnings</a>
              </template>
            </template>
            <h5>COMPANY</h5>
            <a href="#" @click="showAboutUs">About</a>
            <a href="/careers">Careers</a>
<!--            <a href="#">News</a>-->
            <h5>SUPPORT</h5>
             <a href="/contact">Contact Support</a>
            <a href="#" @click="showHowTo">Help Guide</a>
            <a href="#" @click="showFAQs">FAQ</a>

           <h5>PARTNERSHIP</h5>
          <a href="/advertise">Advertise With Us</a>
          <a href="/partnership">Partnerships</a>

            <h5>LEGAL</h5>

          <a href="javascript://" @click="showPrivacyPolicy">Privacy Policy</a>
          <a href="javascript://" @click="showCookiePolicy">Cookie Policy</a>
          <a href="javascript://" @click="showCommunityAgreement">Community Member Agreement</a>
          <a href="javascript://" @click="showContentCreatorTerms">Content Creator Terms</a>
          <a href="javascript://" @click="showCallToActionTerms">Call to Action Terms</a>
          <a href="javascript://" @click="showLicenseAgreement">Content Creator Licence Agreement</a>

            <hr>
            <a v-if="!showLogin" href="javascript://" @click="logout">Logout</a>
            <hr class="logout_link">
            <ul class="list-unstyled inline-list social_links">
              <li><a href="https://www.instagram.com/excluzeev/" target="_blank"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
              <li><a href="https://www.twitter.com/excluzeev/" target="_blank"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
              <li><a href="https://www.facebook.com/excluzeev" target="_blank"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
            </ul>
          </div>
          <div class="menu_sticks" @click="toggleSideMenu">
            <span class="menu_sticks_item"></span>
          <span class="menu_sticks_item"></span>
          <span class="menu_sticks_item"></span>
          </div>
        </div>

        <div class="pull-left  home_brand ">
          <a class="navbar-brand" href="/">
            <img src="../assets/Images/logo.svg" draggable="false">
          </a>
        </div>

        <div class="text-center row-auto d-none d-lg-block d-lg-block" id="navbarSupportedContent row-auto ">
          <ul class="navbar-nav row-auto">
            
            <li class="nav-item color_fffffff search_group">
              <div class="form-group has-search">
                <span class="fa fa-search form-control-feedback color_fffffff"></span>
                <form @submit.prevent="searchPreviews" style="margin:0;">
                          
                  <input @click:append="searchPreviews" v-model="query" class="form-control mr-sm-2 btn_radius color_fffffff search" type="search" placeholder="Find the Content Creators, Communities or Videos" aria-label="Search">
                </form>
              </div>
            </li>
          </ul>
        </div>
        <div class="pull-right ">
          <ul class="navbar-nav">

          <li class="search_icon d-md-block d-xl-none d-lg-block">
            <button class="btn btn-borderless search_btn ">
              <i class="fa fa-search" aria-hidden="true"></i>
            </button>
          </li>
          <li  v-if="!hideSignUpContentCreator&!showLogin" class="nav-item d-none d-lg-block d-lg-block">
              <button @click="goLoginContentCreator" class="btn signIn-btn my-2 my-sm-0 btn_radius color_fffffff" type="button" >
                <img src="../assets/Images/live.png"> Become a Content Creator
              </button>
            </li> 

            <li  v-if="hideSignUpContentCreator" class="nav-item d-none d-lg-block d-lg-block">
              <button @click="goLoginLive" class="btn signIn-btn my-2 my-sm-0 btn_radius color_fffffff" type="button" >
                <img src="../assets/Images/live.png"> Excluzeev Live
              </button>
            </li>
            <li v-if="hideSignUpContentCreator" class="nav-item d-none d-lg-block d-lg-block">
              <button @click="goLoginCreate"  class="btn create-account-btn my-2 my-sm-0 btn_radius color_fffffff" type="button" >+ Create a community</button>
            </li>
            <li v-if="!showLogin" class="nav-item d-none d-lg-block d-lg-block">
              <button @click="goToCommunities" class="btn signIn-btn my-2 my-sm-0 btn_radius color_fffffff" type="button" >Communities</button>
            </li> 
            <li v-if="!showLogin" class="nav-item dropdown dropleft d-none d-lg-block d-lg-block">
              <img src="../assets/Images/default_user_profile_white.png" class="rounded-circle dropdown-toggle" role="button" style="width: 40px;height: 40px;background-color:white;" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" id="dropdownMenuLink">
              <ul class="dropdown-menu list-unstyled" aria-labelledby="dropdownMenuLink">
                <li class="dropdown-item" type="button" v-if="userData">
                  <a href="#">{{userData.displayName}}</a> 
                </li>
                <li class="dropdown-item" type="button">
                  <router-link  :to="{ name: 'MyProfile' }"> My profile </router-link>
                </li>
                <li v-if="hideSignUpContentCreator" class="dropdown-item" type="button">
                  <router-link  :to="{ name: 'MyCrowdFundings' }"> My crowd funding </router-link>
                </li>
                <li v-if="hideSignUpContentCreator" class="dropdown-item" type="button">
                  <router-link  :to="{ name: 'MyEarnings' }"> My earnings </router-link>
                </li>

                <!-- <li class="dropdown-item" type="button">
                  <router-link  :to="{ name: 'Settings' }"> Settings </router-link>
                </li> -->
                <li class="dropdown-item" type="button"> 
			<a href="javascript://"  @click="logout" >Signout</a>
		</li>
              </ul>
            </li>
            

          </ul>

        </div>
        <div class="pull-right d-none d-lg-block d-lg-block">

          <form class=" inline my-2 my-lg-0" v-if="showLogin">
            <button class="btn create-account-btn my-2 my-sm-0 btn_radius color_fffffff" type="button" data-toggle="modal" data-target="#signUpModal">Create an Account</button>
            <button  class="btn signIn-btn my-2 my-sm-0 btn_radius color_fffffff" type="button" data-toggle="modal" data-target="#signInModal">Sign In</button>
          </form>

          <!-- <form class=" inline my-2 my-lg-0" v-if="!showLogin">
            <button  @click="logout" class="btn signIn-btn my-2 my-sm-0 btn_radius color_fffffff" type="button" >Sign Out</button>
          </form> -->
            
        </div>
      </nav>

      <v-layout row justify-center>
      <v-dialog v-model="dialogt" fullscreen hide-overlay transition="dialog-bottom-transition">
        <v-card>
          <v-toolbar dark color="primary">
            <v-btn icon dark @click="dialogt = false">
              <v-icon>close</v-icon>
            </v-btn>
            <v-toolbar-title>{{ titleDialogt }}</v-toolbar-title>
          </v-toolbar>
          <component v-bind:is="componentDialogt"></component>
        </v-card>
      </v-dialog>
    </v-layout>
  </div>
</template>

<script>
import AccountMenu from "./AccountMenu.vue";
import store from "../store/index";

import PrivacyPolicy from "../components/PrivacyPolicy";
import CookiePolicy from "../components/CookiePolicy";
import ContentCreator from "../components/ContentCreator";
import CommunityAgreement from "../components/CommunityAgreement";
import LicenseAgreement from "../components/LicenseAgreement";
import AboutUs from "./About";
import FAQs from "./FAQs";
import CommunityAgreementVue from "./CommunityAgreement.vue";
import LicenseAgreementVue from "./LicenseAgreement.vue";
import CallToActionTerms from "./CallToActionTerms";

export default {
  components: {
    AccountMenu
  },
  computed: {
    showLogin() {
      this.userData=store.getters.getFUser;
        
      return store.getters.getUser == null;
    },
    hideSignUpContentCreator() {
      return store.getters.getFUser != null
        ? store.getters.getFUser.isContentCreator
        : false;
    }
  },
  data: () => {
    return {
      query: "",
      dialogt: false,
      titleDialogt: "",
      componentDialogt: null,
      sideNav: false,
      userData: {},
    };
  },
    mounted() {

    //SideMenu toggling
    $('body,html').on("click", (event) =>{

      //console.log("Clicked outside",event.target,this.sideNav)

      //event.stopPropagation();

      var sidebar = $('#mySidenav');
      var a=event.target
      var a_class=$(a).attr('class')

      if(a !== sidebar  && a_class != 'menu_sticks_item'){
        this.sideNav=false
      }


    });

  },
  methods: {
    toggleSideMenu(){
      console.log("Toggle side menu",this.sideNav)
      this.sideNav = !this.sideNav
    },
    logout() {
      this.sideNav=false;
    try{

            this.$store.dispatch("signOut").then(() => {

                this.$router.push({ name: "Previews" });

                //console.log("Signout successful")

               this.$toasted.show("Sign out successful", {
                theme: "outline",
                position: "top-right",
                duration: 2000
              });

            });


          }catch(err){
            console.log("Error: ",err)
          }
    },
    goLoginContentCreator() {
       this.sideNav = false;
      if (this.showLogin) {

        this.$root.$emit('openLoginForm');
        return;
      }
      if (!this.hideSignUpContentCreator) {
        this.$root.$emit('openSignupCCForm');
        return;
      }
    },
    goCallToAction() {
      this.$router.push({
        name: "SingleCategory",
        query: { category: "Call-to-Action" }
      });
    },
    goLoginLive() {
       this.sideNav = false;
      if (this.showLogin) {
        this.$root.$emit('openLoginForm');

      } else {
        this.$router.push({ name: "AddExcluzeev" });
      }
    },
    goLoginCreate() {
       this.sideNav = false;
      if (this.showLogin) {
        this.$root.$emit('openLoginForm');

      } else {
        this.$router.push({ name: "CreateChannel" });
      }
    },
    goToCommunities() {
      this.$router.push({ name: "Communities" });
    },
    goToSubscriptions() {
      this.$router.push({ name: "MySubscriptions" });
    },
       goToMyCrowdFunding(){
      this.sideNav=false;
      this.$router.push("/my-crowd-fundings");
    },
    goToMyEarnings(){
      this.sideNav=false;
      this.$router.push("/my-earnings");
    },
    goToMyProfile(){
      this.sideNav=false;
      this.$router.push("/my-profile");
    },
    goToMyChannels() {
      this.$router.push({ name: "MyChannels" });
    },
    searchPreviews() {
      this.sideNav = false;
      this.$router.push({
        name: "SearchPreviews",
        params: { query: this.query }
      });
    },
        showCommunityAgreement() {
      this.titleDialog = "Community Agreement";
      this.componentDialog = CommunityAgreement;
      this.sideNav = false;
      this.dialogt = true;
    },
    showPrivacyPolicy() {
      this.sideNav = false;
      this.titleDialogt = "Privacy Policy";
      this.componentDialogt = PrivacyPolicy;
      this.dialogt = true;
    },
    showCookiePolicy() {
      this.sideNav = false;
      this.titleDialogt = "Cookie Policy";
      this.componentDialogt = CookiePolicy;
      this.dialogt = true;
    },
    showContentCreatorTerms() {
      this.sideNav = false;
      this.titleDialogt = "Terms Of Service For Creators";
      this.componentDialogt = ContentCreator;
      this.dialogt = true;
    },

    showCallToActionTerms() {
      this.sideNav = false;
      this.titleDialogt = "Excluzeev Call To Action Terms";
      this.componentDialogt = CallToActionTerms;
      this.dialogt = true;
    },
    showCommunityMemberAgreement() {
      this.sideNav = false;
      this.titleDialogt = "Community Member Agreement";
      this.componentDialogt = CommunityAgreement;
      this.dialogt = true;
    },

    showLicenseAgreement() {
      this.sideNav = false;
      this.titleDialogt = "License Agreement";
      this.componentDialogt = LicenseAgreement;
      this.dialogt = true;
    },
    showAboutUs() {
      this.sideNav = false;
      this.titleDialogt = "About Us";
      this.componentDialogt = AboutUs;
      this.dialogt = true;
    },
    showFAQs() {
      this.sideNav = false;
      this.titleDialogt = "FAQs";
      this.componentDialogt = FAQs;
      this.dialogt = true;
    },
    nullDialog() {
      this.titleDialogt = "";
      this.componentDialogt = null;
    },

    showHowTo() {
      this.$router.push({ name: "HowTo" });
    }
  }
};

  
</script>

<style scoped>


.homepage-nav {
  padding: 2% 3% 0 3%;
  background: #16120e !important;
} 
  
.navbar{padding-left: 0;padding-right: 0;width: 100% }
.btn_radius{border-radius: 22px; }
.color_fffffff{color: #FFFFFF }
.nav-item{padding: 0 7.5px}
.nav-home{display: flex;}
.navbar-brand{padding: 0}
.navbar-brand>p{text-align: right;margin-bottom: 0;padding-right: 8px;font: 27px/34px quicksand-medium}
a{width: max-content;font:18px/22px rubik-regular;}
a:hover{color: #FFFFFF}
.bri_n_teesh_title p{font:18px/22px rubik-regular;margin-bottom: 23px;color: #FFFFFF}
.navbar-expand-lg .navbar-nav .nav-link{padding-right: 0;padding-left: 0 }
.row-auto{ margin:0 auto}
.has-search .form-control-feedback {position: absolute; z-index: 2; display: block; width: 2.375rem; height: 2.375rem; line-height: 2.375rem; text-align: center; pointer-events: none; color: #FFFFFF; font-size: 14px/17px; font-weight: 400!important }
.has-search .form-control {width: 100%; padding-left: 35px; background-color: transparent; color: #FFFFFF }
.has-search{margin-bottom: 0!important;    width: 321px;}
#home .search{margin-bottom: 0!important;margin-right: 0!important;outline: none!important;width: 382px;}
#home .search:focus{outline: none!important;}
.form-control::-webkit-input-placeholder {font:14px/17px rubik-regular; color: #FFFFFF; }
.form-control:-ms-input-placeholder { /* Internet Explorer */ font:14px/17px rubik-regular; color: #FFFFFF; }
.form-control::placeholder {font:14px/17px rubik-regular; color: #FFFFFF; }
.create-account-btn, .signIn-btn,.create-account-btn:hover,
.signIn-btn:hover,{color:#FFFFFF;padding: 8px 15px;font:18px/22px rubik-regular;}


.sidenav {height: 100%;  position: fixed; z-index: 2; padding-bottom: 15%;top: 0; left: 0; background-color: #FFFFFF; overflow-x: hidden; transition: 0.5s; padding-top: 20px; }
.sidenav img{width: 150px;margin-left: 53px;margin-bottom: 20px;} 
.sidenav a {padding: 0; margin: 12px 8px 12px 32px; text-decoration: none; font: 15px/19px rubik-regular; color: #000; display: block; transition: 0.3s; }
.sidenav a:hover {color: #000; } 
.sidenav .closebtn {position: absolute; top: 0; right: 0; font-size: 36px; margin-left: 50px; color: #29ABE2; }
.sidenav hr{margin: 12px 8px 12px 32px;border:1px solid #29ABE2;width: 20px}


</style>
