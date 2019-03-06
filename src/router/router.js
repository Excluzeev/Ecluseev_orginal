import Vue from "vue";
import VueRouter from "vue-router";
import Home from "../views/Home.vue";
import TrailerDetail from "../views/TrailerDetail";
import Login from "../views/auth/Login";
import Registration from "../views/auth/Registration";
import ForgotPassword from "../views/auth/ForgotPassword";
import ResetPassword from "../views/auth/ResetPassword";

import store from "../store/index";
import { auth } from "../firebase/init";

Vue.use(VueRouter);

const router = new VueRouter({
  routes: [
    {
      path: "/",
      name: "home",
      component: Home
    },
    {
      path: "/trailer/:trailerId",
      name: "trailer-single",
      component: TrailerDetail
    },
    {
      path: "/login",
      name: "login",
      component: Login,
      meta: { noAuth: true, showNav: false }
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
        next({ name: "home", redirect: from.fullPath });
      } else {
        next();
      }
    });
  } else {
    next();
  }
});
export default router;
