<template>
  <v-container grid-list-xl>
    <v-card-actions class="justify-center">
      <img :src="require('../assets/e.png')" height="50" />
      <v-btn
        style="background-color: #fff !important;"
        class="blue--text lighten-1 "
        round
        >My Channels</v-btn
      >
      <v-btn
        style="background-color: #fff !important;"
        class="blue--text lighten-1"
        round
        >Excluzeev</v-btn
      >
      <v-btn
        style="background-color: #fff !important;"
        class="blue--text lighten-1"
        round
        >My Subscriptions</v-btn
      >
      <v-text-field
        append-icon="search"
        label="Search"
        solo
        color="blue lighten-1"
        class="my-input"
      ></v-text-field>
      <v-select
        v-model="select"
        :items="items"
        item-text="Category"
        label="Select a catergory"
        persistent-hint
        return-object
        single-line
        solo
        class="my-input"
      ></v-select>
    </v-card-actions>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      select: { Category: "Select a Catergory" },
      items: [
        { Category: "Call to action" },
        { Category: "Comic" },
        { Category: "Drama" },
        { Category: "Entertiment" }
      ]
    };
  }
};
</script>

<style>
.my-input.v-input .v-input__slot {
  border-radius: 100px !important;
  background-color: #fff !important;
}
</style>
