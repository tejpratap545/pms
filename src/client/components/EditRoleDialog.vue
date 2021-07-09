<template>
  <vs-dialog v-model="active" :loading="loading" not-close prevent-close>
    <template #header>
      <h4 class="not-margin">Add a new <b>Role</b></h4>

      <vs-button class="closeDialogButton" icon floating @click="closeDialog">
        <i class="bx bx-x"></i>
      </vs-button>
    </template>

    <div v-if="$fetchState.pending"><Spinner /></div>
    <div v-else class="con-form">
      <vs-select
        v-if="$store.state.user.user.is_superuser"
        v-model="roleData.company"
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

      <vs-input v-model="roleData.name" placeholder="Name">
        <template #icon> <i class="bx bx-tag-alt"></i> </template>
      </vs-input>

      <vs-select
        v-model="roleData.permissions"
        placeholder="Permissions"
        block
        filter
        multiple
      >
        <vs-option
          v-for="permission in permissionList"
          :key="permission.id"
          :label="permission.name"
          :value="permission.id"
        >
          {{ permission.name }}
        </vs-option>
      </vs-select>
    </div>

    <template #footer>
      <div class="footer-dialog">
        <vs-button :loading="loading" block @click="createRole">
          Add New
        </vs-button>
      </div>
    </template>
  </vs-dialog>
</template>

<script>
export default {
  name: "EditRoleDialog",
  props: {
    dialog: Boolean,
    // eslint-disable-next-line vue/require-default-prop
    companyList: Array,
    // eslint-disable-next-line vue/require-default-prop
    selectedRole: Object,
  },
  data: () => ({
    active: false,
    loading: false,
    permissionList: [],
    roleData: {},
  }),
  async fetch() {
    this.loading = true;
    try {
      this.permissionList = await this.$axios.$get(`api/permission/`, {
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
    this.roleData = this.selectedRole;
  },
  methods: {
    closeDialog() {
      this.$emit("close");
    },
    createRole() {
      if (!this.loading) {
        this.loading = true;

        this.$axios
          .$patch(`api/role/`, this.roleData, {
            headers: {
              Authorization: `Bearer ${this.$store.state.accessToken}`,
            },
          })
          .then(() => this.closeDialog())
          .catch(() => {
            this.loading = false;
            return this.$vs.notification({
              color: "danger",
              title: "Error creating Role",
            });
          });
      }
    },
  },
};
</script>
