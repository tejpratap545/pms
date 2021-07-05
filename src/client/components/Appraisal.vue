<template>
  <div>
    <vs-table v-model="selected" class="my-5">
      <template #header>
        <div class="table-header" style="justify-content: space-between">
          <h3>Goals</h3>
          <vs-button v-if="CanEdit" @click="newGoal = true"> Add </vs-button>
        </div>
      </template>
      <template #thead>
        <vs-tr>
          <vs-th> Summary </vs-th>
          <vs-th> Weightage </vs-th>
          <vs-th> KPI Count </vs-th>
          <vs-th> Due </vs-th>
          <vs-th>Status</vs-th>
        </vs-tr>
      </template>
      <template #tbody>
        <vs-tr
          v-for="(tr, i) in selectedAppraisal.goal_set"
          :key="i"
          :data="tr"
          :is-selected="selected == tr"
        >
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
          <vs-td>
            <!-- TO-DO  Add icons here  -->
            <span v-if="tr.status == 1"> approved</span>
            <span v-else-if="tr.status == -1"> rejected</span>
            <span v-else> No action</span>
          </vs-td>

          <template #expand>
            <div>
              <div class="con-content">
                <vs-button
                  v-if="CanEdit"
                  color="success"
                  flat
                  icon
                  @click="editGoal = true"
                >
                  <i class="bx bx-edit-alt"></i>
                </vs-button>
                <vs-button
                  v-if="CanEdit"
                  border
                  danger
                  @click="deleteItem('goal', tr.id)"
                >
                  Delete
                </vs-button>
                <vs-button
                  v-if="goalApprove"
                  border
                  success
                  @click="(goalApproveDialog = true), (selectedGoal = tr)"
                >
                  Approve Or Reject Goal
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
                  <vs-col w="4">
                    <b>Goal setting stage employee comment</b>
                  </vs-col>
                  <vs-col w="8" class="description-card">
                    <span v-if="tr.stage1_employee_comment != null">
                      <!-- eslint-disable-next-line vue/no-v-html -->
                      <span v-html="tr.stage1_employee_comment"></span>
                    </span>
                    <span v-else>No Comment</span>
                  </vs-col>
                </vs-row>
                <vs-row style="padding: 20px 0">
                  <vs-col w="4">
                    <b>Goal setting stage manager comment</b>
                  </vs-col>
                  <vs-col w="8" class="description-card">
                    <span v-if="tr.stage1_manager_comment != null">
                      <!-- eslint-disable-next-line vue/no-v-html -->
                      <span v-html="tr.stage1_manager_comment"></span>
                    </span>
                    <span v-else>No Comment</span>
                  </vs-col>
                </vs-row>
                <vs-row
                  v-if="tr.stage1_rejection_comment != null"
                  style="padding: 20px 0"
                >
                  <vs-col w="4">
                    <b>Goal setting stage rejection comment</b>
                  </vs-col>
                  <vs-col w="8" class="description-card">
                    <!-- eslint-disable-next-line vue/no-v-html -->
                    <span v-html="tr.stage1_rejection_comment"></span>
                  </vs-col>
                </vs-row>
                <vs-row style="padding: 20px 0">
                  <vs-col w="4"> <b>Mid year employee comment</b> </vs-col>
                  <vs-col w="8" class="description-card">
                    <span v-if="tr.stage2_employee_comment != null">
                      <!-- eslint-disable-next-line vue/no-v-html -->
                      <span v-html="tr.stage2_employee_comment"></span>
                    </span>
                    <span v-else>No Comment</span>
                  </vs-col>
                </vs-row>
                <vs-row style="padding: 20px 0">
                  <vs-col w="4"> <b>Mid year manager comment</b> </vs-col>
                  <vs-col w="8" class="description-card">
                    <span v-if="tr.stage2_manager_comment != null">
                      <!-- eslint-disable-next-line vue/no-v-html -->
                      <span v-html="tr.stage2_manager_comment"></span>
                    </span>
                    <span v-else>No Comment</span>
                  </vs-col>
                </vs-row>
                <vs-row
                  v-if="tr.stage2_rejection_comment != null"
                  style="padding: 20px 0"
                >
                  <vs-col w="4"> <b>Mid year rejection comment</b> </vs-col>
                  <vs-col w="8" class="description-card">
                    <!-- eslint-disable-next-line vue/no-v-html -->
                    <span v-html="tr.stage2_rejection_comment"></span>
                  </vs-col>
                </vs-row>
                <vs-row style="padding: 20px 0">
                  <vs-col w="4"> <b>End year employee comment</b> </vs-col>
                  <vs-col w="8" class="description-card">
                    <span v-if="tr.stage3_employee_comment != null">
                      <!-- eslint-disable-next-line vue/no-v-html -->
                      <span v-html="tr.stage3_employee_comment"></span>
                    </span>
                    <span v-else>No Comment</span>
                  </vs-col>
                </vs-row>
                <vs-row style="padding: 20px 0">
                  <vs-col w="4"> <b>End year manager comment</b> </vs-col>
                  <vs-col w="8" class="description-card">
                    <span v-if="tr.stage3_manager_comment != null">
                      <!-- eslint-disable-next-line vue/no-v-html -->
                      <span v-html="tr.stage3_manager_comment"></span>
                    </span>
                    <span v-else>No Comment</span>
                  </vs-col>
                </vs-row>
                <vs-row
                  v-if="tr.stage3_rejection_comment != null"
                  style="padding: 20px 0"
                >
                  <vs-col w="4"> <b>End year rejection comment</b> </vs-col>
                  <vs-col w="8" class="description-card">
                    <!-- eslint-disable-next-line vue/no-v-html -->
                    <span v-html="tr.stage3_rejection_comment"></span>
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
                      v-if="CanEdit"
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
    <vs-table v-model="selected" class="my-5">
      <template #header>
        <div class="table-header" style="justify-content: space-between">
          <h3>Core values</h3>
          <vs-button v-if="CanEdit" @click="newCoreValue = true">
            Add
          </vs-button>
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
          :data="tr"
          :is-selected="selected == tr"
        >
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
              <div v-if="CanEdit" class="con-content">
                <vs-button
                  color="success"
                  flat
                  icon
                  @click="editCoreValue = true"
                >
                  <i class="bx bx-edit-alt"></i>
                </vs-button>
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
    <vs-table v-model="selected" class="my-5">
      <template #header>
        <div class="table-header" style="justify-content: space-between">
          <h3>Skills</h3>
          <vs-button v-if="CanEdit" @click="newSkill = true"> Add </vs-button>
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
          :data="tr"
          :is-selected="selected == tr"
        >
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
              <div v-if="CanEdit" class="con-content">
                <vs-button color="success" flat icon @click="editSkill = true">
                  <i class="bx bx-edit-alt"></i>
                </vs-button>
                <vs-button border danger @click="deleteItem('skill', tr.id)">
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
          <h3>Department goals</h3>
        </div>
      </template>
      <template #thead>
        <vs-tr>
          <vs-th> Summary </vs-th>
          <vs-th> Category </vs-th>
          <vs-th> Manager </vs-th>
          <vs-th> Description </vs-th>
          <vs-th> Due </vs-th>
        </vs-tr>
      </template>
      <template #tbody>
        <vs-tr
          v-for="(tr, i) in selectedAppraisal.overall_appraisal
            .departmentalgoal_set"
          :key="i"
        >
          <vs-td>
            {{ tr.summary }}
          </vs-td>
          <vs-td>
            {{ tr.category.name }}
          </vs-td>
          <vs-td>
            {{ tr.manager.name }}
          </vs-td>
          <vs-td>
            <!-- eslint-disable-next-line vue/no-v-html -->
            <span v-html="tr.description"></span>
          </vs-td>
          <vs-td>
            {{ tr.due }}
          </vs-td>
        </vs-tr>
      </template>
    </vs-table>
    <vs-table class="my-5">
      <template #header>
        <div class="table-header" style="justify-content: space-between">
          <h3>Department corevalues</h3>
        </div>
      </template>
      <template #thead>
        <vs-tr>
          <vs-th> Summary </vs-th>
          <vs-th> Category </vs-th>
          <vs-th> Manager </vs-th>
          <vs-th> Description </vs-th>
          <vs-th> Due </vs-th>
        </vs-tr>
      </template>
      <template #tbody>
        <vs-tr
          v-for="(tr, i) in selectedAppraisal.overall_appraisal
            .departmentalcorevalue_set"
          :key="i"
        >
          <vs-td>
            {{ tr.summary }}
          </vs-td>
          <vs-td>
            {{ tr.category.name }}
          </vs-td>
          <vs-td>
            {{ tr.manager.name }}
          </vs-td>
          <vs-td>
            <!-- eslint-disable-next-line vue/no-v-html -->
            <span v-html="tr.description"></span>
          </vs-td>
          <vs-td>
            {{ tr.due }}
          </vs-td>
        </vs-tr>
      </template>
    </vs-table>

    <!-- Dialogs -->

    <EditGoalDialog
      v-if="editGoal"
      :dialog="editGoal"
      :selected-goal="selected"
      @close="(editGoal = false), $emit('refresh')"
    />

    <EditCoreValueDialog
      v-if="editCoreValue"
      :dialog="editCoreValue"
      :selected-corevalue="selected"
      @close="(editCoreValue = false), $emit('refresh')"
    />

    <EditSkillsDialog
      v-if="editSkill"
      :dialog="editSkill"
      :selected-corevalue="selected"
      @close="(editSkill = false), $emit('refresh')"
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

    <ApproveGoal
      v-if="goalApproveDialog"
      :dialog="goalApproveDialog"
      :goal="selectedGoal"
      @close="(goalApproveDialog = false), $emit('refresh')"
    />
  </div>
</template>

<script>
export default {
  name: "Appraisal",
  props: {
    dialog: Boolean,
    expanded: Boolean,
    // eslint-disable-next-line vue/require-default-prop
    selectedAppraisal: Object,
    edit: {
      type: Boolean,
      default: false,
    },
    goalApprove: {
      type: Boolean,
      default: false,
    },
  },
  data: () => ({
    selected: {},
    newGoal: false,
    newCoreValue: false,
    newSkill: false,
    newKpi: false,
    editGoal: false,
    editCoreValue: false,
    editSkill: false,
    goalApproveDialog: false,
  }),
  computed: {
    user() {
      return this.$store.state.user;
    },
    CanEdit() {
      if (
        this.edit === true &&
        this.selectedAppraisal.employee.id === this.user.id &&
        this.selectedAppraisal.status === 0 &&
        this.selectedAppraisal.overall_appraisal.stage === 0
      ) {
        return true;
      } else {
        return false;
      }
    },
  },

  methods: {
    deleteItem(item, id) {
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
