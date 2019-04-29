<script>
import VueCharts from "vue-chartjs";
import { Pie } from "vue-chartjs";

// CommitChart.js
import { Bar } from "vue-chartjs";

export default {
  extends: Pie,
  mounted() {
    // Overwriting base render method with actual data.
    this.renderChart(
      {
        labels: ["January", "February", "March", "April"],
        datasets: [
          {
            label: "Data One",
            backgroundColor: ["#41B883", "#E46651", "#00D8FF", "#DD1B16"],
            data: [40, 20, 80, 10]
          }
        ]
      },
      { responsive: true, maintainAspectRatio: false }
    );
  }
};
</script>
