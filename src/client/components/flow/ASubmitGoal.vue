<template>
	<vs-dialog v-model="active" :loading="loading" not-close prevent-close>
		<template #header>
			<h4 class="not-margin"><b>Submit Goals, Core Value and skills</b></h4>

			<vs-button class="closeDialogButton" icon floating @click="closeDialog">
				<i class="bx bx-x"></i>
			</vs-button>
		</template>

		<!-- <div v-if="$fetchState.pending"><Spinner /></div> -->
		<div class="con-form">
			<Appraisal :edit="true" :selected-appraisal="appraisal" />
		</div>

		<template #footer>
			<div class="footer-dialog">
				<vs-button :loading="loading" block @click="submitGoal"> Submit Goals </vs-button>
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
		appraisal: Object
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
		submitGoal() {
			this.$axios
				.$post(`api/appraisal/${this.appraisal.id}/up-stage/submit/`, this.roleData, {
					headers: {
						Authorization: `Bearer ${this.$store.state.accessToken}`
					}
				})
				.then(() => {
					this.$vs.notification({
						color: 'success',
						title: 'Suucessfullly submitted goals'
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
