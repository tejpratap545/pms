<template>
  <vs-dialog v-model="active" not-close prevent-close>
    <template #header>
      <h4 class="not-margin">Add a new <b>Employee</b></h4>

      <vs-button class="closeDialogButton" icon floating @click="closeDialog">
        <i class="bx bx-x"></i>
      </vs-button>
    </template>

    <div class="con-form">
      <vs-select
        v-if="$store.state.user.user.is_superuser"
        v-model="newEmployeeData.user.company"
        placeholder="Select Company"
        block
        filter
      >
        <vs-option
          v-for="company in companyList"
          :key="company.id"
          :label="company.name"
          :value="company.id"
        >
          {{ company.name }}
        </vs-option>
      </vs-select>

      <vs-input v-model="newEmployeeData.job_title" placeholder="Job title">
        <template #icon>
          <i class="bx bxs-user-badge"></i>
        </template>
      </vs-input>

      <vs-input
        v-model="newEmployeeData.user.first_name"
        placeholder="Firstname"
      >
        <template #icon>
          <i class="bx bx-user"></i>
        </template>
      </vs-input>

      <vs-input v-model="newEmployeeData.user.last_name" placeholder="Lastname">
        <template #icon>
          <i class="bx bx-user"></i>
        </template>
      </vs-input>

      <vs-input v-model="newEmployeeData.user.username" placeholder="Username">
        <template #icon>
          <i class="bx bx-user"></i>
        </template>
      </vs-input>

      <vs-input
        v-model="newEmployeeData.user.password"
        type="password"
        placeholder="User password"
      >
        <template #icon>
          <i class="bx bxs-lock"></i>
        </template>
      </vs-input>

      <vs-input v-model="newEmployeeData.user.email" placeholder="User email">
        <template #icon> @ </template>
      </vs-input>
    </div>

    <template #footer>
      <div class="footer-dialog">
        <vs-button :loading="loading" block @click="createEmployee">
          Add New
        </vs-button>
      </div>
    </template>
  </vs-dialog>
</template>

<script>
export default {
  name: "NewEmployeeDialog",
  props: {
    dialog: Boolean,
  },
  data: () => ({
    active: false,
    loading: false,
    companyList: [],
    newEmployeeData: {
      user: {
        password: "",
        first_name: "",
        username: "",
        last_name: "",
        email: "",
        contact_number: "",
        company: "",
      },
      job_title: "",
      address_1: "",
      address_2: "",
    },
  }),
  async fetch() {
    try {
      this.companyList = await this.$axios.$get(`api/company/`, {
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
  },
  mounted() {
    this.active = this.dialog;
  },
  methods: {
    closeDialog() {
      this.$emit("close");
    },
    createEmployee() {
      if (!this.loading) {
        this.loading = true;

        this.$axios
          .$post(`api/user/`, this.newEmployeeData, {
            headers: {
              Authorization: `Bearer ${this.$store.state.accessToken}`,
            },
          })
          .then(() => this.closeDialog())
          .catch(() => {
            this.loading = false;
            return this.$vs.notification({
              color: "danger",
              title: "Error creating employee",
            });
          });
      }
    },
  },
};
</script>
