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
        labels: ["Excluzeev", "PayPal", "Content Creator"],
        datasets: [
          {
            label: "One",
            backgroundColor: ["#41B883", "#E46651", "#00D8FF"],
            data: [5, 5.5, 90],
            l: ["5%", "5% + 5 cents", "Remaining"],
            tooltips: {
              mode: "index"
            }
          }
        ]
      },
      {
        responsive: true,
        maintainAspectRatio: false,
        tooltips: {
          enabled: true,
          callbacks: {
            label: function(tooltipItem, data) {
              let dataset = data.datasets[tooltipItem.datasetIndex];
              let currentValue = dataset.l[tooltipItem.index];
              let label = data.labels[tooltipItem.index];
              return label + " " + currentValue;
            }
          }
        }
      }
    );
  }
};
</script>
