<template>
  <div class="HowTo">
    <div style="padding-top:25px"></div>
    <v-container v-if="hows.length > 0">
      <h1 style="padding-top: 10px;padding-bottom: 10px;">How To</h1>
      <div v-for="(how, index) in hows" v-bind:key="index">
        <h2 style="padding-top: 10px;padding-bottom: 10px;">{{how.title}}</h2>
    
                 <video v-bind:id="'video_player_'+index" class="video-js" controls preload="auto" width="100%" >
                    </video>



        <p style="padding-top: 10px;padding-bottom: 10px;">{{how.description}}</p>
      </div>
    </v-container>
  </div>
</template>

<script>
// @ is an alias to /src
import { fireStore } from "../firebase/init";
import collections from "../firebase/utils";

export default {
  name: "HowTo",
  components: {},
  data: () => {
    return {
      playersOptions: [],
      hows: []
    };
  },
  async mounted() {
    this.fetchHows();
  },
  methods: {
    async fetchHows() {
      let howToRef = fireStore
        .collection(collections.howToCollection)
        .orderBy("sno", "asc");
      let allHows = await howToRef.get();
      let i = 0;
      for (i = 0; i < allHows.docs.length; i++) {
        let how = allHows.docs[i].data();
        let option = {
          overNative: true,
          controls: true,
          autoplay: false,
          errorDisplay: false,
          preload: "auto",
          techOrder: ["html5"],
          sourceOrder: true,
          playbackRates: [0.7, 1.0, 1.5, 2.0],
          aspectRatio: "16:9",
          html5: { hls: { withCredentials: false } },
          sources: [
            {
              withCredentials: false,
              type: "application/x-mpegURL",
              src: how.url
            }
          ],
          poster: ""
        };
        this.playersOptions.push(option);



        this.hows.push(how);
      }

       let loader = this.$loading.show({
          // Pass props by their camelCased names
          canCancel: true, // default false
          color: '#000000',
          width: 64,
          height: 64,
          backgroundColor: '#ffffff',
          opacity: 0.5,
          zIndex: 999,
          loader: "dots"
        },{
          // Pass slots by their names
        });

      let _vm=this
      setTimeout(function(){
          for (i = 0; i < allHows.docs.length; i++) {

                // To detach the attached video play
                
                var oldPlayer = document.getElementById('video_player_'+i);
                //if(oldPlayer)
                //  videojs(oldPlayer).dispose();



                console.log("oldPlayer",oldPlayer,'video_player_'+i)

                if(oldPlayer){
                    videojs("video_player_"+i,_vm.playersOptions[i], function(){

                        //console.log("Attached")

                    });
                }


            }

            loader.hide();
        },2000);
      // console.log(this.playersOptions[0]);
    }
  }
};
</script>
<style>
.HowTo{margin-bottom:50px;}
@media only screen and (max-width:767px){
  .HowTo h2{font-size:18px;}
}
@media only screen  (max-width:767px) and (min-width:768px){
  .HowTo h2{font-size:32px;}
}
</style>