<template>
  <div class="page">
    <h1>Overall Appraisal Management</h1>
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
              @click="
                appraisalList = $vs.sortData($event, appraisalList, 'name')
              "
            >
              Name
            </vs-th>
            <vs-th
              sort
              @click="
                appraisalList = $vs.sortData($event, appraisalList, 'status')
              "
            >
              Stage
            </vs-th>
            <vs-th
              v-if="$store.state.user.user.is_superuser"
              sort
              @click="
                appraisalList = $vs.sortData($event, appraisalList, 'company')
              "
            >
              company
            </vs-th>
            <vs-th
              sort
              @click="appraisalList = $vs.sortData($event, appraisalList, 'id')"
            >
              Id
            </vs-th>
          </vs-tr>
        </template>
        <template #tbody>
          <vs-tr
            v-for="(tr, i) in $vs.getSearch(appraisalList, search)"
            :key="i"
            :data="tr"
            :is-selected="selected == tr"
            class="data-2"
          >
            <vs-td>
              {{ tr.name }}
            </vs-td>
            <vs-td>
              {{ `Stage ${tr.stage}` }}
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
                  <vs-button border danger @click="deleteAppraisal(tr.id)">
                    Delete appraisal
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
    <NewAppraisalDialog
      v-if="newActive"
      :dialog="newActive"
      :company-list="companyList"
      @close="(newActive = false), $fetch()"
    />

    <EditAppraisalDialog
      v-if="editActive"
      :dialog="editActive"
      :selected-appraisal="selected"
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
    appraisalList: [],
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
          title: "Adding Appraisals",
        },
        content:
          "Use this button to add appraisals for individuals, departments or entire company",
      },
      {
        target: ".data-2",
        header: {
          title: "Editing Appraisals",
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

      this.appraisalList = await this.$axios.$get(`api/over-all-appraisal/`, {
        headers: {
          Authorization: `Bearer ${this.$store.state.accessToken}`,
        },
      });
    } catch (err) {
      return this.$vs.notification({
        color: "danger",
        title: "Error fetching appraisals",
      });
    }
  },
  methods: {
    deleteAppraisal(id) {
      if (!this.loading) {
        this.loading = true;

        this.$axios
          .$delete(`api/over-all-appraisal/${id}/`, {
            headers: {
              Authorization: `Bearer ${this.$store.state.accessToken}`,
            },
          })
          .then(() => this.$fetch())
          .catch(() => {
            this.loading = false;
            return this.$vs.notification({
              color: "danger",
              title: "Error deleting appraisals",
            });
          });
      }
    },
  },
};
</script>

<style></style>
