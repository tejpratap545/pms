<template>
  <div class="page">
    <h1>Company Management</h1>
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
              @click="company = $vs.sortData($event, company, 'name')"
            >
              Name
            </vs-th>
            <vs-th
              sort
              @click="company = $vs.sortData($event, company, 'domain')"
            >
              Domain
            </vs-th>
            <vs-th sort @click="company = $vs.sortData($event, company, 'id')">
              Id
            </vs-th>
          </vs-tr>
        </template>
        <template #tbody>
          <vs-tr v-for="(tr, i) in $vs.getSearch(company, search)" :key="i">
            <vs-td>
              {{ tr.name }}
            </vs-td>
            <vs-td>
              {{ tr.domain }}
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
                  <vs-button border danger @click="deleteCompany(tr.id)">
                    Delete company
                  </vs-button>
                </div>
              </div>
            </template>
          </vs-tr>
        </template>
      </vs-table>
    </div>

    <vs-dialog v-model="newActive">
      <template #header>
        <h4 class="not-margin">Add a new <b>Company</b></h4>
      </template>

      <div class="con-form">
        <vs-input
          v-model="newCompanyData.admin_username"
          placeholder="Admin username"
        >
          <template #icon>
            <i class="bx bx-user"></i>
          </template>
        </vs-input>

        <vs-input
          v-model="newCompanyData.admin_password"
          type="password"
          placeholder="Admin password"
        >
          <template #icon>
            <i class="bx bxs-lock"></i>
          </template>
        </vs-input>

        <vs-input
          v-model="newCompanyData.admin_email"
          placeholder="Admin email"
        >
          <template #icon> @ </template>
        </vs-input>

        <vs-input v-model="newCompanyData.admin_name" placeholder="Admin name">
          <template #icon>
            <i class="bx bx-user"></i>
          </template>
        </vs-input>

        <vs-input v-model="newCompanyData.name" placeholder="Company Name">
          <template #icon>
            <i class="bx bx-building"></i>
          </template>
        </vs-input>

        <vs-input
          v-model="newCompanyData.domain"
          type="url"
          placeholder="Company domain"
        >
          <template #icon> <i class="bx bx-globe"></i> </template>
        </vs-input>
      </div>

      <template #footer>
        <div class="footer-dialog" style="margin-top: 10px">
          <vs-button :loading="loading" block @click="createCompany">
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
    newActive: false,
    edit: null,
    editProp: "",
    search: "",
    allCheck: false,
    page: 1,
    max: 3,
    loading: false,
    selected: [],
    company: [],
    newCompanyData: {
      admin_username: "",
      admin_email: "",
      admin_name: "",
      admin_password: "",
      name: "",
      domain: "",
    },
  }),
  async fetch() {
    try {
      this.company = await this.$axios.$get(`api/company/`, {
        headers: {
          Authorization: `Bearer ${this.$store.state.accessToken}`,
        },
      });
    } catch (err) {
      return this.$vs.notification({
        color: "danger",
        title: "Error fetching companies",
      });
    }
  },
  methods: {
    createCompany() {
      if (!this.loading) {
        this.loading = true;

        this.$axios
          .$post(`api/company/`, this.newCompanyData, {
            headers: {
              Authorization: `Bearer ${this.$store.state.accessToken}`,
            },
          })
          .then(() => location.reload())
          .catch(() => {
            this.loading = false;
            return this.$vs.notification({
              color: "danger",
              title: "Error creating company",
            });
          });
      }
    },
    deleteCompany(id) {
      if (!this.loading) {
        this.loading = true;

        this.$axios
          .$delete(`api/company/${id}`, {
            headers: {
              Authorization: `Bearer ${this.$store.state.accessToken}`,
            },
          })
          .then(() => location.reload())
          .catch(() => {
            this.loading = false;
            return this.$vs.notification({
              color: "danger",
              title: "Error deleting company",
            });
          });
      }
    },
  },
};
</script>

<style></style>
