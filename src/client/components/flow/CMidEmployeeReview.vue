<template>
  <vs-dialog
    v-model="active"
    :loading="loading"
    scroll
    overflow-hidden
    not-close
    prevent-close
  >
    <template #header>
      <h4 class="not-margin">Midyear <b>Review</b></h4>

      <vs-button class="closeDialogButton" icon floating @click="closeDialog">
        <i class="bx bx-x"></i>
      </vs-button>
    </template>

    <!-- <div v-if="$fetchState.pending"><Spinner /></div> -->
    <div class="con-form">
      <EmployeeInfo :employee="selectedAppraisal.employee" />
      <vs-table class="my-5">
        <template #header>
          <div class="table-header" style="justify-content: space-between">
            <h3>Goals</h3>
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
                      <b>Tracing status</b>
                    </vs-col>
                    <vs-col w="8" class="description-card">
                      <vs-select
                        v-if="trackingStatusList.length != 0"
                        v-model="tr.tracking_status"
                        block
                        filter
                      >
                        <vs-option
                          v-for="(status, index) in trackingStatusList"
                          :key="index"
                          :label="status"
                          :value="status"
                        >
                          {{ status }}
                        </vs-option>
                      </vs-select>
                    </vs-col>
                  </vs-row>

                  <vs-row style="padding: 20px 0">
                    <vs-col w="4">
                      <b>Midyear employee component</b>
                    </vs-col>
                    <vs-col w="8" class="description-card">
                      <Editor
                        :data="tr.stage1_employee_comment"
                        @changeData="
                          (value) => (tr.stage1_employee_comment = value)
                        "
                      />
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
    </div>

    <template #footer>
      <div class="footer-dialog">
        <vs-button :loading="loading" block @click="submit">
          Submit Review
        </vs-button>
      </div>
    </template>
  </vs-dialog>
</template>

<script>
export default {
  props: {
    dialog: Boolean,
    // eslint-disable-next-line vue/require-default-prop
    selectedAppraisal: Object,
    edit: {
      type: Boolean,
      default: false,
    },
  },
  data: () => ({
    active: false,
    loading: false,
    trackingStatusList: ["null", "On Track", "Not On Track"],
  }),

  mounted() {
    this.active = this.dialog;
  },
  methods: {
    patchGoals() {
      this.selectedAppraisal.goal_set.forEach(async (goal) => {
        await this.$axios.patch(`api/goal/${goal.id}/`, {
          stage1_employee_comment: goal.stage1_employee_comment,
          tracking_status: goal.tracking_status,
        });
      });
    },

    submit() {
      this.loading = true;
      this.patchGoals();

      this.$axios
        .$post(
          `api/appraisal/${this.selectedAppraisal.id}/up-stage/employee/mid-review/`,
          {},
          {
            headers: {
              Authorization: `Bearer ${this.$store.state.accessToken}`,
            },
          }
        )
        .then(() => {
          this.$vs.notification({
            color: "success",
            title: `"Sucessfullly review appraisal ${this.selectedAppraisal.name} . Please Confirm or Edit review  and then Submit"`,
          });
          this.closeDialog();
        })
        .catch(() => {
          return this.$vs.notification({
            color: "danger",
            title: `"Error review mid year appraisal ${this.selectedAppraisal.name}."`,
          });
        })
        .finally(() => {
          this.loading = false;
        });
    },
    closeDialog() {
      this.$emit("close");
    },
  },
};
</script>
