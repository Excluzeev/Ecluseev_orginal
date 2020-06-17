<template>
    <div class="promote-links">

       <a  target="_blank" v-for="pl in promote_links" :href="pl.link">{{pl.display_name}}</a>

    </div>
</template>

<script>
    export default {
        name: "ChannelPromoteLinks",
        props:['channel_id'],
        data(){
            return{
                promote_links:[
                    {
                        'display_name': "Facebook",
                        'link': "link"
                    },
                    {
                        'display_name': "Instagram",
                        'link': "link"
                    },
                     {
                        'display_name': "Website",
                        'link': "link"
                    },
                     {
                        'display_name': "Merchandise",
                        'link': "link"
                    },

                ]
            }
        },
        methods:{
            /* Fetch promote links of the channel */
            fetch_promote_links(channelId){

                this.$store.dispatch("fetchLinks",{channelId: channelId})
                .then((links) => {

                   if(links){
                       this.promote_links=links
                   }else{
                       this.promote_links=[]
                   }




                })
                .catch((error, data) => {

                     console.log("Promote links error",error);

                })


            }

        },
        mounted() {
            this.$root.$on("fetch_promote_links",(channelId) =>{
                this.fetch_promote_links(channelId)
            });

        }
    }
</script>

<style scoped>
    .promote-links{
        display: flex;
        justify-content: center;
        flex-wrap: wrap;

    }
    .promote-links a{
        min-width: 130px;

        box-shadow: 0px 3px 6px #00000029;
        -webkit-box-shadow: 0px 3px 6px #00000029;
        -moz-box-shadow: 0px 3px 6px #00000029;
        -o-box-shadow:0px 3px 6px #00000029;

        border: 1px solid;
        border-radius: 13px;
        text-align: center;
        padding: 5px;
        margin: 5px;

    }
</style>