<template>
	<vs-dialog v-model="active" style="min-width: 600px" not-close prevent-close>
		<template #header>
			<h4 class="not-margin">Approve Or Reject <b>Goal</b></h4>
			<vs-button class="closeDialogButton" icon floating @click="closeDialog">
				<i class="bx bx-x"></i>
			</vs-button>
		</template>
		<vs-row style="padding: 20px 0">
			<vs-col w="4">
				<b>Summary</b>
			</vs-col>
			<vs-col w="8" class="description-card">
				<!-- eslint-disable-next-line vue/no-v-html -->
				<span v-html="goal.summary"></span>
			</vs-col>
		</vs-row>

		<vs-row style="padding: 20px 0">
			<vs-col w="4">
				<b>Description</b>
			</vs-col>
			<vs-col w="8" class="description-card">
				<!-- eslint-disable-next-line vue/no-v-html -->
				<span v-html="goal.description"></span>
			</vs-col>
		</vs-row>

		<template #footer>
			<div class="footer-dialog">
				<vs-button :loading="loading" @click="actionGoal('reject')"> Reject Goal </vs-button>
				<vs-button :loading="loading" @click="actionGoal('approve')"> Approve Goal </vs-button>
			</div>
		</template>
	</vs-dialog>
</template>

<script>
export default {
	props: {
		dialog: Boolean,
		// eslint-disable-next-line vue/require-default-prop
		goal: Object
	},
	data: () => ({
		active: false,
		loading: false
	}),

	mounted() {
		this.active = this.dialog;
		this.roleData = this.selectedRole;
	},
	methods: {
		closeDialog() {
			this.$emit('close');
		},
		actionGoal(action) {
			this.$axios
				.$post(`api/goal/${this.goal.id}/${action}/`, {
					headers: {
						Authorization: `Bearer ${this.$store.state.accessToken}`
					}
				})
				.then(() => {
					this.$vs.notification({
						color: 'success',
						title: `Suucessfullly  ${action} goal ${this.goal.summary}`
					});
					this.closeDialog();
				})
				.catch(() => {
					this.loading = false;
					return this.$vs.notification({
						color: 'danger',
						title: 'Error Submitting goals please check goals Weightage or kpi '
					});
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
