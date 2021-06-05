<template>
  <div class="hidden">
    <vs-sidebar v-model="active" absolute reduce open>
      <template #logo>
        <img src="~/assets/img/icon.png" />
      </template>

      <vs-sidebar-item id="home" to="/">
        <template #icon>
          <i class="bx bx-home"></i>
        </template>
        Home
      </vs-sidebar-item>

      <vs-sidebar-group
        v-if="
          $store.state.user.user.is_superuser || $store.state.user.user.is_admin
        "
      >
        <template #header>
          <vs-sidebar-item arrow>
            <template #icon> <i class="bx bx-user-pin"></i> </template>
            Admin
          </vs-sidebar-item>
        </template>

        <vs-sidebar-item id="admin-department" to="/sections/admin/department">
          <template #icon>
            <i class="bx bx-tag-alt"></i>
          </template>
          Department Management
        </vs-sidebar-item>

        <vs-sidebar-item id="admin-company" to="/sections/admin/company">
          <template #icon>
            <i class="bx bx-building"></i>
          </template>
          Company Management
        </vs-sidebar-item>

        <vs-sidebar-item id="admin-appraisals" to="/sections/admin/appraisals">
          <template #icon>
            <i class="bx bx-list-check"></i>
          </template>
          Appraisal Management
        </vs-sidebar-item>
      </vs-sidebar-group>

      <vs-sidebar-item
        v-if="!$store.state.user.user.is_superuser"
        id="my-appraisals"
        to="/sections/appraisals"
      >
        <template #icon>
          <i class="bx bx-message-square-dots"></i>
        </template>
        Appraisals
      </vs-sidebar-item>

      <vs-sidebar-item
        v-if="!$store.state.user.user.is_superuser"
        id="department"
        to="/sections/department"
      >
        <template #icon>
          <i class="bx bx-building-house"></i>
        </template>
        Department
      </vs-sidebar-item>

      <vs-sidebar-item id="employee" to="/sections/employee">
        <template #icon>
          <i class="bx bx-group"></i>
        </template>
        Employee Management
      </vs-sidebar-item>

      <vs-sidebar-item
        v-if="!$store.state.user.user.is_superuser"
        id="records"
        to="/sections/records"
      >
        <template #icon>
          <i class="bx bx-data"></i>
        </template>
        Records
      </vs-sidebar-item>

      <template #footer>
        <vs-row justify="center">
          <vs-button icon @click="tutorialActive != tutorialActive">
            <i class="bx bx-help-circle"></i>
          </vs-button>

          <vs-avatar>
            <img
              :src="
                $store.state.user.avatar
                  ? $store.state.user.avatar
                  : `https://avatars.dicebear.com/api/jdenticon/${$store.state.user.user.email}.svg`
              "
              alt="profile picture"
            />
          </vs-avatar>
        </vs-row>
      </template>
    </vs-sidebar>

    <div>
      <Nuxt />
    </div>

    <!--Dialogs -->

    <vs-dialog v-model="tutorialActive" width="550px" not-center>
      <template #header>
        <h2 class="not-margin">PMS <b>Navigation</b></h2>
      </template>

      <div class="con-tutorials">
        <div class="tutorial-item">
          <p>Create new <b>Company</b></p>
          <vs-button @click="companyCreateTutorial"> Start </vs-button>
        </div>
        <div class="tutorial-item"></div>
        <div class="tutorial-item"></div>
        <div class="tutorial-item"></div>
      </div>
    </vs-dialog>
  </div>
</template>

<script>
export default {
  data: () => ({
    active: "home",
    tutorialActive: false,
  }),
  mounted() {
    this.active = location.pathname.split("/").pop();
  },
  methods: {
    companyCreateTutorial() {
      this.tutorialActive = false;
      this.$router.replace("/sections/company");

      // console.log(document.querySelector("#newCompanyButton"));
      // console.log(this.$tours.companyCreateTour);

      this.$tours.companyCreateTour.start();
    },
  },
};
</script>

<style>
html {
  font-family: "Source Sans Pro", -apple-system, BlinkMacSystemFont, "Segoe UI",
    Roboto, "Helvetica Neue", Arial, sans-serif;
  font-size: 16px;
  word-spacing: 1px;
  -ms-text-size-adjust: 100%;
  -webkit-text-size-adjust: 100%;
  -moz-osx-font-smoothing: grayscale;
  -webkit-font-smoothing: antialiased;
  box-sizing: border-box;
}

*,
*::before,
*::after {
  box-sizing: border-box;
  margin: 0;
}

.button--green {
  display: inline-block;
  border-radius: 4px;
  border: 1px solid #3b8070;
  color: #3b8070;
  text-decoration: none;
  padding: 10px 30px;
}

.button--green:hover {
  color: #fff;
  background-color: #3b8070;
}

.button--grey {
  display: inline-block;
  border-radius: 4px;
  border: 1px solid #35495e;
  color: #35495e;
  text-decoration: none;
  padding: 10px 30px;
  margin-left: 15px;
}

.button--grey:hover {
  color: #fff;
  background-color: #35495e;
}

.con-tutorials .tutorial-item {
  display: flex;
  justify-content: space-between;
  margin-left: 10px;
}
</style>
