<template>
	<vs-dialog v-model="active" :loading="loading" scroll overflow-hidden not-close prevent-close>
		<template #header>
			<h4 class="not-margin">Endyear <b>Review</b></h4>

			<vs-button class="closeDialogButton" icon floating @click="closeDialog">
				<i class="bx bx-x"></i>
			</vs-button>
		</template>

		<!-- <div v-if="$fetchState.pending"><Spinner /></div> -->
		<div class="con-form">
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
									<vs-row v-if="tr.stage0_rejection_comment != null" style="padding: 20px 0">
										<vs-col w="4">
											<b>Goal setting stage rejection comment</b>
										</vs-col>
										<vs-col w="8" class="description-card">
											<!-- eslint-disable-next-line vue/no-v-html -->
											<span v-html="tr.stage0_rejection_comment"></span>
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
										<vs-col w="4"> <b>Mid year manager comment</b> </vs-col>
										<vs-col w="8" class="description-card">
											<span v-if="tr.stage1_manager_comment != null">
												<!-- eslint-disable-next-line vue/no-v-html -->
												<span v-html="tr.stage1_manager_comment"></span>
											</span>
											<span v-else>No Comment</span>
										</vs-col>
									</vs-row>

									<vs-row style="padding: 20px 0">
										<vs-col w="4">
											<b>Endyear employee comment</b>
										</vs-col>
										<vs-col w="8">
											<Editor
												:data="tr.stage2_employee_comment"
												@changeData="(value) => (tr.stage2_employee_comment = value)"
											/>
										</vs-col>
									</vs-row>
									<vs-row style="padding: 20px 0">
										<vs-col w="4">
											<b>Endyear employee rating</b>
										</vs-col>
										<vs-col w="8" style="display: flex; justify-content: flex-end">
											<star-rating
												v-model="tr.employee_rating"
												:star-size="20"
												:rating="tr.employee_rating"
											></star-rating>
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

			<vs-col w="4">
				<b>Endyear employee core value comment</b>
			</vs-col>
			<vs-col w="8">
				<Editor
					:data="core_value_employee_comment"
					@changeData="(value) => (core_value_employee_comment = value)"
				/>
			</vs-col>

			<vs-row style="padding: 20px 0">
				<vs-col w="4">
					<b>Endyear employee core value rating</b>
				</vs-col>
				<vs-col w="8" style="display: flex; justify-content: flex-end">
					<star-rating
						v-model="core_value_employee_rating"
						:star-size="20"
						:rating="core_value_employee_rating"
					></star-rating>
				</vs-col>
			</vs-row>
		</div>

		<template #footer>
			<div class="footer-dialog">
				<vs-button :loading="loading" block @click="submit"> Submit Review </vs-button>
			</div>
		</template>
	</vs-dialog>
</template>

<script>
export default {
	props: {
		dialog: Boolean,
		// eslint-disable-next-line vue/require-default-prop
		appraisal: Object,
		edit: {
			type: Boolean,
			default: false
		}
	},
	data: () => ({
		active: false,
		loading: false,
		core_value_employee_rating: 1
	}),

	mounted() {
		this.active = this.dialog;
	},
	methods: {
		patchGoals() {
			this.appraisal.goal_set.forEach(async (goal) => {
				await this.$axios.patch(`api/goal/${goal.id}/`, {
					stage2_employee_comment: goal.stage2_employee_comment,
					employee_rating: goal.employee_rating
				});
			});
		},

		async submit() {
			this.loading = true;
			this.patchGoals();
			await this.$$axios.$patch(
				`api/appraisal/${this.appraisal.id}/`,
				{
					core_value_employee_comment: this.appraisal.core_value_employee_comment,
					core_value_employee_rating: this.core_value_employee_rating
				},
				{
					headers: {
						Authorization: `Bearer ${this.$store.state.accessToken}`
					}
				}
			);

			this.$axios
				.$post(
					`api/appraisal/${this.appraisal.id}/up-stage/employee/end-review/`,
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
						title: `"Sucessfullly review appraisal ${this.appraisal.name} . Please Confirm or Edit review  and then Submit"`
					});
					this.closeDialog();
				})
				.catch(() => {
					return this.$vs.notification({
						color: 'danger',
						title: `"Error review end year appraisal ${this.appraisal.name}."`
					});
				})
				.finally(() => {
					this.loading = false;
				});
		},
		closeDialog() {
			this.$emit('close');
		}
	}
};
</script>
