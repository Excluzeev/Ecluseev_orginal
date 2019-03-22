import Vue from "vue";
import VueRouter from "vue-router";
import Home from "../views/Home.vue";
import SignUpCC from "../views/SignUpCC.vue";
import CreateChannel from "../views/CreateChannel.vue";
import MyChannels from "../views/MyChannels.vue";
import MyChannelDetails from "../views/MyChannelDetails.vue";
import AddTrailer from "../views/AddTrailer.vue";
import TrailerDetail from "../views/TrailerDetail";
import Login from "../views/auth/Login";
import Registration from "../views/auth/Registration";
import ForgotPassword from "../views/auth/ForgotPassword";
import ResetPassword from "../views/auth/ResetPassword";
import { auth } from "../firebase/init";
import store from "../store/index";
import AddVideo from "../views/AddVideo";
import MySubscriptions from "../views/MySubscriptions";
import SubscribedChannelDetails from "../views/SubscribedChannelDetails";
import VideoDetail from "../views/VideoDetail";
import AddLive from "../views/AddLive";
import LiveDetail from "../views/LiveDetail";

import Meta from "vue-meta";
import DCrowd from "../views/DCrowd";
import CrowdFundingTrailer from "../views/CrowdFundingTrailer";
import CrowdFundingVideo from "../views/CrowdFundingVideo";
Vue.use(Meta);

Vue.use(VueRouter);

const router = new VueRouter({
  mode: "history",
  routes: [
    {
      path: "/",
      name: "Home",
      component: Home,
      meta: {
        showNav: true, title: "Excluzeev - Stream. Crowdfunding. Social Network"
      }
    },
    {
      path: "/trailer/:trailerId",
      name: "TrailerSingle",
      component: TrailerDetail,
      meta: { showNav: true, title: "Excluzeev Trailers" }
    },
    {
      path: "/login",
      name: "Login",
      component: Login,
      meta: { noAuth: true, showNav: false, title: "Excluzeev Login" }
    },
    {
      path: "/logout",
      name: "Logout",
      beforeEnter(to, from, next) {
        store.dispatch("signOut").then(() => {
          next({ name: "Home" });
        });
      }
    },
    {
      path: "/registration",
      name: "Registration",
      component: Registration,
      meta: { title: "Excluzeev Registration", noAuth: true, showNav: false }
    },
    {
      path: "/forgot-password",
      name: "ForgotPassword",
      component: ForgotPassword,
      meta: { noAuth: true, showNav: false, title: "Excluzeev Forgot Password" }
    },
    {
      path: "/reset-password",
      name: "ResetPassword",
      component: ResetPassword,
      meta: { noAuth: true, showNav: false, title: "Excluzeev Reset Password" }
    },
    {
      path: "/sign-up-cc",
      name: "SignUpCC",
      component: SignUpCC,
      meta: {
        noAuth: false,
        showNav: true,
        title: "Sign up as content creator"
      }
    },
    {
      path: "/create-channel",
      name: "CreateChannel",
      component: CreateChannel,
      meta: {
        noAuth: false,
        showNav: true,
        title: "Create a Channel"
      }
    },
    {
      path: "/my-channels",
      name: "MyChannels",
      component: MyChannels,
      meta: {
        noAuth: false,
        showNav: true,
        title: "My Channels"
      }
    },
    {
      path: "/my-channel-details/:channelId",
      name: "MyChannelDetails",
      component: MyChannelDetails,
      meta: {
        noAuth: false,
        showNav: true,
        title: "My Channels Details"
      }
    },
    {
      path: "/add-trailer",
      name: "AddTrailer",
      component: AddTrailer,
      meta: { noAuth: false, showNav: true, title: "Add a trailer" },
      props: route => ({
        ...route.params
      })
    },
    {
      path: "/add-video",
      name: "AddVideo",
      component: AddVideo,
      meta: { noAuth: false, showNav: true, title: "Add a Video" },
      props: route => ({
        ...route.params
      })
    },
    {
      path: "/add-excluzeev",
      name: "AddExcluzeev",
      component: AddLive,
      meta: { noAuth: false, showNav: true, title: "Excluzeev Live" },
      props: route => ({
        ...route.params
      })
    },
    {
      path: "/video/:videoId",
      name: "VideoSingle",
      component: VideoDetail,
      meta: { showNav: true, title: "Excluzeev Videos" }
    },
    {
      path: "/crowd/:trailerId",
      name: "CrowdFundingTrailer",
      component: CrowdFundingTrailer,
      meta: { showNav: true, title: "Excluzeev Videos" }
    },
    {
      path: "/crowd/video/:videoId",
      name: "CrowdFundingVideo",
      component: CrowdFundingVideo,
      meta: { showNav: true, title: "Excluzeev Videos" }
    },
    {
      path: "/live/:videoId",
      name: "LiveSingle",
      component: LiveDetail,
      meta: { showNav: true, title: "Excluzeev Videos" }
    },
    {
      path: "/my-subscriptions",
      name: "MySubscriptions",
      component: MySubscriptions,
      meta: {
        noAuth: false,
        showNav: true,
        title: "My Subscriptions"
      }
    },
    {
      path: "/:channelId/:subscriptionId",
      name: "SubscribedChannelDetails",
      component: SubscribedChannelDetails,
      meta: {
        noAuth: false,
        showNav: true,
        title: "Channels Details"
      },
      props: route => ({
        ...route.params
      })
    },
    {
      path: "/crowd",
      name: "Crowd",
      component: DCrowd,
      meta: {
        noAuth: false,
        showNav: true,
        title: "Crowd Funding"
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

router.beforeEach((to, from, next) => {
  if (to.meta.noAuth) {
    auth.onAuthStateChanged(user => {
      if (user) {
        next({ name: "Home" });
      } else {
        next();
      }
    });
  } else {
    next();
  }
});

export default router;
