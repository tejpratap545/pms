<template>
  <div>
    <div class="my-5 pa-2">
      <vs-row>
        <vs-col w="4"> Actions </vs-col>
        <vs-col w="8" style="display: flex; justify-content: flex-end">
          <vs-button @click="upstageAppraisal = true">
            Upstage Apraisal {{ selectedAppraisal.stage }}
          </vs-button>
        </vs-col>
      </vs-row>
    </div>
    <vs-table class="my-5">
      <template #header>
        <div class="table-header" style="justify-content: space-between">
          <h3>Goals</h3>
          <vs-button @click="newGoal = true"> Add </vs-button>
        </div>
      </template>
      <template #thead>
        <vs-tr>
          <vs-th> Summary </vs-th>
          <vs-th> Weightage </vs-th>
          <vs-th> KPI Count </vs-th>
          <vs-th> Due </vs-th>
        </vs-tr>
      </template>
      <template #tbody>
        <vs-tr v-for="(tr, i) in selectedAppraisal.goal_set" :key="i">
          <vs-td>
            {{ tr.summary }}
          </vs-td>
          <vs-td>
            {{ tr.weightage }}
          </vs-td>
          <vs-td>
            {{ tr.kpi_set.length }}
          </vs-td>
          <vs-td>
            {{ tr.due }}
          </vs-td>

          <template #expand>
            <div>
              <div class="con-content">
                <vs-button border danger @click="deleteItem('goal', tr.id)">
                  Delete
                </vs-button>
              </div>
              <div style="font-size: 12.8px">
                <vs-row v-if="tr.description != null" style="padding: 20px 0">
                  <vs-col w="4">
                    <b>Description</b>
                  </vs-col>
                  <vs-col w="8" class="description-card">
                    <!-- eslint-disable-next-line vue/no-v-html -->
                    <span v-html="tr.description"></span>
                  </vs-col>
                </vs-row>
                <vs-row style="padding: 20px 0">
                  <vs-col w="4"> <b>Stage 1 Employee comment</b> </vs-col>
                  <vs-col w="8" class="description-card">
                    <span v-if="tr.stage1_employee_comment != null">
                      <!-- eslint-disable-next-line vue/no-v-html -->
                      <span v-html="tr.stage1_employee_comment"></span>
                    </span>
                    <span v-else>No Comment</span>
                  </vs-col>
                </vs-row>
                <vs-row style="padding: 20px 0">
                  <vs-col w="4"> <b>Stage 1 Manager comment</b> </vs-col>
                  <vs-col w="8" class="description-card">
                    <span v-if="tr.stage1_manager_comment != null">
                      <!-- eslint-disable-next-line vue/no-v-html -->
                      <span v-html="tr.stage1_manager_comment"></span>
                    </span>
                    <span v-else>No Comment</span>
                  </vs-col>
                </vs-row>
                <vs-row style="padding: 20px 0">
                  <vs-col w="4"> <b>Stage 1 Rejection comment</b> </vs-col>
                  <vs-col w="8" class="description-card">
                    <span v-if="tr.stage1_rejection_comment != null">
                      <!-- eslint-disable-next-line vue/no-v-html -->
                      <span v-html="tr.stage1_rejection_comment"></span>
                    </span>
                    <span v-else>No Comment</span>
                  </vs-col>
                </vs-row>
                <vs-row style="padding: 20px 0">
                  <vs-col w="4"> <b>Stage 2 Employee comment</b> </vs-col>
                  <vs-col w="8" class="description-card">
                    <span v-if="tr.stage2_employee_comment != null">
                      <!-- eslint-disable-next-line vue/no-v-html -->
                      <span v-html="tr.stage2_employee_comment"></span>
                    </span>
                    <span v-else>No Comment</span>
                  </vs-col>
                </vs-row>
                <vs-row style="padding: 20px 0">
                  <vs-col w="4"> <b>Stage 2 Manager comment</b> </vs-col>
                  <vs-col w="8" class="description-card">
                    <span v-if="tr.stage2_manager_comment != null">
                      <!-- eslint-disable-next-line vue/no-v-html -->
                      <span v-html="tr.stage2_manager_comment"></span>
                    </span>
                    <span v-else>No Comment</span>
                  </vs-col>
                </vs-row>
                <vs-row style="padding: 20px 0">
                  <vs-col w="4"> <b>Stage 2 Rejection comment</b> </vs-col>
                  <vs-col w="8" class="description-card">
                    <span v-if="tr.stage2_rejection_comment != null">
                      <!-- eslint-disable-next-line vue/no-v-html -->
                      <span v-html="tr.stage2_rejection_comment"></span>
                    </span>
                    <span v-else>No Comment</span>
                  </vs-col>
                </vs-row>
                <vs-row style="padding: 20px 0">
                  <vs-col w="4"> <b>Stage 3 Employee comment</b> </vs-col>
                  <vs-col w="8" class="description-card">
                    <span v-if="tr.stage3_employee_comment != null">
                      <!-- eslint-disable-next-line vue/no-v-html -->
                      <span v-html="tr.stage3_employee_comment"></span>
                    </span>
                    <span v-else>No Comment</span>
                  </vs-col>
                </vs-row>
                <vs-row style="padding: 20px 0">
                  <vs-col w="4"> <b>Stage 3 Manager comment</b> </vs-col>
                  <vs-col w="8" class="description-card">
                    <span v-if="tr.stage3_manager_comment != null">
                      <!-- eslint-disable-next-line vue/no-v-html -->
                      <span v-html="tr.stage3_manager_comment"></span>
                    </span>
                    <span v-else>No Comment</span>
                  </vs-col>
                </vs-row>
                <vs-row style="padding: 20px 0">
                  <vs-col w="4"> <b>Stage 3 Rejection comment</b> </vs-col>
                  <vs-col w="8" class="description-card">
                    <span v-if="tr.stage3_rejection_comment != null">
                      <!-- eslint-disable-next-line vue/no-v-html -->
                      <span v-html="tr.stage3_rejection_comment"></span>
                    </span>
                    <span v-else>No Comment</span>
                  </vs-col>
                </vs-row>
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
                  <vs-tr v-for="(kpi, j) in tr.kpi_set" :key="j">
                    <vs-td style="padding: 10px">{{ kpi.summary }}</vs-td>
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
        <div class="table-header" style="justify-content: space-between">
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
        <vs-tr v-for="(tr, i) in selectedAppraisal.corevalue_set" :key="i">
          <vs-td>
            {{ tr.summary }}
          </vs-td>
          <vs-td>
            <!-- eslint-disable-next-line vue/no-v-html -->
            <span v-html="tr.description"></span>
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
        <div class="table-header" style="justify-content: space-between">
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
        <vs-tr v-for="(tr, i) in selectedAppraisal.skill_set" :key="i">
          <vs-td>
            {{ tr.summary }}
          </vs-td>
          <vs-td>
            <!-- eslint-disable-next-line vue/no-v-html -->
            <span v-html="tr.description"></span>
          </vs-td>
          <vs-td>
            {{ tr.due }}
          </vs-td>

          <template #expand>
            <div>
              <div class="con-content">
                <vs-button border danger @click="deleteItem('skill', tr.id)">
                  Delete
                </vs-button>
              </div>
            </div>
          </template>
        </vs-tr>
      </template>
    </vs-table>

    <!-- Dialogs -->
    <UpstageAppraisal
      v-if="upstageAppraisal"
      :dialog="upstageAppraisal"
      :selected-appraisal-id="selectedAppraisal.id"
      @close="(upstageAppraisal = false), $emit('refresh')"
    />

    <NewGoalDialog
      v-if="newGoal"
      :dialog="newGoal"
      :selected-appraisal="selectedAppraisal"
      @close="(newGoal = false), $emit('refresh')"
    />

    <NewCoreValueDialog
      v-if="newCoreValue"
      :dialog="newCoreValue"
      :selected-appraisal="selectedAppraisal"
      @close="(newCoreValue = false), $emit('refresh')"
    />

    <NewSkillsDialog
      v-if="newSkill"
      :dialog="newSkill"
      :selected-appraisal="selectedAppraisal"
      @close="(newSkill = false), $emit('refresh')"
    />

    <NewKpiDialog
      v-if="newKpi"
      :dialog="newKpi"
      :selected-goal="selectedGoal"
      @close="(newKpi = false), $emit('refresh')"
    />
  </div>
</template>

<script>
export default {
  name: "Appraisal",
  props: {
    dialog: Boolean,
    // eslint-disable-next-line vue/require-default-prop
    selectedAppraisal: Object,
  },
  data: () => ({
    newGoal: false,
    newCoreValue: false,
    newSkill: false,
    newKpi: false,
    upstageAppraisal: false,
  }),
  methods: {
    deleteItem(item, id) {
      // eslint-disable-next-line no-console
      console.log(item, id);
      this.loading = true;

      this.$axios
        .$delete(`api/${item}/${id}/`, {
          headers: {
            Authorization: `Bearer ${this.$store.state.accessToken}`,
          },
        })
        .then(() => {
          this.$emit("refresh");
          return this.$vs.notification({
            color: "success",
            title: `Successfully deleted ${item}`,
          });
        });
    },
  },
};
</script>

<style>
.description-card {
  padding: 10px;
  background-color: #f4f7f8;
  border-radius: 16px;
}
</style>
