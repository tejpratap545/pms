<template>
  <div class="app">
    <vs-dialog v-model="active" class="dialog" not-close prevent-close>
      <template #header>
        <h4 class="not-margin">Login to <b>Denselight</b></h4>
      </template>

      <div class="con-form">
        <vs-input v-model="username">
          <template #icon> @ </template>
        </vs-input>
        <vs-input v-model="password" type="password">
          <template #icon>
            <i class="bx bxs-lock"></i>
          </template>
        </vs-input>
        <div class="flex">
          <vs-checkbox v-model="remember">Remember me</vs-checkbox>
          <a href="#">Forgot Password?</a>
        </div>
      </div>

      <template #footer>
        <div class="footer-dialog">
          <vs-button block :loading="loading" @click="login">
            Sign In
          </vs-button>

          <div class="new">New Here? <a href="#">Create New Account</a></div>
        </div>
      </template>
    </vs-dialog>
  </div>
</template>

<script>
export default {
  middleware({ store, redirect }) {
    if (store.state.isAuthenticate) {
      return redirect("/");
    }
  },
  data: () => ({
    active: true,
    username: "",
    password: "",
    remember: false,
    loading: false,
  }),
  methods: {
    login() {
      if (!this.loading) {
        this.loading = true;

        fetch("/api/login", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },

          body: JSON.stringify({
            username: this.username,
            password: this.password,
          }),
        })
          .then(() => location.reload())
          // eslint-disable-next-line no-console
          .catch((err) => console.log(err));
      }
    },
  },
};
</script>

<style>
.app {
  background: url(~/assets/img/background.jpg);
  background-size: cover;
  width: 100%;
  height: 100%;
  position: absolute;
}

a {
  text-decoration: none;
  font-weight: 600;
  color: rgb(102, 102, 102);
  opacity: 0.7;
}

a:hover {
  text-decoration: none;
}

.not-margin {
  margin: 0px;
  font-weight: normal;
  padding: 10px;
}
.con-form {
  width: 100%;
}
.con-form .flex {
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.con-form .flex a {
  font-size: 0.8rem;
  opacity: 0.7;
}
.con-form .flex a:hover {
  opacity: 1;
}
.con-form .vs-checkbox-label {
  font-size: 0.8rem;
}
.con-form .vs-input-content {
  margin: 10px 0px;
  width: calc(100%);
}
.con-form .vs-input-content .vs-input {
  width: 100%;
}
.footer-dialog {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  width: calc(100%);
}
.footer-dialog .new {
  margin: 0px;
  margin-top: 20px;
  padding: 0px;
  font-size: 0.7rem;
}
.footer-dialog .new a {
  margin-left: 6px;
}
.footer-dialog .new a:hover {
  text-decoration: underline;
}
.footer-dialog .vs-button {
  margin: 0px;
}
</style>
