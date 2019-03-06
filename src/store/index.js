import Vue from "vue";
import Vuex from "vuex";
import trailers from "./trailers/trailer";
import categories from "./categories/categories";
import authModule from "./auth/auth";

import { auth } from "../firebase/init";

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    trailers,
    categories,
    authModule
  },
  getters: {
    getUser: state => {
      return state.user;
    }
  },
  state: {
    user: null,
    showLogin: false
  },
  mutations: {
    setUser: state => {
      state.showLogin = auth.currentUser == null;
      state.user = auth.currentUser;
    }
  },
  actions: {
    signOut: ({ state, commit }) => {
      return new Promise(resolve => {
        auth.signOut();
        commit("setUser");
        resolve("Done");
      })
    }
  }
});
