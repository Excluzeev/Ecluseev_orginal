/* eslint-disable */
import { fireStore, auth } from "../../firebase/init";
import collections from "../../firebase/utils";
import utils from "../../utility/utils";

export default {
  namespaced: true,
  state: {},
  getters: {},
  mutations: {},
  actions: {
    

    getTotalEarnings: ({ state },{channelId}) => {
      return new Promise(async resolve => {
        let total=0;
        //console.log("Earnings Channel id ",channelId)
        let channelsRef = fireStore
          .collection(collections.subscribersCollection)
          //.where("channelId", "==", channelId)
            
        let channelsQuerySnapshot = await channelsRef.get();
        channelsQuerySnapshot.forEach(snapshot => {
          if (
            snapshot != null &&
            snapshot.data().channelType != "CrowdFunding"
          ) {
            
            let price=parseInt(snapshot.data().price)

            total+=price

          }
        });
        resolve(total);
      });
    },


    getChannelSubscriptions: ({ state },{channelId,limit}) => {
      return new Promise(async resolve => {
        let channelsList = [];

        console.log("Channel id,limit: ",channelId,limit)
        let channelsRef = fireStore
          .collection(collections.subscribersCollection)
          //.where("channelId", "==", channelId)
          .limit(limit)
            
        let channelsQuerySnapshot = await channelsRef.get();
        channelsQuerySnapshot.forEach(snapshot => {
          if (
            snapshot != null &&
            snapshot.data().channelType != "CrowdFunding"
          ) {
            channelsList.push(snapshot.data());
          }
        });
        console.log("List",channelsList);
        resolve(channelsList);
      });
    },


    getUserSubscriptions: ({ state }) => {
      let fUser =
        localStorage.getItem("fUser") != null
          ? JSON.parse(localStorage.getItem("fUser"))
          : null;
      let userId = fUser.uid;
      if (userId == "" || userId == null) {
        let userId = auth.currentUser.uid;
      }
      return new Promise(async resolve => {
        let channelsList = [];
        let channelsRef = fireStore
          .collection(collections.subscribersCollection)
          .where("userId", "==", userId)
          .where("isActive", "==", true);

        let channelsQuerySnapshot = await channelsRef.get();
        channelsQuerySnapshot.forEach(snapshot => {
          if (
            snapshot != null &&
            snapshot.data().channelType != "CrowdFunding"
          ) {
            channelsList.push(snapshot.data());
          }
        });

        resolve(channelsList);
      });
    },
    getUserChannelTrailers: ({ state }, { channelId }) => {
      let userId = auth.currentUser.uid;
      return new Promise(async resolve => {
        let trailersList = [];
        let trailersRef = fireStore
          .collection(collections.trailerCollection)
          .where("userId", "==", userId)
          .where("channelId", "==", channelId);

        let trailersQuerySnapshot = await trailersRef.get();
        trailersQuerySnapshot.forEach(snapshot => {
          trailersList.push(utils.extractTrailerData(snapshot));
        });

        resolve(trailersList);
      });
    },
    getUserChannelVideos: ({ state }, { channelId }) => {
      let userId = auth.currentUser.uid;
      return new Promise(async resolve => {
        let videosList = [];
        let videosRef = fireStore
          .collection(collections.videosCollection)
          .where("userId", "==", userId)
          .where("channelId", "==", channelId);

        let videosQuerySnapshot = await videosRef.get();
        videosQuerySnapshot.forEach(snapshot => {
          videosList.push(utils.extractVideoData(snapshot));
        });

        resolve(videosList);
      });
    }
  }
};
