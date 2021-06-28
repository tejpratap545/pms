<template>
  <div class="page">
    <h1>Department Management</h1>

    <div v-if="$fetchState.pending"><Spinner /></div>
    <div v-else class="center">
      <vs-navbar v-model="active" center-collapsed>
        <vs-navbar-item
          id="subordinate-details"
          :active="active == 'subordinate-details'"
        >
          Subordinate details
        </vs-navbar-item>
        <vs-navbar-item
          id="subordinate-appraials"
          :active="active == 'subordinate-appraials'"
        >
          Subordinate appraisals
        </vs-navbar-item>
      </vs-navbar>
      <div class="square">
        <div v-if="active == 'subordinate-details'" class="child">
          Subordinate details
        </div>
        <div v-if="active == 'subordinate-appraials'" class="child">
          <vs-table v-model="selected">
            <template #header>
              <div class="table-header">
                <vs-input v-model="search" placeholder="Search" shadow>
                  <template #icon>
                    <i class="bx bx-search"></i>
                  </template>
                </vs-input>
              </div>
            </template>
            <template #thead>
              <vs-tr>
                <vs-th
                  sort
                  @click="
                    appraisalManagerList = $vs.sortData(
                      $event,
                      appraisalManagerList,
                      'name'
                    )
                  "
                >
                  Name
                </vs-th>
                <vs-th
                  sort
                  @click="
                    appraisalManagerList = $vs.sortData(
                      $event,
                      appraisalManagerList,
                      'goal_count'
                    )
                  "
                >
                  Goal Count
                </vs-th>
                <vs-th
                  sort
                  @click="
                    appraisalManagerList = $vs.sortData(
                      $event,
                      appraisalManagerList,
                      'corevalue_count'
                    )
                  "
                >
                  Corevalue count
                </vs-th>
                <vs-th
                  sort
                  @click="
                    appraisalManagerList = $vs.sortData(
                      $event,
                      appraisalManagerList,
                      'skill_count'
                    )
                  "
                >
                  Skill count
                </vs-th>
                <vs-th
                  sort
                  @click="
                    appraisalManagerList = $vs.sortData(
                      $event,
                      appraisalManagerList,
                      'stage'
                    )
                  "
                >
                  Status
                </vs-th>
                <vs-th
                  sort
                  @click="
                    appraisalManagerList = $vs.sortData(
                      $event,
                      appraisalManagerList,
                      'status'
                    )
                  "
                >
                  Status
                </vs-th>
              </vs-tr>
            </template>
            <template #tbody>
              <vs-tr
                v-for="(tr, i) in $vs.getSearch(appraisalManagerList, search)"
                :key="i"
                :data="tr"
                :is-selected="selected == tr"
              >
                <vs-td>
                  {{ tr.name }}
                </vs-td>
                <vs-td>
                  {{ tr.goal_count }}
                </vs-td>
                <vs-td>
                  {{ tr.corevalue_count }}
                </vs-td>
                <vs-td>
                  {{ tr.skill_count }}
                </vs-td>
                <vs-td>
                  {{ tr.stage }}
                </vs-td>
                <vs-td>
                  {{ tr.status }}
                </vs-td>

                <template #expand>
                  <div class="con-content">
                    <div>
                      <vs-button color="success" flat icon>
                        <i class="bx bx-edit-alt"></i>
                      </vs-button>
                      <vs-button danger> Delete department </vs-button>
                    </div>
                  </div>
                </template>
              </vs-tr>
            </template>
          </vs-table>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  layout: "dashboard",
  middleware: ["auth"],
  data: () => ({
    active: "subordinate-details",
    search: "",
    loading: false,
    selected: {},
    appraisalManagerList: [],
  }),
  async fetch() {
    try {
      this.appraisalManagerList = await this.$axios.$get(
        `api/appraisal/manager`,
        {
          headers: {
            Authorization: `Bearer ${this.$store.state.accessToken}`,
          },
        }
      );
    } catch (err) {
      return this.$vs.notification({
        color: "danger",
        title: "Error fetching department",
      });
    }
  },
};
</script>

<style>
.vs-navbar-content,
.vs-navbar,
.vs-navbar__line {
  position: relative;
}
</style>
