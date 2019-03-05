import Vue from "vue";
import "./plugins/vuetify";
import App from "./App.vue";
import router from "./router/router";
import store from "./store/index";
import "./registerServiceWorker";

import VueVideoPlayer from "vue-video-player";
import "video.js/dist/video-js.css";
import "vue-video-player/src/custom-theme.css";
import "videojs-flash";
import "videojs-contrib-hls";
import "material-design-icons-iconfont/dist/material-design-icons.css";
// import "videojs-contrib-hls/dist/videojs-contrib-hls";

Vue.config.productionTip = false;

Vue.use(VueVideoPlayer);

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount("#app");
