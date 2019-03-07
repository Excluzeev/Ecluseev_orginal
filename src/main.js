import Vue from "vue";
import "./plugins/vuetify";
import App from "./App.vue";
import store from "./store/index";
import router from "./router/router";
import "./registerServiceWorker";

import VueVideoPlayer from "vue-video-player";
import "video.js/dist/video-js.css";
import "vue-video-player/src/custom-theme.css";
import "videojs-flash";
import "videojs-contrib-hls";
import "material-design-icons-iconfont/dist/material-design-icons.css";
// import "videojs-contrib-hls/dist/videojs-contrib-hls";
import { auth } from "./firebase/init";

import Toasted from "vue-toasted";

auth.onAuthStateChanged(user => {
  store.commit("setUser");
  store.commit("fetchUser", { user });
});

Vue.config.productionTip = false;

Vue.use(VueVideoPlayer);
Vue.use(Toasted);

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount("#app");
