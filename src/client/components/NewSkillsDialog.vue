<template>
  <vs-dialog v-model="active" :loading="loading" not-close prevent-close>
    <template #header>
      <h4 class="not-margin">Add a new <b>Skill</b></h4>

      <vs-button class="closeDialogButton" icon floating @click="closeDialog">
        <i class="bx bx-x"></i>
      </vs-button>
    </template>

    <div v-if="$fetchState.pending"></div>
    <div v-else class="con-form">
      <vs-input v-model="newSkillsData.summary" placeholder="Summary">
        <template #icon> <i class="bx bx-tag-alt"></i> </template>
      </vs-input>

      <vs-input v-model="newSkillsData.description" placeholder="Description">
        <template #icon> <i class="bx bx-tag-alt"></i> </template>
      </vs-input>

      <vs-select
        v-if="skillsCategoryList.length != 0"
        v-model="newSkillsData.category"
        placeholder="Select Skills Category"
        style="margin-bottom: 10px"
        block
        filter
      >
        <vs-option
          v-for="(category, index) in skillsCategoryList"
          :key="index"
          :label="category.name"
          :value="category.id"
        >
          {{ category.name }}
        </vs-option>
      </vs-select>

      <div class="con-form-control my-2">
        <p>Skills due date</p>
        <vs-input v-model="newSkillsData.due" type="date">
          <template #icon><i class="bx bx-calendar-check"></i></template>
        </vs-input>
      </div>
    </div>

    <template #footer>
      <div class="footer-dialog">
        <vs-button :loading="loading" block @click="createSkill">
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
    skillsCategoryList: [],
    newSkillsData: {
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
      this.skillsCategoryList = await this.$axios.$get(`api/category/skills/`, {
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
    this.newSkillsData.appraisal = this.selectedAppraisal.id;
  },
  methods: {
    closeDialog() {
      this.$emit("close");
    },
    createSkill() {
      if (!this.loading) {
        this.loading = true;

        this.$axios
          .$post(`api/skill/`, this.newSkillsData, {
            headers: {
              Authorization: `Bearer ${this.$store.state.accessToken}`,
            },
          })
          .then(() => this.closeDialog())
          .catch(() => {
            this.loading = false;
            return this.$vs.notification({
              color: "danger",
              title: "Error creating SKills",
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
