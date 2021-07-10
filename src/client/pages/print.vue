<template>
	<div>
		<div v-if="$fetchState.pending"><Spinner /></div>
		<div v-else class="center">
			<div style="background-color: #eee">
				<div
					style="
						width: 1200px;
						background-color: #fff;
						margin: 0 auto;
						padding: 20px;
						box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
						min-height: 100vh;
					"
				>
					<div style="float: right">
						<vs-button @click="printPdf"> Print to PDF </vs-button>
					</div>

					<h1>{{ appraisal.name }}</h1>

					<h2 style="margin-top: 50px">Goals</h2>

					<div v-for="(tr, i) in appraisal.goal_set" :key="i">
						<table style="margin-top: 20px">
							<thead>
								<tr>
									<th>Summary</th>
									<th>Weightage</th>
									<th>KPI Count</th>
									<th>Due</th>
								</tr>
							</thead>

							<tbody>
								<tr>
									<td>
										{{ tr.summary }}
									</td>
									<td>
										{{ tr.weightage }}
									</td>
									<td>
										{{ tr.kpi_set.length }}
									</td>
									<td>
										{{ tr.due }}
									</td>
								</tr>

								<tr>
									<td colspan="4">
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
												<vs-col w="4">
													<b>Mid year employee comment</b>
												</vs-col>
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
											<vs-row v-if="tr.stage2_rejection_comment != null" style="padding: 20px 0">
												<vs-col w="4">
													<b>Mid year rejection comment</b>
												</vs-col>
												<vs-col w="8" class="description-card">
													<!-- eslint-disable-next-line vue/no-v-html -->
													<span v-html="tr.stage1_rejection_comment"></span>
												</vs-col>
											</vs-row>
											<vs-row style="padding: 20px 0">
												<vs-col w="4">
													<b>End year employee comment</b>
												</vs-col>
												<vs-col w="8" class="description-card">
													<span v-if="tr.stage2_employee_comment != null">
														<!-- eslint-disable-next-line vue/no-v-html -->
														<span v-html="tr.stage2_employee_comment"></span>
													</span>
													<span v-else>No Comment</span>
												</vs-col>
											</vs-row>
											<vs-row style="padding: 20px 0">
												<vs-col w="4"> <b>End year manager comment</b> </vs-col>
												<vs-col w="8" class="description-card">
													<span v-if="tr.stage2_manager_comment != null">
														<!-- eslint-disable-next-line vue/no-v-html -->
														<span v-html="tr.stage2_manager_comment"></span>
													</span>
													<span v-else>No Comment</span>
												</vs-col>
											</vs-row>
											<vs-row v-if="tr.stage3_rejection_comment != null" style="padding: 20px 0">
												<vs-col w="4">
													<b>End year rejection comment</b>
												</vs-col>
												<vs-col w="8" class="description-card">
													<!-- eslint-disable-next-line vue/no-v-html -->
													<span v-html="tr.stage2_rejection_comment"></span>
												</vs-col>
											</vs-row>
										</div>
									</td>
								</tr>

								<tr>
									<td colspan="4">
										<table>
											<thead>
												<tr>
													<th colspan="3">
														<h3>KPIs</h3>
													</th>
												</tr>
												<tr>
													<th>Summary</th>
													<th>Due</th>
													<th>Progress</th>
												</tr>
											</thead>
											<tbody>
												<tr v-for="(kpi, j) in tr.kpi_set" :key="j">
													<td>{{ kpi.summary }}</td>
													<td>{{ kpi.due }}</td>
													<td>{{ kpi.progress }}</td>
												</tr>
											</tbody>
										</table>
									</td>
								</tr>
							</tbody>
						</table>
					</div>

					<h2 style="margin-top: 50px">Core values</h2>
					<table style="margin-top: 20px">
						<tr>
							<th>Summary</th>
							<th>Description</th>
							<th>Due</th>
						</tr>

						<tr v-for="(tr, i) in appraisal.goal_set" :key="i">
							<td>
								{{ tr.summary }}
							</td>
							<td>
								<!-- eslint-disable-next-line vue/no-v-html -->
								<span v-html="tr.description"></span>
							</td>
							<td>
								{{ tr.due }}
							</td>
						</tr>
					</table>

					<h2 style="margin-top: 50px">Skills</h2>
					<table style="margin-top: 20px">
						<tr>
							<th>Summary</th>
							<th>Description</th>
							<th>Due</th>
						</tr>

						<tr v-for="(tr, i) in appraisal.skill_set" :key="i">
							<td>
								{{ tr.summary }}
							</td>
							<td>
								<!-- eslint-disable-next-line vue/no-v-html -->
								<span v-html="tr.description"></span>
							</td>
							<td>
								{{ tr.due }}
							</td>
						</tr>
					</table>

					<h2 style="margin-top: 50px">Departmental Goals</h2>
					<table style="margin-top: 20px">
						<tr>
							<th>Summary</th>
							<th>Category</th>
							<th>Manager</th>
							<th>Description</th>
							<th>Due</th>
						</tr>

						<tr v-for="(tr, i) in appraisal.overall_appraisal.departmentalgoal_set" :key="i">
							<td>
								{{ tr.summary }}
							</td>
							<td>{{ tr.category.name }}</td>
							<td>{{ tr.manager.name }}</td>
							<td>
								<!-- eslint-disable-next-line vue/no-v-html -->
								<span v-html="tr.description"></span>
							</td>
							<td>
								{{ tr.due }}
							</td>
						</tr>
					</table>

					<h2 style="margin-top: 50px">Departmental Core values</h2>
					<table style="margin-top: 20px">
						<tr>
							<th>Summary</th>
							<th>Category</th>
							<th>Manager</th>
							<th>Description</th>
							<th>Due</th>
						</tr>

						<tr v-for="(tr, i) in appraisal.overall_appraisal.departmentalcorevalue_set" :key="i">
							<td>
								{{ tr.summary }}
							</td>
							<td>{{ tr.category.name }}</td>
							<td>{{ tr.manager.name }}</td>
							<td>
								<!-- eslint-disable-next-line vue/no-v-html -->
								<span v-html="tr.description"></span>
							</td>
							<td>
								{{ tr.due }}
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
export default {
	data: () => ({
		appraisal: {}
	}),
	async fetch() {
		const id = this.$route.query.id;
		this.appraisal = await this.$axios.$get(`/api/appraisal/${id}/`);
	},
	methods: {
		printPdf() {
			print();
		}
	}
};
</script>

<style>
table {
	width: 100%;
}

th,
td {
	text-align: center;
	padding: 10px;
	border: 1.5px solid rgba(0, 0, 0, 0.7);
}
</style>

<style scoped>
* {
	font-family: 'Times New Roman', Times, serif !important;
}
</style>
