<template>
  
  <router-link class="" :to="'/' + getLinkTag + '/' + trailer.trailerId">
  
   
    	<li>
            <a href="#">
                <div class="row">
                    <div class="col-xl-6 col-xs-6 col-sm-6 col-6 col-md-6">
      <img :src="trailer.image" class="img-fluid" style="width: 100%;border-radius:10px;"/>
                    </div>
                    <div class="col-xl-6 col-xs-6 col-sm-6 col-6 col-md-6">
                        <div class="video_title">
                            <h3><span> {{ trailer.title }}</span></h3>
                            <h4> {{ trailer.channelName }}</h4>
                            <p>{{ trailer.description }}</p>
                        </div>
                    </div>
                </div>
            </a>
        </li>
  
  </router-link>

</template>

<script>
export default {
  name: "TrailerVideoItem",
  props: ["trailer"],
  computed: {
    getLinkTag() {
      return this.trailer.channelType == "CrowdFunding" ? "crowd" : "trailer";
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
