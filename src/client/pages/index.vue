<template>
	<div class="page">
		<h1>Home</h1>
		<div v-if="$fetchState.pending"><Spinner /></div>
		<div v-else class="center dashboard">
			<div class="child detailsx">
				<div class="status-cards-group">
					<div class="card">
						<div class="status-description">Appraisals in goal setting stage</div>

						<div class="status">
							<h1>{{ apprisalStatus.a1 }}</h1>
						</div>
					</div>

					<div class="card">
						<div class="status-description">Appraisals in mid year review</div>

						<div class="status">
							<h1>{{ apprisalStatus.a2 }}</h1>
						</div>
					</div>

					<div class="card">
						<div class="status-description">Appraisals in end year review</div>

						<div class="status">
							<h1>{{ apprisalStatus.a3 }}</h1>
						</div>
					</div>

					<div class="card">
						<div class="status-description">Peer Appraisals</div>

						<div class="status">
							<h1>2</h1>
						</div>
					</div>
				</div>

				<div class="status-user-profile">
					<div class="avatar">
						<vs-avatar size="100">
							<img
								:src="
									$store.state.user.avatar
										? $store.state.user.avatar
										: `https://avatars.dicebear.com/api/human/${$store.state.user.user.email}.svg`
								"
								alt=""
							/>
						</vs-avatar>
					</div>

					<h2 style="margin-top: 10px; text-align: center">Person details</h2>
					<div class="details">
						<vs-table class="table" striped>
							<template #tbody>
								<vs-tr>
									<vs-td> Firstname </vs-td>
									<vs-td>
										{{ $store.state.user.user.first_name }}
									</vs-td>
								</vs-tr>
								<vs-tr>
									<vs-td> Lastname </vs-td>
									<vs-td>
										{{ $store.state.user.user.last_name }}
									</vs-td>
								</vs-tr>
								<vs-tr>
									<vs-td> Username </vs-td>
									<vs-td>
										{{ $store.state.user.user.username }}
									</vs-td>
								</vs-tr>
								<vs-tr>
									<vs-td> Email </vs-td>
									<vs-td>
										{{ $store.state.user.user.email }}
									</vs-td>
								</vs-tr>
								<vs-tr>
									<vs-td> Company </vs-td>
									<vs-td>
										{{ companyList.filter((x) => x.id == $store.state.user.user.company)[0].name }}
									</vs-td>
								</vs-tr>
								<vs-tr v-if="$store.state.user.department">
									<vs-td> Department </vs-td>
									<vs-td> {{ $store.state.user.department.name }} </vs-td>
								</vs-tr>

								<vs-tr>
									<vs-td> Gender </vs-td>
									<vs-td>
										{{ $store.state.user.gender }}
									</vs-td>
								</vs-tr>

								<vs-tr>
									<vs-td> Marital status </vs-td>
									<vs-td>
										{{ $store.state.user.marital_status }}
									</vs-td>
								</vs-tr>

								<vs-tr>
									<vs-td> Role </vs-td>
									<vs-td>
										{{
											$store.state.user.user.is_superuser
												? 'Superadmin'
												: $store.state.user.user.role.name
										}}
									</vs-td>
								</vs-tr>

								<vs-tr>
									<vs-td> Date of hire </vs-td>
									<vs-td>
										{{ $store.state.user.date_of_hire }}
									</vs-td>
								</vs-tr>

								<vs-tr>
									<vs-td> Job Title </vs-td>
									<vs-td>
										{{ $store.state.user.job_title }}
									</vs-td>
								</vs-tr>

								<vs-tr>
									<vs-td> Employee ID </vs-td>
									<vs-td>
										{{ $store.state.user.employee_id }}
									</vs-td>
								</vs-tr>

								<vs-tr>
									<vs-td> Employee Type </vs-td>
									<vs-td>
										{{ $store.state.user.user.employment_type }}
									</vs-td>
								</vs-tr>

								<vs-tr>
									<vs-td> First reporting manager</vs-td>
									<vs-td>
										{{ $store.state.user.first_reporting_manager.name }}
									</vs-td>
								</vs-tr>

								<vs-tr>
									<vs-td> Second reporting manager</vs-td>
									<vs-td>
										{{ $store.state.user.second_reporting_manager.name }}
									</vs-td>
								</vs-tr>
							</template>
						</vs-table>
					</div>

					<div class="action-buttons">
						<vs-button @click="logout"> Logout </vs-button>
						<vs-button @click="passwordActive = true"> Change password </vs-button>
						<vs-button @click="avatarUpload = true"> Change Profile </vs-button>
					</div>
				</div>
			</div>
			<div class="child notifications">
				<Notifications />
			</div>
		</div>

		<!-- Dialogs -->
		<ChangePassword
			v-if="passwordActive"
			:dialog="passwordActive"
			@close="passwordActive = false"
		/>

		<AddEmployeeAvatarDialog
			v-if="avatarUpload"
			:dialog="avatarUpload"
			@close="avatarUpload = false"
		/>
	</div>
</template>

<script>
export default {
	layout: 'dashboard',
	middleware: ['auth'],
	data: () => ({
		loading: false,
		passwordActive: false,
		avatarUpload: false,
		companyList: [],
		apprisalStatus: {
			a1: 0,
			a2: 0,
			a3: 0
		}
	}),
	async fetch() {
		try {
			this.apprisalStatus = await this.$axios.$get(`api/appraisal/status`, {
				headers: {
					Authorization: `Bearer ${this.$store.state.accessToken}`
				}
			});
			this.companyList = await this.$axios.$get(`api/company/`, {
				headers: {
					Authorization: `Bearer ${this.$store.state.accessToken}`
				}
			});
		} catch (err) {
			return this.$vs.notification({
				color: 'danger',
				title: 'Error fetching appriasal status'
			});
		}
	},
	fetchOnServer: false,
	computed: {
		theme: {
			get() {
				if (process.client) {
					return this.$vs.setTheme();
				}
				return 'dark';
			}
		}
	},
	methods: {
		ChangeTheme() {
			console.log(this.theme);
			if (process.client) {
				if (this.theme === 'light') {
					document.body.classList.add('darken');
				}
				if (this.theme === 'dark') {
					this.$vsTheme.themeDarken = true;
					document.body.classList.remove('darken');
				}
				this.$vs.toggleTheme();
			}
		},
		logout() {
			if (!this.loading) {
				this.loading = true;

				fetch('/api/logout', {
					method: 'POST'
				}).then(() => location.reload());
			}
		}
	}
};
</script>

<style>
.dashboard {
	display: flex;
	height: 100vh;
	flex-wrap: wrap;
}

.child {
	height: 100%;
}

.detailsx {
	width: 70%;
}

.notifications {
	width: 30%;
	padding-left: 50px;
}

@media only screen and (max-width: 800px) {
	.child {
		width: 100%;
	}

	.notifications {
		margin-top: 800px;
	}
}

.status-cards-group {
	display: flex;
	justify-content: center;
	flex-wrap: wrap;
}

.card {
	color: #eee;
	display: flex;
	flex-direction: column;
	justify-content: space-around;
	background: #306bff;
	width: 100%;
	margin: 10px;
	padding: 20px;
	max-width: 180px;
	height: 130px;
	border-radius: 16px;
	box-shadow: 0px 0px 25px 0px rgba(0, 0, 0, var(--vs-shadow-opacity));
}

.card .icon {
	text-align: center;
}

.card .icon i {
	font-size: 48px;
}

.card .status-description {
	font-size: 14px;
	font-weight: 600;
	text-align: center;
}

.card .status {
	font-size: 20px;
}

.status-user-profile {
	margin: 50px 0;
}

.status-user-profile .avatar {
	justify-content: center;
	display: flex;
}

.status-user-profile .details {
	display: flex;
	flex-direction: column;
	align-items: center;
	margin-top: 30px;
}

.status-user-profile .details .table {
	max-width: 500px;
	box-shadow: 0px 0px 25px 0px rgba(0, 0, 0, var(--vs-shadow-opacity));
}

.action-buttons {
	display: flex;
	justify-content: center;
	margin: 20px 0;
}
</style>
