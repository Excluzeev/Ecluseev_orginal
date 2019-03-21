<template>
  <div>
    <v-container grid-list-md text-xs-center>
      <v-layout row>
        <v-flex xs2>
          <div align="left">
            <v-icon color="teal darken-2" x-large dark>account_circle</v-icon>
            <div style="font-size:1.4rem" class="quick-sand-font-l">
              VJ Pranay
            </div>
          </div>
        </v-flex>
        <v-flex xs10>
          <div align="left">
            <div class="flex display-1 font-weight-normal">
              Free software is vital! Its more then human right!!
            </div>
            <div class="nav-c t1824">
              The free software movement (FSM) or free/open-source software
              movement (FOSSM) or free/libre open-source software movement
              (FLOSSM)
            </div>
          </div>
        </v-flex>
        <v-flex xs3> </v-flex>
      </v-layout>
      <v-layout row> </v-layout>
      <v-layout row>
        <v-flex xs8>
          <iframe
            src="https://player.vimeo.com/video/153239711"
            width="750"
            height="480"
            frameborder="0"
            webkitallowfullscreen
            mozallowfullscreen
            allowfullscreen
          ></iframe>
        </v-flex>
        <v-flex>
          <v-spacer></v-spacer>
        </v-flex>
        <v-flex xs4>
          <v-progress-linear
            color="teal"
            height="5"
            value="30"
          ></v-progress-linear>
          <div align="left">
            <div
              style="font-size:1.4rem;"
              class="flex display-1 font-weight-normal teal--text darken-2"
            >
              US$ 278,418
            </div>
            <p class="nav-c t1824">pledged of US$ 250,000 goal</p>
            <p class="nav-c flex d-flex align-start display-1 font-weight-thin">
              7,268
            </p>
            <p class="nav-c t1824">backers</p>
            <p class="nav-c flex d-flex align-start display-1 font-weight-thin">
              13
            </p>
            <p class="nav-c t1824">days to go</p>
            <v-btn block class="quick-sand-font-b white--text" color="teal"
              >Donate 25$</v-btn
            >
            <v-btn block class="quick-sand-font-b white--text" color="teal"
              >Donate 50$</v-btn
            >
            <v-btn block class="quick-sand-font-b white--text" color="teal"
              >Donate 100$</v-btn
            >
          </div>
        </v-flex>
      </v-layout>
    </v-container>
    <v-footer class="white" height="auto">
      <v-flex xs3>
        <div align="center">
          <img
            style="width: 50%;"
            alt="Excluzeev
            logo"
            src="../assets/excluzeev_bottom_text.png"
          />
          <!-- <div class="light-blue--text quick-sand-font-b">
            &copy; 2019 Excluzeev
          </div> -->
        </div>
      </v-flex>
      <v-flex xs2>
        <div align="center">
          <div align="left">
            <h3 class="nav-c quick-sand-font-b">EXPLORE</h3>

            <h3 class="light-blue--text quick-sand-font">About</h3>
            <h3 class="light-blue--text quick-sand-font">Support</h3>
            <h3 class="light-blue--text quick-sand-font">Contact us</h3>
          </div>
        </div>
      </v-flex>
      <v-flex xs2>
        <div align="top center">
          <div align="left">
            <h3 class="nav-c quick-sand-font-b">LEGAL</h3>

            <h3 class="light-blue--text quick-sand-font">
              Terms and conditions
            </h3>
            <h3 class="light-blue--text quick-sand-font">Privacy Policy</h3>
            <h3 class="light-blue--text quick-sand-font">Cookie Policy</h3>
          </div>
        </div>
      </v-flex>
      <v-flex xs2>
        <div align="top center">
          <div align="left">
            <h3 class="nav-c quick-sand-font-b">FOLLOW US</h3>

            <h3 class="light-blue--text quick-sand-font">Facebook</h3>
            <h3 class="light-blue--text quick-sand-font">Instagram</h3>
            <h3 class="light-blue--text quick-sand-font">Twitter</h3>
          </div>
        </div>
      </v-flex>
      <v-flex xs3>
        <h3 class="nav-c quick-sand-font-b">APPS</h3>
        <img
          style="width: 120px;"
          alt="Download_on_the_App_Store"
          src="../assets/Download_on_the_App_Store.svg"
        />
        <img
          style="width: 120px;"
          alt="google-play-badge"
          src="../assets/google-play-badge.png"
        />
      </v-flex>
    </v-footer>
  </div>
</template>

<script>
export default {
  name: "DCrowd"
};
</script>

<style scoped>
.nav-c {
  color: #656969;
}
.t1824 {
  font-size: 1.3rem;
}
</style>
