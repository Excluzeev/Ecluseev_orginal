import { fireStore, auth } from "../../firebase/init";
import collections from "../../firebase/utils";
import utils from "../../utility/utils";

export default {
  namespaced: true,
  state: {},
  getters: {
    currentUser: () => {
      return auth.currentUser;
    }
  },
  mutations: {},
  actions: {
    checkUser: ({ state }) => {
      let userId = auth.currentUser.uid;
      return new Promise(async resolve => {
        let userRef = fireStore
          .collection(collections.usersCollections)
          .doc(userId);
        let userSnap = await userRef.get();
        let userData = null;
        if (userSnap.exists) {
          userData = utils.extractUserData(userSnap);
        }
        resolve({
          exists: userSnap.exists,
          data: userData
        });
      });
    },
    loginUser: ({ state }, { email, password }) => {
      console.log(email);
      console.log(password);
      return new Promise(resolve => {
        let errorData = { error: false, message: "Login Successful" };
        auth
          .signInWithEmailAndPassword(email, password)
          .then(() => {
            errorData = { error: false, message: "Login Successful" };
            resolve(errorData);
          })
          .catch(error => {
            errorData = {
              code: error.code,
              message: error.message,
              error: true
            };
            resolve(errorData);
          });
      });
    },
    signUpUser: ({ state }, { email, password, firstName, lastName }) => {
      return new Promise(resolve => {
        let errorData = { error: false, message: "User SignUp Successful" };
        auth
          .createUserWithEmailAndPassword(email, password)
          .then(async () => {
            let currentUser = auth.currentUser;
            await currentUser.updateProfile({
              displayName: firstName + " " + lastName
            });
            let userDoc = {
              firstName: firstName,
              lastName: lastName,
              email: email,
              uid: currentUser.uid,
              isContentCreator: false
            };
            let userRef = fireStore
              .collection(collections.usersCollections)
              .doc(userDoc.uid);
            let userSnap = await userRef.get();
            if (userSnap.exists) {
              await fireStore.runTransaction(async transaction => {
                await transaction.update(userRef, userDoc);
              });
            } else {
              await fireStore.runTransaction(async transaction => {
                await transaction.set(userRef, userDoc);
              });
            }
            resolve(errorData);
          })
          .catch(error => {
            let errorCode = error.code;
            let errorMessage = error.message;
            errorData = { error: true, message: errorMessage, code: errorCode };
            resolve(errorData);
          });
      });
    },
    resetPassword: ({ state }, { email }) => {
      return new Promise(resolve => {
        let data = {
          error: false,
          message: "Password Reset Email Sent Successful."
        };
        auth
          .sendPasswordResetEmail(email)
          .then(() => {
            resolve(data);
          })
          .catch(error => {
            data.code = error.code;
            data.error = true;
            data.message = "No user found with the email.";
            resolve(data);
          });
      });
    }
  }
};
