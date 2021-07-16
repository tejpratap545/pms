<template>
	<div class="app">
		<vs-dialog v-model="active" class="dialog" not-close prevent-close>
			<template #header>
				<h4 class="not-margin">
					Login to <b>{{ company.name }}</b>
				</h4>
			</template>

			<div class="con-form">
				<vs-input v-model="username" placeholder="Username">
					<template #icon> @ </template>
				</vs-input>
				<vs-input v-model="password" type="password" placeholder="Password">
					<template #icon>
						<i class="bx bxs-lock"></i>
					</template>
				</vs-input>
			</div>

			<template #footer>
				<div class="footer-dialog">
					<vs-button block :loading="loading" @click="login"> Sign In </vs-button>

					<div class="new">Forgot password? <a href="/forgot-password">Reset password</a></div>
				</div>
			</template>
		</vs-dialog>
	</div>
</template>

<script>
export default {
	middleware({ store, redirect }) {
		if (store.state.isAuthenticate) {
			return redirect('/');
		}
	},
	data: () => ({
		active: true,
		username: '',
		password: '',
		remember: false,
		loading: false,
		company: {}
	}),
	fetch() {
		if (process.client) {
			this.$axios
				.$post('/api/company/domain/', {
					domain: window.location.host
				})
				.then((response) => {
					this.company = response;
				});
		}
	},
	fetchOnServer: false,

	methods: {
		login() {
			if (!this.loading) {
				this.loading = true;

				fetch('/api/login', {
					method: 'POST',
					headers: {
						'Content-Type': 'application/json'
					},

					body: JSON.stringify({
						username: this.username,
						password: this.password
					})
				})
					.then(() => location.reload())
					// eslint-disable-next-line no-console
					.catch((err) => console.log(err));
			}
		}
	}
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
