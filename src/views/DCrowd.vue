<template>
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
