import Vue from "vue";
import "./plugins/vuetify";



Vue.config.productionTip = false


import  jQuery from "jquery";
window.jQuery = jQuery
window.$ = jQuery


import App from "./App.vue";
import store from "./store/index";
import router from "./router/router";
import "./registerServiceWorker";
import titleMixin from "./mixins/titleMixin";
// import VueVideoPlayer from "vue-video-player";
import "video.js/dist/video-js.css";
import "vue-video-player/src/custom-theme.css";
import "./assets/css/videojsnew.css";


import "videojs-flash";
import "videojs-contrib-hls";
import "material-design-icons-iconfont/dist/material-design-icons.css";

// import "videojs-contrib-hls/dist/videojs-contrib-hls";
import "videojs-ima/dist/videojs.ima";
import "videojs-ima/dist/videojs.ima.css";
import "videojs-contrib-ads/dist/videojs-contrib-ads";
import "videojs-contrib-ads/dist/videojs-contrib-ads.css";

// Import component
import Loading from 'vue-loading-overlay';
// Import stylesheet
import 'vue-loading-overlay/dist/vue-loading.css';
// Init plugin
Vue.use(Loading);

import {
  auth
} from "./firebase/init";

import Toasted from "vue-toasted";

import LoadScript from "vue-plugin-load-script";

Vue.use(LoadScript);



import VueProgrammaticInvisibleGoogleRecaptcha from "vue-programmatic-invisible-google-recaptcha";

Vue.component(
  "vue-programmatic-invisible-google-recaptcha",
  VueProgrammaticInvisibleGoogleRecaptcha
  );






Vue.loadScript("https://www.google.com/recaptcha/api.js?render=explicit")
.then(() => {
    // console.log("recaptcha loaded");
  })
.catch(() => {
    // console.log("recaptcha load failed");
  });


Vue.loadScript("https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js")
.then(() => {
    // console.log("popper loaded");
  })
.catch(() => {
    // console.log("popper load failed");
  });


Vue.loadScript("https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js")
.then(() => {
    // console.log("bootstrapjs loaded");
  })
.catch(() => {
    // console.log("bootstrapjs load failed");
  });

Vue.loadScript("https://vjs.zencdn.net/7.6.6/video.js")
.then(() => {
    // console.log("videojs loaded");
  })
.catch(() => {
    // console.log("videojs failed");
  });

Vue.loadScript("https://imasdk.googleapis.com/js/sdkloader/ima3.js")
.then(() => {
    // Script is loaded, do something
    // console.log("ima3 loaded");
  })
.catch(() => {
    // Failed to fetch script
    // console.log("ima3 load failed");
  });




auth.onAuthStateChanged(user => {
  store.commit("setUser");
  store.commit("fetchUser", {
    user
  });
});

Vue.config.productionTip = false;

// Vue.use(VueVideoPlayer);

Vue.use(Toasted, {
  router
});
Vue.mixin(titleMixin);

import {
  library
} from "@fortawesome/fontawesome-svg-core";
import {
  faTwitter,
  faFacebook,
  faInstagram
} from "@fortawesome/free-brands-svg-icons";
import {
  FontAwesomeIcon
} from "@fortawesome/vue-fontawesome";

library.add(faTwitter, faFacebook, faInstagram);

Vue.component("font-awesome-icon", FontAwesomeIcon);

import vueHeadful from "vue-headful";

Vue.component("vue-headful", vueHeadful);


new Vue({
  router,
  store,
  render: h => h(App)
}).$mount("#app");

