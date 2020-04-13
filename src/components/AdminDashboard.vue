<template>

      <div>

        <p class="page-title">Dashboard</p>


        <h5>Content creators</h5>
        <div class="table-responsive p-20">
            <table class="table">
              <thead>
                <tr>
                  <th class=" bdwT-0">User name</th>
                  <th class=" bdwT-0">Email</th>
                  <th class=" bdwT-0">Actions</th>
                </tr>
              </thead>
              <tbody>
                    <tr v-for="user in users" v-if="user.isContentCreator">
                        <td> {{user.firstName}} {{user.lastName}}</td>
                        <td> {{user.email}}</td>
                        <td></td>                
                    </tr>
              </tbody>

            </table>

        </div>


        <h5>Admins</h5>
        <div class="table-responsive p-20">
            <table class="table">
              <thead>
                <tr>
                  <th class=" bdwT-0">User name</th>
                  <th class=" bdwT-0">Email</th>
                  <th class=" bdwT-0">Actions</th>
                </tr>
              </thead>
              <tbody>
                    <tr v-for="user in users" v-if="user.isAdmin">
                        <td> {{user.firstName}} {{user.lastName}}</td>
                        <td> {{user.email}}</td>
                        <td></td>
                        
                    </tr>
              </tbody>

            </table>

        </div>



        <h5>Users</h5>
        <div class="table-responsive p-20">
            <table class="table">
              <thead>
                <tr>
                  <th class=" bdwT-0">User name</th>
                  <th class=" bdwT-0">Email</th>
                  <th class=" bdwT-0">Actions</th>
                </tr>
              </thead>
              <tbody>
                    <tr v-for="user in users" v-if="!user.isAdmin&user.isContentCreator">
                        <td> {{user.firstName}} {{user.lastName}}</td>
                        <td> {{user.email}}</td>
                        <td></td>
                        
                    </tr>
              </tbody>

            </table>

        </div>






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
        users:[],        
    };
  },
  mounted() {
      
       this.users=[]; 
       fireStore
           .collection(utils.usersCollections)
        .get()
        .then(querySnapshot =>{

          querySnapshot.forEach(snapShot => {

            this.users.push(snapShot.data());

          });


        });



  },
  methods: {
  }
};
</script>

<style scoped>

</style>
