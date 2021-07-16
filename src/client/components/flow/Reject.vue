<template>
	<vs-dialog v-model="active" style="min-width: 600px" not-close prevent-close>
		<template #header>
			<h4 class="not-margin">Reject Appraisal {{ appraisal.name }}</h4>
			<vs-button class="closeDialogButton" icon floating @click="closeDialog">
				<i class="bx bx-x"></i>
			</vs-button>
		</template>
		<vs-row style="padding: 20px 0">
			<vs-col w="4"> <b>Rjection comment</b> </vs-col>
			<vs-col w="8">
				<!-- eslint-disable-next-line vue/no-v-html -->
				<Editor :data="comment" @changeData="changeComment" />
			</vs-col>
		</vs-row>
		<template #footer>
			<div class="footer-dialog">
				<vs-button danger :loading="loading" @click="reject"> Reject </vs-button>
			</div>
		</template>
	</vs-dialog>
</template>

<script>
export default {
	props: {
		dialog: Boolean,
		// eslint-disable-next-line vue/require-default-prop
		appraisal: Object
		// eslint-disable-next-line vue/require-default-prop
	},
	data: () => ({
		active: false,
		loading: false
	}),
	computed: {
		stage() {
			return this.appraisal.overall_appraisal.stage;
		},
		comment: {
			get() {
				if (this.stage === 0) {
					return this.appraisal.stage0_rejection_comment;
				} else if (this.stage === 0) {
					return this.appraisal.stage1_rejection_comment;
				} else return this.appraisal.stage2_rejection_comment;
			}
		}
	},

	mounted() {
		this.active = this.dialog;
	},
	methods: {
		changeComment(comment) {
			if (this.stage === 0) {
				// eslint-disable-next-line vue/no-mutating-props
				this.appraisal.stage0_rejection_comment = comment;
			} else if (this.stage === 0) {
				// eslint-disable-next-line vue/no-mutating-props
				this.appraisal.stage1_rejection_comment = comment;
				// eslint-disable-next-line vue/no-mutating-props
			} else this.appraisal.stage2_rejection_comment = comment;
		},
		closeDialog() {
			this.$emit('close');
		},

		reject() {
			this.$axios
				.$post(
					`api/appraisal/${this.appraisal.id}/reject/stage-${this.stage}/`,
					{
						comment: this.comment
					},
					{
						headers: {
							Authorization: `Bearer ${this.$store.state.accessToken}`
						}
					}
				)
				.then(() => {
					this.$vs.notification({
						color: 'success',
						title: `Suucessfullly  rejected appraisal . rejection comment is  ${this.comment}`
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
