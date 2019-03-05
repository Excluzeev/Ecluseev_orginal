import { fireStore } from "../../firebase/init";
import collections from "../../firebase/utils";
import utils from "../../utility/utils";

export default {
  namespaced: true,
  state: {},
  getters: {},
  mutations: {},
  actions: {
    fetchCategories: () => {
      return new Promise(resolve => {
        fireStore
          .collection(collections.categoryCollection)
          .get()
          .then(querySnapshot => {
            let categories = [];
            querySnapshot.forEach(doc => {
              categories.push(utils.extractCategoryData(doc));
            });
            // commit("addNewCategoryTrailers", catTrailers);
            console.log(categories);
            resolve(categories);
          });
      });
    }
  }
};
