<template>
  <div class="page">
    <h1>Employee Management</h1>
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
          >
            <vs-td>
              <vs-avatar>
                <img :src="`${tr.avatar}`" alt="Avatar" />
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
                  <vs-button flat icon>
                    <i class="bx bx-lock-open-alt"></i>
                  </vs-button>
                  <vs-button flat icon> Send Email </vs-button>
                  <vs-button
                    border
                    danger
                    @click="(resignActive = true), (singleSelected = tr.id)"
                  >
                    Resign employee
                  </vs-button>
                </div>
              </div>
            </template>
          </vs-tr>
        </template>
      </vs-table>
    </div>

    <vs-dialog v-model="resignActive">
      <template #header> Resign Employee </template>

      <div class="con-form">
        <vs-input
          v-model="resignEmployeeData.replace_employee"
          placeholder="Resign Employee ID"
        />
      </div>

      <template #footer>
        <div class="footer-dialog" style="margin-top: 10px">
          <vs-button :loading="loading" block @click="resignEmployee">
            Add New
          </vs-button>
        </div>
      </template>
    </vs-dialog>

    <vs-dialog v-model="newActive">
      <template #header>
        <h4 class="not-margin">Add a new <b>Employee</b></h4>
      </template>

      <div class="con-form">
        <vs-select
          v-if="$store.state.user.user.is_superuser"
          v-model="newEmployeeData.user.company"
          placeholder="Select Company"
          style="display: contents"
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

        <vs-input v-model="newEmployeeData.job_title" placeholder="Job title">
          <template #icon>
            <i class="bx bxs-user-badge"></i>
          </template>
        </vs-input>

        <vs-input
          v-model="newEmployeeData.user.first_name"
          placeholder="Firstname"
        >
          <template #icon>
            <i class="bx bx-user"></i>
          </template>
        </vs-input>

        <vs-input
          v-model="newEmployeeData.user.last_name"
          placeholder="Lastname"
        >
          <template #icon>
            <i class="bx bx-user"></i>
          </template>
        </vs-input>

        <vs-input
          v-model="newEmployeeData.user.username"
          placeholder="Username"
        >
          <template #icon>
            <i class="bx bx-user"></i>
          </template>
        </vs-input>

        <vs-input
          v-model="newEmployeeData.user.password"
          type="password"
          placeholder="User password"
        >
          <template #icon>
            <i class="bx bxs-lock"></i>
          </template>
        </vs-input>

        <vs-input v-model="newEmployeeData.user.email" placeholder="User email">
          <template #icon> @ </template>
        </vs-input>
      </div>

      <template #footer>
        <div class="footer-dialog" style="margin-top: 10px">
          <vs-button :loading="loading" block @click="createEmployee">
            Add New
          </vs-button>
        </div>
      </template>
    </vs-dialog>
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
    edit: null,
    editProp: "",
    search: "",
    allCheck: false,
    page: 1,
    max: 3,
    active: 0,
    loading: false,
    selected: [],
    employeeList: [],
    singleSelected: 0,
    resignEmployeeData: {
      replace_employee: 0,
    },
    newEmployeeData: {
      user: {
        password: "",
        first_name: "",
        username: "",
        last_name: "",
        email: "",
        contact_number: "",
        company: "",
      },
      job_title: "",
      address_1: "",
      address_2: "",
    },
    companyList: [],
  }),
  async fetch() {
    try {
      this.employeeList = await this.$axios.$get(`api/user/`, {
        headers: {
          Authorization: `Bearer ${this.$store.state.accessToken}`,
        },
      });
      this.companyList = await this.$axios.$get(`api/company/`, {
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
  methods: {
    createEmployee() {
      if (!this.loading) {
        this.loading = true;

        this.$axios
          .$post(`api/user/`, this.newEmployeeData, {
            headers: {
              Authorization: `Bearer ${this.$store.state.accessToken}`,
            },
          })
          .then(() => location.reload())
          .catch(() => {
            this.loading = false;
            return this.$vs.notification({
              color: "danger",
              title: "Error creating employee",
            });
          });
      }
    },
    resignEmployee() {
      if (!this.loading) {
        this.loading = true;

        this.$axios
          .$post(
            `api/user/${this.singleSelected}/resign/`,
            this.resignEmployeeData,
            {
              headers: {
                Authorization: `Bearer ${this.$store.state.accessToken}`,
              },
            }
          )
          .then(() => location.reload())
          .catch(() => {
            this.loading = false;
            return this.$vs.notification({
              color: "danger",
              title: "Error resigning employee",
            });
          });
      }
    },
  },
};
</script>
