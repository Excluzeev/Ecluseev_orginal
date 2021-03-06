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
        getActivePromotedBanners: ({ state }) => {
            return new Promise(async resolve => {
                let bannersList = [];
                let bannersRef = fireStore
                    .collection(collections.bannersCollection)
                    .where("isActive", "==", true);

                try {
                    let bannersQuerySnapshot = await bannersRef.get();
                       
                        for(var i in bannersQuerySnapshot.docs){
 
                        let snapshot=bannersQuerySnapshot.docs[i]
                        let bdata=snapshot.data()
                        if(bdata.isTrailer){
                        
                        }else{
                            bdata.trailerId="0"
                        }

                        bannersList.push(bdata);
                           
                        
                        }

                    console.log("Banners",bannersList)

                     resolve(bannersList);
                    
                } catch (e) {
                    console.error("Error on getting banners",e)
                }


            });
        },

        getAllPromotedBanners: ({ state }) => {
            return new Promise(async resolve => {
                let bannersList = [];
                let bannersRef = fireStore
                    .collection(collections.bannersCollection)

                try {
                    let bannersQuerySnapshot = await bannersRef.get();
                        bannersQuerySnapshot.forEach(snapshot => {
                        bannersList.push(snapshot.data());
                    });
                } catch (e) {
                    console.error(e)
                }


                resolve(bannersList);
            });
        },
        getChannels: ({ state }) => {
            let fUser = localStorage.getItem("fUser") != null ? JSON.parse(localStorage.getItem("fUser")) : null;
            let userId = fUser.uid;
            return new Promise(async resolve => {
                let channelsList = [];
                let channelsRef = fireStore
                    .collection(collections.channelsCollection)
                    .where("userId", "==", userId);

                try {
                    let channelsQuerySnapshot = await channelsRef.get();
                    channelsQuerySnapshot.forEach(snapshot => {
                        channelsList.push(snapshot.data());
                    });
                } catch (e) {
                    console.error(e)
                }


                resolve(channelsList);
            });
        },
        getUserChannelTrailers: ({ state }, { channelId }) => {
            let userId = auth.currentUser.uid;
            return new Promise(async resolve => {
                let trailersList = [];
                let trailersRef = fireStore
                    .collection(collections.trailerCollection)
                    .where("channelId", "==", channelId)
                    .orderBy("createdDate", "desc");

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
                    .where("channelId", "==", channelId)
                    .orderBy("createdDate", "desc");

                let videosQuerySnapshot = await videosRef.get();
                videosQuerySnapshot.forEach(snapshot => {
                    videosList.push(utils.extractVideoData(snapshot));
                });

                resolve(videosList);
            });
        },
        getCrowdFundingChannels: ({ state }) => {
          return new Promise(async resolve => {
            let videosList = [];
            let videosRef = fireStore
                .collection(collections.channelsCollection)
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
