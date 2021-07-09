<template>
  <div class="page">
    <h1>Notifications</h1>
    <div v-if="$fetchState.pending"><Spinner /></div>
    <div v-else class="center">
      <vs-alert
        v-for="notification in notifications"
        :key="notification.id"
        :color="notification.color"
        solid
      >
        <template #title> {{ notification.title }} </template>
        <!-- eslint-disable-next-line vue/no-v-html -->
        <span v-html="notification.description"></span>
      </vs-alert>
    </div>
  </div>
</template>

<script>
export default {
  layout: "dashboard",
  middleware: ["auth"],
  data: () => ({
    notifications: [],
  }),
  async fetch() {
    try {
      this.notifications = await this.$axios.$get(`api/notification/me/`, {
        headers: {
          Authorization: `Bearer ${this.$store.state.accessToken}`,
        },
      });
    } catch (err) {
      return this.$vs.notification({
        color: "danger",
        title: "Error fetching notifications",
      });
    }
  },
};
</script>

<style>
.notification-container {
  padding: 50px 0;
}
</style>
