<template>
  <div class="page">
    <h1>Records</h1>
    <div v-if="$fetchState.pending"><Spinner /></div>
    <div v-else class="center">
      <vs-navbar v-model="activeStage" center-collapsed>
        <vs-navbar-item id="stage1" :active="activeStage == 'stage1'">
          Goal setting stage
        </vs-navbar-item>
        <vs-navbar-item id="stage2" :active="activeStage == 'stage2'">
          Mid year review
        </vs-navbar-item>
        <vs-navbar-item id="stage3" :active="activeStage == 'stage3'">
          End year review
        </vs-navbar-item>
      </vs-navbar>
      <div class="square my-5">
        <div v-if="activeStage == 'stage1'" class="child">
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
                <vs-th> Employee Name </vs-th>
                <vs-th
                  sort
                  @click="
                    recordList.stage1 = $vs.sortData(
                      $event,
                      recordList.stage1,
                      'name'
                    )
                  "
                >
                  Name
                </vs-th>
                <vs-th
                  sort
                  @click="
                    recordList.stage1 = $vs.sortData(
                      $event,
                      recordList.stage1,
                      'goal_count'
                    )
                  "
                >
                  Goal Count
                </vs-th>
                <vs-th
                  sort
                  @click="
                    recordList.stage1 = $vs.sortData(
                      $event,
                      recordList.stage1,
                      'corevalue_count'
                    )
                  "
                >
                  Corevalue count
                </vs-th>
                <vs-th
                  sort
                  @click="
                    recordList.stage1 = $vs.sortData(
                      $event,
                      recordList.stage1,
                      'skill_count'
                    )
                  "
                >
                  Skill count
                </vs-th>
                <vs-th
                  sort
                  @click="
                    recordList.stage1 = $vs.sortData(
                      $event,
                      recordList.stage1,
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
                v-for="(tr, i) in $vs.getSearch(recordList.stage1, search)"
                :key="i"
                :data="tr"
                :is-selected="selected == tr"
              >
                <vs-td>
                  {{ tr.employee.name }}
                </vs-td>
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
                  {{ getStatus(tr.status, tr.stage) }}
                </vs-td>
              </vs-tr>
            </template>
          </vs-table>
        </div>
        <div v-if="activeStage == 'stage2'" class="child">
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
                <vs-th> Employee Name </vs-th>
                <vs-th
                  sort
                  @click="
                    recordList.stage2 = $vs.sortData(
                      $event,
                      recordList.stage2,
                      'name'
                    )
                  "
                >
                  Name
                </vs-th>
                <vs-th
                  sort
                  @click="
                    recordList.stage2 = $vs.sortData(
                      $event,
                      recordList.stage2,
                      'goal_count'
                    )
                  "
                >
                  Goal Count
                </vs-th>
                <vs-th
                  sort
                  @click="
                    recordList.stage2 = $vs.sortData(
                      $event,
                      recordList.stage2,
                      'corevalue_count'
                    )
                  "
                >
                  Corevalue count
                </vs-th>
                <vs-th
                  sort
                  @click="
                    recordList.stage2 = $vs.sortData(
                      $event,
                      recordList.stage2,
                      'skill_count'
                    )
                  "
                >
                  Skill count
                </vs-th>
                <vs-th
                  sort
                  @click="
                    recordList.stage2 = $vs.sortData(
                      $event,
                      recordList.stage2,
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
                v-for="(tr, i) in $vs.getSearch(recordList.stage2, search)"
                :key="i"
                :data="tr"
                :is-selected="selected == tr"
              >
                <vs-td>
                  {{ tr.employee.name }}
                </vs-td>
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
                  {{ getStatus(tr.status, tr.stage) }}
                </vs-td>
              </vs-tr>
            </template>
          </vs-table>
        </div>
        <div v-if="activeStage == 'stage3'" class="child">
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
                <vs-th> Employee Name </vs-th>
                <vs-th
                  sort
                  @click="
                    recordList.stage3 = $vs.sortData(
                      $event,
                      recordList.stage3,
                      'name'
                    )
                  "
                >
                  Name
                </vs-th>
                <vs-th
                  sort
                  @click="
                    recordList.stage3 = $vs.sortData(
                      $event,
                      recordList.stage3,
                      'goal_count'
                    )
                  "
                >
                  Goal Count
                </vs-th>
                <vs-th
                  sort
                  @click="
                    recordList.stage3 = $vs.sortData(
                      $event,
                      recordList.stage3,
                      'corevalue_count'
                    )
                  "
                >
                  Corevalue count
                </vs-th>
                <vs-th
                  sort
                  @click="
                    recordList.stage3 = $vs.sortData(
                      $event,
                      recordList.stage3,
                      'skill_count'
                    )
                  "
                >
                  Skill count
                </vs-th>
                <vs-th
                  sort
                  @click="
                    recordList.stage3 = $vs.sortData(
                      $event,
                      recordList.stage3,
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
                v-for="(tr, i) in $vs.getSearch(recordList.stage3, search)"
                :key="i"
                :data="tr"
                :is-selected="selected == tr"
              >
                <vs-td>
                  {{ tr.employee.name }}
                </vs-td>
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
                  {{ getStatus(tr.status, tr.stage) }}
                </vs-td>
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
    activeStage: "stage1",
    selected: {},
    recordList: {
      stage1: [],
      stage2: [],
      stage3: [],
    },
  }),
  async fetch() {
    try {
      const res = await this.$axios.$get(`api/appraisal/manager`, {
        headers: {
          Authorization: `Bearer ${this.$store.state.accessToken}`,
        },
      });

      this.recordList.stage1 = res.filter((x) => x.stage === 0);
      this.recordList.stage2 = res.filter((x) => x.stage === 1);
      this.recordList.stage3 = res.filter((x) => x.stage === 2);
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
