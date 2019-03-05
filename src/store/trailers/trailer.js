import { fireStore } from "../../firebase/init";
import collections from "../../firebase/utils";
import utils from "../../utility/utils";

export default {
  namespaced: true,
  state: {
    // categoriesTrailers: []
  },
  getters: {
    categoriesTrailers: state => {
      return state.categoriesTrailers;
    }
  },
  mutations: {},
  actions: {
    fetchCategoryTrailers: (
      { state, commit },
      { categoryId, categoryName }
    ) => {
      return new Promise((resolve, reject) => {
        let catTrailers = {
          catId: categoryId,
          catName: categoryName
        };
        fireStore
          .collection(collections.trailerCollection)
          .where("categoryId", "==", categoryId)
          .orderBy("createdDate", "desc")
          .get()
          .then(querySnapshot => {
            let trailers = [];
            querySnapshot.forEach(doc => {
              trailers.push(utils.extractTrailerData(doc));
            });
            if (trailers.length > 0) {
              catTrailers["trailers"] = trailers;
              resolve(catTrailers);
            } else {
              reject();
            }
          });
      });
    },
    fetchTrailer: ({ state, commit }, { trailerId }) => {
      console.log(trailerId);
      return new Promise((resolve, reject) => {
        fireStore
          .collection(collections.trailerCollection)
          .doc(trailerId)
          .get()
          .then(documentSnapshot => {
            resolve(utils.extractTrailerData(documentSnapshot));
          });
      });
    }
  }
};
