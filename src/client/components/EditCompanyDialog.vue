<template>
  <vs-dialog v-model="active" not-close prevent-close>
    <template #header>
      <h4 class="not-margin">Update <b>Company</b></h4>

      <vs-button class="closeDialogButton" icon floating @click="closeDialog">
        <i class="bx bx-x"></i>
      </vs-button>
    </template>

    <div class="con-form">
      <vs-input
        v-model="companyData.admin_username"
        placeholder="Admin username"
      >
        <template #icon>
          <i class="bx bx-user"></i>
        </template>
      </vs-input>

      <vs-input
        v-model="companyData.admin_password"
        type="password"
        placeholder="Admin password"
      >
        <template #icon>
          <i class="bx bxs-lock"></i>
        </template>
      </vs-input>

      <vs-input v-model="companyData.admin_email" placeholder="Admin email">
        <template #icon> @ </template>
      </vs-input>

      <vs-input v-model="companyData.admin_name" placeholder="Admin name">
        <template #icon>
          <i class="bx bx-user"></i>
        </template>
      </vs-input>

      <vs-input v-model="companyData.name" placeholder="Company Name">
        <template #icon>
          <i class="bx bx-building"></i>
        </template>
      </vs-input>

      <vs-input
        v-model="companyData.domain"
        type="url"
        placeholder="Company domain"
      >
        <template #icon> <i class="bx bx-globe"></i> </template>
      </vs-input>
    </div>

    <template #footer>
      <div class="footer-dialog">
        <vs-button
          :loading="loading"
          block
          @click="updateCompany(companyData.id)"
        >
          Update
        </vs-button>
      </div>
    </template>
  </vs-dialog>
</template>

<script>
export default {
  name: "EditCompanyDialog",
  props: {
    dialog: Boolean,
    // eslint-disable-next-line vue/require-default-prop
    selectedCompany: Object,
  },
  data: () => ({
    active: false,
    loading: false,
    companyData: {},
  }),
  mounted() {
    this.active = this.dialog;
    this.companyData = this.selectedCompany;
  },
  methods: {
    closeDialog() {
      this.$emit("close");
    },
    updateCompany(id) {
      if (!this.loading) {
        this.loading = true;

        this.$axios
          .$patch(`api/company/${id}`, this.companyData, {
            headers: {
              Authorization: `Bearer ${this.$store.state.accessToken}`,
            },
          })
          .then(() => this.closeDialog())
          .catch(() => {
            this.loading = false;
            return this.$vs.notification({
              color: "danger",
              title: "Error creating company",
            });
          });
      }
    },
  },
};
</script>
