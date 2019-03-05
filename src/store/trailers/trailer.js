import { fireStore } from "../../firebase/init";
import collections from "../../firebase/utils";
import utils from "../../utility/utils";

export default {
  namespaced: true,
  state: {
    categoriesTrailers: []
  },
  getters: {
    categoriesTrailers: state => {
      return state.categoriesTrailers;
    }
  },
  mutations: {
    addNewCategoryTrailers(state, data) {
      state.categoriesTrailers.push(data);
    }
  },
  actions: {
    fetchCategoryTrailers({ state, commit }, categoryId, categoryName) {
      return new Promise((resolve, reject) => {
        let catTrailers = {
          catId: categoryId,
          catName: categoryName
        };
        console.log(fireStore);
        console.log(collections.trailerCollection);
        fireStore
          .collection(collections.trailerCollection)
          .where("categoryId", "==", categoryId)
          .get()
          .then(querySnapshot => {
            this.trailers = [];
            querySnapshot.forEach(doc => {
              console.log(utils.extractTrailerData(doc));
              this.trailers.push(utils.extractTrailerData(doc));
            });
            catTrailers["trailers"] = this.trailers;
            commit("addNewCategoryTrailers", catTrailers);
            resolve(state.categoriesTrailers);
          });
      });
    }
  }
};
