<template>
  <vs-dialog v-model="active" :loading="loading" not-close prevent-close>
    <template #header>
      <h4 class="not-margin">Goal Setting Stage <b>Chat</b></h4>

      <vs-button class="closeDialogButton" icon floating @click="closeDialog">
        <i class="bx bx-x"></i>
      </vs-button>
    </template>

    <div class="con-form">
      <vs-row style="padding: 20px 0">
        <vs-col w="4">
          <b>Goal setting stage manager comment</b>
        </vs-col>
        <vs-col w="8" class="description-card">
          <span v-if="selectedGoal.stage0_manager_comment != null">
            <!-- eslint-disable-next-line vue/no-v-html -->
            <span v-html="selectedGoal.stage0_manager_comment"></span>
          </span>
          <span v-else>No Comment</span>
        </vs-col>
      </vs-row>

      <Editor
        :data="employeeComment"
        @changeData="(value) => (employeeComment = value)"
      />
    </div>

    <template #footer>
      <div class="footer-dialog">
        <vs-button :loading="loading" block @click="updateGoalComment">
          Add New
        </vs-button>
      </div>
    </template>
  </vs-dialog>
</template>

<script>
export default {
  name: "GoalCommentEmployee",
  props: {
    dialog: Boolean,
    // eslint-disable-next-line vue/require-default-prop
    selectedGoal: Object,
  },
  data: () => ({
    active: false,
    loading: false,
    employeeComment: "",
  }),
  mounted() {
    this.active = this.dialog;
  },
  methods: {
    closeDialog() {
      this.$emit("close");
    },
    updateGoalComment() {
      if (!this.loading) {
        this.loading = true;

        this.$axios
          .$post(
            `api/goal/${this.selectedGoal.id}/`,
            {
              stage0_employee_comment: this.employeeComment,
            },
            {
              headers: {
                Authorization: `Bearer ${this.$store.state.accessToken}`,
              },
            }
          )
          .then(() => this.closeDialog())
          .catch(() => {
            this.loading = false;
            return this.$vs.notification({
              color: "danger",
              title: "Error updating employee comment",
            });
          });
      }
    },
  },
};
</script>

<style>
.description-card {
  padding: 10px;
  background-color: #f4f7f8;
  border-radius: 16px;
}
</style>
