$(document).on('click', '.memo-dialog-close-btn', function() {
    event.preventDefault();
    //해당 다이얼로그를 객체로 잡는다.
    console.log("close btn clicked");
    let dialog = $(this).closest('.memo-dialog');
    //해당 다이얼로그를 닫는다.
    dialog.remove();
});

$(document).on('click', '.memo-dialog-save-btn', function() {
    event.preventDefault();
    console.log("save btn clicked");
    let dialog = $(this).closest('.memo-dialog');
    saveMemo(dialog);
});

$(document).on('input', '.memo-dialog-color-input', function() {
    let selectedColor = $(this).val();
    console.log("color changed to " + selectedColor);
    changeMemoColor($(this), selectedColor);
});

$(document).on('click', '.memo-dialog-edit-btn', function() {
    event.preventDefault();
    console.log("save btn clicked");
    let dialog = $(this).closest('.memo-dialog');
    editMemo(dialog);
});

