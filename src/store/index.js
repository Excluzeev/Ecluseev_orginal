import Vue from "vue";
import Vuex from "vuex";
import trailers from "./trailers/trailer";
import categories from "./categories/categories";
Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    trailers,
    categories
  },
  state: {},
  mutations: {},
  actions: {}
});
