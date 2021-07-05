<template>
  <vs-dialog v-model="active" :loading="loading" not-close prevent-close>
    <template #header>
      <h4 class="not-margin">Update <b>Goal</b></h4>

      <vs-button class="closeDialogButton" icon floating @click="closeDialog">
        <i class="bx bx-x"></i>
      </vs-button>
    </template>

    <div v-if="$fetchState.pending"><Spinner /></div>
    <div v-else class="con-form">
      <vs-input v-model="goalData.summary" placeholder="Summary">
        <template #icon> <i class="bx bx-tag-alt"></i> </template>
      </vs-input>

      <vs-input v-model="goalData.weightage" placeholder="Weightage">
        <template #icon> <i class="bx bx-tag-alt"></i> </template>
      </vs-input>

      <vs-select
        v-if="trackingStatusList.length != 0"
        v-model="goalData.tracking_status"
        placeholder="Tracking Status"
        style="margin: 10px 0"
        block
        filter
      >
        <vs-option
          v-for="(status, index) in trackingStatusList"
          :key="index"
          :label="status"
          :value="status"
        >
          {{ status }}
        </vs-option>
      </vs-select>

      <Editor
        :data="goalData.description"
        @changeData="(value) => (goalData.description = value)"
      />

      <vs-select
        v-if="goalCategoryList.length != 0"
        v-model="goalData.category"
        placeholder="Select goal category"
        style="margin: 10px 0"
        block
        filter
      >
        <vs-option
          v-for="(category, index) in goalCategoryList"
          :key="index"
          :label="category.name"
          :value="category.id"
        >
          {{ category.name }}
        </vs-option>
      </vs-select>

      <div class="con-form-control my-2">
        <p>Goal due date</p>
        <vs-input v-model="goalData.due" type="date">
          <template #icon><i class="bx bx-calendar-check"></i></template>
        </vs-input>
      </div>
    </div>

    <template #footer>
      <div class="footer-dialog">
        <vs-button :loading="loading" block @click="updateGoal">
          Update
        </vs-button>
      </div>
    </template>
  </vs-dialog>
</template>

<script>
export default {
  name: "EditGoalDialog",
  props: {
    dialog: Boolean,
    // eslint-disable-next-line vue/require-default-prop
    selectedGoal: Object,
  },
  data: () => ({
    active: false,
    loading: false,
    goalCategoryList: [],
    trackingStatusList: ["null", "On Track", "Not On Track"],
    goalData: {},
  }),
  async fetch() {
    this.loading = true;
    try {
      this.goalCategoryList = await this.$axios.$get(`api/category/goal/`, {
        headers: {
          Authorization: `Bearer ${this.$store.state.accessToken}`,
        },
      });
    } catch (err) {
      return this.$vs.notification({
        color: "danger",
        title: "Error fetching employees",
      });
    }
    this.loading = false;
  },
  mounted() {
    this.active = this.dialog;
    this.goalData = this.selectedGoal;
  },
  methods: {
    closeDialog() {
      this.$emit("close");
    },
    updateGoal() {
      if (!this.loading) {
        this.loading = true;

        this.$axios
          .$patch(`api/goal/${this.goalData.id}/`, this.goalData, {
            headers: {
              Authorization: `Bearer ${this.$store.state.accessToken}`,
            },
          })
          .then(() => this.closeDialog())
          .catch(() => {
            this.loading = false;
            return this.$vs.notification({
              color: "danger",
              title: "Error updating Goal",
            });
          });
      }
    },
  },
};
</script>

<style>
.con-form-control {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>
