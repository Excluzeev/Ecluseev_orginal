<template>
  <v-content>
    <v-container fluid fill-height>
      <ChartPie/>
    </v-container>
  </v-content>
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
