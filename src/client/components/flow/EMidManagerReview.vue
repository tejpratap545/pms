<template>
	<vs-dialog v-model="active" :loading="loading" not-close prevent-close>
		<template #header>
			<h4 class="not-margin"><b>Mid Year Manager/Supervisor Review</b></h4>

			<vs-button class="closeDialogButton" icon floating @click="closeDialog">
				<i class="bx bx-x"></i>
			</vs-button>
		</template>

		<div v-if="$fetchState.pending">loading ...</div>
		<di v-else class="con-form">
			<EmployeeInfo :employee="appraisal.employee" />
			<vs-table class="my-5">
				<template #header>
					<div class="table-header" style="justify-content: space-between">
						<h3>Goals</h3>
					</div>
				</template>
				<template #thead>
					<vs-tr>
						<vs-th> Summary </vs-th>
						<vs-th> Weightage </vs-th>
						<vs-th> KPI Count </vs-th>
						<vs-th> Due </vs-th>
					</vs-tr>
				</template>
				<template #tbody>
					<vs-tr v-for="(tr, i) in appraisal.goal_set" :key="i">
						<vs-td>
							{{ tr.summary }}
						</vs-td>
						<vs-td>
							{{ tr.weightage }}
						</vs-td>
						<vs-td>
							{{ tr.kpi_set.length }}
						</vs-td>
						<vs-td>
							{{ tr.due }}
						</vs-td>

						<template #expand>
							<div>
								<div style="font-size: 12.8px">
									<vs-row v-if="tr.description != null" style="padding: 20px 0">
										<vs-col w="4">
											<b>Description</b>
										</vs-col>
										<vs-col w="8" class="description-card">
											<!-- eslint-disable-next-line vue/no-v-html -->
											<span v-html="tr.description"></span>
										</vs-col>
									</vs-row>

									<vs-row style="padding: 20px 0">
										<vs-col w="4">
											<b>Goal setting stage employee comment</b>
										</vs-col>
										<vs-col w="8" class="description-card">
											<span v-if="tr.stage0_employee_comment != null">
												<!-- eslint-disable-next-line vue/no-v-html -->
												<span v-html="tr.stage0_employee_comment"></span>
											</span>
											<span v-else>No Comment</span>
										</vs-col>
									</vs-row>
									<vs-row style="padding: 20px 0">
										<vs-col w="4">
											<b>Goal setting stage manager comment</b>
										</vs-col>
										<vs-col w="8" class="description-card">
											<span v-if="tr.stage0_manager_comment != null">
												<!-- eslint-disable-next-line vue/no-v-html -->
												<span v-html="tr.stage0_manager_comment"></span>
											</span>
											<span v-else>No Comment</span>
										</vs-col>
									</vs-row>

									<vs-row style="padding: 20px 0">
										<vs-col w="4"> <b>Mid year employee comment</b> </vs-col>
										<vs-col w="8" class="description-card">
											<span v-if="tr.stage1_employee_comment != null">
												<!-- eslint-disable-next-line vue/no-v-html -->
												<span v-html="tr.stage1_employee_comment"></span>
											</span>
											<span v-else>No Comment</span>
										</vs-col>
									</vs-row>
									<vs-row style="padding: 20px 0">
										<vs-col w="4"> <b>Tracking Status</b> </vs-col>
										<vs-col w="8" class="description-card">
											<span v-if="tr.tracking_status != null">
												<!-- eslint-disable-next-line vue/no-v-html -->
												<span v-html="tr.tracking_status"></span>
											</span>
											<span v-else>No Comment</span>
										</vs-col>
									</vs-row>
									<vs-row style="padding: 20px 0">
										<vs-col w="4"> <b>Mid year manager comment</b> </vs-col>
										<vs-col w="8">
											<!-- eslint-disable-next-line vue/no-v-html -->
											<Editor
												:data="tr.stage1_manager_comment"
												@changeData="(value) => (tr.stage1_manager_comment = value)"
											/>
										</vs-col>
									</vs-row>
								</div>
								<vs-table class="my-5">
									<template #header>
										<div class="table-header" style="justify-content: space-between">
											<h3>KPIs</h3>
										</div>
									</template>
									<template #thead>
										<vs-tr>
											<vs-th> Summary </vs-th>
											<vs-th> Due </vs-th>
											<vs-th> Progress </vs-th>
										</vs-tr>
									</template>
									<template #tbody>
										<vs-tr v-for="(kpi, j) in tr.kpi_set" :key="j">
											<vs-td style="padding: 10px">{{ kpi.summary }}</vs-td>
											<vs-td>{{ kpi.due }}</vs-td>
											<vs-td>{{ kpi.progress }}</vs-td>
										</vs-tr>
									</template>
								</vs-table>
							</div>
						</template>
					</vs-tr>
				</template>
			</vs-table>
		</di>
		<Reject
			v-if="rejectDialog"
			:dialog="rejectDialog"
			:appraisal="appraisal"
			@close="(rejectDialog = false), closeDialog"
		/>

		<template #footer>
			<div class="footer-dialog">
				<vs-button danger :loading="loading" @click="rejectDialog = true">
					Reject Appraiasal
				</vs-button>
				<vs-button :loading="loading" block @click="submit"> Submit Review </vs-button>
			</div>
		</template>
	</vs-dialog>
</template>

<script>
export default {
	name: 'EndyearReview',
	props: {
		dialog: Boolean,
		// eslint-disable-next-line vue/require-default-prop
		appraisalId: Number
	},
	data: () => ({
		active: false,
		loading: false,
		appraisal: {}
	}),

	async fetch() {
		this.loading = true;
		this.appraisal = await this.$axios.$get(`api/appraisal/${this.appraisalId}/`, {
			headers: {
				Authorization: `Bearer ${this.$store.state.accessToken}`
			}
		});
		this.loading = false;
	},

	mounted() {
		this.active = this.dialog;
	},
	methods: {
		closeDialog() {
			this.$emit('close');
		},
		patchGoals() {
			this.appraisal.goal_set.forEach(async (goal) => {
				await this.$axios.patch(`api/goal/${goal.id}/`, {
					stage1_manager_comment: goal.stage1_manager_comment
				});
			});
		},
		submit() {
			this.loading = true;
			this.patchGoals();
			this.$axios
				.$post(
					`api/appraisal/${this.appraisalId}/up-stage/manager/mid-review/`,
					{},
					{
						headers: {
							Authorization: `Bearer ${this.$store.state.accessToken}`
						}
					}
				)
				.then(() => {
					this.$vs.notification({
						color: 'success',
						title: `"Suucessfullly approved appraisal ${this.appraisal.name} of ${this.appraisal.employee.name}"`
					});
					this.closeDialog();
				})
				.catch(() => {
					return this.$vs.notification({
						color: 'danger',
						title: `"Error Approving appraisal ${this.appraisal.name} of ${this.appraisal.employee.name}. All goals must be approved "`
					});
				})
				.finally(() => {
					this.loading = false;
				});
		}
	}
};
</script>
<style scoped>
.footer-dialog {
	display: flex;
	flex-direction: row;
}
</style>
