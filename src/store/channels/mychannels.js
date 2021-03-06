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
        getChannels: ({ state }, { userId }) => {
            return new Promise(async resolve => {
                let channelsList = [];
                let channelsRef = fireStore
                    .collection(collections.channelsCollection)
                    .where("userId", "==", userId);

                let channelsQuerySnapshot = await channelsRef.get();
                channelsQuerySnapshot.forEach(snapshot => {
                    channelsList.push(snapshot.data());
                });

                resolve(channelsList);
            });
        },
        getUserChannelTrailers: ({ state }, { channelId, userId }) => {
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
