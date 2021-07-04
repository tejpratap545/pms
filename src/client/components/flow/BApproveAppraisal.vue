<template>
  <vs-dialog v-model="active" :loading="loading" not-close prevent-close>
    <template #header>
      <h4 class="not-margin"><b>Submit Goals , Core Value and skills</b></h4>

      <vs-button class="closeDialogButton" icon floating @click="closeDialog">
        <i class="bx bx-x"></i>
      </vs-button>
    </template>

    <div v-if="$fetchState.pending">loading ...</div>
    <di v-else class="con-form">
      <Appraisal
        :goal-approve="true"
        :edit="false"
        :selected-appraisal="appraisal"
      />
    </di>

    <template #footer>
      <div class="footer-dialog">
        <vs-button :loading="loading" block @click="approveGoal">
          Approve Appraiasal
        </vs-button>
      </div>
    </template>
  </vs-dialog>
</template>

<script>
export default {
  name: "EndyearReview",
  props: {
    dialog: Boolean,
    // eslint-disable-next-line vue/require-default-prop
    appraisalId: Number,
  },
  data: () => ({
    active: false,
    loading: false,
    appraisal: {},
  }),

  async fetch() {
    this.loading = true;
    this.appraisal = await this.$axios.$get(
      `api/appraisal/${this.appraisalId}/`,
      {
        headers: {
          Authorization: `Bearer ${this.$store.state.accessToken}`,
        },
      }
    );
    this.loading = false;
  },

  mounted() {
    this.active = this.dialog;
  },
  methods: {
    closeDialog() {
      this.$emit("close");
    },
    approveGoal() {
      this.$axios
        .$post(
          `api/appraisal/${this.appraisalId.id}/up-stage/`,
          this.roleData,
          {
            headers: {
              Authorization: `Bearer ${this.$store.state.accessToken}`,
            },
          }
        )
        .then(() => {
          this.$vs.notification({
            color: "success",
            title: "Suucessfullly submitted goals",
          });
          this.closeDialog();
        })
        .catch(() => {
          this.loading = false;
          return this.$vs.notification({
            color: "danger",
            title:
              "Error Submitting goals please check goals Weightage or kpi ",
          });
        });
    },
  },
};
</script>
