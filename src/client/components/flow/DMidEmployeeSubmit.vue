<template>
	<vs-dialog v-model="active" :loading="loading" scroll overflow-hidden not-close prevent-close>
		<template #header>
			<h4 class="not-margin">Submit Midyear <b>Review</b></h4>

			<vs-button class="closeDialogButton" icon floating @click="closeDialog">
				<i class="bx bx-x"></i>
			</vs-button>
		</template>

		<!-- <div v-if="$fetchState.pending"><Spinner /></div> -->
		<div class="con-form">
			<EmployeeInfo :employee="appraisal.employee" />
			<Appraisal :edit="false" :appraisal="appraisal" />
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
		loading: false
	}),

	mounted() {
		this.active = this.dialog;
	},
	methods: {
		submit() {
			this.loading = true;

			this.$axios
				.$post(
					`api/appraisal/${this.appraisal.id}/up-stage/employee/mid-submit/`,
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
						title: `"Sucessfullly submmited mid year review of  appraisal ${this.appraisal.name} ."`
					});
					this.closeDialog();
				})
				.catch(() => {
					return this.$vs.notification({
						color: 'danger',
						title: `"Error  submitting review mid year appraisal ${this.appraisal.name}."`
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
