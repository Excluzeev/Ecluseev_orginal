/* eslint-disable */
import {
  fireStore,
  auth,
  gprovider,
  fprovider
} from "../../firebase/init";
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
    checkUser: ({
      state
    }) => {
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

    signInFb: ({
      state,
      dispatch
    }) => {
      return new Promise(resolve => {
        let errorData = {
          error: false,
          message: "Login Successful"
        };

        
        auth
          .signInWithPopup(fprovider)
          .then(() => {
            errorData = {
              error: false,
              message: "Login Successful"
            };
            dispatch('checkUser').then(userRecord => {
              if (userRecord.exists) {
                resolve(errorData);
              } else {
                errorData = {
                  error: true,
                  message: "User not found. Please register."
                };
                resolve(errorData);
              }
            });
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
    signInGmail: ({
      state,
      dispatch
    }) => {
      return new Promise(resolve => {

        let errorData = {
          error: false,
          message: "Login Successful"
        };

        
        //console.log("Signin via gmail")
        auth
          .signInWithPopup(gprovider)
          .then(() => {
            errorData = {
              error: false,
              message: "Login Successful"
            };
            dispatch('checkUser').then(userRecord => {

              //console.log("userRecord",userRecord)
              if (userRecord.exists) {
                resolve(errorData);
              } else {
                errorData = {
                  error: true,
                  message: "User not found. Please register."
                };
                resolve(errorData);
              }
            });
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
    loginUser: ({
      state,
      dispatch
    }, {
      email,
      password
    }) => {
      return new Promise(resolve => {
        let errorData = {
          error: false,
          message: "Login Successful"
        };
        auth
          .signInWithEmailAndPassword(email, password)
          .then(() => {
            errorData = {
              error: false,
              message: "Login Successful"
            };
            dispatch('checkUser').then(userRecord => {



              if (userRecord.exists) {

                let cuser=auth.currentUser

                //console.log("user",cuser)
                if(cuser.emailVerified == false){

                    errorData = {
                        error: true,
                        message: "Email not verified",
                        isEmailVerified: false
                    };
                    resolve(errorData);
                }else{
                    resolve(errorData);

                }
              } else {
                errorData = {
                  error: true,
                  message: "User not found. Please register."
                };
                resolve(errorData);
              }
            });
          })
          .catch(error => {
            errorData = {
              code: error.code,
              message: error.message,
              error: true
            };

            auth.signOut();
            resolve(errorData);
          });
      });
    },
    signUpUser: ({
      state,
      dispatch
    }, {
      email,
      password,
      firstName,
      lastName
    }) => {
      return new Promise(resolve => {
        let errorData = {
          error: false,
          message: "User SignUp Successful"
        };
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
            console.log(userDoc);
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
            dispatch('checkUser').then(userRecord => {
              if (userRecord.exists) {

                var user = auth.currentUser;

                user.sendEmailVerification().then(function() {
                   // Email sent.
                   resolve(errorData);
                }).catch(function(error) {
                  // An error happened.

                    errorData.code = error.code;
                    errorData.error = true;
                    errorData.message = "Unable to send verification email!!";
                    
                    resolve(errorData);
                });




              } else {
                errorData = {
                  error: true,
                  message: "User not found. Please register."
                };
                resolve(errorData);
              }
            });
            resolve(errorData);
          })
          .catch(error => {
            let errorCode = error.code;
            let errorMessage = error.message;
            errorData = {
              error: true,
              message: errorMessage,
              code: errorCode
            };
            resolve(errorData);
          });
      });
    },
    resetPassword: ({
      state
    }, {
      email
    }) => {
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
    },
    sendVerifyEmail: ({

    }) => {

      return new Promise(resolve => {

            let data = {
              error: false,
              message: "Verfication Email Sent Successful."
            };


            var user = auth.currentUser;

            user.sendEmailVerification().then(function() {
              // Email sent.
              resolve(data) 
            }).catch(function(error) {
              // An error happened.

                data.code = error.code;
                data.error = true;
                data.message = "Unable to send verification email!!";
                resolve(data);
            });

            

      });
        

    },
    signOut: () => {
      try{
          console.log("Going to signout");
          auth.signOut();
      }catch(err){
        console.log("Error",err)
      }
    }
  }
};
