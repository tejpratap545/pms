<template>
  <vs-dialog
    v-model="active"
    :loading="loading"
    not-close
    prevent-close
    width="500px"
  >
    <template #header>
      <h4 class="not-margin">Add a new <b>Appraisal</b></h4>

      <vs-button class="closeDialogButton" icon floating @click="closeDialog">
        <i class="bx bx-x"></i>
      </vs-button>
    </template>

    <div v-if="$fetchState.pending"></div>
    <div v-else class="con-form">
      <vs-select
        v-if="$store.state.user.user.is_superuser"
        v-model="newAppraisalData.company"
        placeholder="Select Company"
        style="margin-bottom: 10px"
        block
        filter
      >
        <vs-option
          v-for="company in companyList"
          :key="company.id"
          :placeholder="company.name"
          :value="company.id"
        >
          {{ company.name }}
        </vs-option>
      </vs-select>

      <vs-select
        v-model="newAppraisalData.individual_employees"
        placeholder="Select Employees"
        style="margin-bottom: 10px"
        block
        filter
        multiple
      >
        <vs-option
          v-for="employee in newAppraisalData.company
            ? employeeList.filter(
                (x) => x.user.company == newAppraisalData.company
              )
            : employeeList"
          :key="employee.id"
          :placeholder="employee.user.username"
          :value="employee.id"
        >
          {{ employee.user.username }}
        </vs-option>
      </vs-select>

      <vs-select
        v-if="departmentList != null"
        v-model="newAppraisalData.departments"
        placeholder="Select Departments"
        style="margin-bottom: 10px"
        block
        filter
        multiple
      >
        <vs-option
          v-for="department in newAppraisalData.company
            ? departmentList.filter(
                (x) => x.company == newAppraisalData.company
              )
            : departmentList"
          :key="department.id"
          :placeholder="department.name"
          :value="department.id"
        >
          {{ department.name }}
        </vs-option>
      </vs-select>

      <vs-input v-model="newAppraisalData.name" placeholder="Appraisal Name">
        <template #icon>
          <i class="bx bx-building"></i>
        </template>
      </vs-input>

      <vs-select
        v-model="newAppraisalData.stage"
        placeholder="Select Stage"
        style="margin-bottom: 10px"
        block
        filter
      >
        <vs-option
          v-for="i in 6"
          :key="i"
          :placeholder="`Stage ${i}`"
          :value="i"
        >
          {{ `Stage ${i}` }}
        </vs-option>
      </vs-select>

      <div class="con-form-control">
        <p>Stage 1 Start date</p>
        <vs-input v-model="newAppraisalData.stage1_start_date" type="date">
          <template #icon><i class="bx bx-calendar-check"></i></template>
        </vs-input>
      </div>

      <div class="con-form-control">
        <p>Stage 1 End date</p>
        <vs-input v-model="newAppraisalData.stage1_end_date" type="date">
          <template #icon><i class="bx bx-calendar-check"></i></template>
        </vs-input>
      </div>

      <div class="con-form-control">
        <p>Stage 2 Start date</p>
        <vs-input v-model="newAppraisalData.stage2_start_date" type="date">
          <template #icon><i class="bx bx-calendar-check"></i></template>
        </vs-input>
      </div>

      <div class="con-form-control">
        <p>Stage 2 End date</p>
        <vs-input v-model="newAppraisalData.stage2_end_date" type="date">
          <template #icon><i class="bx bx-calendar-check"></i></template>
        </vs-input>
      </div>

      <div class="con-form-control">
        <p>Stage 3 Start date</p>
        <vs-input v-model="newAppraisalData.stage3_start_date" type="date">
          <template #icon><i class="bx bx-calendar-check"></i></template>
        </vs-input>
      </div>

      <div class="con-form-control">
        <p>Stage 3 End date</p>
        <vs-input v-model="newAppraisalData.stage3_end_date" type="date">
          <template #icon><i class="bx bx-calendar-check"></i></template>
        </vs-input>
      </div>

      <div class="con-form-control">
        <p>Reports End date</p>
        <vs-input v-model="newAppraisalData.reports_end_date" type="date">
          <template #icon><i class="bx bx-calendar-check"></i></template>
        </vs-input>
      </div>

      <div class="con-form-control">
        <p>Calibration End date</p>
        <vs-input v-model="newAppraisalData.calibration_end_date" type="date">
          <template #icon><i class="bx bx-calendar-check"></i></template>
        </vs-input>
      </div>
    </div>

    <template #footer>
      <div class="footer-dialog">
        <vs-button :loading="loading" block @click="createAppraisal">
          Add New
        </vs-button>
      </div>
    </template>
  </vs-dialog>
</template>

<script>
export default {
  name: "NewAppraisalDialog",
  props: {
    dialog: Boolean,
    // eslint-disable-next-line vue/require-default-prop
    companyList: Array,
  },
  data: () => ({
    active: false,
    loading: true,
    employeeList: [],
    departmentList: [],
    newAppraisalData: {
      individual_employees: [],
      departments: [],
      is_company: false,
      name: "",
      stage: 0,
      goal_weightage: 0,
      core_value_weightage: 0,
      skill_weightage: 0,
      stage1_start_date: "",
      stage1_end_date: "",
      stage2_start_date: "",
      stage2_end_date: "",
      stage3_start_date: "",
      stage3_end_date: "",
      reports_end_date: "",
      calibration_end_date: "",
      company: 0,
    },
  }),
  async fetch() {
    try {
      this.employeeList = await this.$axios.$get(`api/user/`, {
        headers: {
          Authorization: `Bearer ${this.$store.state.accessToken}`,
        },
      });

      this.departmentList = await this.$axios.$get(`api/department/`, {
        headers: {
          Authorization: `Bearer ${this.$store.state.accessToken}`,
        },
      });

      this.loading = false;
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
    createAppraisal() {
      if (!this.loading) {
        this.loading = true;

        this.$axios
          .$post(`api/over-all-appraisal/`, this.newAppraisalData, {
            headers: {
              Authorization: `Bearer ${this.$store.state.accessToken}`,
            },
          })
          .then(() => this.closeDialog())
          .catch(() => {
            this.loading = false;
            return this.$vs.notification({
              color: "danger",
              title: "Error creating Appraisal",
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
