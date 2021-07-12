<template>
  <vs-dialog v-model="active" :loading="loading" not-close prevent-close>
    <template #header>
      <h4 class="not-margin">Change <b>Password</b></h4>

      <vs-button class="closeDialogButton" icon floating @click="closeDialog">
        <i class="bx bx-x"></i>
      </vs-button>
    </template>

    <div class="con-form">
      <vs-input v-model="passwordData.password" placeholder="Current Password">
        <template #icon> <i class="bx bxs-lock-alt"></i></template>
      </vs-input>

      <vs-input v-model="passwordData.password1" placeholder="New Password">
        <template #icon> <i class="bx bxs-lock-alt"></i></template>
      </vs-input>

      <vs-input v-model="passwordData.password2" placeholder="Confirm Password">
        <template #icon> <i class="bx bxs-lock-alt"></i></template>
      </vs-input>
    </div>

    <template #footer>
      <div class="footer-dialog">
        <vs-button :loading="loading" block @click="updatePassword">
          Add New
        </vs-button>
      </div>
    </template>
  </vs-dialog>
</template>

<script>
export default {
  name: "ChangePassword",
  props: {
    dialog: Boolean,
  },
  data: () => ({
    active: false,
    loading: false,
    passwordData: {
      password: "",
      password1: "",
      password2: "",
    },
  }),
  mounted() {
    this.active = this.dialog;
  },
  methods: {
    closeDialog() {
      this.$emit("close");
    },
    updatePassword() {
      if (!this.loading) {
        this.loading = true;

        this.$axios
          .$post(
            `api/user/${this.$store.state.user.id}/change_password/`,
            this.passwordData,
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
              title: "Error changing password",
            });
          });
      }
    },
  },
};
</script>
