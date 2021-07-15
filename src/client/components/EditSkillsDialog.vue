<template>
  <vs-dialog v-model="active" :loading="loading" not-close prevent-close>
    <template #header>
      <h4 class="not-margin">Update <b>Skill</b></h4>

      <vs-button class="closeDialogButton" icon floating @click="closeDialog">
        <i class="bx bx-x"></i>
      </vs-button>
    </template>

    <div v-if="$fetchState.pending"><Spinner /></div>
    <div v-else class="con-form">
      <vs-input v-model="skillsData.summary" placeholder="Summary">
        <template #icon> <i class="bx bx-tag-alt"></i> </template>
      </vs-input>

      <vs-input v-model="skillsData.weightage" placeholder="Weightage">
        <template #icon> <i class="bx bx-tag-alt"></i> </template>
      </vs-input>

      <Editor
        :data="skillsData.description"
        @changeData="(value) => (skillsData.description = value)"
      />

      <vs-select
        v-if="skillsCategoryList.length != 0"
        v-model="skillsData.category"
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
        <vs-input v-model="skillsData.due" type="date">
          <template #icon><i class="bx bx-calendar-check"></i></template>
        </vs-input>
      </div>
    </div>

    <template #footer>
      <div class="footer-dialog">
        <vs-button :loading="loading" block @click="createSkill">
          Update
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
    selectedSkills: Object,
  },
  data: () => ({
    active: false,
    loading: false,
    skillsCategoryList: [],
    skillsData: {},
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
    this.skillsData = this.selectedSkills;
  },
  methods: {
    closeDialog() {
      this.$emit("close");
    },
    createSkill() {
      if (!this.loading) {
        this.loading = true;

        this.$axios
          .$patch(`api/skill/`, this.skillsData, {
            headers: {
              Authorization: `Bearer ${this.$store.state.accessToken}`,
            },
          })
          .then(() => this.closeDialog())
          .catch(() => {
            this.loading = false;
            return this.$vs.notification({
              color: "danger",
              title: "Error updating SKills",
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
