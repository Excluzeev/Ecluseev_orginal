<template>
  <div id="live-chat">
    <div class="chat_section">
      <h3><span>CHAT</span></h3>



      <div class="user_comment_section d-flex" ref="chatHistory">

        <div class="chat-message clearfix" v-if="liveChat.length == 0">
          <h5>No Messages yet.</h5>
        </div>
       

        <div v-if="liveChat.length != 0"> 
          <div v-for="chat in liveChat" v-bind:key="chat.chatId">
            <img src="../assets/Images/Copy of Bri N Teesh.png" class="rounded-circle img-fluid pull-left" style="width: 25px;height: 25px;" >
            <div class="user_name_comment">
              <ul class="list-unstyled">
          
                <li class="list-inline">
          
                  <h3 class="pull-left">
                    <!-- Rick Patterson -->
                    {{ chat.userName }} 
                  </h3>
                  <div class="posted_time pull-right"><p>
                    <!-- 5 hours ago -->
                    {{ chat.time }}   
                  </p></div>
                  <div class="clearfix"></div>
          
                </li>
                <li>
                  <p>{{ chat.message }}</p>
                </li>
              </ul>
            </div>
          </div> 
        </div>

          
      </div>
    </div>
    <!-- Chat section end -->
    <div class="chat_messege_section">
      <form @submit.prevent="postMessage">
        
        <div class="input-group mb-3">
          <div class="input-group-prepend">
            <button class="btn btn-user-img" type="button"><img src="../assets/Images/Copy of Bri N Teesh.png" class="rounded-circle " style="width: 25px;height: 25px;" ></button>
          </div>
          <input type="text" v-model="message" class="form-control" placeholder="Type to comment" id="messageInput" aria-label="" aria-describedby="basic-addon1">
          <div class="input-group-append">
            <button class="btn btn-send" type="submit">Send</button>
          </div>
        </div>
      
      </form>

    </div>




  </div>
  
</template>

<script>
import { auth, fireStore, firebaseTimestamp } from "../firebase/init";
import utils from "../firebase/utils";
import moment from "moment";

export default {
  name: "LiveChat",
  props: ["videoId"],
  data: () => {
    return {
      liveChat: [],
      message: ""
    };
  },
  mounted() {
    
    var chatInterval=setInterval(() => {
        
        if(this.videoId){   
            console.log("Updating chats") 
            this.updateChats()

            
            var killId = setTimeout(function() {
              for (var i = killId; i > 0; i--) clearInterval(i)
            }, 3000);


        }
 
       }, 1000);
    
  },
  methods: {

    updateChats(){



        
        console.log("VideoID",this.videoId)
        if(this.videoId){
            fireStore
              .collection("videos")
              .doc(this.videoId)
              .collection("chat")
              .orderBy("createdAt")
              .limit(100)
              .onSnapshot(querySnapshot => {
                let chats = [];
                querySnapshot.forEach(function(doc) {
                  let d = doc.data();
                  chats.push({
                    message: d.message,
                    time: moment(d.createdAt.toDate()).fromNow(),
                    userName: d.userName,
                    chatId: d.chatId
                  });
                });
                this.liveChat = chats;
                //console.log("chats",chats)
                try{
                    this.$refs.chatHistory.scrollTop = this.$refs.chatHistory.scrollHeight;

                }catch(err){

                }

              });
        }


    },
    async postMessage() {
      console.log("Chat messge send clicked")
      let msg = this.message;
      let chatId = utils.generateId();
      console.log("VideoId",this.videoId)
      let chatRef = fireStore
        .collection("videos")
        .doc(this.videoId)
        .collection("chat")
        .doc(chatId);

      let displayName = auth.currentUser.displayName;
      if (displayName == "" || displayName == null) {
        let fUser = JSON.parse(localStorage.getItem("fUser"));
        displayName = fUser.firstName + " " + fUser.lastName;
      }
      let chatData = {
        message: msg,
        chatId: chatId,
        userId: auth.currentUser.uid,
        userName: displayName,
        createdAt: firebaseTimestamp.fromDate(new Date())
      };
      await chatRef.set(chatData);
      this.message = "";

        try{
            this.$refs.chatHistory.scrollTop = this.$refs.chatHistory.scrollHeight;
        }catch(err){
        }
    }
  }
};
</script>

<style scoped>

</style>
