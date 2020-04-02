import {
  auth,
  fireStore
} from "../../firebase/init";
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
    fetchChannel: ({
      state,
      commit
    }, {
      channelId
    }) => {
      return new Promise((resolve, reject) => {
        fireStore
          .collection(collections.channelsCollection)
          .doc(channelId)
          .get()
          .then(querySnapshot => {
            resolve(querySnapshot.data());
          });
      });
    },
    fetchCategoryTrailers: ({
      state,
      commit
    }, {
      categoryId,
      categoryName
    }) => {
      return new Promise((resolve, reject) => {
        
        let catTrailers = {
          catId: categoryId,
          catName: categoryName
        };
        let query;
        if (categoryId != undefined) {
          query = fireStore
            .collection(collections.trailerCollection)
            .where("categoryId", "==", categoryId)
            .orderBy("createdDate", "desc");
        } else {
          query = fireStore
            .collection(collections.trailerCollection)
            .where("categoryName", "==", categoryName)
            .orderBy("createdDate", "desc")
        }

        query.get()
          .then(querySnapshot => {
            let trailers = [];
            querySnapshot.forEach(doc => {
              trailers.push(utils.extractTrailerData(doc));
            });
              catTrailers["trailers"] = trailers;

            resolve(catTrailers);
          });
         
      });
    },


    getPromotedTrailers: ({
      state,
      commit
    }) => {
      return new Promise((resolve, reject) => {

        fireStore
          .collection(collections.trailerCollection)
          .orderBy("createdDate", "desc")
          .limit(5)
          .get()
          .then(querySnapshot => {
            let trailers = [];
            querySnapshot.forEach(doc => {


             
              trailers.push(utils.extractTrailerData(doc));
            });
            resolve(trailers);
          });
      });
    },



    getUserCrowdFundingTrailers: ({
      state,
      commit
    }) => {
      return new Promise((resolve, reject) => {

        let userId = auth.currentUser.uid;
        console.log("Fetch crowdfund trailors",userId)
        fireStore
          .collection(collections.trailerCollection)
          .where("userId", "==", userId)            
          .where("categoryName", "==", "Call-to-Action") 
          .orderBy("createdDate", "desc")
          .get()
          .then(querySnapshot => {
            let trailers = [];
            querySnapshot.forEach(doc => {


             
              trailers.push(utils.extractTrailerData(doc));
            });
            resolve(trailers);
          });
      });
    },



    fetchCategoryTrailersTop10: ({
      state,
      commit
    }, {
      categoryId
    }) => {
      return new Promise((resolve, reject) => {
        fireStore
          .collection(collections.trailerCollection)
          .where("categoryId", "==", categoryId)
          .orderBy("createdDate", "desc")
          .limit(10)
          .get()
          .then(querySnapshot => {
            let trailers = [];
            querySnapshot.forEach(doc => {
              trailers.push(utils.extractTrailerData(doc));
            });
            resolve(trailers);
          });
      });
    },
    fetchTrailer: ({
      state,
      commit
    }, {
      trailerId
    }) => {
      return new Promise(resolve => {
        fireStore
          .collection(collections.trailerCollection)
          .doc(trailerId)
          .get()
          .then(documentSnapshot => {
            resolve(utils.extractTrailerData(documentSnapshot));
          });
      });
    },
    fetchTop10Trailer: ({
      state,
      commit
    }) => {
      return new Promise(resolve => {
        fireStore
          .collection(collections.trailerCollection)
          .orderBy("createdDate", "desc")
          .limit(5)
          .get()
          .then(querySnapshot => {
            let trailers = [];
            querySnapshot.forEach(doc => {
              trailers.push(utils.extractTrailerData(doc));
            });
            resolve(trailers);
          });
      });
    }
  }
};
