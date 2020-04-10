<template>

      <div>

         <p class="page-title">Dashboard</p>


      </div>
  
</template>

<script>
import { auth, fireStore, firebaseTimestamp } from "../firebase/init";
import utils from "../firebase/utils";
import moment from "moment";

export default {
  name: "AdminDashboard",
  data: () => {
    return {
        
    };
  },
  mounted() {
  },
  methods: {
  }
};
</script>

<style scoped>

</style>
