<template>
  <vs-dialog v-model="active" not-close prevent-close>
    <template #header>
      <h4 class="not-margin">Add a new <b>Company</b></h4>

      <vs-button class="closeDialogButton" icon floating @click="closeDialog">
        <i class="bx bx-x"></i>
      </vs-button>
    </template>

    <div class="con-form">
      <vs-input
        v-model="newCompanyData.admin_username"
        placeholder="Admin username"
      >
        <template #icon>
          <i class="bx bx-user"></i>
        </template>
      </vs-input>

      <vs-input
        v-model="newCompanyData.admin_password"
        type="password"
        placeholder="Admin password"
      >
        <template #icon>
          <i class="bx bxs-lock"></i>
        </template>
      </vs-input>

      <vs-input v-model="newCompanyData.admin_email" placeholder="Admin email">
        <template #icon> @ </template>
      </vs-input>

      <vs-input v-model="newCompanyData.admin_name" placeholder="Admin name">
        <template #icon>
          <i class="bx bx-user"></i>
        </template>
      </vs-input>

      <vs-input v-model="newCompanyData.name" placeholder="Company Name">
        <template #icon>
          <i class="bx bx-building"></i>
        </template>
      </vs-input>

      <vs-input
        v-model="newCompanyData.domain"
        type="url"
        placeholder="Company domain"
      >
        <template #icon> <i class="bx bx-globe"></i> </template>
      </vs-input>
    </div>

    <template #footer>
      <div class="footer-dialog">
        <vs-button :loading="loading" block @click="createCompany">
          Add New
        </vs-button>
      </div>
    </template>
  </vs-dialog>
</template>

<script>
export default {
  name: "NewCompanyDialog",
  props: {
    dialog: Boolean,
  },
  data: () => ({
    active: false,
    loading: false,
    newCompanyData: {
      admin_username: "",
      admin_email: "",
      admin_name: "",
      admin_password: "",
      name: "",
      domain: "",
    },
  }),
  mounted() {
    this.active = this.dialog;
  },
  methods: {
    closeDialog() {
      this.$emit("close");
    },
    createCompany() {
      if (!this.loading) {
        this.loading = true;

        this.$axios
          .$post(`api/company/`, this.newCompanyData, {
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
