<template>
	<div>
		<editor :editor="editor" />
	</div>
</template>

<script>
import { Editor } from '@tiptap/core';
import StarterKit from '@tiptap/starter-kit';
export default {
	components: {
		Editor
	},
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
		editor: null,

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
	},
	mounted() {
		this.editor = new Editor({
			extensions: [StarterKit],
			content: this.editorData,
			onUpdate: () => {
				// HTML
				this.$emit('input', this.editor.getHTML());

				// JSON
				// this.$emit('input', this.editor.getJSON())
			}
		});
	},

	beforeDestroy() {
		this.editor.destroy();
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
