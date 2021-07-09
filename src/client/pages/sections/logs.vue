<template>
  <div class="page">
    <h1>Logs</h1>
    <div v-if="$fetchState.pending"><Spinner /></div>
    <div v-else class="center">
      <vs-alert
        v-for="log in logList.results"
        :key="log.id"
        :color="log.color"
        class="my-5"
        solid
      >
        <template #title> {{ log.title }} </template>
        <!-- eslint-disable-next-line vue/no-v-html -->
        <span v-html="log.description"></span>
      </vs-alert>

      <h2 v-if="logList.count == 0" style="text-align: center">No logs</h2>
      <vs-row class="my-5 pa-2">
        <vs-col v-if="logList.is_previous" w="4">
          <vs-button @click="page--, $fetch()"> Previous </vs-button>
        </vs-col>
        <vs-col
          v-if="logList.is_next"
          w="8"
          style="display: flex; justify-content: flex-end"
        >
          <vs-button @click="page++, $fetch()"> Next </vs-button>
        </vs-col>
      </vs-row>
    </div>
  </div>
</template>

<script>
export default {
  layout: "dashboard",
  middleware: ["auth"],
  data: () => ({
    logList: [],
    page: 1,
  }),
  async fetch() {
    try {
      this.logList = await this.$axios.$get(`api/log/?page=${this.page}`, {
        headers: {
          Authorization: `Bearer ${this.$store.state.accessToken}`,
        },
      });
    } catch (err) {
      return this.$vs.log({
        color: "danger",
        title: "Error fetching logs",
      });
    }
  },
};
</script>

<style>
.log-container {
  padding: 50px 0;
}
</style>
