<template>
  <vs-dialog v-model="active" :loading="loading" not-close prevent-close>
    <template #header>
      <h4 class="not-margin">Upstage <b>Appraisal</b></h4>

      <vs-button class="closeDialogButton" icon floating @click="closeDialog">
        <i class="bx bx-x"></i>
      </vs-button>
    </template>

    <div class="con-form">Are you sure want to Upstage Appraisal</div>

    <template #footer>
      <div class="footer-dialog">
        <vs-button :loading="loading" block @click="upstageApraisal">
          Upstage now
        </vs-button>
      </div>
    </template>
  </vs-dialog>
</template>

<script>
export default {
  name: "UpstageAppraisal",
  props: {
    dialog: Boolean,
    // eslint-disable-next-line vue/require-default-prop
    selectedAppraisalId: Number,
  },
  data: () => ({
    active: false,
    loading: false,
  }),
  mounted() {
    this.active = this.dialog;
  },
  methods: {
    closeDialog() {
      this.$emit("close");
    },
    upstageApraisal() {
      if (!this.loading) {
        this.loading = true;

        this.$axios
          .$post(`api/appraisal/${this.selectedAppraisalId}/up-stage/`, {
            headers: {
              Authorization: `Bearer ${this.$store.state.accessToken}`,
            },
          })
          .then(() => this.closeDialog())
          .catch(() => {
            this.loading = false;
            return this.$vs.notification({
              color: "danger",
              title: "Error upstaging appraisal",
            });
          });
      }
    },
  },
};
</script>

<style>
.con-form {
  text-align: center;
}
</style>
