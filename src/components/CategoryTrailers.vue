<template>
  <div class="top-padding" v-show="categoryTrailers.length > 0">
      <div v-for="item in categoryTrailers" v-bind:key="item.catId">

        <div class="pull-left">
			  	<h3><i class="fa fa-star" aria-hidden="true"></i>{{ item.catName }}</h3>
			  </div>
			  <div class="pull-right d-md-none d-lg-none d-xs-block"><h3><a href="#">View All</a></h3></div>
	
        <section id="popper_section_carosel">
          <div class="row">
            <div class="large-12 columns col-md-12 col-lg-12 col-xs-12 col-sm-12">
              <div class="owl-carousel owl-theme">
                
                <div class="item"  v-for="trailer in item.trailers" v-bind:key="trailer.trailerId">

                   
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
    this.$store.dispatch("trailers/fetchCategoryTrailers", cat).then(data => {
      this.categoryTrailers.push(data);
    });
  },
  methods: {}
};
</script>

<style scoped>

</style>
