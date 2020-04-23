<template>
  <div style="position:relative">

    <v-card elevation="0" class="all-bg ">
    <div class="row">
      <div class="col-md-3 col-sm-5" >
        <div  style="padding:7.5px 0;">
          <router-link :to="'/' + getLinkTag + '/' + trailer.trailerId">
          <v-img :src="trailer.image" height="125px" style="border-radius: 24px;width:100%;"></v-img>
        </router-link>
      </div>
    </div>
    <div class="col-md-9 col-sm-7" >
      <div class="" style="padding:7.5px 0;">
        <router-link :to="'/' + getLinkTag + '/' + trailer.trailerId">
        <div class="title--text max-2-lines quick-sand-font-n">{{ trailer.title }}</div>
        <span
        class="desc--text"
        style="padding:5px 0">{{ trailer.channelName }} • {{ trailer.views }} views • {{ trailer.timeAgo }}</span>
        <div class="desc--text only-desp" style="">{{ trailer.description }}
        </div>
      </router-link>
    </div>
  </div>
</div>
</v-card>
</div>
</template>

<script>
  export default {
    name: "TrailerSearchItem",
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
    color:#000;
    display:contents!important;
  }
  .margin {
    margin: 10px;
  }
  .padding {
    padding: 10px;
  }
  .title--text {
    color: #0a0a0a;
    font-size: 1.2rem;
    font-weight: 600;
  }
  .desc--text {
    font-size: 0.9rem;
  }
  .only-desp {
    font-size: 1rem;
    padding:5px 0;
    overflow: hidden; 
    text-overflow: ellipsis;
    display: -webkit-box;
    display: -moz-box;
    -moz-line-clamp: 3;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
    text-transform: lowercase;
    line-height: 25px;
    font-size: 16px;
  }
  @media only screen and (max-width:660px){.container{padding:0}}
</style>
