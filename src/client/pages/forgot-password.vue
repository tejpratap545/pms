<template>
  <div class="app">
    <vs-dialog v-model="active" class="dialog" not-close prevent-close>
      <template #header>
        <h4 class="not-margin">Password <b>Reset</b></h4>
      </template>

      <div v-if="stage == 1" class="con-form">
        <vs-input v-model="username" placeholder="Your username">
          <template #icon> @ </template>
        </vs-input>
      </div>

      <div v-else class="con-form">
        <p>{{ res }}</p>
        <vs-input v-model="token" placeholder="Enter OTP">
          <template #icon> @ </template>
        </vs-input>
        <vs-input
          v-model="password1"
          type="password"
          placeholder="New password"
        >
          <template #icon>
            <i class="bx bxs-lock"></i>
          </template>
        </vs-input>
        <vs-input
          v-model="password2"
          type="password"
          placeholder="Confirm password"
        >
          <template #icon>
            <i class="bx bxs-lock"></i>
          </template>
        </vs-input>
      </div>

      <template #footer>
        <div class="footer-dialog">
          <vs-button block :loading="loading" @click="resetPassword">
            Send email
          </vs-button>
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
    token: "",
    password1: "",
    password2: "",
    stage: 1,
    loading: false,
    res: "",
  }),
  methods: {
    async resetPassword() {
      try {
        if (!this.loading) {
          this.loading = true;

          if (this.stage === 1) {
            this.res = await this.$axios.$post(`api/user/get_token`, {
              username: this.username,
            });
            this.stage = 2;
          } else {
            await this.$axios.$post(`api/user/reset_password`, {
              token: this.token,
              password1: this.password1,
              password2: this.password2,
            });
          }
          this.loading = true;
        }
      } catch (err) {
        return this.$vs.notification({
          color: "danger",
          title: "Error resetting password",
        });
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

.vs-dialog {
  min-width: 400px;
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
