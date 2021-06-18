<template>
  <div class="page">
    <h1>My Appraiasals Management</h1>
    <div v-if="$fetchState.pending"></div>
    <div v-else class="center grid" style="margin-top: 50px">
      <div class="appraisal-lists">
        <h3>My Appraisals</h3>
        <div
          v-for="a in apprisalList"
          :key="a.id"
          :class="`appraisal-list-item ${
            selectedAppraisal.id == a.id ? `active` : ``
          }`"
          @click="() => (selectedAppraisal = a)"
        >
          {{ a.name }}
        </div>
      </div>
      <div class="appraisal-grid">
        <div class="appraisal-item-open">
          <div class="appraisal-item">
            <div v-if="selectedAppraisal != null">
              <vs-table class="my-5">
                <template #header>
                  <div
                    class="table-header"
                    style="justify-content: space-between"
                  >
                    <h3>Goals</h3>
                    <vs-button @click="newGoal = true"> Add </vs-button>
                  </div>
                </template>
                <template #thead>
                  <vs-tr>
                    <vs-th> Summary </vs-th>
                    <vs-th> Description </vs-th>
                    <vs-th> Due </vs-th>
                  </vs-tr>
                </template>
                <template #tbody>
                  <vs-tr v-for="(tr, i) in selectedAppraisal.goal_set" :key="i">
                    <vs-td>
                      {{ tr.summary }}
                    </vs-td>
                    <vs-td>
                      {{ tr.description }}
                    </vs-td>
                    <vs-td>
                      {{ tr.due }}
                    </vs-td>

                    <template #expand>
                      <div>
                        <div class="con-content">
                          <vs-button
                            border
                            danger
                            @click="deleteItem('goal', tr.id)"
                          >
                            Delete
                          </vs-button>
                        </div>
                        <vs-table class="my-5">
                          <template #header>
                            <div
                              class="table-header"
                              style="justify-content: space-between"
                            >
                              <h3>KPIs</h3>
                              <vs-button
                                color="success"
                                flat
                                icon
                                @click="(newKpi = true), (selectedGoal = tr)"
                              >
                                <i class="bx bx-plus"></i>
                              </vs-button>
                            </div>
                          </template>
                          <template #thead>
                            <vs-tr>
                              <vs-th> Summary </vs-th>
                              <vs-th> Due </vs-th>
                              <vs-th> Progress </vs-th>
                            </vs-tr>
                          </template>
                          <template #tbody>
                            <vs-tr
                              v-for="(kpi, j) in tr.kpi_set"
                              :key="j"
                              class="kpi-container-item"
                            >
                              <vs-td>{{ kpi.summary }}</vs-td>
                              <vs-td>{{ kpi.due }}</vs-td>
                              <vs-td>{{ kpi.progress }}</vs-td>
                            </vs-tr>
                          </template>
                        </vs-table>
                      </div>
                    </template>
                  </vs-tr>
                </template>
              </vs-table>
              <vs-table class="my-5">
                <template #header>
                  <div
                    class="table-header"
                    style="justify-content: space-between"
                  >
                    <h3>Core values</h3>
                    <vs-button @click="newCoreValue = true"> Add </vs-button>
                  </div>
                </template>
                <template #thead>
                  <vs-tr>
                    <vs-th> Summary </vs-th>
                    <vs-th> Description </vs-th>
                    <vs-th> Due </vs-th>
                  </vs-tr>
                </template>
                <template #tbody>
                  <vs-tr
                    v-for="(tr, i) in selectedAppraisal.corevalue_set"
                    :key="i"
                  >
                    <vs-td>
                      {{ tr.summary }}
                    </vs-td>
                    <vs-td>
                      {{ tr.description }}
                    </vs-td>
                    <vs-td>
                      {{ tr.due }}
                    </vs-td>

                    <template #expand>
                      <div>
                        <div class="con-content">
                          <vs-button
                            border
                            danger
                            @click="deleteItem('core-value', tr.id)"
                          >
                            Delete
                          </vs-button>
                        </div>
                      </div>
                    </template>
                  </vs-tr>
                </template>
              </vs-table>
              <vs-table class="my-5">
                <template #header>
                  <div
                    class="table-header"
                    style="justify-content: space-between"
                  >
                    <h3>Skills</h3>
                    <vs-button @click="newSkill = true"> Add </vs-button>
                  </div>
                </template>
                <template #thead>
                  <vs-tr>
                    <vs-th> Summary </vs-th>
                    <vs-th> Description </vs-th>
                    <vs-th> Due </vs-th>
                  </vs-tr>
                </template>
                <template #tbody>
                  <vs-tr
                    v-for="(tr, i) in selectedAppraisal.skill_set"
                    :key="i"
                  >
                    <vs-td>
                      {{ tr.summary }}
                    </vs-td>
                    <vs-td>
                      {{ tr.description }}
                    </vs-td>
                    <vs-td>
                      {{ tr.due }}
                    </vs-td>

                    <template #expand>
                      <div>
                        <div class="con-content">
                          <vs-button
                            border
                            danger
                            @click="deleteItem('skill', tr.id)"
                          >
                            Delete
                          </vs-button>
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

    <!-- Dialogs -->
    <NewGoalDialog
      v-if="newGoal"
      :dialog="newGoal"
      :selected-appraisal="selectedAppraisal"
      @close="(newGoal = false), $fetch()"
    />

    <NewCoreValueDialog
      v-if="newCoreValue"
      :dialog="newCoreValue"
      :selected-appraisal="selectedAppraisal"
      @close="(newCoreValue = false), $fetch()"
    />

    <NewSkillsDialog
      v-if="newSkill"
      :dialog="newSkill"
      :selected-appraisal="selectedAppraisal"
      @close="(newSkill = false), $fetch()"
    />

    <NewKpiDialog
      v-if="newKpi"
      :dialog="newKpi"
      :selected-goal="selectedGoal"
      @close="(newKpi = false), $fetch()"
    />
  </div>
</template>

<script>
export default {
  layout: "dashboard",
  middleware: ["auth"],
  data: () => ({
    newGoal: false,
    newCoreValue: false,
    newSkill: false,
    newKpi: false,
    loading: false,
    apprisalList: [],
    selectedGoal: {},
    selectedAppraisal: {},
  }),
  async fetch() {
    try {
      this.apprisalList = await this.$axios.$get(`api/appraisal/me`, {
        headers: {
          Authorization: `Bearer ${this.$store.state.accessToken}`,
        },
      });

      if (this.apprisalList.length !== 0)
        this.selectedAppraisal = this.apprisalList[0];
    } catch (err) {
      return this.$vs.notification({
        color: "danger",
        title: "Error fetching appriasals",
      });
    }
  },
  methods: {
    deleteItem(item, id) {
      console.log(item, id);
      this.loading = true;

      this.$axios
        .$delete(`api/${item}/${id}/`, {
          headers: {
            Authorization: `Bearer ${this.$store.state.accessToken}`,
          },
        })
        .then(() => {
          this.$fetch();
          return this.$vs.notification({
            color: "success",
            title: `Successfully deleted ${item}`,
          });
        })
        .catch(() => {
          this.loading = false;
          return this.$vs.notification({
            color: "danger",
            title: `Error deleting ${item}`,
          });
        });
    },
  },
};
</script>

<style>
.appraisal-grid {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
}

.kpi-container-item {
  padding: 10px;
}

.appraisal-lists {
  width: 330px;
  position: fixed;
  height: 100%;
  background: #f4f7f8;
  left: 0;
  top: 0;
  padding-left: 75px;
}

.appraisal-lists > h3 {
  text-align: center;
  margin: 50px 0;
}

.appraisal-lists > .appraisal-list-item {
  padding: 10px;
  background: #eee;
  border-radius: 12px;
  margin-right: 20px;
  margin-bottom: 10px;
  opacity: 0.7;
  text-align: center;
}

.appraisal-lists > .appraisal-list-item.active,
.appraisal-lists > .appraisal-list-item:hover {
  cursor: pointer;
  color: #195bff;
  background: rgba(25, 91, 255, 0.15);
}

.appraisal-item {
  width: 100%;
  min-height: 600px;
  background: #fff;
  box-shadow: 0px 0px 25px 0px rgba(0, 0, 0, var(--vs-shadow-opacity));
  border-radius: 16px;
  padding: 30px;
}

.appraisal-property {
  display: flex;
}

.appraisal-item-open {
  max-width: 1000px;
  width: 100%;
  margin-left: 200px;
}

.appraisal-property-key {
  background: #ccc;
  padding: 10px;
  width: 50%;
  border-radius: 25px;
}

.appraisal-property {
  display: flex;
  text-align: center;
  margin: 20px 0;
}

.appraisal-property-value {
  padding: 10px;
  text-align: center;
  width: 50%;
}

@media only screen and (max-width: 800px) {
  .appraisal-lists > .appraisal-list-item {
    margin-right: unset;
  }
}
</style>
