<template>
  <vs-dialog v-model="active" :loading="loading" not-close prevent-close>
    <template #header>
      <h4 class="not-margin">Add a new <b>Core Value</b></h4>

      <vs-button class="closeDialogButton" icon floating @click="closeDialog">
        <i class="bx bx-x"></i>
      </vs-button>
    </template>

    <div v-if="$fetchState.pending"><Spinner /></div>
    <div v-else class="con-form">
      <vs-input v-model="newCoreValueData.summary" placeholder="Summary">
        <template #icon> <i class="bx bx-tag-alt"></i> </template>
      </vs-input>

      <Editor
        :data="newCoreValueData.description"
        @changeData="(value) => (newCoreValueData.description = value)"
      />

      <vs-select
        v-if="coreValueCategoryList.length != 0"
        v-model="newCoreValueData.category"
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
        <vs-input v-model="newCoreValueData.due" type="date">
          <template #icon><i class="bx bx-calendar-check"></i></template>
        </vs-input>
      </div>
    </div>

    <template #footer>
      <div class="footer-dialog">
        <vs-button :loading="loading" block @click="createCoreValue">
          Add New
        </vs-button>
      </div>
    </template>
  </vs-dialog>
</template>

<script>
export default {
  name: "NewCoreValueDialog",
  props: {
    dialog: Boolean,
    // eslint-disable-next-line vue/require-default-prop
    selectedAppraisal: Object,
  },
  data: () => ({
    active: false,
    loading: false,
    coreValueCategoryList: [],
    newCoreValueData: {
      summary: "",
      description: "",
      due: "",
      weightage: 1,
      // status: -1,
      // tracking_status: "null",
      appraisal: 0,
      category: 0,
    },
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
    this.newCoreValueData.appraisal = this.selectedAppraisal.id;
  },
  methods: {
    closeDialog() {
      this.$emit("close");
    },
    createCoreValue() {
      if (!this.loading) {
        this.loading = true;

        this.$axios
          .$post(`api/core-value/`, this.newCoreValueData, {
            headers: {
              Authorization: `Bearer ${this.$store.state.accessToken}`,
            },
          })
          .then(() => this.closeDialog())
          .catch(() => {
            this.loading = false;
            return this.$vs.notification({
              color: "danger",
              title: "Error creating Core value dialog",
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
