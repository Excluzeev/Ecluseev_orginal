<template>

    <div class="home">
    <div style="padding-top:25px"></div>
  		<div id="home">
			<div class="container-fluid">
				<div class="row">
					<div class="offset-xl-2 col-xl-8 offset-xl-2  offset-md-1  col-md-10 offset-md-1 offset-lg-1 col-lg-10  offset-lg-1 text-center">
						<h1 class="inline-list"><img src="../assets/Images/home_logo.png"><!--<span>den</span>--></h1>
						<h4>of</h4>
						<h2>Content Creators</h2>
						<p>A platform where content creators feature and monetize their exclusive content.</p>
						<div class="inline-list">
							<router-link :to="{ name: 'Previews' }" class="">
							    <button class="btn btn-explore-previews btn_radius color_fffffff">Explore Previews</button>							
							</router-link>
							<button class="mt-1 btn btn-learn-more">Learn More</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="how-does-it-works-section">
			<div class="container-fluid">
				<div class="row">
					<div class="col-xl-12 text-center">
						<h3>How does it work?</h3>
					</div>
				</div>
				<div class="row ">
					<div class="col-xl-4 col-lg-4 col-md-4 text-center">
						<h4>UPLOAD</h4>
						<img src="../assets//Images/2.png" class="img-fluid">
						<p>Create a community and upload your recordings or videos based on your category in the website</p>
					</div>
					<div class="col-xl-4 col-lg-4 col-md-4 text-center">
						<h4>SHARE</h4>
						<img src="../assets//Images/1.png" class="img-fluid">
						<p>Promote the preview video to the world on your social platforms</p>
					</div>
					<div class="col-xl-4 col-lg-4 col-md-4 text-center">
						<h4>EXCLUZEEV!</h4>
						<img src="../assets//Images/3.png" class="img-fluid">
						<p>Go excluzeev! and generate revenue from your fans joining your community</p>
					</div>
				</div>
			</div>
		</div>
		<div id="curious_section">
			<div class="container-fluid">
			<div class="row">
				<div class="offset-xl-2 col-xl-8  offset-lg-1 col-lg-9 col-md-12">
					<div class="list-inline curious_section ">
						<div class="curious_title_top">
							<h3>Curious?</h3>
							<div class="list-inline title_btn_inline "><h4>Let’s</h4>

							<router-link :to="{ name: 'CreateChannel' }" class="">

                                <button class="btn btn-lts-start">
                                        Start
                                </button>
							</router-link>

                            <h4>a community now!</h4></div>
							<p>It takes less than a minute to upload your first video</p>
						</div>
					</div>
				</div>
			</div>
			</div>
		</div>


		


  </div>
</template>

<script>



export default {
  name: "Home",
  components: {
  },
  data: () => {
    return {
    };
  },
  methods: {
  },
  async mounted() {

    console.log("env",process.env)

    //console.log("Home mounted",this.$route.query.done);
    if (this.$route.query.done) {
      await this.$store.commit("forceFetchUser", {
        user: auth.currentUser,
        force: true
      });
	}

  }
};
</script>
	 
