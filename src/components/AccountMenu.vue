<template>
  <v-menu
    offset-y
    content-class="dropdown-menu"
    transition="slide-y-transition"
  >
    <v-icon x-large slot="activator" color="blue lighten-1"
      >account_circle</v-icon
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
      notifications: [
        "Mike, John responded to your email",
        "You have 5 new tasks",
        "You're now a friend with Andrew",
        "Another Notification",
        "Another One"
      ]
    };
  }
};
</script>

<style></style>
