<template>
    <div class="footer">
    <div class="footer_brand_section d-none d-xs-block  d-sm-none d-md-none d-lg-block d-xl-block">
			<a class="navbar-brand" href="index.html"><img src="../assets/Images/logo.svg" draggable="false"></a>
		</div>

		<div class="footer_section d-none d-xs-block  d-sm-none d-md-none d-lg-block d-xl-block ">
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-4 col-sm-4 col-lg-4 col-xl-2">
						<h4>COMPANY</h4>
						<a href="javascript://" @click="showAbout">About</a>
						<a href="javascript://">Careers</a>
						<a href="javascript://">News</a>
					</div>
					<div class="col-md-4 col-sm-4 col-lg-4 col-xl-2">
						<h4>ACCOUNT</h4>
						<a href="javascript://" v-if="userData" @click="goToCommunities">My Community</a>
						<a href="javascript://" v-if="userData" @click="goToMyProfile">My Profile</a>


					</div>
					<div class="col-md-4 col-sm-4 col-lg-4 col-xl-2">
						<h4>SUPPORT</h4>
						<a href="javascript://">Contact Support</a>
						<a href="/howto">Help Guide</a>
						<a href="javascript://" @click="showFAQs">FAQ</a>

					</div>
					<div class="col-md-4 col-sm-4 col-lg-4 col-xl-2">
						<h4>LEGAL</h4>
						<a href="javascript://" @click="showPrivacyPolicy">Privacy Policy</a>
          
						<a href="javascript://" @click="showCookiePolicy">Cookie Policy</a>
						<a href="javascript://" @click="showCommunityAgreement">Community Member Agreement</a>
						<a href="javascript://" @click="showContentCreatorTerms">Content Creator Terms</a>
						<a href="javascript://" @click="showCallToActionTerms">Call to Action Terms</a>
						<a href="javascript://" @click="showLicenseAgreement">Content Creator Licence Agreement</a>
					</div>
					<div class="col-md-4 col-sm-4 col-lg-4 col-xl-2">
						<h4>PARTNERSHIP</h4>
						<a href="javascript://">Advertise With Us</a>
						<a href="javasript://">Partnerships</a>
						<a href="javascript://">Content Research</a>
					</div>
					<div class="col-md-4 text-center col-sm-4 col-lg-4 col-xl-2">
						<ul class="list-unstyled inline-list bootom_social_links">
							<li><a href="https://www.instagram.com/excluzeev/" target="_blank"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
							<li><a href="https://www.twitter.com/excluzeev/" target="_blank"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
							<li><a href="https://www.facebook.com/excluzeev" target="_blank"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
						</ul>
						<a href="https://itunes.apple.com/bt/app/excluzeev/id1457995935?mt=8" target="_blank"><img src="../assets/Images/Download_on_the_App_Store_Badge.svg"></a>
						<a href="https://play.google.com/store/apps/details?id=com.trenstop.mobile" target="_blank"><img src="../assets/Images/Google_Play_Store_badge_EN.svg"></a>
					</div>
				</div>
			</div>
		</div>
		<div class="copyright_section text-center d-none d-xs-block  d-sm-none d-md-none d-lg-block d-xl-block">
			<hr>
			<p>Copyright © 2019 Excluzeev, Inc. All rights reserved.</p>
			<!-- <p>A Design by Tracy Tech Works</p> -->
		</div>
		<div class="footer_menu_section  d-xs-block d-lg-none d-xl-none d-md-block">
			<nav class="navbar fixed-bottom navbar-light bg-faded">
				<div class="pull-left">
					<a class="" href="/"><i class="fa fa-home" aria-hidden="true"></i></a>
				</div>
				<div class="text-center row-auto footer-searchbar">
					<div class="form-group has-search">
						<span class="fa fa-search form-control-feedback color_fffffff"></span>

                          <form @submit.prevent="searchPreviews" style="margin:0;">


						<input @click:append="searchPreviews" v-model="query" class="form-control mr-sm-2 btn_radius color_fffffff search" type="search" placeholder="Find the Content Creators, Communities or Videos" aria-label="Search">

                        </form>


					</div>
					<!-- <a class="" href="#"><i class="fa fa-users" aria-hidden="true"></i></a> -->
				</div>
                <!--
				<div class="pull-right">
					<a class="" href="#"><i class="fa fa-cog" aria-hidden="true"></i></a>
				</div>
                -->
			</nav>
		</div>



    <v-layout row justify-center>
      <v-dialog v-model="dialog" fullscreen hide-overlay transition="dialog-bottom-transition">
        <v-card>
          <v-toolbar dark color="primary">
            <v-btn icon dark @click="dialog = false">
              <v-icon>close</v-icon>
            </v-btn>
            <v-toolbar-title>{{ titleDialog }}</v-toolbar-title>
          </v-toolbar>
          <component v-bind:is="componentDialog"></component>
        </v-card>
      </v-dialog>
    </v-layout>


  </div>

	

</template>

<script>
import PrivacyPolicy from "./PrivacyPolicy";
import CookiePolicy from "./CookiePolicy";
import About from "./About";
import FAQs from "./FAQs";
import ContentCreator from "./ContentCreator";
import CommunityAgreement from "./CommunityAgreement";
import CallToActionTerms from "../components/CallToActionTerms";
import LicenseAgreement from "./LicenseAgreement";
import store from "../store";

export default {
  name: "FooterComponent",
  data: () => {
    return {
      dialog: false,
      privacyPolicy: false,
      termsCreator: false,
      terms: false,
      dialog: false,
      titleDialog: "",
      componentDialog: null,
      query:"",
	  userData:null,
    };
  },
  created(){


  		setTimeout( () =>{
             this.userData=store.getters.getFUser

        },2000)



  },
  methods: {
    goToMyProfile(){
      this.$router.push("/my-profile");
    },
	  goToCommunities() {
      this.$router.push({ name: "Communities" });
    },
       searchPreviews() {
      this.sideNav = false;
      this.$router.push({
        name: "SearchPreviews",
        params: { query: this.query }
      });
    },
     openCookiePolicy: function() {
      window.open("https://excluzeev.com/cookie-policy", "_blank");
    },
     showCallToActionTerms() {
      this.titleDialog = "Excluzeev Call To Action Terms";
      this.componentDialog = CallToActionTerms;
      this.dialog = true;
    },
    showPrivacyPolicy() {
      this.titleDialog = "Privacy Policy";
      this.componentDialog = PrivacyPolicy;
      this.dialog = true;
    },
    showAbout() {
      this.titleDialog = "About Us";
      this.componentDialog = About;
      this.dialog = true;
    },
    showFAQs() {
      this.titleDialog = "FAQs";
      this.componentDialog = FAQs;
      this.dialog = true;
    },
     showContentCreatorTerms() {
      this.titleDialog = "Terms Of Service For Creators";
      this.componentDialog = ContentCreator;
      this.dialog = true;
    },
    showCookiePolicy() {
      this.titleDialog = "Cookie Policy";
      this.componentDialog = CookiePolicy;
      this.dialog = true;
    },

    showCommunityAgreement() {
      this.titleDialog = "Community Agreement";
      this.componentDialog = CommunityAgreement;
      this.dialog = true;
    },
    showLicenseAgreement() {
      this.titleDialog = "License Agreement";
      this.componentDialog = LicenseAgreement;
      this.dialog = true;
    }
  }
};
</script>

<style scoped>

</style>
