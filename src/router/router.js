import Vue from "vue";
import Router from "vue-router";
import Home from "../views/Home.vue";
import TrailerDetail from "../views/TrailerDetail";
import Login from "../views/auth/login";
import Registration from "../views/auth/registration";
import ForgotPassword from "../views/auth/forgotPassword";
import ResetPassword from "../views/auth/resetPassword";

Vue.use(Router);

export default new Router({
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
      component: Login
    },
    {
      path: "/registration",
      name: "registration",
      component: Registration
    },
    {
      path: "/forgotPassword",
      name: "ForgotPassword",
      component: ForgotPassword
    },
    {
      path: "/resetPassword",
      name: "ResetPassword",
      component: ResetPassword
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
