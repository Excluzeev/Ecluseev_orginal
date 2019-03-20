import Vue from "vue";
import Vuetify from "vuetify/lib";
import "vuetify/src/stylus/app.styl";
import { Ripple } from "vuetify/lib/directives";

Vue.use(Vuetify, {
  theme: {
    primary: "#25ace3"
  },
  iconfont: "md",
  directives: {
    Ripple
  }
});
