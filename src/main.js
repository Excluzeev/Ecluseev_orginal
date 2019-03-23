import Vue from "vue";
import "./plugins/vuetify";
import App from "./App.vue";
import store from "./store/index";
import router from "./router/router";
import "./registerServiceWorker";
import titleMixin from "./mixins/titleMixin";
import VueVideoPlayer from "vue-video-player";
import "video.js/dist/video-js.css";
// import "vue-video-player/src/custom-theme.css";
import "./assets/css/videojsnew.css";
import "videojs-flash";
import "videojs-contrib-hls";
import "material-design-icons-iconfont/dist/material-design-icons.css";

// import "videojs-contrib-hls/dist/videojs-contrib-hls";
import "videojs-ima/dist/videojs.ima";
import "videojs-ima/dist/videojs.ima.css";
import "videojs-contrib-ads/dist/videojs-contrib-ads";
import "videojs-contrib-ads/dist/videojs-contrib-ads.css";

import { auth } from "./firebase/init";

import Toasted from "vue-toasted";

import LoadScript from "vue-plugin-load-script";

import { VueReCaptcha } from "vue-recaptcha-v3";

// For more options see below
Vue.use(VueReCaptcha, { siteKey: "6LcwXpkUAAAAAMRYzY4mULgEmyBwpDnKRt1leWtC", loaderOptions: {
    useRecaptchaNet: true,
    autoHideBadge: true
  } });

Vue.use(LoadScript);

Vue.loadScript("https://imasdk.googleapis.com/js/sdkloader/ima3.js")
  .then(() => {
    // Script is loaded, do something
    console.log("ima3 loaded");
  })
  .catch(() => {
    // Failed to fetch script
    console.log("ima3 load failed");
  });

auth.onAuthStateChanged(user => {
  store.commit("setUser");
  store.commit("fetchUser", { user });
});

Vue.config.productionTip = false;

Vue.use(VueVideoPlayer);
Vue.use(Toasted, {
  router
});
Vue.mixin(titleMixin);

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount("#app");
