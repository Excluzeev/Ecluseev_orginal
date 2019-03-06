import Vue from "vue";
import Vuex from "vuex";
import trailers from "./trailers/trailer";
import categories from "./categories/categories";
import authModule from "./auth/auth";

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    trailers,
    categories,
    authModule
  },
  getters: {},
  state: {},
  mutations: {},
  actions: {}
});
