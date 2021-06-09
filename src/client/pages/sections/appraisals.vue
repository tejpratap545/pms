<template>
  <div class="page">
    <h1>My Appraiasals</h1>
    <div v-if="$fetchState.pending"></div>
    <div v-else class="center grid" style="margin-top: 50px">
      <div class="appraisal-grid">
        <div class="appraisal-lists">
          <div
            v-for="a in apprisalList"
            :key="a.id"
            class="appraisal-list-item"
            @click="() => (selectedAppraisal = a)"
          >
            Appraisal
          </div>
        </div>
        <div class="appraisal-item-open">
          <div class="appraisal-item">
            <div v-if="selectedAppraisal != null">
              <div class="appraisal-property">
                <div class="appraisal-property-key">
                  <b>Stage 1 : </b> Employee Comment
                </div>
                <div class="appraisal-property-value">Sample Text</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  layout: "dashboard",
  middleware: ["auth"],
  data: () => ({
    active: false,
    loading: false,
    apprisalList: [],
    selectedAppraisal: {},
  }),
  async fetch() {
    try {
      this.apprisalList = await this.$axios.$get(`api/appraisal/`, {
        headers: {
          Authorization: `Bearer ${this.$store.state.accessToken}`,
        },
      });
    } catch (err) {
      return this.$vs.notification({
        color: "danger",
        title: "Error fetching appriasals",
      });
    }
  },
};
</script>

<style>
.appraisal-grid {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
}

.appraisal-lists {
  width: 300px;
}

.appraisal-lists > .appraisal-list-item {
  padding: 10px;
  background: #eee;
  border-radius: 16px;
  margin-right: 20px;
  margin-bottom: 10px;
  opacity: 0.7;
  text-align: center;
}

.appraisal-lists > .appraisal-list-item:hover {
  cursor: pointer;
  color: #fff;
  background: #195bff;
}

.appraisal-item {
  width: 100%;
  min-height: 600px;
  background: #f2f2f2;
  box-shadow: 0px 0px 25px 0px rgba(0, 0, 0, var(--vs-shadow-opacity));
  border-radius: 16px;
  padding: 30px;
}

.appraisal-property {
  display: flex;
}

.appraisal-item-open {
  max-width: 800px;
  width: 100%;
}

.appraisal-property-key {
  background: #ccc;
  padding: 10px;
  width: 50%;
  border-radius: 25px;
}

.appraisal-property {
  display: flex;
  text-align: center;
  margin: 20px 0;
}

.appraisal-property-value {
  padding: 10px;
  text-align: center;
  width: 50%;
}

@media only screen and (max-width: 800px) {
  .appraisal-lists > .appraisal-list-item {
    margin-right: unset;
  }
}
</style>
