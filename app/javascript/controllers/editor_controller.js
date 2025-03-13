import { Controller } from "@hotwired/stimulus"



export default class extends Controller {
  connect() {
    const editorElement = document.getElementById("markdown-editor");

    if (editorElement) {
      this.easymde = new EasyMDE({
        element: editorElement,
        autosave: {
          enabled: true,
          delay: 1000,
          uniqueId: `note-editor-${editorElement.dataset.noteId}`,
        },
        toolbar: [
          "bold", "italic", "heading", "|",
          "quote", "unordered-list", "ordered-list", "|",
          "link", "image", "|",
          "preview", "side-by-side", "fullscreen", "|",
          "guide",
        ],
      });
    }
  }
}
