<template>
	<vs-dialog v-model="active" :loading="loading" not-close prevent-close>
		<template #header>
			<h4 class="not-margin">
				Resign Employee
				<b>{{ selectedEmployee.username }}</b>
			</h4>

			<vs-button class="closeDialogButton" icon floating @click="closeDialog">
				<i class="bx bx-x"></i>
			</vs-button>
		</template>

		<div v-if="$fetchState.pending"><Spinner /></div>
		<div v-else class="con-form">
			<vs-select
				v-model="replace_employee"
				:placeholder="`Employee to replace ${selectedEmployee.username}`"
				block
				filter
			>
				<vs-option
					v-for="employee in employeeList"
					:key="employee.id"
					:label="employee.name"
					:value="employee.id"
				>
					{{ employee.name }}
				</vs-option>
			</vs-select>
		</div>

		<template #footer>
			<div class="footer-dialog">
				<vs-button :loading="loading" block @click="resignEmployee"> Add New </vs-button>
			</div>
		</template>
	</vs-dialog>
</template>

<script>
export default {
	name: 'ResignEmployeeDialog',
	props: {
		dialog: Boolean,
		// eslint-disable-next-line vue/require-default-prop
		selectedEmployee: Object
	},
	data: () => ({
		active: false,
		loading: false,
		employeeList: [],
		replace_employee: 0
	}),
	async fetch() {
		this.loading = true;
		try {
			this.employeeList = await this.$axios.$get(`api/user/short`, {
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
		this.loading = false;
	},
	mounted() {
		this.active = this.dialog;
	},
	methods: {
		closeDialog() {
			this.$emit('close');
		},
		resignEmployee() {
			if (!this.loading) {
				this.loading = true;

				this.$axios
					.$post(
						`api/user/${this.selectedEmployee.id}/resign/`,
						{
							replace_employee: this.replace_employee
						},
						{
							headers: {
								Authorization: `Bearer ${this.$store.state.accessToken}`
							}
						}
					)
					.then(() => this.closeDialog())
					.catch(() => {
						this.loading = false;
						return this.$vs.notification({
							color: 'danger',
							title: 'Error resigning employee'
						});
					});
			}
		}
	}
};
</script>
