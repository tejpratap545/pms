<template>
  <vs-dialog v-model="active" not-close prevent-close>
    <template #header>
      <h4 class="not-margin">
        Edit Category {{ selectedCategoryType }} <b>Category</b>
      </h4>

      <vs-button class="closeDialogButton" icon floating @click="closeDialog">
        <i class="bx bx-x"></i>
      </vs-button>
    </template>

    <div class="con-form">
      <vs-select
        v-if="$store.state.user.user.is_superuser"
        v-model="categoryData.company"
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

      <vs-input v-model="categoryData.name" placeholder="Category Name">
        <template #icon>
          <i class="bx bx-building"></i>
        </template>
      </vs-input>
    </div>

    <template #footer>
      <div class="footer-dialog">
        <vs-button
          :loading="loading"
          block
          @click="updateCategory(categoryData.id)"
        >
          Update
        </vs-button>
      </div>
    </template>
  </vs-dialog>
</template>

<script>
export default {
  name: "EditCategoryDialog",
  props: {
    dialog: Boolean,
    // eslint-disable-next-line vue/require-default-prop
    companyList: Array,
    // eslint-disable-next-line vue/require-default-prop
    selectedCategory: Object,
    // eslint-disable-next-line vue/require-default-prop
    selectedCategoryType: String,
  },
  data: () => ({
    active: false,
    loading: false,
    categoryData: {},
  }),
  mounted() {
    this.active = this.dialog;
    this.categoryData = this.selectedCategory;
  },
  methods: {
    closeDialog() {
      this.$emit("close");
    },
    updateCategory(id) {
      if (!this.loading) {
        this.loading = true;

        this.$axios
          .$patch(
            `api/category/${this.selectedCategoryType}/${id}/`,
            {
              name: this.categoryData.name,
            },
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
              title: "Error creating category",
            });
          });
      }
    },
  },
};
</script>
