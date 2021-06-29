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
          <div class="status-user-profile">
            <h3 style="margin-top: 10px; text-align: center">
              Department details
            </h3>
            <div class="details">
              <vs-table class="table" striped>
                <template #tbody>
                  <vs-tr>
                    <vs-td> Department </vs-td>
                    <vs-td> {{ $store.state.user.department.name }} </vs-td>
                  </vs-tr>
                  <vs-tr>
                    <vs-td> Department employees </vs-td>
                    <vs-td> 5 </vs-td>
                  </vs-tr>
                  <vs-tr>
                    <vs-td> Department email</vs-td>
                    <vs-td> department@email.com </vs-td>
                  </vs-tr>
                </template>
              </vs-table>
            </div>
          </div>
        </div>
        <div v-if="active == 'subordinate-appraials'" class="child">
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
          <div class="square">
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
                        appraisalManagerList.stage1 = $vs.sortData(
                          $event,
                          appraisalManagerList.stage1,
                          'name'
                        )
                      "
                    >
                      Name
                    </vs-th>
                    <vs-th
                      sort
                      @click="
                        appraisalManagerList.stage1 = $vs.sortData(
                          $event,
                          appraisalManagerList.stage1,
                          'goal_count'
                        )
                      "
                    >
                      Goal Count
                    </vs-th>
                    <vs-th
                      sort
                      @click="
                        appraisalManagerList.stage1 = $vs.sortData(
                          $event,
                          appraisalManagerList.stage1,
                          'corevalue_count'
                        )
                      "
                    >
                      Corevalue count
                    </vs-th>
                    <vs-th
                      sort
                      @click="
                        appraisalManagerList.stage1 = $vs.sortData(
                          $event,
                          appraisalManagerList.stage1,
                          'skill_count'
                        )
                      "
                    >
                      Skill count
                    </vs-th>
                    <vs-th
                      sort
                      @click="
                        appraisalManagerList.stage1 = $vs.sortData(
                          $event,
                          appraisalManagerList.stage1,
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
                    v-for="(tr, i) in $vs.getSearch(
                      appraisalManagerList.stage1,
                      search
                    )"
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
                      {{ tr.status }}
                    </vs-td>

                    <template #expand>
                      <div class="con-content">
                        <div>
                          <vs-button color="success" flat icon>
                            <i class="bx bx-edit-alt"></i>
                          </vs-button>
                          <vs-button danger> Delete appraisal </vs-button>
                        </div>
                      </div>
                    </template>
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
                        appraisalManagerList.stage2 = $vs.sortData(
                          $event,
                          appraisalManagerList.stage2,
                          'name'
                        )
                      "
                    >
                      Name
                    </vs-th>
                    <vs-th
                      sort
                      @click="
                        appraisalManagerList.stage2 = $vs.sortData(
                          $event,
                          appraisalManagerList.stage2,
                          'goal_count'
                        )
                      "
                    >
                      Goal Count
                    </vs-th>
                    <vs-th
                      sort
                      @click="
                        appraisalManagerList.stage2 = $vs.sortData(
                          $event,
                          appraisalManagerList.stage2,
                          'corevalue_count'
                        )
                      "
                    >
                      Corevalue count
                    </vs-th>
                    <vs-th
                      sort
                      @click="
                        appraisalManagerList.stage2 = $vs.sortData(
                          $event,
                          appraisalManagerList.stage2,
                          'skill_count'
                        )
                      "
                    >
                      Skill count
                    </vs-th>
                    <vs-th
                      sort
                      @click="
                        appraisalManagerList.stage2 = $vs.sortData(
                          $event,
                          appraisalManagerList.stage2,
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
                    v-for="(tr, i) in $vs.getSearch(
                      appraisalManagerList.stage2,
                      search
                    )"
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
                      {{ tr.status }}
                    </vs-td>

                    <template #expand>
                      <div class="con-content">
                        <div>
                          <vs-button color="success" flat icon>
                            <i class="bx bx-edit-alt"></i>
                          </vs-button>
                          <vs-button danger> Delete appraisal </vs-button>
                        </div>
                      </div>
                    </template>
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
                        appraisalManagerList.stage3 = $vs.sortData(
                          $event,
                          appraisalManagerList.stage3,
                          'name'
                        )
                      "
                    >
                      Name
                    </vs-th>
                    <vs-th
                      sort
                      @click="
                        appraisalManagerList.stage3 = $vs.sortData(
                          $event,
                          appraisalManagerList.stage3,
                          'goal_count'
                        )
                      "
                    >
                      Goal Count
                    </vs-th>
                    <vs-th
                      sort
                      @click="
                        appraisalManagerList.stage3 = $vs.sortData(
                          $event,
                          appraisalManagerList.stage3,
                          'corevalue_count'
                        )
                      "
                    >
                      Corevalue count
                    </vs-th>
                    <vs-th
                      sort
                      @click="
                        appraisalManagerList.stage3 = $vs.sortData(
                          $event,
                          appraisalManagerList.stage3,
                          'skill_count'
                        )
                      "
                    >
                      Skill count
                    </vs-th>
                    <vs-th
                      sort
                      @click="
                        appraisalManagerList.stage3 = $vs.sortData(
                          $event,
                          appraisalManagerList.stage3,
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
                    v-for="(tr, i) in $vs.getSearch(
                      appraisalManagerList.stage3,
                      search
                    )"
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
                      {{ tr.status }}
                    </vs-td>

                    <template #expand>
                      <div class="con-content">
                        <div>
                          <vs-button color="success" flat icon>
                            <i class="bx bx-edit-alt"></i>
                          </vs-button>
                          <vs-button danger> Delete appraisal </vs-button>
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
    </div>
  </div>
</template>

<script>
export default {
  layout: "dashboard",
  middleware: ["auth"],
  data: () => ({
    active: "subordinate-details",
    activeStage: "stage1",
    search: "",
    loading: false,
    selected: {},
    appraisalManagerList: {
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

      this.appraisalManagerList.stage1 = res.filter((x) => x.stage === 1);
      this.appraisalManagerList.stage2 = res.filter((x) => x.stage === 2);
      this.appraisalManagerList.stage3 = res.filter((x) => x.stage === 3);
    } catch (err) {
      return this.$vs.notification({
        color: "danger",
        title: "Error fetching department",
      });
    }
  },
  // methods: {
  //   deleteAppraisal(id) {
  //     this.loading = true;

  //     this.$axios
  //       .$delete(`api/appraisal/${id}/`, {
  //         headers: {
  //           Authorization: `Bearer ${this.$store.state.accessToken}`,
  //         },
  //       })
  //       .then(() => {
  //         this.$emit("refresh");
  //         return this.$vs.notification({
  //           color: "success",
  //           title: `Successfully deleted appraisal`,
  //         });
  //       });
  //   },
  // },
};
</script>

<style>
.vs-navbar-content,
.vs-navbar,
.vs-navbar__line {
  position: relative;
}
.status-cards-group {
  display: flex;
  justify-content: space-around;
  flex-wrap: wrap;
}

.status-user-profile {
  margin: 50px 0;
}

.status-user-profile .avatar {
  justify-content: center;
  display: flex;
}

.status-user-profile .details {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: 30px;
}

.status-user-profile .details .table {
  max-width: 500px;
  box-shadow: 0px 0px 25px 0px rgba(0, 0, 0, var(--vs-shadow-opacity));
}
</style>
