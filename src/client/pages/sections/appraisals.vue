<template>
  <div class="page">
    <h1>My Appraiasal Management</h1>
    <div v-if="$fetchState.pending"><Spinner /></div>
    <div v-else class="center grid">
      <div class="appraisal-lists">
        <h3>My Appraisals</h3>
        <div
          v-for="a in apprisalList"
          :key="a.id"
          :class="`appraisal-list-item ${
            selectedAppraisal.id == a.id ? `active` : ``
          }`"
          @click="() => (selectedAppraisal = a)"
        >
          {{ a.name }}
        </div>
      </div>
      <div class="appraisal-grid">
        <div class="mobile-appraisal-select">
          <vs-select
            v-model="selectedAppraisalId"
            placeholder="Select Appraisal"
            style="margin-bottom: 10px; width: 100%"
            block
            filter
          >
            <vs-option
              v-for="a in apprisalList"
              :key="a.id"
              :label="a.name"
              :value="a.id"
              @click="() => (selectedAppraisal = a)"
            >
              {{ a.name }}
            </vs-option>
          </vs-select>
        </div>
        <div class="appraisal-item-open">
          <div class="appraisal-item">
            <Appraisal
              v-if="selectedAppraisal != null"
              :selected-appraisal="
                selectedAppraisalId == 0
                  ? selectedAppraisal
                  : apprisalList.find((x) => x.id == selectedAppraisalId)
              "
              @refresh="$fetch()"
            />
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
    loading: false,
    apprisalList: [],
    selectedGoal: {},
    selectedAppraisal: {},
    selectedAppraisalId: 0,
  }),
  async fetch() {
    try {
      this.apprisalList = await this.$axios.$get(`api/appraisal/me`, {
        headers: {
          Authorization: `Bearer ${this.$store.state.accessToken}`,
        },
      });

      if (this.apprisalList.length !== 0)
        this.selectedAppraisal = this.apprisalList[0];
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

.mobile-appraisal-select {
  display: none;
  width: 100%;
}

.appraisal-lists {
  width: 330px;
  position: fixed;
  height: 100%;
  background: #f4f7f8;
  left: 0;
  top: 0;
  padding-left: 75px;
}

.appraisal-lists > h3 {
  text-align: center;
  margin: 50px 0;
}

.appraisal-lists > .appraisal-list-item {
  padding: 10px;
  background: #eee;
  border-radius: 12px;
  margin-right: 20px;
  margin-bottom: 10px;
  opacity: 0.7;
  text-align: center;
}

.appraisal-lists > .appraisal-list-item.active,
.appraisal-lists > .appraisal-list-item:hover {
  cursor: pointer;
  color: #195bff;
  background: rgba(25, 91, 255, 0.15);
}

.appraisal-item {
  width: 100%;
  min-height: 600px;
  background: #fff;
  box-shadow: 0px 0px 25px 0px rgba(0, 0, 0, var(--vs-shadow-opacity));
  border-radius: 16px;
  padding: 30px;
}

.appraisal-property {
  display: flex;
}

.appraisal-item-open {
  max-width: 1000px;
  width: 100%;
  margin-left: 200px;
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
  .appraisal-item-open {
    margin-left: unset;
  }

  .appraisal-lists {
    display: none;
  }

  .mobile-appraisal-select {
    display: block;
  }
}
</style>
