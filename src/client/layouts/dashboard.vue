<template>
  <div class="hidden">
    <vs-sidebar v-model="active" :reduce="reduce" square open>
      <template #logo>
        <vs-button
          style="margin-left: 10px"
          icon
          flat
          @click="reduce = !reduce"
        >
          <i class="bx bx-menu-alt-left"></i>
        </vs-button>
      </template>

      <div v-if="!reduce" class="hero-image">
        <img src="~/assets/img/icon.png" class="hero" alt="hero" />
      </div>

      <vs-sidebar-item id="home" to="/">
        <template #icon>
          <i class="bx bx-home"></i>
        </template>
        Home
      </vs-sidebar-item>

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

        <vs-sidebar-item id="admin-category" to="/sections/admin/category">
          <template #icon>
            <i class="bx bx-library"></i>
          </template>
          Category Management
        </vs-sidebar-item>

        <vs-sidebar-item id="admin-department" to="/sections/admin/department">
          <template #icon>
            <i class="bx bx-tag-alt"></i>
          </template>
          Department Management
        </vs-sidebar-item>

        <vs-sidebar-item
          v-if="$store.state.user.user.is_superuser"
          id="admin-company"
          to="/sections/admin/company"
        >
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

        <vs-sidebar-item id="admin-employee" to="/sections/admin/employee">
          <template #icon>
            <i class="bx bx-group"></i>
          </template>
          Employee Management
        </vs-sidebar-item>

        <vs-sidebar-item id="admin-roles" to="/sections/admin/roles">
          <template #icon>
            <i class="bx bxs-user-badge"></i>
          </template>
          Roles Management
        </vs-sidebar-item>
      </vs-sidebar-group>

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
        <vs-switch v-model="active2" @click="ChangeTheme">
          <i v-if="!active2" class="bx bxs-sun"></i>
          <i v-else class="bx bxs-moon"></i>
        </vs-switch>
      </template>
    </vs-sidebar>

    <div>
      <Nuxt />
    </div>
  </div>
</template>

<script>
export default {
  data: () => ({
    active: "home",
    active2: false,
    reduce: true,
  }),
  mounted() {
    this.active = location.pathname.split("/").pop();
  },
  methods: {
    ChangeTheme() {
      this.$vs.toggleTheme();
      if (this.active2) {
        document.body.classList.add("darken");
      } else {
        document.body.classList.remove("darken");
      }
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

.hero-image {
  display: flex;
  justify-content: center;
  width: 100%;
}

.hero-image img {
  height: 100px;
}

body.darken {
  background: #1e2023;
}
</style>
