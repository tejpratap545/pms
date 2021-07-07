<template>
  <div class="page">
    <h1>Roles Management</h1>
    <div class="center">
      <vs-table v-model="selected">
        <template #header>
          <div class="table-header">
            <vs-input v-model="search" placeholder="Search" shadow>
              <template #icon>
                <i class="bx bx-search"></i>
              </template>
            </vs-input>
            <vs-button class="data-1" @click="newActive = true">
              Add
            </vs-button>
            <vs-button icon @click="$tours.myTour.start()">
              <i class="bx bx-help-circle"></i>
            </vs-button>
          </div>
        </template>
        <template #thead>
          <vs-tr>
            <vs-th
              sort
              @click="rolesList = $vs.sortData($event, rolesList, 'name')"
            >
              Name
            </vs-th>
            <vs-th
              v-if="$store.state.user.user.is_superuser"
              sort
              @click="rolesList = $vs.sortData($event, rolesList, 'company')"
            >
              company
            </vs-th>
            <vs-th
              sort
              @click="rolesList = $vs.sortData($event, rolesList, 'id')"
            >
              Id
            </vs-th>
          </vs-tr>
        </template>
        <template #tbody>
          <vs-tr
            v-for="(tr, i) in $vs.getSearch(rolesList, search)"
            :key="i"
            :data="tr"
            :is-selected="selected == tr"
            class="data-2"
          >
            <vs-td>
              {{ tr.name }}
            </vs-td>
            <vs-td v-if="$store.state.user.user.is_superuser">
              {{ companyList.filter((x) => x.id == tr.company)[0].name }}
            </vs-td>
            <vs-td>
              {{ tr.id }}
            </vs-td>

            <template #expand>
              <div class="con-content">
                <div>
                  <vs-button
                    color="success"
                    flat
                    icon
                    @click="editActive = true"
                  >
                    <i class="bx bx-edit-alt"></i>
                  </vs-button>
                  <vs-button border danger @click="deleteDepartment(tr.id)">
                    Delete department
                  </vs-button>
                </div>
              </div>
            </template>
          </vs-tr>
        </template>
      </vs-table>
    </div>

    <v-tour name="myTour" :steps="steps"></v-tour>

    <!-- Dialogs -->
    <NewRoleDialog
      v-if="newActive"
      :dialog="newActive"
      :company-list="companyList"
      @close="(newActive = false), $fetch()"
    />

    <EditRoleDialog
      v-if="editActive"
      :dialog="editActive"
      :selected-role="selected"
      :company-list="companyList"
      @close="(editActive = false), $fetch()"
    />
  </div>
</template>

<script>
export default {
  layout: "dashboard",
  middleware: ["auth"],
  data: () => ({
    editActive: false,
    newActive: false,
    search: "",
    loading: false,
    selected: {},
    companyList: [],
    rolesList: [],
    steps: [
      {
        target: ".page", // We're using document.querySelector() under the hood
        header: {
          title: "Get Started",
        },
        content: `Welcome to PMS Onboarding `,
      },
      {
        target: ".data-1",
        header: {
          title: "Adding Roles",
        },
        content: "Use this button to add a roles for employee",
      },
      {
        target: ".data-2",
        header: {
          title: "Editing Roles",
        },
        content:
          "Click on an item to expand it and reveal more options like edit and delete",
      },
    ],
  }),
  async fetch() {
    try {
      if (this.$store.state.user.user.is_superuser) {
        this.companyList = await this.$axios.$get(`api/company/`, {
          headers: {
            Authorization: `Bearer ${this.$store.state.accessToken}`,
          },
        });
      }

      this.rolesList = await this.$axios.$get(`api/role/`, {
        headers: {
          Authorization: `Bearer ${this.$store.state.accessToken}`,
        },
      });
    } catch (err) {
      return this.$vs.notification({
        color: "danger",
        title: "Error fetching department",
      });
    }
  },
  methods: {
    deleteDepartment(id) {
      if (!this.loading) {
        this.loading = true;

        this.$axios
          .$delete(`api/role/${id}/`, {
            headers: {
              Authorization: `Bearer ${this.$store.state.accessToken}`,
            },
          })
          .then(() => this.$fetch())
          .catch(() => {
            this.loading = false;
            return this.$vs.notification({
              color: "danger",
              title: "Error deleting department",
            });
          });
      }
    },
  },
};
</script>

<style></style>
