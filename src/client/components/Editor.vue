<template>
	<ckeditor v-model="editorData" :editor="editor" :config="editorConfig"></ckeditor>
</template>

<script>
import ClassicEditor from '@ckeditor/ckeditor5-build-classic';
export default {
	props: {
		data: {
			type: String,
			required: true
		}
	},
	data: () => ({
		editor: ClassicEditor,

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

<style></style>
