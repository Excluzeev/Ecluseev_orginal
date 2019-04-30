<template>
  <div style="height:100%;">
    <v-container text-xs-center fill-height>
      <v-layout align-center row wrap justify-center>
        <v-flex xs12 sm8 md5 align-center>
          <h1>Ecluzeev Pricing Info</h1>
          <ChartPie/>
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
import ChartPie from "../components/chartpie.vue";

export default {
  components: {
    ChartPie
  },
  data: () => {
    return {};
  }
};
</script>

<style scoped>
.padding {
  padding: 10px;
}
</style>
