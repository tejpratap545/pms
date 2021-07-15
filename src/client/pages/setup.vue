<template>
	<div class="setup">
		<div class="setup-title">
			<h2 style="font-weight: 600">PMS Setup</h2>
			<vs-button v-if="page > 1" flat @click="page--">
				<i class="bx bxs-left-arrow"></i>Back
			</vs-button>
		</div>
		<div class="setup-container">
			<div class="form">
				<div v-if="page == 1" class="setuppage page-1">
					<h2>Nice to meet you</h2>
					<h1>What is your company's name?</h1>
					<vs-input
						v-model="newCompanyData.name"
						style="margin-top: 20px"
						placeholder="Company Name"
						block
					/>
					<vs-button style="margin: unset; margin-top: 20px" block @click="page = 2">
						Next <i class="bx bxs-right-arrow"></i>
					</vs-button>
				</div>
				<div v-if="page == 2" class="setuppage page-2">
					<h2>Few more details</h2>
					<h1>Fill up admin details</h1>
					<vs-input
						v-model="newCompanyData.admin_name"
						placeholder="Admin name"
						style="margin-top: 20px"
						block
					>
						<template #icon>
							<i class="bx bx-user"></i>
						</template>
					</vs-input>
					<vs-input
						v-model="newCompanyData.admin_username"
						placeholder="Admin username"
						style="margin-top: 20px"
						block
					>
						<template #icon>
							<i class="bx bx-user"></i>
						</template>
					</vs-input>

					<vs-input
						v-model="newCompanyData.admin_email"
						placeholder="Admin email"
						style="margin-top: 20px"
						block
					>
						<template #icon> @ </template>
					</vs-input>

					<vs-input
						v-model="newCompanyData.admin_password"
						type="password"
						placeholder="Admin password"
						style="margin-top: 20px"
						block
					>
						<template #icon>
							<i class="bx bxs-lock"></i>
						</template>
					</vs-input>

					<vs-button style="margin: unset; margin-top: 20px" block @click="page = 3">
						Next <i class="bx bxs-right-arrow"></i>
					</vs-button>
				</div>
				<div v-if="page == 3" class="setuppage page-3">
					<h2>Everything done</h2>
					<h1>Lauch PMS</h1>

					<vs-button style="margin: unset; margin-top: 20px" block>
						Launch <i class="bx bx-rocket"></i>
					</vs-button>
				</div>
			</div>
			<div class="infographic">
				<lottie-animation :path="lottieUrl" :width="400" :height="400" />
			</div>
		</div>
	</div>
</template>

<script>
import LottieAnimation from 'lottie-vuejs/src/LottieAnimation.vue'; // import lottie-vuejs

export default {
	components: {
		LottieAnimation
	},
	middleware({ store, redirect }) {
		if (store.state.isAuthenticate) {
			return redirect('/');
		}
	},
	data: () => ({
		page: 1,
		newCompanyData: {
			admin_username: '',
			admin_email: '',
			admin_name: '',
			admin_password: '',
			name: '',
			domain: '',
			setting: {
				goal_nomenclature: '',
				corevalue_nomenclature: '',
				skills_nomenclature: ''
			}
		}
	}),
	computed: {
		lottieUrl() {
			if (this.page === 1) return 'lottie/setup1.json';
			if (this.page === 2) return 'lottie/setup2.json';
			if (this.page === 3) return 'lottie/setup3.json';
			return 'lottie/loading.json';
		}
	}
};
</script>

<style>
h1,
h2 {
	text-align: unset;
	margin: 20px 0;
}

.setup-title {
	padding: 25px 100px;
	position: absolute;
}

.setuppage {
	width: 100%;
}

.setup-container {
	display: flex;
	height: 100vh;
	padding: 100px;
	flex-wrap: wrap;
}

.setup-container > div {
	width: 50%;
	height: 100%;

	display: grid;
	place-items: center;
	padding: 0 20px;
}

@media only screen and (max-width: 800px) {
	.setup-container {
		padding: 0px;
	}

	.setup-container > div {
		width: 100%;
	}

	.infographic {
		display: none;
	}
}
</style>
