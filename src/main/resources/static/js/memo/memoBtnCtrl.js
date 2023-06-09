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

$(document).on('click', '.trip-plan-memo-btn', function() {
    event.preventDefault();
    console.log("trip-plan-memo-btn clicked");
    //이 버튼의 값은 tripPlanNo 이다.
    let tripPlanNo = $(this).val();
    window.location.href = "/tripPlan/selectTripPlan?tripPlanNo="+tripPlanNo;
});

$(document).on('click', '.review-memo-btn', function() {
    event.preventDefault();
    console.log("review-memo-btn clicked");
    //이 버튼의 값은 reviewNo 이다.
    let reviewNo = $(this).val();
    window.location.href = "/review/getReview?reviewNo="+reviewNo;
});

$(document).on('click', '.chat-room-memo-btn', function() {
    event.preventDefault();
    console.log("chat-room-memo-btn clicked");
    //이 버튼의 값은 chatRoomNo 이다.
    let chatRoomNo = $(this).val();
    window.location.href = "/chatRoom/getChatRoom?chatRoomNo="+chatRoomNo;
});

//memo-list-thumbnail-btn
$(document).on('click', '.memo-list-thumbnail-btn', function() {
    event.preventDefault();
    console.log("memo-list-thumbnail-btn clicked");
    //이 버튼의 값은 memoNo 이다.
    let memoJson = $(this).val();
    let memo = JSON.parse(memoJson);
    showMemoDialog(memo);
});

$(document).on('click', '.memo-dialog-share-btn', function() {
    let dialog = $(this).closest('.memo-dialog');
    shareMemo(dialog);
});

