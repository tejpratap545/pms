<template>
	<vs-dialog v-model="active" :loading="loading" not-close prevent-close>
		<template #header>
			<h4 class="not-margin">Update <b>Profile</b></h4>

			<vs-button class="closeDialogButton" icon floating @click="closeDialog">
				<i class="bx bx-x"></i>
			</vs-button>
		</template>

		<div class="con-form">
			<input id="file1" type="file" placeholder="Select Profile" />
		</div>

		<template #footer>
			<div class="footer-dialog">
				<vs-button :loading="loading" block @click="updateProfile"> Add New </vs-button>
			</div>
		</template>
	</vs-dialog>
</template>

<script>
export default {
	name: 'AddEmployeeAvatarDialog',
	props: {
		dialog: Boolean
	},
	data: () => ({
		active: false,
		loading: false
	}),
	mounted() {
		this.active = this.dialog;
	},
	methods: {
		closeDialog() {
			this.$emit('close');
		},
		updateProfile() {
			if (!this.loading) {
				this.loading = true;

				this.$axios
					.$patch(
						`api/user/${this.$store.state.user.id}/`,
						{
							avatar: document.querySelector('#file1').value
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
							title: 'Error changing avatar'
						});
					});
			}
		}
	}
};
</script>
