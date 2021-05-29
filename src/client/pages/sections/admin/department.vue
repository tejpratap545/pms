<template>
  <div class="page">
    <h1>Department Management</h1>
    <div class="center" style="margin-top: 50px">
      <vs-table>
        <template #header>
          <div class="table-header">
            <vs-input v-model="search" placeholder="Search" shadow>
              <template #icon>
                <i class="bx bx-search"></i>
              </template>
            </vs-input>
            <vs-button @click="newActive = true"> Add </vs-button>
          </div>
        </template>
        <template #thead>
          <vs-tr>
            <vs-th
              sort
              @click="
                departmentList = $vs.sortData($event, departmentList, 'name')
              "
            >
              Name
            </vs-th>
            <vs-th
              sort
              @click="
                departmentList = $vs.sortData($event, departmentList, 'id')
              "
            >
              Id
            </vs-th>
          </vs-tr>
        </template>
        <template #tbody>
          <vs-tr
            v-for="(tr, i) in $vs.getSearch(departmentList, search)"
            :key="i"
          >
            <vs-td>
              {{ tr.name }}
            </vs-td>
            <vs-td>
              {{ tr.id }}
            </vs-td>

            <template #expand>
              <div class="con-content">
                <div>
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

    <!-- Dialogs -->
    <NewDepartmentDialog
      v-if="newActive"
      :dialog="newActive"
      @close="(newActive = false), $fetch()"
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
    selected: [],
    departmentList: [],
  }),
  async fetch() {
    try {
      this.departmentList = await this.$axios.$get(`api/department/`, {
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
          .$delete(`api/department/${id}/`, {
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
