<script>
import VueCharts from "vue-chartjs";
import { Pie } from "vue-chartjs";

// CommitChart.js
import { Bar } from "vue-chartjs";

export default {
  extends: Pie,
  props: ["chartdata"],
  mounted() {
    // Overwriting base render method with actual data.
    this.renderChart(this.chartdata, {
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
    });
  }
};
</script>
