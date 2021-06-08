<template>
  <vs-dialog v-model="active" :loading="loading" not-close prevent-close>
    <template #header>
      <h4 class="not-margin">Add a new <b>Department</b></h4>

      <vs-button class="closeDialogButton" icon floating @click="closeDialog">
        <i class="bx bx-x"></i>
      </vs-button>
    </template>

    <div v-if="$fetchState.pending"></div>
    <div v-else class="con-form">
      <vs-select
        v-if="$store.state.user.user.is_superuser"
        v-model="newDepartmentData.company"
        placeholder="Select Company"
        style="margin-bottom: 10px"
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

      <vs-select
        v-model="newDepartmentData.manager"
        placeholder="Manager"
        block
        filter
      >
        <vs-option
          v-for="employee in employeeList"
          :key="employee.id"
          :label="employee.user.username"
          :value="employee.id"
        >
          {{ employee.user.username }}
        </vs-option>
      </vs-select>

      <vs-input v-model="newDepartmentData.name" placeholder="Name">
        <template #icon> <i class="bx bx-tag-alt"></i> </template>
      </vs-input>
    </div>

    <template #footer>
      <div class="footer-dialog">
        <vs-button :loading="loading" block @click="createDepartment">
          Add New
        </vs-button>
      </div>
    </template>
  </vs-dialog>
</template>

<script>
export default {
  name: "NewDepartmentDialog",
  props: {
    dialog: Boolean,
    // eslint-disable-next-line vue/require-default-prop
    companyList: Array,
  },
  data: () => ({
    active: false,
    loading: false,
    employeeList: [],
    newDepartmentData: {
      name: "",
      company: 0,
      manager: 0,
    },
  }),
  async fetch() {
    this.loading = true;
    try {
      this.employeeList = await this.$axios.$get(`api/user/`, {
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

    if (!this.$store.state.user.user.is_superuser) {
      this.newDepartmentData.company = this.$store.state.user.user.company;
    }
  },
  methods: {
    closeDialog() {
      this.$emit("close");
    },
    createDepartment() {
      if (!this.loading) {
        this.loading = true;

        this.$axios
          .$post(`api/department/`, this.newDepartmentData, {
            headers: {
              Authorization: `Bearer ${this.$store.state.accessToken}`,
            },
          })
          .then(() => this.closeDialog())
          .catch(() => {
            this.loading = false;
            return this.$vs.notification({
              color: "danger",
              title: "Error creating department",
            });
          });
      }
    },
  },
};
</script>
