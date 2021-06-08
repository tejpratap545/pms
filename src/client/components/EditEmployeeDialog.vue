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

      <vs-input v-model="employeeData.employee_id" placeholder="Employee Id">
        <template #icon>
          <i class="bx bxs-user-badge"></i>
        </template>
      </vs-input>

      <!-- <vs-select
        v-model="employeeData.gender"
        placeholder="Select gender"
        block
        filter
      >
        <vs-option
          v-for="(gender, index) in genderList"
          :key="index"
          :label="gender"
          :value="gender"
        >
          {{ gender }}
        </vs-option>
      </vs-select> -->

      <vs-select
        v-model="employeeData.martial_status"
        placeholder="Select martial status"
        style="margin-bottom: 10px"
        block
        filter
      >
        <vs-option
          v-for="(martial, index) in martialStatus"
          :key="index"
          :label="martial"
          :value="martial"
        >
          {{ martial }}
        </vs-option>
      </vs-select>

      <vs-select
        v-model="employeeData.employment_type"
        placeholder="Select employee type"
        block
        filter
      >
        <vs-option
          v-for="(employee, index) in employmentType"
          :key="index"
          :label="employee"
          :value="employee"
        >
          {{ employee }}
        </vs-option>
      </vs-select>

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
    // genderList: ["Male", "Female"],
    martialStatus: ["Single", "Married", "Divorced", "Separated", "Widowed"],
    employmentType: ["Contractor", "Full-Time", "Part-Time", "Internship"],
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
          .$patch(`api/user/${id}/`, this.employeeData, {
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
