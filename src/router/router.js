import Vue from "vue";
import VueRouter from "vue-router";
import Home from "../views/Home.vue";
import Previews from "../views/Previews.vue";
import CreateChannel from "../views/CreateChannel.vue";
import Communities from "../views/Communities.vue";
import MyChannels from "../views/Communities.vue";

import Contact from "../views/Contact";
import Careers from "../views/Careers";
import Partnership from "../views/Partnership";
import Advertise from "../views/Advertise";

import MyChannelDetails from "../views/MyChannelDetails.vue";
import AddTrailer from "../views/AddTrailer.vue";
import TrailerDetail from "../views/TrailerDetail";

import {
  auth
} from "../firebase/init";
import store from "../store/index";
import AddVideo from "../views/AddVideo";
import MySubscriptions from "../views/MySubscriptions";
import SubscribedChannelDetails from "../views/SubscribedChannelDetails";

import ChannelDetails from "../views/ChannelDetails";

import VideoDetail from "../views/VideoDetail";
import AddLive from "../views/AddLive";
import LiveDetail from "../views/LiveDetail";

import Meta from "vue-meta";
import CrowdFundings from "../views/MyCrowdFundings";

import MyEarnings from "../views/MyEarnings";
import MyProfile from "../views/MyProfile";
import Settings from "../views/Settings"; 

/* Admin routes */
import AdminLogin from "../views/AdminLogin"; 
import AdminHome from "../views/AdminHome"; 

import CrowdFundingTrailer from "../views/CrowdFundingTrailer";
import CrowdFundingVideo from "../views/CrowdFundingVideo";
import PrivacyPolicy from "../components/PrivacyPolicy";
import ContentCreator from "../components/ContentCreator";
import LicenseAgreement from "../components/LicenseAgreement";
import CookiePolicy from "../components/CookiePolicy";
import CommunityAgreement from "../components/CommunityAgreement";
import CallToActionTerms from "../components/CallToActionTerms";
import FAQs from "../components/FAQs";
import AboutUs from "../components/About";
import SearchPreviews from "../views/SearchPreviews";
import HowTo from "../views/HowTo";
import ExcluzeevCharges from "../views/ExcluzeevCharges";
import ConnectStripe from "../views/ConnectStripe";
// import SingleCategory from '.../views/SingleCategory';
import SingleCategory from "../views/SingleCategory";
import ChannelLinks from "../views/ChannelLinks";




Vue.use(Meta);

Vue.use(VueRouter);

// Excluzeev - Stream. Crowdfunding. Social Network

const router = new VueRouter({
  mode: "history",
  fallback:false,
  scrollBehavior: () => ({
    y: 0
  }),
  routes: [
    {
      path: "/",
      name: "Home",
      component: Home,
      meta: {
        showNav: true,
        isPreviewPage: false,
        title: "Excluzeev - Stream. Crowdfunding. Social Network"
      }
    },
    {
      path: "/previews",
      name: "Previews",
      component: Previews,
      meta: {
        showNav: false,
        isPreviewPage: true,
        title: "Excluzeev - Stream. Crowdfunding. Social Network"
      }
    },
    
    {
      path: "/connect",
      name: "ConnectStripe",
      component: ConnectStripe,
      meta: {
        noEntry: true,
        showNav: false,
        title: "Excluzeev - Stream. Crowdfunding. Social Network"
      }
    },
    {
      path: "/trailer/:trailerId",
      name: "TrailerSingle",
      component: TrailerDetail,
      meta: {
        noEntry: false,
        showNav: true,
        title: "Excluzeev Previews"
      }
    },
    {
      path: "/category",
      name: "SingleCategory",
      component: SingleCategory,
      meta: {
        noEntry: false,
        showNav: true,
        title: "Excluzeev Previews"
      }
    },
    {
      path: "/logout",
      name: "Logout",
      beforeEnter(to, from, next) {
        store.dispatch("signOut").then(() => {
          next({
            name: "Home"
          });
        });


      }
    },

    {
      path: "/admin-logout",
      name: "AdminLogout",
      beforeEnter(to, from, next) {

        store.dispatch("signOut").then(() => {
          next({
            name: "AdminLogin"
          });
        })
        .catch(err => {
           console.log("Exception; ",err)
        })


      }
    },


    {
      path: "/create-channel",
      name: "CreateChannel",
      component: CreateChannel,
      meta: {
        noEntry: true,
        showNav: true,
        title: "Create a Channel"
      }
    },
    {
      path: "/communities",
      name: "Communities",
      component: Communities,
      meta: {
        noEntry: true,
        showNav: true,
        title: "Communities"
      }
    },
    {
      path: "/my-channels",
      name: "MyChannels",
      component: MyChannels,
      meta: {
        noEntry: true,
        showNav: true,
        title: "My Channels"
      }
    },
    {
      path: "/my-channel-details/:channelId",
      name: "MyChannelDetails",
      component: MyChannelDetails,
      meta: {
        noEntry: true,
        showNav: true,
        title: "My Channels Details"
      }
    },
    {
      path: "/add-trailer",
      name: "AddTrailer",
      component: AddTrailer,
      meta: {
        noEntry: true,
        showNav: true,
        title: "Add a preview"
      },
      props: route => ({
        ...route.params
      })
    },
    {
      path: "/update-channel-links",
      name: "UpdateLinks",
      component: ChannelLinks,
      meta: {
        noEntry: true,
        showNav: true,
        title: "Update channel links"
      },
      props: route => ({
        ...route.params
      })
    },
    {
      path: "/add-video",
      name: "AddVideo",
      component: AddVideo,
      meta: {
        noEntry: true,
        showNav: true,
        title: "Add a Video"
      },
      props: route => ({
        ...route.params
      })
    },
    {
      path: "/add-excluzeev",
      name: "AddExcluzeev",
      component: AddLive,
      meta: {
        noEntry: true,
        showNav: true,
        title: "Excluzeev Live"
      },
      props: route => ({
        ...route.params
      })
    },
    {
      path: "/search/:query",
      name: "SearchPreviews",
      component: SearchPreviews,
      meta: {
        showNav: true,
        title: "Search | Excluzeev Videos"
      }
    },
    {
      path: "/video/:videoId",
      name: "VideoSingle",
      component: VideoDetail,
      meta: {
        noEntry: true,
        showNav: true,
        title: "Excluzeev Videos"
      }
    },
    {
      path: "/crowd/:trailerId",
      name: "CrowdFundingTrailer",
      component: CrowdFundingTrailer,
      meta: {
        showNav: true,
        title: "Excluzeev Videos"
      }
    },
    {
      path: "/crowd/video/:videoId",
      name: "CrowdFundingVideo",
      component: CrowdFundingVideo,
      meta: {
        showNav: true,
        title: "Excluzeev Videos"
      }
    },
    {
      path: "/live/:videoId",
      name: "LiveSingle",
      component: LiveDetail,
      meta: {
        noEntry: true,
        showNav: true,
        title: "Excluzeev Videos"
      }
    },
    {
      path: "/my-subscriptions",
      name: "MySubscriptions",
      component: MySubscriptions,
      meta: {
        noEntry: true,
        showNav: true,
        title: "My Subscriptions"
      }
    },
    {
      path: "/subscribed/:channelId/:subscriptionId",
      name: "SubscribedChannelDetails",
      component: SubscribedChannelDetails,
      meta: {
        noEntry: true,
        showNav: true,
        title: "Channels Details"
      },
      props: route => ({
        ...route.params
      })
    },

    {
      path: "/crowd-funding-channel/:channelId",
      name: "ChannelDetails",
      component: ChannelDetails,
      meta: {
        noEntry: true,
        showNav: true,
        title: "Channels Details"
      },
      props: route => ({
        ...route.params
      })
    },


    {
      path: "/my-crowd-fundings",
      name: "MyCrowdFundings",
      component: CrowdFundings,
      meta: {
        noEntry: false,
        showNav: true,
        title: "Crowd Funding"
      }
    },
    {
      path: "/my-earnings",
      name: "MyEarnings",
      component: MyEarnings,
      meta: {
        noEntry: false,
        showNav: true,
        title: "My Earnings"
      }
    },
    {
      path: "/my-profile",
      name: "MyProfile",
      component: MyProfile,
      meta: {
        noEntry: false,
        showNav: true,
        title: "My Profile"
      }
    },

    {
      path: "/admin-login",
      name: "AdminLogin",
      component: AdminLogin,
      meta: {
        noEntry: false,
        showNav: false,
        title: "Admin Login"
      }
    },


    {
      path: "/admin-home",
      name: "AdminHome",
      component: AdminHome,
      meta: {
        isAdminPage: true,
        noEntry: true,
        showNav: false,
        title: "Admin Home"
      }
    },


    {
      path: "/settings",
      name: "Settings",
      component: Settings,
      meta: {
        noEntry: false,
        showNav: true,
        title: "Settings"
      }
    },
    {
      path: "/privacy-policy",
      name: "PrivacyPolicy",
      component: PrivacyPolicy,
      meta: {
        noEntry: false,
        showNav: false,
        title: ""
      }
    },
          {
      path: "/contact",
      name: "Contact",
      component: Contact,
      meta: {
        noEntry: false,
        showNav: true,
        title: ""
      }
    },
    {
      path: "/careers",
      name: "Careers",
      component: Careers,
      meta: {
        noEntry: false,
        showNav: true,
        title: ""
      }
    },
          {
      path: "/advertise",
      name: "Advertise",
      component: Advertise,
      meta: {
        noEntry: false,
        showNav: true,
        title: ""
      }
    },
          {
      path: "/partnership",
      name: "Partnership",
      component: Partnership,
      meta: {
        noEntry: false,
        showNav: true,
        title: ""
      }
    },
    {
      path: "/content-creator-policy",
      name: "ContentCreator",
      component: ContentCreator,
      meta: {
        noEntry: false,
        showNav: false,
        title: ""
      }
    },
    {
      path: "/call-to-action-terms",
      name: "CallToActionTerms",
      component: CallToActionTerms,
      meta: {
        noEntry: false,
        showNav: false,
        title: ""
      }
    },
    {
      path: "/excluzeev-charges",
      name: "ExcluzeevCharges",
      component: ExcluzeevCharges,
      meta: {
        noEntry: false,
        showNav: false,
        title: "Excluzeev Pricing information"
      }
    },
    {
      path: "/license-agreement",
      name: "LicenseAgreement",
      component: LicenseAgreement,
      meta: {
        noEntry: false,
        showNav: false,
        title: ""
      }
    },
    {
      path: "/cookie-policy",
      name: "CookiePolicy",
      component: CookiePolicy,
      meta: {
        noEntry: false,
        showNav: false,
        title: ""
      }
    },
    {
      path: "/community-member",
      name: "CommunityAgreement",
      component: CommunityAgreement,
      meta: {
        noEntry: false,
        showNav: false,
        title: ""
      }
    },
    {
      path: "/faqs",
      name: "Faqs",
      component: FAQs,
      meta: {
        noEntry: false,
        showNav: false,
        title: "FAQ's"
      }
    },
    {
      path: "/aboutus",
      name: "AboutUs",
      component: AboutUs,
      meta: {
        noEntry: false,
        showNav: false,
        title: "Excluzeev - Stream. Crowdfunding. Social Network"
      }
    },
    {
      path: "/howto",
      name: "HowTo",
      component: HowTo,
      meta: {
        noEntry: false,
        showNav: true,
        title: "Excluzeev - Stream. Crowdfunding. Social Network"
      }
    }

    // {
    //   path: "/",
    //   name: "home",
    //   component: Home
    // },
    // {
    //   path: "/about",
    //   name: "about",
    //   // route level code-splitting
    //   // this generates a separate chunk (about.[hash].js) for this route
    //   // which is lazy-loaded when the route is visited.
    //   component: () =>
    //     import(/* webpackChunkName: "about" */ "../views/About.vue")
    // }
  ]
});

let loader=null;

router.beforeEach(async (to, from, next) => {
  const nearestWithTitle = to.matched
    .slice()
    .reverse()
    .find(r => r.meta && r.meta.title);

   console.log("before EAch",to.name)
  // Show progress spinner
   // If this isn't an initial page load.
  if (to.name) {

      loader = Vue.$loading.show({
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


      setTimeout(() => {

        // hide loader whenever you want
        loader.hide();
      }, 2000);
  }

  
  if (nearestWithTitle) document.title = nearestWithTitle.meta.title;

  // if (from.path == to.path) {
  //   console.log("aborting route");
  //   return next(false);
  // }

  // auth.onAuthStateChanged(user => {
  //   console.log(user);
  //   next();
  // }, error => {
  //   console.log(error);
  //   return next({
  //     name: "Home",
  //     replace: true
  //   });
  // });

  // if (to.path == "/connect") {
  //   next();
  // } else {

  
  var unsubscribe = auth.onAuthStateChanged(
    user => {
      if (to.meta.noEntry == true) {



        if (user == null) {

          next(false);


        if(to.meta.isAdminPage){


          next({
            name: "AdminLogin",
            replace: true
          });
                    
        }else{
          // console.log("force redirect");
          // this.$router.push({ name: "Login" });
          next({
            name: "Home",
            replace: true
          });

         //location.reload();

        }




        } else {
          next();
        }
      } else {

        

        // console.log(to.path);
        if (
          user &&
          (to.path == "/login" ||
            to.path == "/registration" ||
            to.path == "/forgot-password")
        ) {
          next(false);
          next({
            name: "Home",
            replace: true
          });
          location.reload();
        } else {

          if(to.meta.isAdminPage){
    

            if(user.isAdmin){

                next();

            }else{
                  next({
                    name: "Home",
                    replace: true
                  });
            }
                        

          }else{
            next();
          }

         
       }
      }
    },
    error => {
      console.log(error);
      next({
        name: "Home",
        replace: true
      });
    }
  );
    
  setTimeout(() => {
    unsubscribe();
  }, 2000);
  

 next();

});

router.afterEach((to, from) => {

      setTimeout(() => {

        // hide loader whenever you want
        loader.hide();
      }, 2000);
})




export default router;
