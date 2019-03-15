<template>
  <!-- swiper -->
  <swiper :options="swiperOption">
    <swiper-slide v-for="(tex, x) in taglines" :key="x">
      <v-img :src="'https://picsum.photos/480/260?image=' + randomNumber()">
        <div class="fill-height bottom-gradient">
          <v-layout align-end fill-height pa-3 white--text>
            <div class="title font-weight-medium featured-text">
              {{ tex }}
            </div>
          </v-layout>
        </div>
      </v-img>
    </swiper-slide>
  </swiper>
</template>

<script>
import "swiper/dist/css/swiper.css";
import "swiper/dist/css/swiper.css";
import { swiper, swiperSlide } from "vue-awesome-swiper";
export default {
  components: {
    swiper,
    swiperSlide
  },
  methods: {
    randomNumber: function() {
      return Math.floor(Math.random() * 50);
    }
  },
  data() {
    return {
      swiperOption: {
        slidesPerView: 3,
        centeredSlides: true,
        spaceBetween: 30,
        loop: true,
        autoplay: {
          delay: 1500,
          disableOnInteraction: false
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
</style>
