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

                    <div class="item_img">
                    <img src="Assets/slider_images/1.png" class="img-fluid">
                  </div>
                  <h6>Two best friends who navigate life in Los Angeles.</h6>
                  <p>Bri N Teesh</p>
                  <p><i class="fa fa-tripadvisor" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;Artist/Band/Vlog</p>
        
                  <!-- <TrailerVideoItem :trailer="trailer" v-on:trailerDelete="onTrailerDeleted"/> -->


        
                </div>


              </div>
            </div>
          </div>
        </section>


      </div>
    <!--
    <v-layout text-xs wrap>
      <v-flex xs12>
        <div v-for="item in categoryTrailers" v-bind:key="item.catId">
          <h2 class="quick-sand-font-b">{{ item.catName }}</h2>
          <v-layout xs12 row wrap>
            <v-flex
              class="trailer-item"
              xs12
              sm4
              md3
              lg2
              v-for="trailer in item.trailers"
              v-bind:key="trailer.trailerId"
            >
              <TrailerVideoItem :trailer="trailer" v-on:trailerDelete="onTrailerDeleted"/>
            </v-flex>
          </v-layout>
        </div>
      </v-flex>
    </v-layout>
    <v-divider></v-divider>
    -->

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
