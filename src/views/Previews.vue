<template>
  <div class="previews" :key="$route.fullPath">
	  <div id="preview_home">
	  	<div class="container">
	  	<section class="title_section">
			<p><i class="fa fa-tripadvisor" aria-hidden="true"></i>Artist/Band/Vlog</p>
				<div class="bri_n_teesh_title">
					<h1>BRI N TEESH</h1>
					<p>Two best friends who navigate life in Los Angeles.</p>
				</div>
				<div class="viedo_preview d-xs-block d-lg-none d-md-none ">
					<i class="fa fa-play-circle" aria-hidden="true"></i>
				</div>
			<div class="inline d-none d-xs-none d-md-block d-lg-block">
				<button class="btn watch_preview-btn my-2 my-sm-0 btn_radius color_fffffff" type="button"><i class="fa fa-play" aria-hidden="true"></i>&nbsp; &nbsp;Watch preview</button>
				<button class="btn join_the_community-btn my-2 my-sm-0 btn_radius color_fffffff" type="button">Join the community</button>
			</div>
			
		</section>
	  	</div>
	  </div>
  	<div id="black_bg_section">
	 	<CategoriesTrailerVideos />
  	</div>
  </div>
</template>

<script>

	

// @ is an alias to /src
// import FeaturedItem from "../components/FeaturedItem";
import CategoriesTrailerVideos from "../components/CategoriesTrailerVideos";

export default {
  name: "Previews",
  components: {
	CategoriesTrailerVideos,
  },
  data: () => {
    return {
    };
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
  }
};


// import '../assets/owlcarousel/js/owl.carousel.js';
// import '../assets/javaScript.js';

</script>

	
	

<style>
	@import '../assets/owlcarousel/css/docs.theme.min.css';
	@import '../assets/owlcarousel/css/owl.carousel.min.css';
	@import '../assets/owlcarousel/css/owl.theme.default.min.css';
	@import '../assets/css/previews.css';

	
</style>