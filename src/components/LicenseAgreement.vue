<template>
  <v-container>
    <div>
      <h1 class="main_text">Content creators terms of use</h1>
      <p>
        Excluzeev contains vast amount of user content including user profiles,
        audio and video content uploaded by Creators on their channels, content
        description, public forum chats, comments etc (“Your Content”). We do
        not claim any ownership of Your Content, but you do acknowledge that by
        uploading, posting and sharing your content you are granting us
        exclusive, world-wide, fully paid, royalty-free, license to use,
        distribute, reproduce, publish, display or share Your Content on our
        Services and to make it accessible to other users in accordance with
        this Agreement and any other licensing agreement we have entered into
        with you as the Creator.
        <br>
        <br>Please note that we may be required to remove Your Content from
        Excluzeev if it is claimed to be infringing the intellectual property
        rights of a third-party. If you believe that Your Content has been
        wrongly removed from Excluzeev, please contact us to rebut the copyright
        infringement claim in accordance with article 12 of this Agreement. For
        the purposes of this agreement ‘Your Content’ includes but is not
        limited to images, audio, videos, text or similar material.
        <br>
        <br>All information transmitted by a User is the sole responsibility of the
        User who posted / listed or shared that content on Excluzeev and the
        Company will not be liable for any errors or omissions in Your Content.
      </p>
    </div>
  </v-container>
</template>

<script>
export default {
  name: "LicenseAgreement",
  metaInfo: {
    title: "License Agreement"
  }
};
</script>

<style scoped>
.license_page {
  text-align: justify;
  font-family: Arial;
  margin: 30px;
  padding: 35px;
}
.main_text {
  text-align: center;
}
p {
  font-size: 16px;
}
</style>
