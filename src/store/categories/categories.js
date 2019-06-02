import {
  fireStore
} from "../../firebase/init";
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
              if (doc.data().name != "Call-to-Action") {
                categories.push(utils.extractCategoryData(doc));
              }
            });
            // commit("addNewCategoryTrailers", catTrailers);
            resolve(categories);
          });
      });
    }
  }
};