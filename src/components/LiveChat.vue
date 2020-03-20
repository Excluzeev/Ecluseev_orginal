<template>
  <div id="live-chat">
    <div class="chat_section">
      <h3><span>CHAT</span></h3>



      <div class="user_comment_section d-flex">

        <!-- <div class="chat-message clearfix" v-if="liveChat.length == 0">
          <h5>No Messages yet.</h5>
        </div> -->
       

        <!-- <div v-if="liveChat.length != 0"> -->
          <!-- <div v-for="chat in liveChat" v-bind:key="chat.chatId"> -->
            <img src="../assets/Images/Copy of Bri N Teesh.png" class="rounded-circle img-fluid pull-left" style="width: 25px;height: 25px;" >
            <div class="user_name_comment">
              <ul class="list-unstyled">
          
                <li class="list-inline">
          
                  <h3 class="pull-left">
                    Rick Patterson 
                    <!-- {{ chat.userName }} -->
                  </h3>
                  <div class="posted_time pull-right"><p>
                    5 hours ago
                    <!-- {{ chat.time }}   -->
                  </p></div>
                  <div class="clearfix"></div>
          
                </li>
                <li>
                  <!-- <p>{{ chat.message }}</p> -->
                  <p>Two best friends who navigate life in Los Angeles, Explore the world and travel to different exciting destinations, experience different cuisines, lifestyle, meet people, learn culture and spread the love and positivity. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Pharetra et ultrices neque ornare aenean euismod elementum nisi quis. In nulla posuere sollicitudin aliquam ultrices sagittis orci a scelerisque. Sem et tortor consequat id porta nibh.</p></li>
              </ul>
            </div>
          <!-- </div> -->
        <!-- </div> -->

          
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
            <button class="btn btn-send" type="button">Send</button>
          </div>
        </div>
      
      </form>

    </div>




  </div>
  <!-- 
  <div id="live-chat">
    <header class="clearfix">
      <h4 class="quick-sand-font-b">Live Chat</h4>
    </header>

    <div class="chat">
      <div class="chat-history" ref="chatHistory">
        <div class="chat-message clearfix" v-if="liveChat.length == 0">
          <h5>No Messages yet.</h5>
        </div>
        <div v-if="liveChat.length != 0">
          <div v-for="chat in liveChat" v-bind:key="chat.chatId">
            <div class="chat-message clearfix">
              <img
                src="https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png"
                alt=""
                width="32"
                height="32"
              />

              <div class="chat-message-content clearfix">
                <span class="chat-time">{{ chat.time }}</span>

                <h5 class="quick-sand-font">{{ chat.userName }}</h5>

                <p>{{ chat.message }}</p>
              </div>
              <!\-- end chat-message-content --\>
            </div>
            <\!-- end chat-message --\>

            <hr />
          </div>
        </div>
        <\!-- end chat-history --\>
      </div>
      <form @submit.prevent="postMessage">
        <fieldset>
          <input
            type="text"
            placeholder="Type your message…"
            autofocus
            v-model="message"
          />
          <input type="hidden" />
        </fieldset>
        <p>Enter to send</p>
      </form>
    </div>
    <\!-- end chat --\>
  </div>
  -->

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
        setTimeout(() => {
          this.$refs.chatHistory.scrollTop = this.$refs.chatHistory.scrollHeight;
        }, 1000);
      });
  },
  methods: {
    async postMessage() {
      let msg = this.message;
      let chatId = utils.generateId();

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
      this.$refs.chatHistory.scrollTop = this.$refs.chatHistory.scrollHeight;
    }
  }
};
</script>

<style scoped>

</style>
