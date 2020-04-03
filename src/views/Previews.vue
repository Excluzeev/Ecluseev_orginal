<template>
  <div class="home" :key="$route.fullPath">

     <!-- Promote content creaters slider start -->
        

 
	  <div id="home">
        

              <div class="owl-carousel owl-theme" id="cc-owl-carousel">

                <div class="item" v-for="banner in promotedBanners" v-bind:key="banner.id">

                        <img :src="banner.image" style="height:540px;"/>
                        
                        <div v-if="banner.isTrailer" class="container-fluid banner-controls">
                            <section class="title_section" v-if="banner.trailer">
                                <p class="channel_type"><i class="fa fa-tripadvisor" aria-hidden="true"></i>{{banner.trailer.categoryName}}</p>

                        
                                    <div class="bri_n_teesh_title">
                                        <h1 class="h1">{{banner.trailer.title}}</h1>
                                        <!--
                                        <p class="content_provider_tittle">Two best friends who navigate life in Los Angeles.</p>
                                        -->
                                    </div>
                                    <div class="viedo_preview d-xs-block d-lg-none d-md-none ">
                                        <i class="fa fa-play-circle" aria-hidden="true"></i>
                                    </div>
                                    
                                <div class="inline d-none d-xs-none d-md-block d-lg-block">

                                     <router-link :to="'/trailer/'+banner.trailerId">

                                        <button class="btn watch_preview-btn my-2 my-sm-0 btn_radius color_fffffff" type="button"><i class="fa fa-play" aria-hidden="true"></i>&nbsp; &nbsp;Watch preview</button>
                                    </router-link>

                                     <router-link :to="'/trailer/'+banner.trailerId">
                                        <button class="btn join_the_community-btn my-2 my-sm-0 btn_radius color_fffffff" type="button">Join the community</button>  
                                    </router-link>
                                </div>
                            
                            </section>
                        </div>
                 </div>


            </div>

       </div>



     <!-- Promote content creaters slider end -->
    

      <div id="black_bg_section">
	 	<CategoriesTrailerVideos />
  	  </div>
  </div>
</template>

<script>

	

// @ is an alias to /src
// import FeaturedItem from "../components/FeaturedItem";
import CategoriesTrailerVideos from "../components/CategoriesTrailerVideos";
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import store from "../store/index";
import trailersModule from "../store/trailers/trailer";
import channelsModule from "../store/channels/channels";

export default {
  name: "Previews",
  components: {
	CategoriesTrailerVideos,
  },
  data: () => {
    return {
        promotedBanners:[],
    };
  },
  mixins: [RegisterStoreModule],
  created() {
    this.registerStoreModule("trailers", trailersModule);
    this.registerStoreModule("channels", channelsModule);


  },
 computed: {
  },

  methods: {
  },
  async mounted() {
    // if (this.$route.query.done) {
    //   await this.$store.commit("forceFetchUser", {
    //     user: auth.currentUser,
    //     force: true
    //   });
	// }




	
	   $("#search_btn").click(function(){
		  	$("#search_btn").hide("slow");
		  	$(".footer_search_section").show("slow");
		  	$(".footer_search_section").slideDown("slow");
		  	$(".footer_menu_section_icons").hide("slow");
		});

		$(".footer_search_section i.fa.fa-angle-down, .footer_search_section a").click(function(){
			$("#search_btn").show("slow");
			$(".footer_search_section").hide("slow");
		  	$(".footer_search_section").slideUp("slow");
		  	$(".footer_menu_section_icons").show("slow");
		});
		
		let owl_carousel = require('owl.carousel');
		window.fn = owl_carousel;
        
       // Get promoted trailers
       this.$store.dispatch("channels/getActivePromotedBanners").then(data => {

                this.promotedBanners=data


            this.$nextTick(function(){

                    console.log("CC carousel loaded",$("#cc-owl-carousel"));
                    $("#cc-owl-carousel").owlCarousel({
                      loop: true, 
                      navigation : true, // Show next and prev buttons
                      slideSpeed : 300,
                      paginationSpeed : 400,
                      items : 1,
                      stagePadding: 0,
                      margin:50, 
                      itemsDesktop : false,
                      itemsDesktopSmall : false,
                      itemsTablet: false,
                      itemsMobile : false,
                      nav: true,
                      autoplay:true,
                      autoplayTimeout:3000,
 
                  });
        });



        });
        
  }
};




//import '../assets/javaScript.js';

</script>

	
	

<style scoped>

@import '../assets/owlcarousel/css/docs.theme.min.css';
@import '../assets/owlcarousel/css/owl.carousel.min.css';
@import '../assets/owlcarousel/css/owl.theme.default.min.css';


#home{padding:0; background-size: 100%; opacity: 1; background: linear-gradient(180deg, #000000E6 0%, #000000BD 8%, #00000000 17%, #00000000 80%, #0000004B 90%, #000000 100%), linear-gradient(18deg, #2598C9E8 10%,transparent, transparent); background-size:cover; background-repeat: no-repeat; }


#home{

    height:540px;

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
.tittle{font:18px/22px rubik-regular;margin-bottom: 23px;color: #FFFFFF}
.navbar-expand-lg .navbar-nav .nav-link{padding-right: 0;padding-left: 0 }
.row-auto{ margin:0 auto;}
.has-search .form-control-feedback {position: absolute; z-index: 2; display: block; width: 2.375rem; height: 2.375rem; line-height: 2.375rem; text-align: center; pointer-events: none; color: #FFFFFF; font-size: 14px/17px; font-weight: 400!important }
.has-search .form-control {width: 100%; padding-left: 35px; background-color: transparent; color: #FFFFFF }
.has-search{margin-bottom: 0!important}
#home .search{margin-bottom: 0!important;margin-right: 0!important;outline: none!important;width: 382px;}
#home .search:focus{outline: none!important;}
.form-control::-webkit-input-placeholder {font:14px/17px rubik-regular; color: #FFFFFF; }
.form-control:-ms-input-placeholder { /* Internet Explorer */ font:14px/17px rubik-regular; color: #FFFFFF; }
.form-control::placeholder {font:14px/17px rubik-regular; color: #FFFFFF; }
ul.navbar-nav.row-auto{margin-top: }
.create-account-btn, .signIn-btn,.create-account-btn:hover,
.signIn-btn:hover,.watch_preview-btn,
.join_the_community-btn,.watch_preview-btn:hover,
.join_the_community-btn:hover{color:#FFFFFF;padding: 8px 15px;font:18px/22px rubik-regular;}
.signIn-btn,.signIn-btn:hover,.watch_preview-btn,
.watch_preview-btn:hover{border-color: #FFFFFF;}
.watch_preview-btn{margin-right: 25px}
.join_the_community-btn{background-color: #000000;border-color: #000000}
.join_the_community-btn:focus{border-color: #000000}
.create-account-btn{margin-right: 10px;background-color: #29ABE2;border-color: #29ABE2}
.create-account-btn:focus{border-color: #29ABE2}
.popper_section>h3>a,.popper_section>h3>a:hover{color: #fff}
.title_section{padding-top:23%;}
.title_section>p>i{padding-right: 10px;}
.channel_type{font:25px/29px rubik-regular !important; color: #FFFFFF !important; padding-bottom: 24px; line-height: 25px !important; margin: 0; }
.h1{margin: 0;font:30px/40px rubik-medium;color: #FFFFFF;}
#black_bg_section{padding: 0 8% 30px 8%; background: #000000 0% 0% no-repeat padding-box; opacity: 1;margin-top: -1px} 


.owl-carousel .item{background: transparent; }


.owl-carousel-1 .item img{
    display: block;
    width: 100%;
    height: auto;
}

.owl-carousel-1 {margin: 0!important }

.owl-carousel-1 .owl-item{
    width:100%;
}


button.owl-prev,button.owl-next{position: absolute; top: 20%; font-size: 0px!important; background: transparent; color: #fff!important; opacity: 1!important; outline: none; margin: 0; padding: 0; }
button.owl-prev{left: -60px;}
button.owl-next{right: -60px;}
button.owl-prev span, button.owl-next span{font-size: 100px; opacity: 1; }
.owl-theme .owl-nav [class*=owl-]:hover,.owl-theme .owl-nav [class*=owl-] {background: transparent!important; color: #FFF; text-decoration: none; }
.item>p>i{color: #29ABE2}
.large-12.columnss{width: 100%}
#demos .owl-carousel .item{padding-right: 42px}
#black_bg_section .item p{font:14px/17px rubik-light;color: #fff;padding-top: 10px;margin-bottom: 0;}
.owl-theme .owl-dots .owl-dot{display: none!important;}
.artist_section>h3>img,.tutorials_section>h3>img{width: 34px;padding-right: 10px}
.footer_brand_section{padding: 168px 0 80px 0 }
.footer_section a{color: #fff; font: 18px/22px rubik-regular; width: auto; display: flex; padding-bottom: 11px; text-align: left; padding-left: 0; padding-right: 0; }
.footer_section a>img{padding-bottom: 23px}
.footer_section ul>li>a>i{font-size: 36px;}
.footer_section ul{text-align: center;margin-right: 0;margin-left: 0}
.footer_menu_section,.fixed-bottom{background-color: #29ABE2;color: #FFFFFF;padding-left: 25px;padding-right: 25px}
.footer_menu_section,.fixed-bottom a{color: #FFFFFF;font-size:30px;}
h5{text-transform: uppercase;color: #29ABE2;font:15px/19px rubik-medium;margin: 12px 8px 12px 32px;margin-top: 10px;margin-bottom: 10px;}
h5:after {content: ""; width: 48px; position: absolute; right: 70px; margin-top: 8px; height: 2px; background: #29abe2; display: inline-block; }
.menu_sticks>span{margin: 5px 0;border-radius: 4px; }
.menu_sticks>span:nth-child(1) {display: block; width: 20px; background: #FFFFFF; height: 4px; }
.menu_sticks>span:nth-child(2) {display: block; width: 40px; background: #FFFFFF; height: 4px; }
.menu_sticks>span:nth-child(3) {display: block; width: 30px; background: #FFFFFF; height: 4px; }
.sidenav {height: 100%; width: 0; position: fixed; z-index: 2; padding-bottom: 15%;top: 0; left: 0; background-color: #FFFFFF; overflow-x: hidden; transition: 0.5s; padding-top: 20px; }
.sidenav img{width: 150px;margin-left: 53px;margin-bottom: 20px;} 
.sidenav a {padding: 0; margin: 12px 8px 12px 32px; text-decoration: none; font: 15px/19px rubik-regular; color: #000; display: block; transition: 0.3s; }
.sidenav a:hover {color: #000; } 
.sidenav .closebtn {position: absolute; top: 0; right: 0; font-size: 36px; margin-left: 50px; color: #29ABE2; }
.sidenav hr{margin: 12px 8px 12px 32px;border:1px solid #29ABE2;width: 20px}
.logout_link{width: 150px!important; margin-right: 15px !important;}
.social_links a i{font-size: 35px; color: #29abe2;}
.social_links a{margin: 0!important}
.social_links{margin: 15px 8px 8px 32px!important;}
.social_links li:nth-child(1){margin-left: 0}
.social_links li{margin-left: 35px;}
button.btn.btn-borderless {padding: 0; line-height: 1px; color: #fff; outline: none; border: transparent; font-size: 35px; }
.viedo_preview{position: relative;}
.viedo_preview>i{font-size: 100px;color: #FFFFFF}
.owl-nav i{font-size: 50px!important;}
.column, .columns{padding-right: 0;padding-left: 0}
.bootom_social_links>li:first-child{margin-left: 2%}
.bootom_social_links>li{margin-left: 20%;}
.container-fluid{padding-right: 0;padding-left: 0}
.col-md-4 ,.col-sm-4 ,.col-lg-4 ,.col-xl-2{padding-left: 0}




.banner-controls{
    position: absolute;
    top: 0;
    left: 53px;
}

</style>
