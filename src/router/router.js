import Vue from "vue";
import VueRouter from "vue-router";
import Home from "../views/Home.vue";
import SignUpCC from "../views/SignUpCC.vue";
import CreateChannel from "../views/CreateChannel.vue";
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
  routes: [
    {
      path: "/",
      name: "home",
      component: Home,
      meta: { showNav: true }
    },
    {
      path: "/trailer/:trailerId",
      name: "trailer-single",
      component: TrailerDetail,
      meta: { showNav: true }
    },
    {
      path: "/login",
      name: "login",
      component: Login,
      meta: { noAuth: true, showNav: false }
    },
    {
      path: "/logout",
      name: "logout",
      beforeEnter(to, from, next) {
        store.dispatch("signOut").then(() => {
          next({ name: "home" });
        });
      }
    },
    {
      path: "/registration",
      name: "registration",
      component: Registration,
      meta: { noAuth: true, showNav: false }
    },
    {
      path: "/forgotPassword",
      name: "ForgotPassword",
      component: ForgotPassword,
      meta: { noAuth: true, showNav: false }
    },
    {
      path: "/resetPassword",
      name: "ResetPassword",
      component: ResetPassword,
      meta: { noAuth: true, showNav: false }
    },
    {
      path: "/SignUpCC",
      name: "SignUpCC",
      component: SignUpCC,
      meta: { noAuth: false, showNav: true }
    },
    {
      path: "/CreateChannel",
      name: "CreateChannel",
      component: CreateChannel,
      meta: { noAuth: false, showNav: true }
    },
    {
      path: "/AddTrailer",
      name: "AddTrailer",
      component: AddTrailer,
      meta: { noAuth: false, showNav: true },
      props: (route) => ({
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
        next({ name: "home" });
      } else {
        next();
      }
    });
  } else {
    next();
  }
});
export default router;
