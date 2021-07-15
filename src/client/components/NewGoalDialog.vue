<template>
	<vs-dialog v-model="active" :loading="loading" not-close prevent-close>
		<template #header>
			<h4 class="not-margin">Add a new <b>Goal</b></h4>

			<vs-button class="closeDialogButton" icon floating @click="closeDialog">
				<i class="bx bx-x"></i>
			</vs-button>
		</template>

		<div v-if="$fetchState.pending"><Spinner /></div>
		<div v-else class="con-form">
			<vs-input v-model="newGoalData.summary" placeholder="Summary">
				<template #icon> <i class="bx bx-tag-alt"></i> </template>
			</vs-input>

			<vs-input v-model="newGoalData.weightage" placeholder="Weightage">
				<template #icon> <i class="bx bx-tag-alt"></i> </template>
			</vs-input>

			<Editor
				:data="newGoalData.description"
				@changeData="(value) => (newGoalData.description = value)"
			/>

			<vs-select
				v-if="goalCategoryList.length != 0"
				v-model="newGoalData.category"
				placeholder="Select goal category"
				style="margin: 10px 0"
				block
				filter
			>
				<vs-option
					v-for="(category, index) in goalCategoryList"
					:key="index"
					:label="category.name"
					:value="category.id"
				>
					{{ category.name }}
				</vs-option>
			</vs-select>

			<div class="con-form-control my-2">
				<p>Goal due date</p>
				<vs-input v-model="newGoalData.due" type="date">
					<template #icon><i class="bx bx-calendar-check"></i></template>
				</vs-input>
			</div>
		</div>

		<template #footer>
			<div class="footer-dialog">
				<vs-button :loading="loading" block @click="createGoal"> Add New </vs-button>
			</div>
		</template>
	</vs-dialog>
</template>

<script>
export default {
	name: 'NewGoalDialog',
	props: {
		dialog: Boolean,
		// eslint-disable-next-line vue/require-default-prop
		selectedAppraisal: Object
	},
	data: () => ({
		active: false,
		loading: false,
		goalCategoryList: [],
		newGoalData: {
			summary: '',
			description: '',
			due: '',
			weightage: '',
			// status: -1,
			tracking_status: 'null',
			appraisal: 0,
			category: 0,
			status: 0
		}
	}),
	async fetch() {
		this.loading = true;
		try {
			this.goalCategoryList = await this.$axios.$get(`api/category/goal/`, {
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
		this.newGoalData.appraisal = this.selectedAppraisal.id;
	},
	methods: {
		closeDialog() {
			this.$emit('close');
		},
		createGoal() {
			if (!this.loading) {
				this.loading = true;

				this.$axios
					.$post(`api/goal/`, this.newGoalData, {
						headers: {
							Authorization: `Bearer ${this.$store.state.accessToken}`
						}
					})
					.then(() => this.closeDialog())
					.catch(() => {
						this.loading = false;
						return this.$vs.notification({
							color: 'danger',
							title: 'Error creating Goal'
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
