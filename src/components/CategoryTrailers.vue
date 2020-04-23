<template>
  <div class="top-padding" v-show="categoryTrailers.length > 0">
      <div v-for="item in categoryTrailers" v-bind:key="item.catId">

        <div class="pull-left">
			  	<h3><i class="fa fa-star" aria-hidden="true"></i>{{ item.catName }}


                <span style="color:grey;">({{item.trailers.length}})</span>
                </h3>
			  </div>
              <!--
			  <div class="pull-right d-md-none d-lg-none d-xs-block"><h3><a href="#">View All</a></h3></div>
	          -->
        <section id="popper_section_carosel">
          <div class="row">
            <div class="large-12 columns col-md-12 col-lg-12 col-xs-12 col-sm-12">
              <div class="owl-carousel owl-theme trailer-slider">
               
                <div class="item"   v-for="trailer in item.trailers" v-bind:key="trailer.trailerId">
              
                    
                  <TrailerVideoItem :trailer="trailer" />
        
                </div>


              </div>
            </div>
          </div>
        </section>


      </div>


  </div>
</template>

<script>
import RegisterStoreModule from "../mixins/RegisterStoreModule";
import trailerModule from "../store/trailers/trailer";
import TrailerVideoItem from "./TrailerVideoItem";

export default {
  name: "CategoryTrailers",
  components: {
    TrailerVideoItem
  },
  data: () => {
    return {
      categoryTrailers: []
    };
  },
  props: ["catId", "catName"],
  mixins: [RegisterStoreModule],
  computed: {},
  created() {
        this.registerStoreModule("trailers", trailerModule);
        
        const cat = {
          categoryId: this.$props.catId,
          categoryName: this.$props.catName
        };
        //console.log("cat",cat)
        this.$store.dispatch("trailers/fetchCategoryTrailers", cat).then(data => {
           this.categoryTrailers.push(data);
           
           this.$forceUpdate();
            

            this.$nextTick(function(){

                	//console.log("Loaded previews js",$('.trailer-slider').length)
					$('.trailer-slider').owlCarousel({
						loop: false, // Do not make it as loop, if there is only one video then it will create muliple carousel items for same video
						margin: 10,
						responsiveClass: true,
						// stagePadding: 50,
						nav: true,
						navText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
						responsive: {
							0: {
								items: 1,
								nav: true,
								margin:20
							},
							600: {
								items: 2,
								nav: true,
								margin:20
							},
							1000: {
								items: 3,
								nav: true,
								margin:20
							},
							1400: {
								items: 4,
								nav: true,
								loop: false,
								margin: 40
							},
							1923: {
								items: 6,
								nav: true,
								loop: false,
								margin: 40
							}
						}
					});


            })



        }).catch(e => {
            console.log(e);
        });
   
     
  },
  mounted(){

        

  },
  methods: {}
};
</script>

<style scoped>

</style>
