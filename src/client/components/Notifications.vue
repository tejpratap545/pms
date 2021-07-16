<template>
  <div>
    <h2 style="font-weight: 600">Notifications</h2>
    <div v-if="$fetchState.pending"><Spinner /></div>
    <div v-else class="center">
      <vs-alert
        v-for="notification in notifications"
        :key="notification.id"
        :color="notification.color"
        class="my-5"
        solid
      >
        <template #title> {{ notification.title }} </template>
        <!-- eslint-disable-next-line vue/no-v-html -->
        <span v-html="notification.description"></span>
        <vs-button
          v-if="!notification.is_read"
          :loading="loading"
          border
          @click="readNotification(notification.id)"
        >
          Mark as read
        </vs-button>
      </vs-alert>

      <h4 v-if="notifications.length == 0">No unread notifications</h4>
    </div>
  </div>
</template>

<script>
export default {
  name: "Notifications",
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
  methods: {
    readNotification(id) {
      if (!this.loading) {
        this.loading = true;

        this.$axios
          .$post(
            `api/notification/${id}/read/`,
            {},
            {
              headers: {
                Authorization: `Bearer ${this.$store.state.accessToken}`,
              },
            }
          )
          .then(() => {})
          .catch(() => {
            this.loading = false;
            return this.$vs.notification({
              color: "danger",
              title: "Cannot mark notification as read",
            });
          });
      }
    },
  },
};
</script>

<style>
.notification-container {
  padding: 50px 0;
}
</style>
