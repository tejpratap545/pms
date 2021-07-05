<template>
  <vs-dialog v-model="active" :loading="loading" not-close prevent-close>
    <template #header>
      <h4 class="not-margin">Update <b>Core Value</b></h4>

      <vs-button class="closeDialogButton" icon floating @click="closeDialog">
        <i class="bx bx-x"></i>
      </vs-button>
    </template>

    <div v-if="$fetchState.pending"><Spinner /></div>
    <div v-else class="con-form">
      <vs-input v-model="coreValueData.summary" placeholder="Summary">
        <template #icon> <i class="bx bx-tag-alt"></i> </template>
      </vs-input>

      <Editor
        :data="coreValueData.description"
        @changeData="(value) => (coreValueData.description = value)"
      />

      <vs-select
        v-model="coreValueData.manager"
        :placeholder="`Select manager`"
        style="margin: 10px 0"
        block
        filter
      >
        <vs-option
          v-for="employee in employeeList"
          :key="employee.id"
          :label="employee.name"
          :value="employee.id"
        >
          {{ employee.name }}
        </vs-option>
      </vs-select>

      <vs-select
        v-if="coreValueCategoryList.length != 0"
        v-model="coreValueData.category"
        placeholder="Select Core Value Category"
        style="margin: 10px 0"
        block
        filter
      >
        <vs-option
          v-for="(category, index) in coreValueCategoryList"
          :key="index"
          :label="category.name"
          :value="category.id"
        >
          {{ category.name }}
        </vs-option>
      </vs-select>

      <div class="con-form-control my-2">
        <p>Core value due date</p>
        <vs-input v-model="coreValueData.due" type="date">
          <template #icon><i class="bx bx-calendar-check"></i></template>
        </vs-input>
      </div>
    </div>

    <template #footer>
      <div class="footer-dialog">
        <vs-button :loading="loading" block @click="updateCoreValue">
          Update
        </vs-button>
      </div>
    </template>
  </vs-dialog>
</template>

<script>
export default {
  name: "EditDepartmentCoreValueDialog",
  props: {
    dialog: Boolean,
    // eslint-disable-next-line vue/require-default-prop
    selectedCorevalue: Object,
  },
  data: () => ({
    active: false,
    loading: false,
    employeeList: [],
    coreValueCategoryList: [],
    coreValueData: {},
  }),
  async fetch() {
    this.loading = true;
    try {
      this.coreValueCategoryList = await this.$axios.$get(
        `api/category/core_value/`,
        {
          headers: {
            Authorization: `Bearer ${this.$store.state.accessToken}`,
          },
        }
      );
      this.employeeList = await this.$axios.$get(`api/user/short`, {
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
    this.coreValueData = this.selectedCorevalue;
  },
  methods: {
    closeDialog() {
      this.$emit("close");
    },
    updateCoreValue() {
      if (!this.loading) {
        this.loading = true;

        this.$axios
          .$patch(
            `api/departmental-core-value/${this.coreValueData.id}/`,
            this.coreValueData,
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
              title: "Error updating Core value",
            });
          });
      }
    },
  },
};
</script>

<style>
.con-form-control {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>
