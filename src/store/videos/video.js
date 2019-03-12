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
    fetchVideo: ({ state, commit }, { videoId }) => {
      return new Promise(resolve => {
        fireStore
          .collection(collections.videosCollection)
          .doc(videoId)
          .get()
          .then(documentSnapshot => {
            resolve(utils.extractVideoData(documentSnapshot));
          });
      });
    }
  }
};