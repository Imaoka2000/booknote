import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["input", "preview"]

    connect() {
        this.inputTarget.addEventListener("change", (e) => {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = (ev) => {
                    this.previewTarget.src = ev.target.result;
                };
                reader.readAsDataURL(file);
            }
        });
    }
}
