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

    <!-- Dialogs -->
    <NewCompanyDialog
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
    company: [],
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
    deleteCompany(id) {
      if (!this.loading) {
        this.loading = true;

        this.$axios
          .$delete(`api/company/${id}/`, {
            headers: {
              Authorization: `Bearer ${this.$store.state.accessToken}`,
            },
          })
          .then(() => this.$fetch())
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
