<template>
  <div class="home" :key="$route.fullPath">
    <div style="padding-top:25px"></div>
    <!--<FeaturedItem />-->
    <CategoriesTrailerVideos />
  </div>
</template>

<script>
// @ is an alias to /src
// import FeaturedItem from "../components/FeaturedItem";
import CategoriesTrailerVideos from "../components/CategoriesTrailerVideos";

export default {
  name: "Home",
  components: {
    // FeaturedItem,
    CategoriesTrailerVideos
  },
  data: () => {
    return {
      // privacyPolicy: false,
      // termsCreator: false,
      // terms: false,
      // dialog: false,
      // titleDialog: "",
      // componentDialog: null
    };
  },
  methods: {
    // showPrivacyPolicy() {
    //   this.titleDialog = "Privacy Policy";
    //   this.componentDialog = PrivacyPolicy;
    //   this.dialog = true;
    // },
    // showCreatorTerms() {
    //   this.titleDialog = "Content Creator Terms";
    //   this.componentDialog = ContentCreator;
    //   this.dialog = true;
    // },
    // showExcluzeevTerms() {
    //   this.titleDialog = "Excluzeev Terms";
    //   this.componentDialog = LicenseAgreement;
    //   this.dialog = true;
    // }
  },
  async mounted() {
    if (this.$route.query.done) {
      await this.$store.commit("forceFetchUser", {
        user: auth.currentUser,
        force: true
      });
    }
  }
};
</script>
