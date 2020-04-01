<template>


  <router-link class="" :to="'/' + getLinkTag + '/' + video.videoId">
    <li>
    <div class="row">
        <div class="col-xl-6 col-xs-6 col-sm-6 col-6 col-md-6">
    <img :src="video.image" class="img-fluid" style="width: 100%;border-radius:10px;"/>
        </div>
        <div class="col-xl-6 col-xs-6 col-sm-6 col-6 col-md-6">
            <div class="video_title">
                <h3><span> {{ video.title }}</span></h3>
                <h4> {{ video.channelName }}</h4>
                <p>{{ video.description }}</p>
            </div>
        </div>
    </div>
    </li>

  </router-link>



</template>

<script>
export default {
  name: "VideoDetailVideoItem",
  props: ["video"],
  computed: {
    getLinkTag() {
      if (this.video.channelType == "CrowdFunding" && this.video.type != "Live") {
        return "crowd/video";
      }
      return this.video.type == "Live" ? "live" : "video";
    }
  }
};
</script>

<style scoped>
  a {
    text-decoration: none;
  }
  .padding {
    padding: 10px;
  }
  .title--text {
    color: #0a0a0a;
    font-size: 1rem;
    font-weight: 600;
  }
  .desc--text {
    font-size: 0.95rem;
  }
  .padding-top {
    padding-top: 10px;
  }
</style>
