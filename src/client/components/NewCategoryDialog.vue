<template>
	<vs-dialog v-model="active" not-close prevent-close>
		<template #header>
			<h4 class="not-margin">Add a new <b>Category</b></h4>

			<vs-button class="closeDialogButton" icon floating @click="closeDialog">
				<i class="bx bx-x"></i>
			</vs-button>
		</template>

		<div class="con-form">
			<vs-select
				v-if="$store.state.user.user.is_superuser"
				v-model="newCategoryData.company"
				placeholder="Select Company"
				style="margin-bottom: 10px"
				block
				filter
			>
				<vs-option
					v-for="company in companyList"
					:key="company.id"
					:label="company.name"
					:value="company.id"
				>
					{{ company.name }}
				</vs-option>
			</vs-select>

			<vs-select
				v-model="selectedCategory"
				placeholder="Category Type"
				style="margin-bottom: 10px"
				block
				filter
			>
				<vs-option label="Core Value" value="core_value"> Core Value </vs-option>
				<vs-option label="Skills" value="skills"> Skills </vs-option>
				<vs-option label="Goals" value="goal"> Goals </vs-option>
			</vs-select>

			<vs-input v-model="newCategoryData.name" placeholder="Category Name">
				<template #icon>
					<i class="bx bx-building"></i>
				</template>
			</vs-input>
		</div>

		<template #footer>
			<div class="footer-dialog">
				<vs-button :loading="loading" block @click="createCategory"> Add New </vs-button>
			</div>
		</template>
	</vs-dialog>
</template>

<script>
export default {
	name: 'NewCategoryDialog',
	props: {
		dialog: Boolean,
		// eslint-disable-next-line vue/require-default-prop
		companyList: Array
	},
	data: () => ({
		active: false,
		loading: false,
		selectedCategory: 'core_value',
		newCategoryData: {
			name: '',
			company: 0
		}
	}),
	mounted() {
		this.active = this.dialog;

		if (!this.$store.state.user.user.is_superuser) {
			this.newCategoryData.company = this.$store.state.user.user.company;
		}
	},
	methods: {
		closeDialog() {
			this.$emit('close');
		},
		createCategory() {
			if (!this.loading) {
				this.loading = true;

				this.$axios
					.$post(`api/category/${this.selectedCategory}/`, this.newCategoryData, {
						headers: {
							Authorization: `Bearer ${this.$store.state.accessToken}`
						}
					})
					.then(() => this.closeDialog())
					.catch(() => {
						this.loading = false;
						return this.$vs.notification({
							color: 'danger',
							title: 'Error creating category'
						});
					});
			}
		}
	}
};
</script>
