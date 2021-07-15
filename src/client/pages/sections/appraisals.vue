<template>
  <div class="page">
    <h1>My Appraiasal Management</h1>
    <div v-if="$fetchState.pending"><Spinner /></div>
    <div v-else class="center grid">
      <div class="appraisal-lists">
        <h3>My Appraisals</h3>
        <div
          v-for="a in appraisalList"
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
        <div class="mobile-appraisal-select" style="display: none">
          <vs-select
            v-model="selectedAppraisalId"
            placeholder="Select Appraisal"
            style="margin-bottom: 10px; width: 100%"
            block
            filter
          >
            <vs-option
              v-for="a in appraisalList"
              :key="a.id"
              :label="a.name"
              :value="a.id"
              @click="() => (selectedAppraisal = a)"
            >
              {{ a.name }}
            </vs-option>
          </vs-select>
        </div>
        <div v-if="currentAppraisal != null" class="appraisal-item-open">
          <div class="appraisal-item">
            <div>
              <vs-row class="my-5 pa-2">
                <vs-col w="4"> <b>Status</b> </vs-col>
                <vs-col w="8" style="display: flex; justify-content: flex-end">
                  <i> {{ getStatus(status, stage) }} </i>
                </vs-col>
              </vs-row>
              <vs-row class="my-5 pa-2">
                <vs-col w="4"> <b>Actions</b> </vs-col>
                <vs-col w="8" style="display: flex; justify-content: flex-end">
                  <vs-button
                    v-if="stage == 0 && status == 0"
                    @click="goalSubmit = true"
                  >
                    Submit Goals
                  </vs-button>
                  <vs-button
                    v-if="stage == 1 && status == 2"
                    @click="midyearReview = true"
                  >
                    Midyear Review
                  </vs-button>
                  <vs-button
                    v-if="stage == 1 && status == 3"
                    @click="midyearReview = true"
                  >
                    Edit Midyear Review
                  </vs-button>
                  <vs-button
                    v-if="stage == 1 && status == 3"
                    @click="submitMidyearReview = true"
                  >
                    Submit Midyear Review
                  </vs-button>
                  <vs-button
                    v-if="stage == 2 && status == 6"
                    @click="endyearReview = true"
                  >
                    EndYear Review
                  </vs-button>
                  <vs-button
                    v-if="stage == 2 && status == 7"
                    @click="endyearReview = true"
                  >
                    Edit End Year Review
                  </vs-button>
                  <vs-button
                    v-if="stage == 2 && status == 7"
                    @click="submitEndyearReview = true"
                  >
                    Submit End Year Review
                  </vs-button>
                  <vs-button icon :to="`/print?id=${selectedAppraisal.id}`">
                    <i class="bx bx-printer"></i>
                  </vs-button>
                  <vs-button icon @click="$tours.myTour.start()">
                    <i class="bx bx-help-circle"></i>
                  </vs-button>
                </vs-col>

                <!-- TO-DO Place this status at right position -->
              </vs-row>
            </div>

            <Appraisal
              :edit="true"
              :appraisal="currentAppraisal"
              @refresh="$fetch()"
            />
          </div>
        </div>
        <div v-else>
          <h2>No Appraisals</h2>
        </div>
      </div>
    </div>

    <v-tour name="myTour" :steps="steps"></v-tour>

    <!-- Dialogs -->

    <ASubmitGoal
      v-if="goalSubmit"
      :dialog="goalSubmit"
      :edit="false"
      :appraisal="currentAppraisal"
      @close="(goalSubmit = false), $fetch()"
    />
    <CMidEmployeeReview
      v-if="midyearReview"
      :dialog="midyearReview"
      :edit="false"
      :appraisal="currentAppraisal"
      @close="(midyearReview = false), $fetch()"
    />
    <DMidEmployeeSubmit
      v-if="submitMidyearReview"
      :dialog="submitMidyearReview"
      :edit="false"
      :appraisal="currentAppraisal"
      @close="(submitMidyearReview = false), $fetch()"
    />
    <GEndEmployeeReview
      v-if="endyearReview"
      :dialog="endyearReview"
      :edit="false"
      :appraisal="currentAppraisal"
      @close="(endyearReview = false), $fetch()"
    />
    <HEndEmployeeSubmit
      v-if="submitEndyearReview"
      :dialog="submitEndyearReview"
      :edit="false"
      :appraisal="currentAppraisal"
      @close="(submitEndyearReview = false), $fetch()"
    />
  </div>
</template>

<script>
import global from "~/mixins/global";
export default {
  mixins: [global],
  layout: "dashboard",
  middleware: ["auth"],
  data: () => ({
    loading: false,
    appraisalList: [],
    selectedGoal: {},
    selectedAppraisal: null,
    selectedAppraisalId: 0,
    upstageAppraisal: false,
    goalSubmit: false,
    midyearReview: false,
    endyearReview: false,
    submitMidyearReview: false,
    submitEndyearReview: false,
    steps: [
      {
        target: ".appraisal-item-open", // We're using document.querySelector() under the hood
        header: {
          title: "Get Started",
        },
        content: `Welcome to PMS Onboarding `,
        params: {
          placement: "left",
        },
      },
    ],
  }),
  async fetch() {
    try {
      this.appraisalList = await this.$axios.$get(`api/appraisal/me`, {
        headers: {
          Authorization: `Bearer ${this.$store.state.accessToken}`,
        },
      });

      if (this.appraisalList.length !== 0)
        this.selectedAppraisal = this.appraisalList[0];
    } catch (err) {
      return this.$vs.notification({
        color: "danger",
        title: "Error fetching appriasals",
      });
    }
  },
  computed: {
    currentAppraisal() {
      return this.selectedAppraisalId === 0
        ? this.selectedAppraisal
        : this.appraisalList.find((x) => x.id === this.selectedAppraisalId);
    },
    status() {
      return this.currentAppraisal ? this.currentAppraisal.status : null;
    },
    stage() {
      return this.currentAppraisal
        ? this.currentAppraisal.overall_appraisal.stage
        : null;
    },
  },
  /* mounted() {
    try {
      if (localStorage.getItem("selectedAppraisal") != null)
        this.selectedAppraisal = JSON.parse(
          localStorage.getItem("selectedAppraisal")
        );
    } catch (e) {
      // eslint-disable-next-line no-console
      console.log(e);
    }
  },
  */
};
</script>

<style>
.appraisal-grid {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
}

.mobile-appraisal-select {
  width: 100%;
}

.appraisal-lists {
  width: 330px;
  position: fixed;
  height: 100%;
  background: rgb(255 255 255 / 15%);
  left: 0;
  top: 0;
  padding-left: 75px;
  box-shadow: 0px 0px 25px 0px rgba(0, 0, 0, var(--vs-shadow-opacity));
}

.appraisal-lists > h3 {
  text-align: center;
  margin: 50px 0;
}

.appraisal-lists > .appraisal-list-item {
  padding: 10px;
  background: rgb(255 255 255 / 15%);
  border-radius: 8px;
  margin-right: 20px;
  margin-bottom: 10px;
  opacity: 0.7;
  text-align: center;
  overflow: hidden;
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
  background: rgb(255 255 255 / 15%);
  box-shadow: 0px 0px 25px 0px rgba(0, 0, 0, var(--vs-shadow-opacity));
  border-radius: 16px;
  padding: 30px;
}

.appraisal-property {
  display: flex;
}

.appraisal-item-open {
  max-width: 1200px;
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
  .appraisal-item-open {
    margin-left: unset;
  }

  .appraisal-lists {
    display: none;
  }

  .mobile-appraisal-select {
    display: block;
  }
}
</style>
