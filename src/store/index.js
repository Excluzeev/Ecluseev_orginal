import Vue from "vue";
import Vuex from "vuex";
import trailers from "./trailers/trailer";
import categories from "./categories/categories";
import authModule from "./auth/auth";
import channelsModule from "./channels/channels";
import videosModule from "./videos/video";

import {
  auth,
  fireStore
} from "../firebase/init";
import collections from "../firebase/utils";
import utils from "../utility/utils";

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    trailers,
    categories,
    authModule,
    channelsModule,
    videosModule
  },
  getters: {
    getUser: state => {
      return state.user;
    },
    getFUser: state => {
      return state.fUser;
    }
  },
  state: {
    user: null,
    showLogin: false,
    fUser: null
  },
  mutations: {
    setUser: state => {
      state.showLogin = auth.currentUser == null;
      state.user = auth.currentUser;
    },
    forceFetchUser: async state => {
      auth.onAuthStateChanged(user => {});
      let user = auth.currentUser;
      let userRef = fireStore
        .collection(collections.usersCollections)
        .doc(user.uid);
      let userSnap = await userRef.get();
      let userData = null;
      if (userSnap.exists) {
        userData = utils.extractUserData(userSnap);
      }
      localStorage.setItem("fUser", JSON.stringify(userData));
      localStorage.setItem("last", Date.now());
      state.fUser = userData;
    },
    fetchUser: async (state, {
      user,
      force = false
    }) => {
      let now = Date.now();
      let last =
        localStorage.getItem("last") != null ?
        parseInt(localStorage.getItem("last")) + 600000 :
        0;
      if (user == null) {
        // localStorage.removeItem("fUser");
        localStorage.removeItem("last");
        state.fUser = null;
        return;
      }
      if (localStorage.getItem("fUser") == null) {
        force = true;
      }
      if ((last != null && last < now) || last == 0 || force) {
        let userRef = fireStore
          .collection(collections.usersCollections)
          .doc(user.uid);
        let userSnap = await userRef.get();
        let userData = null;
        if (userSnap.exists) {
          userData = utils.extractUserData(userSnap);
        }
        localStorage.setItem("fUser", JSON.stringify(userData));
        localStorage.setItem("last", Date.now());
        state.fUser = userData;
      } else {
        let data = localStorage.getItem("fUser");
        if (data != null) {
          state.fUser = JSON.parse(data);
        }
      }
    }
  },
  actions: {
    signOut: ({
      state,
      commit
    }) => {
      return new Promise(resolve => {
        auth.signOut();
        commit("setUser");
        resolve("Done");
      });
    },
    signUpContentCreator: ({
      state,
      commit,
      dispatch
    }, {
      email
    }) => {
      return new Promise(async resolve => {
        let userDoc = {
          isContentCreator: true,
          paypalEmail: email
        };

        let userRef = fireStore
          .collection(collections.usersCollections)
          .doc(auth.currentUser.uid);
        let userSnap = await userRef.get();
        if (userSnap.exists) {
          await userRef.update(userDoc);
          commit("fetchUser", {
            user: auth.currentUser,
            force: true
          });
          resolve({
            error: false
          });
        } else {
          dispatch("signOut");
          resolve({
            error: true
          });
        }
        commit("setUser");
        resolve("Done");
      });
    },
    fetchCategories: async () => {
      return new Promise(async resolve => {
        let cats = [];
        let categoriesRef = fireStore.collection(
          collections.categoriesCollection
        );
        try {
          let categoriesQuerySnapshot = await categoriesRef.get();
          categoriesQuerySnapshot.forEach(snapShot => {
            cats.push(snapShot.data());
          });
          resolve(cats);
        } catch (error) {
          resolve(cats);
        }
      });
    },
    deleteVideo: async ({
      state,
      commit
    }, {
      video
    }) => {
      return new Promise(async resolve => {
        let videosRef = fireStore
          .collection(collections.videosCollection)
          .doc(video.videoId);
        await videosRef.delete();

        resolve("Done");
      });
    },
    deleteTrailer: async ({
      state,
      commit
    }, {
      trailer
    }) => {
      return new Promise(async resolve => {
        let tarilerRef = fireStore
          .collection(collections.trailerCollection)
          .doc(trailer.trailerId);
        await tarilerRef.delete();

        resolve("Done");
      });
    }
  }
});