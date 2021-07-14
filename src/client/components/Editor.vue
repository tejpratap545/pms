<template>
	<div>
		<froala v-model="editorData" :tag="'textarea'" :config="config"></froala>
	</div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import VueFroala from 'vue-froala-wysiwyg';
export default {
	props: {
		data: {
			type: String,
			required: true
		}
	},
	data: () => ({
		config: {
			placeholderText: 'Edit Your Content Here!',
			theme: 'dark',
			events: {
				'froalaEditor.initialized'() {
					console.log('initialized');
				}
			}
		},

		editorConfig: {
			// The configuration of the editor.
		}
	}),

	computed: {
		editorData: {
			get() {
				return this.data;
			},
			set(value) {
				this.$emit('changeData', value);
			}
		}
	}
};
</script>

<style>
:root {
	--color: red;
}

.ck-editor {
	color: var(--color);
}
</style>
