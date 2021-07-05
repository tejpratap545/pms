<template>
  <div>
    <div v-if="$fetchState.pending"><Spinner /></div>
    <div v-else class="center">
      <div style="background-color: #eee">
        <div
          style="
            width: 1200px;
            background-color: #fff;
            margin: 0 auto;
            padding: 20px;
            box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
            min-height: 100vh;
          "
        >
          <vs-row>
            <vs-col w="10"></vs-col>
            <vs-col w="2">
              <vs-button> Print to PDF </vs-button>
            </vs-col>
          </vs-row>

          <h1>{{ appraisal.name }}</h1>

          <h2 style="margin-top: 50px">Goals</h2>
          <table style="margin-top: 20px">
            <tr>
              <th>Summary</th>
              <th>Weightage</th>
              <th>KPI Count</th>
              <th>Due</th>
            </tr>

            <tr v-for="(tr, i) in appraisal.goal_set" :key="i">
              <td>
                {{ tr.summary }}
              </td>
              <td>
                {{ tr.weightage }}
              </td>
              <td>
                {{ tr.kpi_set.length }}
              </td>
              <td>
                {{ tr.due }}
              </td>
            </tr>
          </table>

          <h2 style="margin-top: 50px">Core values</h2>
          <table style="margin-top: 20px">
            <tr>
              <th>Summary</th>
              <th>Description</th>
              <th>Due</th>
            </tr>

            <tr v-for="(tr, i) in appraisal.goal_set" :key="i">
              <td>
                {{ tr.summary }}
              </td>
              <td>
                <!-- eslint-disable-next-line vue/no-v-html -->
                <span v-html="tr.description"></span>
              </td>
              <td>
                {{ tr.due }}
              </td>
            </tr>
          </table>

          <h2 style="margin-top: 50px">Skills</h2>
          <table style="margin-top: 20px">
            <tr>
              <th>Summary</th>
              <th>Description</th>
              <th>Due</th>
            </tr>

            <tr v-for="(tr, i) in appraisal.skill_set" :key="i">
              <td>
                {{ tr.summary }}
              </td>
              <td>
                <!-- eslint-disable-next-line vue/no-v-html -->
                <span v-html="tr.description"></span>
              </td>
              <td>
                {{ tr.due }}
              </td>
            </tr>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data: () => ({
    appraisal: {},
  }),
  async fetch() {
    const id = this.$route.query.id;
    this.appraisal = await this.$axios.$get(`/api/appraisal/${id}/`);
  },
};
</script>

<style>
table {
  width: 100%;
}

th,
td {
  text-align: center;
  border: 2px solid #000;
}
</style>
