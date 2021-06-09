<template>
  <vs-dialog
    v-model="active"
    :loading="loading"
    not-close
    prevent-close
    width="500px"
  >
    <template #header>
      <h4 class="not-margin">Update <b>Appraisal</b></h4>

      <vs-button class="closeDialogButton" icon floating @click="closeDialog">
        <i class="bx bx-x"></i>
      </vs-button>
    </template>

    <div v-if="$fetchState.pending"></div>
    <div v-else class="con-form">
      <vs-select
        v-model="appraisalData.individual_employees"
        placeholder="Select Employees"
        style="margin-bottom: 10px"
        block
        filter
        multiple
      >
        <vs-option
          v-for="employee in appraisalData.company
            ? employeeList.filter(
                (x) => x.user.company == appraisalData.company
              )
            : employeeList"
          :key="employee.id"
          :label="employee.user.username"
          :value="employee.id"
        >
          {{ employee.user.username }}
        </vs-option>
      </vs-select>

      <vs-select
        v-if="departmentList != null"
        v-model="appraisalData.departments"
        placeholder="Select Departments"
        style="margin-bottom: 10px"
        block
        filter
        multiple
      >
        <vs-option
          v-for="department in appraisalData.company
            ? departmentList.filter((x) => x.company == appraisalData.company)
            : departmentList"
          :key="department.id"
          :label="department.name"
          :value="department.id"
        >
          {{ department.name }}
        </vs-option>
      </vs-select>

      <vs-input v-model="appraisalData.name" placeholder="Appraisal Name">
        <template #icon>
          <i class="bx bx-building"></i>
        </template>
      </vs-input>

      <vs-select
        v-model="appraisalData.stage"
        placeholder="Select Stage"
        style="margin-bottom: 10px"
        block
        filter
      >
        <vs-option v-for="i in 6" :key="i" :label="`Stage ${i}`" :value="i">
          {{ `Stage ${i}` }}
        </vs-option>
      </vs-select>

      <div class="con-form-control">
        <p>Stage 1 Start date</p>
        <vs-input v-model="appraisalData.stage1_start_date" type="date">
          <template #icon><i class="bx bx-calendar-check"></i></template>
        </vs-input>
      </div>

      <div class="con-form-control">
        <p>Stage 1 End date</p>
        <vs-input v-model="appraisalData.stage1_end_date" type="date">
          <template #icon><i class="bx bx-calendar-check"></i></template>
        </vs-input>
      </div>

      <div class="con-form-control">
        <p>Stage 2 Start date</p>
        <vs-input v-model="appraisalData.stage2_start_date" type="date">
          <template #icon><i class="bx bx-calendar-check"></i></template>
        </vs-input>
      </div>

      <div class="con-form-control">
        <p>Stage 2 End date</p>
        <vs-input v-model="appraisalData.stage2_end_date" type="date">
          <template #icon><i class="bx bx-calendar-check"></i></template>
        </vs-input>
      </div>

      <div class="con-form-control">
        <p>Stage 3 Start date</p>
        <vs-input v-model="appraisalData.stage3_start_date" type="date">
          <template #icon><i class="bx bx-calendar-check"></i></template>
        </vs-input>
      </div>

      <div class="con-form-control">
        <p>Stage 3 End date</p>
        <vs-input v-model="appraisalData.stage3_end_date" type="date">
          <template #icon><i class="bx bx-calendar-check"></i></template>
        </vs-input>
      </div>

      <div class="con-form-control">
        <p>Reports End date</p>
        <vs-input v-model="appraisalData.reports_end_date" type="date">
          <template #icon><i class="bx bx-calendar-check"></i></template>
        </vs-input>
      </div>

      <div class="con-form-control">
        <p>Calibration End date</p>
        <vs-input v-model="appraisalData.calibration_end_date" type="date">
          <template #icon><i class="bx bx-calendar-check"></i></template>
        </vs-input>
      </div>
    </div>

    <template #footer>
      <div class="footer-dialog">
        <vs-button
          :loading="loading"
          block
          @click="updateAppraisal(appraisalData.id)"
        >
          Update
        </vs-button>
      </div>
    </template>
  </vs-dialog>
</template>

<script>
export default {
  name: "EditAppraisalDialog",
  props: {
    dialog: Boolean,
    // eslint-disable-next-line vue/require-default-prop
    selectedAppraisal: Object,
  },
  data: () => ({
    active: false,
    loading: false,
    employeeList: [],
    departmentList: [],
    appraisalData: {},
  }),
  async fetch() {
    this.loading = true;
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
    this.appraisalData = {
      individual_employees: [],
      departments: [],
      is_company: false,
      ...this.selectedAppraisal,
    };
  },
  methods: {
    closeDialog() {
      this.$emit("close");
    },
    updateAppraisal(id) {
      if (!this.loading) {
        this.loading = true;

        this.$axios
          .$patch(`api/over-all-appraisal/${id}/`, this.appraisalData, {
            headers: {
              Authorization: `Bearer ${this.$store.state.accessToken}`,
            },
          })
          .then(() => this.closeDialog())
          .catch(() => {
            this.loading = false;
            return this.$vs.notification({
              color: "danger",
              title: "Error updating Appraisal",
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
