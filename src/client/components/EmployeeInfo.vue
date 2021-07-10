<template>
	<div class="status-user-profile" style="margin: 10px">
		<h3 style="text-align: center">Employee details</h3>
		<div class="details">
			<vs-table class="table" striped>
				<template #tbody>
					<vs-tr>
						<vs-td> Name </vs-td>

						<vs-td> {{ employee.name }} </vs-td>
					</vs-tr>
					<vs-tr>
						<vs-td> Email </vs-td>
						<vs-td> {{ employee.email }} </vs-td>
					</vs-tr>
					<vs-tr>
						<vs-td> Date OF Hire </vs-td>
						<vs-td> {{ employee.date_of_hire }} </vs-td>
					</vs-tr>
					<vs-tr>
						<vs-td> Department</vs-td>
						<vs-td>
							{{ employee.department ? employee.department.name : '' }}
						</vs-td>
					</vs-tr>
					<vs-tr>
						<vs-td> Manager</vs-td>
						<vs-td>
							{{ employee.first_reporting_manager ? employee.first_reporting_manager.name : '' }}
						</vs-td>
					</vs-tr>
				</template>
			</vs-table>
		</div>
	</div>
</template>
<script>
export default {
	props: {
		// eslint-disable-next-line vue/require-default-prop
		employee: Object
	}
};
</script>
