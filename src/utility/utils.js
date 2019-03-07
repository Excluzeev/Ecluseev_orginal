import moment from "moment";

export default {
  extractTrailerData: documentSnap => {
    const data = documentSnap.data();
    return {
      userId: data.userId != null ? data.userId : "",
      trailerId: data.trailerId != null ? data.trailerId : "",
      channelId: data.channelId != null ? data.channelId : "",
      channelName: data.channelName != null ? data.channelName : "",
      categoryId: data.categoryId != null ? data.categoryId : "",
      categoryName: data.categoryName != null ? data.categoryName : "",
      channelType: data.channelType != null ? data.channelType : "",
      createdBy: data.createdBy != null ? data.createdBy : "",
      title: data.title != null ? data.title : "",
      description: data.description != null ? data.description : "",
      image: "https://image.mux.com/" + data.playbackId + "/thumbnail.png",
      channelImage:
        "https://firebasestorage.googleapis.com/v0/b/trenstop-public/o/channels%2F" +
        data.channelId +
        "%2Fthumbnail.jpg?alt=media",
      videoUrl: "https://stream.mux.com/" + data.playbackId + ".m3u8",
      originalUrl: data.originalUrl != null ? data.originalUrl : "",
      playbackId: data.playbackId != null ? data.playbackId : "",
      createdDate: data.createdDate != null ? data.createdDate : null,
      likes: data.likes != null ? data.likes : 0,
      dislikes: data.dislikes != null ? data.dislikes : 0,
      neutral: data.neutral != null ? data.neutral : 0,
      timeAgo: moment(data.createdDate.toDate()).fromNow()
    };
  },

  extractCategoryData: documentSnap => {
    const data = documentSnap.data();
    return {
      id: data.id != null ? data.id : "",
      image: data.image != null ? data.image : "",
      name: data.name != null ? data.name : ""
    };
  },

  extractUserData: documentSnap => {
    let data = documentSnap.data();
    localStorage.setItem("fUser", JSON.stringify(data));
    return data;
  },

  getUser: () => {
    return JSON.parse(
      localStorage.getItem("fUser") != null ? localStorage.getItem("fUser") : ""
    );
  }
};
