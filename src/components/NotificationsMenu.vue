<template>
  <v-menu
    offset-y
    content-class="dropdown-menu"
    transition="slide-y-transition"
  >
    <v-icon x-large slot="activator" color="blue lighten-1"
      >notifications_none</v-icon
    >
    <v-card>
      <v-list dense>
        <v-list-tile v-for="notification in notifications" :key="notification">
          <v-list-tile-title v-text="notification" />
        </v-list-tile>
      </v-list>
    </v-card>
  </v-menu>
</template>

<script>
export default {
  data() {
    return {
      notifications: ["No Notifications"]
    };
  }
};
</script>

<style></style>
