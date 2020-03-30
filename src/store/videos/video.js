import {auth, fireStore} from "../../firebase/init";
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
    fetchChannel: ({ state, commit }, { channelId }) => {
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
    },
    getUserChannelVideos: ({ state }, { channelId }) => {
      let userId = auth.currentUser.uid;
      return new Promise(async resolve => {
        let videosList = [];
        let videosRef = fireStore
            .collection(collections.videosCollection)
            .where("userId", "==", userId)
            .where("channelId", "==", channelId)
            .limit(10);

        let videosQuerySnapshot = await videosRef.get();
        videosQuerySnapshot.forEach(snapshot => {
          videosList.push(utils.extractVideoData(snapshot));
        });

        resolve(videosList);
      });
    },


    getUserCrowdFundingChannels: ({ state }) => {
      let userId = auth.currentUser.uid;
      return new Promise(async resolve => {
        let videosList = [];
        let videosRef = fireStore
            .collection(collections.channelsCollection)
            .where("userId", "==", userId)
            .where("categoryName", "==", "Call-to-Action")
            
        let videosQuerySnapshot = await videosRef.get();
        videosQuerySnapshot.forEach(snapshot => {
          videosList.push(utils.extractVideoData(snapshot));
        });

        resolve(videosList);
      });
    },
    getUserCrowdFundingVideos: ({ state }) => {
      let userId = auth.currentUser.uid;
      return new Promise(async resolve => {
        let videosList = [];
        let videosRef = fireStore
            .collection(collections.videosCollection)
            .where("userId", "==", userId)
            .where("categoryName", "==", "Call-to-Action")
            
        let videosQuerySnapshot = await videosRef.get();
        videosQuerySnapshot.forEach(snapshot => {
          videosList.push(utils.extractVideoData(snapshot));
        });

        resolve(videosList);
      });
    },
        

  }
};
