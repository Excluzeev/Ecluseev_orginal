<template>
  <div class="search">
    <v-container>
      <div v-for="trailer in trailers" v-bind:key="trailer.id">
        <TrailerSearchItem :trailer="trailer"/>
      </div>
    </v-container>
  </div>
</template>

<script>
// @ is an alias to /src
import TrailerSearchItem from "../components/TrailerSearchItem";
import axios from "axios";
import utils from "../utility/utils";

export default {
  name: "SearchPreviews",
  components: {
    TrailerSearchItem
  },
  data: () => {
    return {
      trailers: [],
      processing: true
    };
  },
  mounted() {
    let headers = {
      "X-Algolia-API-Key": "a43f7e807dbde9c65ecd0b08fd5f4bb7",
      "X-Algolia-Application-Id": "8LGSQX6S2G"
    };
    axios
      .get(
        "https://8LGSQX6S2G-dsn.algolia.net/1/indexes/trailers?query=" +
          this.$route.params.query,
        {
          headers: headers
        }
      )
      .then(response => {
        let d = response.data;
        if (response.status != 200) {
          this.showToast("No Search Results.");
        } else {
          if (d.hits.length > 0) {
            d.hits.forEach(hit => {
              this.trailers.push(utils.extractTrailerData(hit, false));
            });
          } else {
            this.showToast("No Search Results.");
          }
        }
      })
      .catch(error => {
        this.processing = false;
        // console.log(error);
      })
      .finally(() => {
        this.processing = false;
      });
  },
  methods: {
    showToast(msg) {
      this.$toasted.show(msg, {
        theme: "outline",
        position: "top-right",
        duration: 2000
      });
    }
  }
};
</script>
