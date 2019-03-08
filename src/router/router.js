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

Vue.use(VueRouter);

const router = new VueRouter({
  mode: "history",
  routes: [
    {
      path: "/",
      name: "Home",
      component: Home,
      meta: {
        showNav: true
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
      path: "/my-channel-cetails",
      name: "MyChannelDetails",
      component: MyChannelDetails,
      meta: {
        noAuth: false,
        showNav: true,
        title: "My Channels Details"
      },
      props: route => ({
        ...route.params
      })
    },
    {
      path: "/add-trailer",
      name: "AddTrailer",
      component: AddTrailer,
      meta: { noAuth: false, showNav: true, title: "Add a trailer" },
      props: route => ({
        ...route.params
      })
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
