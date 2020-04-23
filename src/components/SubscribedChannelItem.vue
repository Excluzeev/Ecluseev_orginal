<template>
  <router-link
    :to="{
      name: 'SubscribedChannelDetails',
      params: {
        channelId: subscription.channelId,
        subscriptionId: subscription.subscriptionId
      }
    }"
  >
    <v-card>
      <v-layout class="padding text-xs-center quick-sand-font-n" justify-center wrap>
          <v-flex>
              <h3 class="padding text-xs-center">
                  {{ subscription.channelName }}
              </h3>

              <v-divider></v-divider>
              <div class="padding"></div>
          </v-flex>
        <v-flex>
            <v-avatar :tile="tile" size="150px" color="grey lighten-4">
                <img
                        :src="
              'https://firebasestorage.googleapis.com/v0/b/trenstop-public/o/channels%2F' +
                subscription.channelId +
                '%2Fthumbnail.jpg?alt=media'
            "
                        alt="avatar"
                />
            </v-avatar>
        </v-flex>

      </v-layout>
    </v-card>
  </router-link>
</template>

<script>
export default {
  name: "SubscribedChannelItem",
  props: ["subscription"]
};
</script>

<style scoped>
    .padding {
        padding: 10px;
    }
    a{display:contents!important}
.trailer-item a,
.subscriber a{display:contents!important}
h6{color:#294D5D}
</style>
