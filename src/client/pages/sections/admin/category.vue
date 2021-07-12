<template>
  <div class="page">
    <h1>Category Management</h1>
    <div v-if="$fetchState.pending"><Spinner /></div>
    <div v-else class="center grid">
      <vs-navbar v-model="activeStage" center-collapsed>
        <vs-navbar-item id="core-value" :active="activeStage == 'core-value'">
          Core Value
        </vs-navbar-item>
        <vs-navbar-item id="goals" :active="activeStage == 'goals'">
          Goals
        </vs-navbar-item>
        <vs-navbar-item id="skills" :active="activeStage == 'skills'">
          Skills
        </vs-navbar-item>
      </vs-navbar>

      <div class="square my-5">
        <vs-table v-if="activeStage == 'core-value'" v-model="selected">
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
              <vs-th> Name </vs-th>
              <vs-th> Type </vs-th>
              <vs-th v-if="$store.state.user.user.is_superuser">
                Company
              </vs-th>
              <vs-th> Id </vs-th>
            </vs-tr>
          </template>
          <template #tbody>
            <vs-tr
              v-for="(tr, i) in $vs.getSearch(coreValueList, search)"
              :key="`core${i}`"
              :data="tr"
              :is-selected="selected == tr"
              class="data-2"
            >
              <vs-td>
                {{ tr.name }}
              </vs-td>
              <vs-td> Core Values </vs-td>
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
                      @click="
                        (editActive = true), (selectedType = 'core_value')
                      "
                    >
                      <i class="bx bx-edit-alt"></i>
                    </vs-button>
                    <vs-button border danger @click="deleteCategory(tr.id)">
                      Delete category
                    </vs-button>
                  </div>
                </div>
              </template>
            </vs-tr>
          </template>
        </vs-table>

        <vs-table v-if="activeStage == 'goals'" v-model="selected">
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
              <vs-th> Name </vs-th>
              <vs-th> Type </vs-th>
              <vs-th v-if="$store.state.user.user.is_superuser">
                Company
              </vs-th>
              <vs-th> Id </vs-th>
            </vs-tr>
          </template>
          <template #tbody>
            <vs-tr
              v-for="(tr, i) in $vs.getSearch(goalList, search)"
              :key="`goal${i}`"
              :data="tr"
              :is-selected="selected == tr"
            >
              <vs-td>
                {{ tr.name }}
              </vs-td>
              <vs-td> Goals </vs-td>
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
                      @click="(editActive = true), (selectedType = 'goal')"
                    >
                      <i class="bx bx-edit-alt"></i>
                    </vs-button>
                    <vs-button border danger @click="deleteCategory(tr.id)">
                      Delete category
                    </vs-button>
                  </div>
                </div>
              </template>
            </vs-tr>
          </template>
        </vs-table>

        <vs-table v-if="activeStage == 'skills'" v-model="selected">
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
              <vs-th> Name </vs-th>
              <vs-th> Type </vs-th>
              <vs-th v-if="$store.state.user.user.is_superuser">
                Company
              </vs-th>
              <vs-th> Id </vs-th>
            </vs-tr>
          </template>
          <template #tbody>
            <vs-tr
              v-for="(tr, i) in $vs.getSearch(skillList, search)"
              :key="`skill${i}`"
              :data="tr"
              :is-selected="selected == tr"
            >
              <vs-td>
                {{ tr.name }}
              </vs-td>
              <vs-td> Skills </vs-td>
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
                      @click="(editActive = true), (selectedType = 'skills')"
                    >
                      <i class="bx bx-edit-alt"></i>
                    </vs-button>
                    <vs-button border danger @click="deleteCategory(tr.id)">
                      Delete category
                    </vs-button>
                  </div>
                </div>
              </template>
            </vs-tr>
          </template>
        </vs-table>
      </div>
    </div>

    <v-tour name="myTour" :steps="steps"></v-tour>

    <!-- Dialogs -->
    <NewCategoryDialog
      v-if="newActive"
      :dialog="newActive"
      :company-list="companyList"
      @close="(newActive = false), $fetch()"
    />

    <EditCategoryDialog
      v-if="editActive"
      :dialog="editActive"
      :selected-category="selected"
      :selected-category-type="selectedType"
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
    selectedType: "",
    activeStage: "core-value",

    companyList: [],
    coreValueList: [],
    goalList: [],
    skillList: [],
    steps: [
      {
        target: ".page", // We're using document.querySelector() under the hood
        header: {
          title: "Get Started",
        },
        content: `Welcome to PMS Onboarding `,
        params: {
          placement: "top",
        },
      },
      {
        target: ".data-1",
        header: {
          title: "Adding Category",
        },
        content:
          "Use this button to add category for goal, core values and skills",
        params: {
          placement: "top",
        },
      },
      {
        target: ".data-2",
        header: {
          title: "Editing Category",
        },
        content:
          "Click on an item to expand it and reveal more options like edit and delete",
        params: {
          placement: "top",
        },
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

      this.coreValueList = await this.$axios.$get(`api/category/core_value/`, {
        headers: {
          Authorization: `Bearer ${this.$store.state.accessToken}`,
        },
      });

      this.goalList = await this.$axios.$get(`api/category/goal/`, {
        headers: {
          Authorization: `Bearer ${this.$store.state.accessToken}`,
        },
      });

      this.skillList = await this.$axios.$get(`api/category/skills/`, {
        headers: {
          Authorization: `Bearer ${this.$store.state.accessToken}`,
        },
      });
    } catch (err) {
      return this.$vs.notification({
        color: "danger",
        title: "Error fetching categories",
      });
    }
  },
  methods: {
    deleteCategory(id) {
      if (!this.loading) {
        this.loading = true;

        this.$axios
          .$delete(`api/category/${this.selectedType}/${id}/`, {
            headers: {
              Authorization: `Bearer ${this.$store.state.accessToken}`,
            },
          })
          .then(() => this.$fetch())
          .catch(() => {
            this.loading = false;
            return this.$vs.notification({
              color: "danger",
              title: "Error deleting category",
            });
          });
      }
    },
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
