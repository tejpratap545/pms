<template>
  <vs-dialog v-model="active" :loading="loading" not-close prevent-close>
    <template #header>
      <h4 class="not-margin">Update <b>Employee</b></h4>

      <vs-button class="closeDialogButton" icon floating @click="closeDialog">
        <i class="bx bx-x"></i>
      </vs-button>
    </template>

    <div v-if="$fetchState.pending"><Spinner /></div>
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

      <vs-input
        v-model="employeeData.user.contact_number"
        placeholder="Contact number"
        @change="checkContactNumber(employeeData.user.contact_number)"
      >
        <template #icon>
          <i class="bx bxs-phone"></i>
        </template>
        <template v-if="!validContactNumber" #message-danger>
          Contact number must be unique
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

      <vs-input
        v-model="employeeData.user.username"
        placeholder="Username"
        @change="checkUsername(employeeData.user.username)"
      >
        <template #icon>
          <i class="bx bx-user"></i>
        </template>
        <template v-if="!validUsername" #message-danger>
          Username must be unique
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

      <vs-select
        v-model="employeeData.gender"
        style="margin-bottom: 10px"
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
      </vs-select>

      <vs-select
        v-model="employeeData.user.role"
        placeholder="Select Role"
        style="margin-bottom: 10px"
        block
        filter
      >
        <vs-option
          v-for="(role, index) in roleList"
          :key="index"
          :label="role.name"
          :value="role.id"
        >
          {{ role.name }}
        </vs-option>
      </vs-select>

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
        style="margin-bottom: 10px"
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

      <vs-select
        v-model="employeeData.first_reporting_manager"
        placeholder="First reporting manager"
        style="margin-bottom: 10px"
        block
        filter
      >
        <vs-option
          v-for="(user, index) in userList"
          :key="index"
          :label="user.name"
          :value="user.id"
        >
          {{ user.name }}
        </vs-option>
      </vs-select>

      <vs-select
        v-model="employeeData.second_reporting_manager"
        placeholder="Second reporting manager"
        style="margin-bottom: 10px"
        block
        filter
      >
        <vs-option
          v-for="(user, index) in userList"
          :key="index"
          :label="user.name"
          :value="user.id"
        >
          {{ user.name }}
        </vs-option>
      </vs-select>

      <vs-input
        v-model="employeeData.user.email"
        placeholder="User email"
        @change="checkEmail(employeeData.user.email)"
      >
        <template #icon> @ </template>
        <template v-if="!validEmail" #message-danger>
          Email must be unique
        </template>
      </vs-input>
    </div>

    <template #footer>
      <div v-if="validEmail && validUsername" class="footer-dialog">
        <vs-button
          :loading="loading"
          block
          @click="updateEmployee(employeeData.id)"
        >
          Update
        </vs-button>
      </div>
      <div v-else>
        <vs-alert color="danger"> Some of the fields are invalid </vs-alert>
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
    genderList: ["Male", "Female"],
    martialStatus: ["Single", "Married", "Divorced", "Separated", "Widowed"],
    employmentType: ["Contractor", "Full-Time", "Part-Time", "Internship"],
    roleList: [],
    userList: [],
    validEmail: true,
    validUsername: true,
    validContactNumber: true,
    employeeData: {},
  }),
  async fetch() {
    this.loading = true;
    try {
      if (this.$store.state.user.user.is_superuser) {
        this.companyList = await this.$axios.$get(`api/company/`, {
          headers: {
            Authorization: `Bearer ${this.$store.state.accessToken}`,
          },
        });
      }

      this.roleList = await this.$axios.$get(`api/role/`, {
        headers: {
          Authorization: `Bearer ${this.$store.state.accessToken}`,
        },
      });

      this.userList = await this.$axios.$get(`api/user/short`, {
        headers: {
          Authorization: `Bearer ${this.$store.state.accessToken}`,
        },
      });

      if (this.employeeData.gender == null)
        this.employeeData.gender = this.genderList[0];

      this.employeeData.user.role = this.roleList[0].id;
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

    if (!this.$store.state.user.user.is_superuser) {
      this.userList = this.userList.filter(
        (x) => x.user.company === this.$store.state.user.user.company
      );
    }
  },
  methods: {
    checkEmail(email) {
      this.$axios
        .$post(
          `api/check/email`,
          {
            email,
          },
          {
            headers: {
              Authorization: `Bearer ${this.$store.state.accessToken}`,
            },
          }
        )
        .then(() => (this.validEmail = true))
        .catch(() => {
          this.validEmail = false;
        });
    },
    checkContactNumber(contactNumber) {
      this.$axios
        .$post(
          `api/check/contact_number`,
          {
            contact_number: contactNumber,
          },
          {
            headers: {
              Authorization: `Bearer ${this.$store.state.accessToken}`,
            },
          }
        )
        .then(() => (this.validContactNumber = true))
        .catch(() => {
          this.validContactNumber = false;
        });
    },
    checkUsername(username) {
      this.$axios
        .$post(
          `api/check/username`,
          {
            username,
          },
          {
            headers: {
              Authorization: `Bearer ${this.$store.state.accessToken}`,
            },
          }
        )
        .then(() => (this.validUsername = true))
        .catch(() => {
          this.validUsername = false;
        });
    },
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

<style>
.con-form {
  padding: 20px;
  overflow-y: scroll;
  overflow-x: hidden;
  max-height: 500px;
}

.con-form-control {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>
