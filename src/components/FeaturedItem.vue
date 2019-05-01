<template>
  <!-- swiper -->
  <div style="max-height: 320px;">
    <swiper :options="swiperOption" v-if="featuredTrailers.length > 0">
      <swiper-slide v-for="(trailer, x) in featuredTrailers" :key="x">
        <router-link :to="'/trailer/' + trailer.trailerId">
          <div class="image">
            <img :src="trailer.image" alt>

            <h2>{{ trailer.title }}</h2>
          </div>
        </router-link>
      </swiper-slide>
    </swiper>
  </div>
</template>

<script>
import "swiper/dist/css/swiper.css";
import "swiper/dist/css/swiper.css";
import { swiper, swiperSlide } from "vue-awesome-swiper";
import trailerModule from "../store/trailers/trailer";
import RegisterStoreModule from "../mixins/RegisterStoreModule";

export default {
  components: {
    swiper,
    swiperSlide
  },
  created() {
    this.registerStoreModule("trailers", trailerModule);

    this.$store.dispatch("trailers/fetchTop10Trailer").then(data => {
      this.featuredTrailers = data;
    });
  },
  mixins: [RegisterStoreModule],
  methods: {
    randomNumber: function() {
      return Math.floor(Math.random() * 50);
    }
  },
  data() {
    return {
      featuredTrailers: [],
      swiperOption: {
        slidesPerView: 3,
        centeredSlides: true,
        spaceBetween: 30,
        loop: true,
        height: 320,
        noSwiping: false,
        autoplay: {
          delay: 1500,
          disableOnInteraction: true
        }
      },
      taglines: [
        "You Only Live Twice",
        "From Russia with Love",
        "The Man with the Golden Gun",
        "Live and Let Die",
        "Die Another Day"
      ]
    };
  }
};
</script>
<style scoped>
.bottom-gradient {
  background-image: linear-gradient(
    to top,
    rgba(0, 0, 0, 0.7) 10%,
    transparent 80px
  );
}
.featured-text {
  position: absolute;
  bottom: 10px;
}
/*.v-responsive__sizer {*/
/*padding-bottom: 56.25% !important;*/
/*}*/
/*.v-image__image--cover {*/
/*background-size: cover;*/
/*}*/
.image {
  width: 320px;
  height: auto;
  position: relative;
}
.image img {
  width: 320px;
  height: 180px;
}

h2 {
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  padding: 10px;
  background: #0f0f0fb3;
  color: white;
}
</style>
