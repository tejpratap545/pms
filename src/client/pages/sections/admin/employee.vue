<template>
	<div class="page">
		<h1>Employee Management</h1>
		<div v-if="$fetchState.pending"><Spinner /></div>
		<div v-else class="center grid">
			<vs-table v-model="selected">
				<template #header>
					<div class="table-header">
						<vs-input v-model="search" placeholder="Search" shadow>
							<template #icon>
								<i class="bx bx-search"></i>
							</template>
						</vs-input>
						<vs-button class="data-1" @click="newActive = true"> Add </vs-button>
						<vs-button icon @click="$tours.myTour.start()">
							<i class="bx bx-help-circle"></i>
						</vs-button>
					</div>
				</template>
				<template #thead>
					<vs-tr>
						<vs-th> Avatar </vs-th>
						<vs-th> Username </vs-th>
						<vs-th> Name </vs-th>
						<vs-th> Email </vs-th>
						<vs-th> Date of Hire </vs-th>
						<vs-th> Department </vs-th>
						<vs-th> Supervisor </vs-th>
						<vs-th sort @click="employeeList = $vs.sortData($event, employeeList, 'id')">
							Id
						</vs-th>
					</vs-tr>
				</template>
				<template #tbody>
					<vs-tr
						v-for="(tr, i) in $vs.getSearch(employeeList, search)"
						:key="i"
						:data="tr"
						:is-selected="selected == tr"
						class="data-2"
					>
						<vs-td>
							<vs-avatar>
								<img
									:src="
										tr.avatar ? tr.avatar : `https://avatars.dicebear.com/api/human/${tr.email}.svg`
									"
									alt="Avatar"
								/>
							</vs-avatar>
						</vs-td>
						<vs-td> {{ tr.username }} </vs-td>
						<vs-td> {{ tr.name }} </vs-td>
						<vs-td>
							{{ tr.email }}
						</vs-td>
						<vs-td>
							{{ tr.date_of_hire }}
						</vs-td>
						<vs-td>
							{{ tr.department ? tr.department.name : `` }}
						</vs-td>
						<vs-td>
							{{ tr.first_reporting_manager ? tr.first_reporting_manager.name : `` }}
						</vs-td>
						<vs-td>
							{{ tr.id }}
						</vs-td>

						<template #expand>
							<div class="con-content">
								<div>
									<vs-button color="success" flat icon @click="editActive = true">
										<i class="bx bx-edit-alt"></i>
									</vs-button>
									<vs-button border danger @click="resignActive = true">
										Resign employee
									</vs-button>
								</div>
							</div>
						</template>
					</vs-tr>
				</template>
			</vs-table>
		</div>

		<v-tour name="myTour" :steps="steps"></v-tour>

		<!-- Dialogs -->
		<NewEmployeeDialog
			v-if="newActive"
			:dialog="newActive"
			@close="(newActive = false), $fetch()"
		/>

		<EditEmployeeDialog
			v-if="editActive"
			:dialog="editActive"
			:selected-employee="selected"
			@close="(editActive = false), $fetch()"
		/>

		<ResignEmployeeDialog
			v-if="resignActive"
			:dialog="resignActive"
			:selected-employee="selected"
			@close="(resignActive = false), $fetch()"
		/>
	</div>
</template>

<script>
export default {
	layout: 'dashboard',
	middleware: ['auth'],
	data: () => ({
		editActive: false,
		resignActive: false,
		newActive: false,
		search: '',
		loading: false,
		selected: {},
		employeeList: [],
		departmentList: [],
		steps: [
			{
				target: '.page', // We're using document.querySelector() under the hood
				header: {
					title: 'Get Started'
				},
				content: `Welcome to PMS Onboarding `,
				params: {
					placement: 'top'
				}
			},
			{
				target: '.data-1',
				header: {
					title: 'Adding Employee'
				},
				content: 'Use this button to add a employee',
				params: {
					placement: 'top'
				}
			},
			{
				target: '.data-2',
				header: {
					title: 'Editing Employee'
				},
				content: 'Click on an item to expand it and reveal more options like edit and delete',
				params: {
					placement: 'top'
				}
			}
		]
	}),
	async fetch() {
		try {
			this.employeeList = await this.$axios.$get(`api/user/`, {
				headers: {
					Authorization: `Bearer ${this.$store.state.accessToken}`
				}
			});

			this.departmentList = await this.$axios.$get(`api/department/`, {
				headers: {
					Authorization: `Bearer ${this.$store.state.accessToken}`
				}
			});
		} catch (err) {
			return this.$vs.notification({
				color: 'danger',
				title: 'Error fetching employees'
			});
		}
	},
	fetchOnServer: false
};
</script>
