<template>
  <div style="height:100%;">
    <v-container text-xs-center fill-height>
      <v-layout align-center row wrap justify-center>
        <v-flex xs12 sm8 md5 align-center>
          <h1>Ecluzeev Charges Information</h1>
          <ChartPie :chartdata="tier1" />
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
    return {
      tier2: {
        labels: ["Excluzeev", "Stripe", "Content Creator"],
        datasets: [
          {
            label: "One",
            backgroundColor: ["#41B883", "#E46651", "#00D8FF"],
            data: [5, 3.0, 90],
            l: ["5%", "2.9% + 0.30$", "Remaining"],
            tooltips: {
              mode: "index"
            }
          }
        ]
      },
      tier1: {
        labels: ["Excluzeev", "Stripe", "Content Creator"],
        datasets: [
          {
            label: "One",
            backgroundColor: ["#41B883", "#E46651", "#00D8FF"],
            data: [5, 0.25, 94.75],
            l: ["5%", "0.25%", "Remaining"],
            tooltips: {
              mode: "index"
            }
          }
        ]
      }
    };
  }
};
</script>

<style scoped>
.padding {
  padding: 10px;
}
</style>
