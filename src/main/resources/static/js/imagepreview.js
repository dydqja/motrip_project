

document.getElementById("uploadFile").addEventListener("change", function(event) {
    var previewContainer = document.getElementById("image-preview");
    previewContainer.innerHTML = ""; // Clear any existing previews

    var files = event.target.files;
    for (var i = 0; i < files.length; i++) {
    var file = files[i];
    var reader = new FileReader();

    reader.onload = function(e) {
    var image = document.createElement("img");
    image.src = e.target.result;
    console.log(image.src);
    image.classList.add("preview-image");
    previewContainer.appendChild(image);
    };

    reader.readAsDataURL(file);
    }
});
