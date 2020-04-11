<template>
  
		<div class="nav_section homepage-nav">
			<nav class="nav-home navbar-expand-lg navbar " id="nav">
				<div class="pull-left d-md-block d-xl-none d-lg-none">
					<div id="mySidenav" class="sidenav" v-show="sideNav">
						<div class="inline-list ">
							<img src="../assets/Images/menu_logo.png">
							<a href="javascript:void(0)" class="closebtn" @click="sideNav = false">&times;</a>
						</div>
            <template v-if="!showLogin">
						  <h5>Account</h5>
						  <a href="#">My Profile</a>
					    <a href="#" @click="goToCommunities">Communities</a>
						  <a href="#"  @click="goLoginLive">Excluzeev Live</a>
						  <a href="#">Setting</a>
            </template>
						<h5>COMPANY</h5>
						<a href="#" @click="showAboutUs">About</a>
						<a href="#">Careers</a>
						<a href="#">News</a>
						<h5>SUPPORT</h5>
						<a href="#">Contact Support</a>
						<a href="#" @click="showHowTo">Help Guide</a>
						<a href="#" @click="showFAQs">FAQ</a>
						<h5>LEAGAL</h5>
						<hr>
						<a v-if="!showLogin" href="#" @click="logout">Logout</a>
						<hr class="logout_link">
						<ul class="list-unstyled inline-list social_links">
							<li><a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
							<li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
							<li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
						</ul>
					</div>
					<div class="menu_sticks" @click="sideNav = !sideNav">
						<span></span>
						<span></span>
						<span></span>
					</div>
				</div>

				<div class="pull-left  home_brand ">
					<a class="navbar-brand" href="/">
						<img src="../assets/Images/logo.svg" draggable="false">
					</a>
				</div>



				<div class="text-center row-auto d-none d-lg-block d-lg-block" id="navbarSupportedContent row-auto ">
					<ul class="navbar-nav row-auto">
						<!-- <li class="nav-item color_fffffff">
							<a class="nav-link color_fffffff" href="#" @click="showAboutUs">About Excluzeev</a>
						</li> -->
						<li class="nav-item color_fffffff search_group">
							<div class="form-group has-search">
								<span class="fa fa-search form-control-feedback color_fffffff"></span>
                        <form @submit.prevent="searchPreviews" style="margin:0;">
                          
                          	<input @click:append="searchPreviews" v-model="query" class="form-control mr-sm-2 btn_radius color_fffffff search" type="search" placeholder="Find the Content Creators, Communities or Videos" aria-label="Search">

                        </form>

							</div>
						</li>
						
          
            <li  v-if="!hideSignUpContentCreator&!showLogin" class="nav-item d-none d-lg-block d-lg-block">

              	<button  class="btn signIn-btn my-2 my-sm-0 btn_radius color_fffffff" type="button" data-toggle="modal" data-target="#becomeCCModal">
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
            <!-- For testing -->
            <!-- 
            <li v-if="!showLogin" class="nav-item d-none d-lg-block d-lg-block">
							<button @click="goLoginLive" class="btn signIn-btn my-2 my-sm-0 btn_radius color_fffffff" type="button" >
								<img src="../assets/Images/live.png"> Excluzeev Live
							</button>
						</li>
						<li v-if="!showLogin" class="nav-item d-none d-lg-block d-lg-block">
							<button @click="goLoginCreate"  class="btn create-account-btn my-2 my-sm-0 btn_radius color_fffffff" type="button" >+ Create a community</button>
						</li>
						<li v-if="!showLogin" class="nav-item d-none d-lg-block d-lg-block">
							<button @click="goToCommunities" class="btn signIn-btn my-2 my-sm-0 btn_radius color_fffffff" type="button" >Communities</button>
						</li>
               
            -->
						<li v-if="!showLogin" class="nav-item dropdown dropleft d-none d-lg-block d-lg-block">
							<img src="../assets/Images/commu_image.png" class="rounded-circle dropdown-toggle" role="button" style="width: 40px;height: 40px" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" id="dropdownMenuLink">
							<ul class="dropdown-menu list-unstyled" aria-labelledby="dropdownMenuLink">


								<li class="dropdown-item" type="button" v-if="userData"><a href="#">{{userName}}</a> </li>

                         		<li class="dropdown-item" type="button">

                                     <router-link  :to="{ name: 'MyProfile' }">
                                      My profile
                                     </router-link>
                               </li>
                         		<li v-if="hideSignUpContentCreator" class="dropdown-item" type="button">
                                     <router-link  :to="{ name: 'MyCrowdFundings' }">
                                      My crowd funding
                                     </router-link>
                               </li>
						
                         		<li v-if="hideSignUpContentCreator" class="dropdown-item" type="button">

                                     <router-link  :to="{ name: 'MyEarnings' }">
                                      My earnings
                                     </router-link>
                               </li>

                                <!--
                         		<li class="dropdown-item" type="button">

                                     <router-link  :to="{ name: 'Settings' }">
                                      Settings
                                     </router-link>
                               </li>
                                -->

								<li class="dropdown-item" type="button"> 

                                     <router-link  :to="{ name: 'Logout' }">
                                      Signout
                                     </router-link>
                                    <!--
                                    <a href="#"  @click="logout" >Signout</a>
                                    -->
                                    </li>
							</ul>
						</li>
						




					</ul>
				</div>
				<div class="pull-right search_icon d-md-block d-xl-none d-lg-block">
					<button class="btn btn-borderless search_btn "><i class="fa fa-search" aria-hidden="true"></i></button>
				</div>
				<div class="pull-right d-none d-lg-block d-lg-block">

					<form class=" inline my-2 my-lg-0" v-if="showLogin">
						<button class="btn create-account-btn my-2 my-sm-0 btn_radius color_fffffff" type="button" data-toggle="modal" data-target="#signUpModal">Create an Account</button>
          	<button  class="btn signIn-btn my-2 my-sm-0 btn_radius color_fffffff" type="button" data-toggle="modal" data-target="#signInModal">Sign In</button>
					</form>

            
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
      this.userData=store.getters.getUser;
      let fuserData=store.getters.getFUser;
      if(fuserData)
        this.userName=fuserData.firstName+" "+fuserData.lastName

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
      userData: store.getters.getUser,
      userName:"",
    };
  },
  methods: {
    
    logout() {
      this.$router.push("/logout");
      this.$toasted.show("Sign out successful", {
        theme: "outline",
        position: "top-right",
        duration: 2000
      });


    },
    goToCrowd(){
      this.$router.push("/crowd");
    },
    goToMyEarnings(){
      this.$router.push("/my-earnings");
    },
    goToMyProfile(){
      this.$router.push("/my-profile");
    },
    goToSettings(){
      this.$router.push("/settingsss");
    },
    goLoginContentCreator() {
      if (this.showLogin) {

        this.$root.$emit('openLoginForm');
        return;
      }
      if (!this.hideSignUpContentCreator) {
        this.$router.push({ name: "SignUpCC" });
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
      if (this.showLogin) {
        this.$root.$emit('openLoginForm');

      } else {
        this.$router.push({ name: "AddExcluzeev" });
      }
    },
    goLoginCreate() {
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


</style>
