<template>
  <div id="live-chat">
    <header class="clearfix">
      <h4>Live Chat</h4>
    </header>

    <div class="chat">
      <div class="chat-history" ref="chatHistory">
        <div class="chat-message clearfix" v-if="liveChat.length == 0">
          <h5>No Messages yet.</h5>
        </div>
        <div v-for="chat in liveChat" v-else>
          <div class="chat-message clearfix">
            <img
              src="https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png"
              alt=""
              width="32"
              height="32"
            />

            <div class="chat-message-content clearfix">
              <span class="chat-time">{{ chat.time }}</span>

              <h5>{{ chat.userName }}</h5>

              <p>{{ chat.message }}</p>
            </div>
            <!-- end chat-message-content -->
          </div>
          <!-- end chat-message -->

          <hr />
        </div>
        <!-- end chat-history -->
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
    <!-- end chat -->
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
            userName: d.userName
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
/* ---------- GENERAL ---------- */

body {
  background: #e9e9e9;
  color: #9a9a9a;
  font: 100%/1.5em "Droid Sans", sans-serif;
  margin: 0;
}

a {
  text-decoration: none;
}

fieldset {
  border: 0;
  margin: 0;
  padding: 0;
}

h4,
h5 {
  line-height: 1.5em;
  margin: 0;
}

hr {
  background: #e9e9e9;
  border: 0;
  -moz-box-sizing: content-box;
  box-sizing: content-box;
  height: 1px;
  margin: 0;
  min-height: 1px;
}

img {
  border: 0;
  display: block;
  height: auto;
  max-width: 100%;
}

input {
  border: 0;
  color: inherit;
  font-family: inherit;
  font-size: 100%;
  line-height: normal;
  margin: 0;
}

p {
  margin: 0;
}

.clearfix {
  *zoom: 1;
} /* For IE 6/7 */
.clearfix:before,
.clearfix:after {
  content: "";
  display: table;
}
.clearfix:after {
  clear: both;
}

/* ---------- LIVE-CHAT ---------- */

#live-chat {
  bottom: 0;
  font-size: 12px;
  right: 24px;
  width: 100%;
}

#live-chat header {
  background: #293239;
  color: #fff;
  cursor: pointer;
  padding: 16px 24px;
}

#live-chat h4:before {
  background: #1a8a34;
  border-radius: 50%;
  content: "";
  display: inline-block;
  height: 8px;
  margin: 0 8px 0 0;
  width: 8px;
}

#live-chat h4 {
  font-size: 12px;
}

#live-chat h5 {
  font-size: 10px;
}

#live-chat form {
  padding: 24px;
}

#live-chat input[type="text"] {
  border: 1px solid #ccc;
  border-radius: 3px;
  padding: 8px;
  outline: none;
  width: 234px;
}

.chat-message-counter {
  background: #e62727;
  border: 1px solid #fff;
  border-radius: 50%;
  display: none;
  font-size: 12px;
  font-weight: bold;
  height: 28px;
  left: 0;
  line-height: 28px;
  margin: -15px 0 0 -15px;
  position: absolute;
  text-align: center;
  top: 0;
  width: 28px;
}

.chat-close {
  background: #1b2126;
  border-radius: 50%;
  color: #fff;
  display: block;
  float: right;
  font-size: 10px;
  height: 16px;
  line-height: 16px;
  margin: 2px 0 0 0;
  text-align: center;
  width: 16px;
}

.chat {
  background: #fff;
}

.chat-history {
  height: 252px;
  padding: 8px 24px;
  overflow-y: scroll;
}

.chat-message {
  margin: 16px 0;
}

.chat-message img {
  border-radius: 50%;
  float: left;
}

.chat-message-content {
  margin-left: 56px;
}

.chat-time {
  float: right;
  font-size: 10px;
}

.chat-feedback {
  font-style: italic;
  margin: 0 0 0 80px;
}
</style>
