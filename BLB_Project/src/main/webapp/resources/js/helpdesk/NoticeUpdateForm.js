$(document).ready(function () {
            // File upload preview
            $('#upfile').on('change', function () {
                const files = this.files;
                const previewGrid = $('#filePreviewGrid');
                if (files.length + previewGrid.children('.file-preview').length > 5) {
                    alert('이미지는 최대 5개까지 업로드 가능합니다.');
                    return;
                }

                Array.from(files).forEach(file => {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        const preview = `
                            <div class="file-preview" data-temp="true">
                                <img src="${e.target.result}" width="400px" height="400px">
                                <button type="button" class="delete-btn">×</button>
                            </div>`;
                        previewGrid.append(preview);
                    };
                    reader.readAsDataURL(file);
                });

                this.value = ""; // Reset file input
            });

            // Delete preview file
            $(document).on('click', '.delete-btn', function () {
                const preview = $(this).closest('.file-preview');
                const fileName = preview.data('id');

                if (fileName) {
                    // Server-side file deletion logic can go here
                    console.log('Delete file:', fileName);
                }

                preview.remove();
            });
        });