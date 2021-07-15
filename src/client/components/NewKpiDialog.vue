<template>
	<vs-dialog v-model="active" :loading="loading" not-close prevent-close>
		<template #header>
			<h4 class="not-margin">Add a new <b>Kpi</b></h4>

			<vs-button class="closeDialogButton" icon floating @click="closeDialog">
				<i class="bx bx-x"></i>
			</vs-button>
		</template>

		<!-- <div v-if="$fetchState.pending"></div> -->
		<div class="con-form">
			<vs-input v-model="newKpiData.summary" placeholder="Summary">
				<template #icon> <i class="bx bx-tag-alt"></i> </template>
			</vs-input>

			<vs-select
				v-model="newKpiData.progress"
				placeholder="Progress"
				style="margin-bottom: 10px"
				block
				filter
			>
				<vs-option
					v-for="(progress, index) in progressList"
					:key="index"
					:label="progress"
					:value="progress"
				>
					{{ progress }}
				</vs-option>
			</vs-select>

			<div class="con-form-control my-2">
				<p>Due date</p>
				<vs-input v-model="newKpiData.due" type="date">
					<template #icon><i class="bx bx-calendar-check"></i></template>
				</vs-input>
			</div>
		</div>

		<template #footer>
			<div class="footer-dialog">
				<vs-button :loading="loading" block @click="createKpi"> Add New </vs-button>
			</div>
		</template>
	</vs-dialog>
</template>

<script>
export default {
	name: 'NewKpiDialog',
	props: {
		dialog: Boolean,
		// eslint-disable-next-line vue/require-default-prop
		selectedGoal: Object
	},
	data: () => ({
		active: false,
		loading: false,
		progressList: ['Working', 'Completed'],
		newKpiData: {
			summary: '',
			due: '',
			progress: 'Working',
			goal: 0
		}
	}),
	mounted() {
		this.active = this.dialog;
		this.newKpiData.goal = this.selectedGoal.id;
	},
	methods: {
		closeDialog() {
			this.$emit('close');
		},
		createKpi() {
			if (!this.loading) {
				this.loading = true;

				this.$axios
					.$post(`api/kpi/`, this.newKpiData, {
						headers: {
							Authorization: `Bearer ${this.$store.state.accessToken}`
						}
					})
					.then(() => this.closeDialog())
					.catch(() => {
						this.loading = false;
						return this.$vs.notification({
							color: 'danger',
							title: 'Error creating Kpi'
						});
					});
			}
		}
	}
};
</script>

<style>
.con-form-control {
	display: flex;
	justify-content: space-between;
	align-items: center;
}
</style>
