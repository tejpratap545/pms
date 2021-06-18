<template>
  <div class="page">
    <h1>Employee Management</h1>
    <div class="center">
      <vs-table v-model="selected">
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
            <vs-th> Avatar </vs-th>
            <vs-th> Username </vs-th>
            <vs-th> Fullname </vs-th>
            <vs-th> Email </vs-th>
            <vs-th
              sort
              @click="employeeList = $vs.sortData($event, employeeList, 'id')"
            >
              Id
            </vs-th>
          </vs-tr>
        </template>
        <template #tbody>
          <vs-tr
            v-for="(tr, i) in $vs.getSearch(employeeList, search)"
            :key="i"
            :data="tr"
            :is-selected="selected == tr"
          >
            <vs-td>
              <vs-avatar>
                <img
                  :src="
                    tr.avatar
                      ? tr.avatar
                      : `https://avatars.dicebear.com/api/jdenticon/${tr.user.email}.svg`
                  "
                  alt="Avatar"
                />
              </vs-avatar>
            </vs-td>
            <vs-td> {{ tr.user.username }} </vs-td>
            <vs-td> {{ tr.user.first_name }} {{ tr.user.last_name }} </vs-td>
            <vs-td>
              {{ tr.user.email }}
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
                  <vs-button border danger @click="resignActive = true">
                    Resign employee
                  </vs-button>
                </div>
              </div>
            </template>
          </vs-tr>
        </template>
      </vs-table>
    </div>

    <!-- Dialogs -->
    <NewEmployeeDialog
      v-if="newActive"
      :dialog="newActive"
      @close="(newActive = false), $fetch()"
    />

    <EditEmployeeDialog
      v-if="editActive"
      :dialog="editActive"
      :selected-employee="selected"
      @close="(editActive = false), $fetch()"
    />

    <ResignEmployeeDialog
      v-if="resignActive"
      :dialog="resignActive"
      :selected-employee="selected"
      @close="(resignActive = false), $fetch()"
    />
  </div>
</template>

<script>
export default {
  layout: "dashboard",
  middleware: ["auth"],
  data: () => ({
    editActive: false,
    resignActive: false,
    newActive: false,
    search: "",
    loading: false,
    selected: {},
    employeeList: [],
  }),
  async fetch() {
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
  },
};
</script>
