<template>
  <div class="home">
    <img alt="Vue logo" src="../assets/logo.png" />
    <HelloWorld msg="Welcome to Your Vue.js App" />
    <CategoryTrailers />
  </div>
</template>

<script>
// @ is an alias to /src
import HelloWorld from "../components/HelloWorld";
import CategoryTrailers from "../components/CategoryTrailers";

export default {
  name: "home",
  components: {
    HelloWorld,
    CategoryTrailers
  }
};
</script>
