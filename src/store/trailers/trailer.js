import firestore from "../../firebase/init";
import collections from "../../firebase/utils";

export default {
  state: {
    categoriesTrailers: []
  },
  getters: {},
  mutations: {
    addNewCategoryTrailers(state, data) {
      state.categoriesTrailers.push(data);
    }
  },
  actions: {
    fetchCategory({ state, commit }, categoryId) {
      return new Promise((resolve, reject) => {
        firestore.collection(collections.trailerCollection).where("");
      });
    }
  }
};
