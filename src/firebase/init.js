import * as firebase from "firebase/app";
import "firebase/auth";
import "firebase/firestore";
import "firebase/database";
import "firebase/storage";

const config = {
  apiKey: "AIzaSyBaaaA4ABqwDHINyDwx0bDM40hXs8p5Fcs",
  authDomain: "trenstop-2033f.firebaseapp.com",
  databaseURL: "https://trenstop-2033f.firebaseio.com",
  projectId: "trenstop-2033f",
  storageBucket: "trenstop-public",
  messagingSenderId: "527781088405"
};

if (!firebase.apps.length) {
  firebase.initializeApp(config);
}
export const auth = firebase.auth();
export const fireStore = firebase.firestore();
export const storage = firebase.storage();
export default firebase.app();
