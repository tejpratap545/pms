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

      <vs-sidebar-item
        v-if="$store.state.user.user.is_superuser"
        id="company"
        to="/sections/company"
      >
        <template #icon>
          <i class="bx bx-building"></i>
        </template>
        Company Management
      </vs-sidebar-item>

      <vs-sidebar-item
        v-if="!$store.state.user.user.is_superuser"
        id="appraisals"
        to="/sections/my-appraisals"
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

      <vs-sidebar-item id="employee-managment" to="/sections/employee">
        <template #icon>
          <i class="bx bx-group"></i>
        </template>
        Employee Management
      </vs-sidebar-item>

      <vs-sidebar-item id="appraisal-managment" to="/sections/appraisals">
        <template #icon>
          <i class="bx bx-list-check"></i>
        </template>
        Appraisal Management
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
          <vs-avatar>
            <img
              src="https://randomuser.me/api/portraits/women/83.jpg"
              alt=""
            />
          </vs-avatar>
        </vs-row>
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
  }),
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
</style>
