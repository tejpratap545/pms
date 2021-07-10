<template>
	<vs-dialog v-model="active" :loading="loading" not-close prevent-close>
		<template #header>
			<h4 class="not-margin"><b>Approve Mid Year Review</b></h4>

			<vs-button class="closeDialogButton" icon floating @click="closeDialog">
				<i class="bx bx-x"></i>
			</vs-button>
		</template>

		<div v-if="$fetchState.pending">loading ...</div>
		<di v-else class="con-form">
			<EmployeeInfo :employee="appraisal.employee" />
			<Appraisal :edit="false" :selected-appraisal="appraisal" @refresh="$fetch()" />
		</di>

		<template #footer>
			<div class="footer-dialog">
				<vs-button :loading="loading" block @click="approveGoal"> Approve </vs-button>
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
		appraisalId: Number
	},
	data: () => ({
		active: false,
		loading: false,
		appraisal: {}
	}),

	async fetch() {
		this.loading = true;
		this.appraisal = await this.$axios.$get(`api/appraisal/${this.appraisalId}/`, {
			headers: {
				Authorization: `Bearer ${this.$store.state.accessToken}`
			}
		});
		this.loading = false;
	},

	mounted() {
		this.active = this.dialog;
	},
	methods: {
		closeDialog() {
			this.$emit('close');
		},
		approveGoal() {
			this.loading = true;
			this.$axios
				.$post(
					`api/appraisal/${this.appraisalId}/up-stage/manager/mid-approve/`,
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
						title: `"Suucessfullly approved mid year review   ${this.appraisal.name} of ${this.appraisal.employee.name}"`
					});
					this.closeDialog();
				})
				.catch(() => {
					return this.$vs.notification({
						color: 'danger',
						title: `"Error Approving mid year review appraisal ${this.appraisal.name} of ${this.appraisal.employee.name}. All goals must be approved "`
					});
				})
				.finally(() => {
					this.loading = false;
				});
		}
	}
};
</script>
