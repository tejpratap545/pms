<template>
  <vs-dialog v-model="active" :loading="loading" not-close prevent-close>
    <template #header>
      <h4 class="not-margin">Update <b>Employee</b></h4>

      <vs-button class="closeDialogButton" icon floating @click="closeDialog">
        <i class="bx bx-x"></i>
      </vs-button>
    </template>

    <div v-if="$fetchState.pending"></div>
    <div v-else class="con-form">
      <vs-select
        v-if="$store.state.user.user.is_superuser"
        v-model="employeeData.user.company"
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

      <vs-input v-model="employeeData.job_title" placeholder="Job title">
        <template #icon>
          <i class="bx bxs-user-badge"></i>
        </template>
      </vs-input>

      <vs-input v-model="employeeData.user.first_name" placeholder="Firstname">
        <template #icon>
          <i class="bx bx-user"></i>
        </template>
      </vs-input>

      <vs-input v-model="employeeData.user.last_name" placeholder="Lastname">
        <template #icon>
          <i class="bx bx-user"></i>
        </template>
      </vs-input>

      <vs-input v-model="employeeData.user.username" placeholder="Username">
        <template #icon>
          <i class="bx bx-user"></i>
        </template>
      </vs-input>

      <vs-input
        v-model="employeeData.user.password"
        type="password"
        placeholder="User password"
      >
        <template #icon>
          <i class="bx bxs-lock"></i>
        </template>
      </vs-input>

      <vs-input v-model="employeeData.user.email" placeholder="User email">
        <template #icon> @ </template>
      </vs-input>
    </div>

    <template #footer>
      <div class="footer-dialog">
        <vs-button
          :loading="loading"
          block
          @click="updateEmployee(employeeData.id)"
        >
          Update
        </vs-button>
      </div>
    </template>
  </vs-dialog>
</template>

<script>
export default {
  name: "EditEmployeeDialog",
  props: {
    dialog: Boolean,
    // eslint-disable-next-line vue/require-default-prop
    selectedEmployee: Object,
  },
  data: () => ({
    active: false,
    loading: false,
    companyList: [],
    employeeData: {},
  }),
  async fetch() {
    this.loading = true;
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
    this.loading = false;
  },
  mounted() {
    this.active = this.dialog;
    this.employeeData = this.selectedEmployee;
  },
  methods: {
    closeDialog() {
      this.$emit("close");
    },
    updateEmployee(id) {
      if (!this.loading) {
        this.loading = true;

        this.$axios
          .$patch(`api/user/${id}`, this.employeeData, {
            headers: {
              Authorization: `Bearer ${this.$store.state.accessToken}`,
            },
          })
          .then(() => this.closeDialog())
          .catch(() => {
            this.loading = false;
            return this.$vs.notification({
              color: "danger",
              title: "Error updating employee",
            });
          });
      }
    },
  },
};
</script>
