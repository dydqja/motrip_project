$(document).on('click', '.memo-dialog-close-btn', function() {
    event.preventDefault();
    //해당 다이얼로그를 객체로 잡는다.
//    console.log("close btn clicked");
    let dialog = $(this).closest('.memo-dialog');
    //해당 다이얼로그를 닫는다.
    dialog.remove();
});

$(document).on('click', '.memo-dialog-save-btn', function() {
    event.preventDefault();
//    console.log("save btn clicked");
    let dialog = $(this).closest('.memo-dialog');
    saveMemo(dialog);
});

$(document).on('input', '.memo-dialog-color-input', function() {
    let selectedColor = $(this).val();
//    console.log("color changed to " + selectedColor);
    changeMemoColor($(this), selectedColor);
});

$(document).on('click', '.memo-dialog-edit-btn', function() {
    event.preventDefault();
  //  console.log("save btn clicked");
    let dialog = $(this).closest('.memo-dialog');
    editMemo(dialog);
});

$(document).on('click', '.trip-plan-memo-btn', function() {
    event.preventDefault();
    //console.log("trip-plan-memo-btn clicked");
    //이 버튼의 값은 tripPlanNo 이다.
    let tripPlanNo = $(this).val();
    window.location.href = "/tripPlan/selectTripPlan?tripPlanNo="+tripPlanNo;
});

$(document).on('click', '.review-memo-btn', function() {
    event.preventDefault();
    //console.log("review-memo-btn clicked");
    //이 버튼의 값은 reviewNo 이다.
    let reviewNo = $(this).val();
    window.location.href = "/review/getReview?reviewNo="+reviewNo;
});

$(document).on('click', '.chat-room-memo-btn', function() {
    event.preventDefault();
    //console.log("chat-room-memo-btn clicked");
    //이 버튼의 값은 chatRoomNo 이다.
    let chatRoomNo = $(this).val();
    window.location.href = "/chatRoom/getChatRoom?chatRoomNo="+chatRoomNo;
});

//memo-list-thumbnail-btn
$(document).on('click', '.memo-list-thumbnail-btn', function() {
    event.preventDefault();
    //console.log("memo-list-thumbnail-btn clicked");
    //이 버튼의 값은 memoNo 이다.
    let memoJson = $(this).val();
    let memo = JSON.parse(memoJson);
    showMemoDialog(memo);
});

$(document).on('click', '.memo-dialog-share-btn', function() {
    event.preventDefault();
    let dialog = $(this).closest('.memo-dialog');
    shareMemo(dialog);
});

$(document).on('click', '.memo-dialog-delete-btn', function() {
    event.preventDefault();
    let memoDialog = $(this).closest('.memo-dialog');
    deleteMemo(memoDialog);
});

$(document).on('click', '.memo-dialog-restore-btn', function() {
    event.preventDefault();
    let memoDialog = $(this).closest('.memo-dialog');
    restoreMemo(memoDialog);
});

$(document).on('click', '.memo-dialog-remove-btn', function() {
    event.preventDefault();
    let memoDialog = $(this).closest('.memo-dialog');
    removeMemo(memoDialog);
});



$(document).on('click', '.memo-share-modal-unShare-btn-for-sharer', function() {
    event.preventDefault();
    //unShareMemo 를 하기 위한 정보를 모은다.
    //memoNo 는 memo-sharer-list-memoNo 에 있다.
    let memoNo = $(this).closest('#memo-sharer-list-body').find('#memo-sharer-list-memoNo').val();
    let memoAccessUser = $(this).val();
    //console.log("공유해제될 memoNo : " + memoNo);
    //console.log("공유해제될 memoAccessUser : " + memoAccessUser);
    unshareMemoRequest(memoNo, memoAccessUser);
});

$(document).on('click', '#memo-share-modal-unShare-btn-for-shared', function() {
   event.preventDefault();
    //unShareMemo 를 하기 위한 정보를 모은다.
    let memoNo = $("#memo-sharer-list-memoNo").val();
    let memoAccessUser = $(this).val();
    //console.log("공유해제될 memoNo : " + memoNo);
    //console.log("공유해제될 memoAccessUser : " + memoAccessUser);
    unshareMemoReQuestForShared(memoNo, memoAccessUser);
});
//new-memo-sharee-plus-btn
$(document).on('click', '.new-memo-sharee-ajax-btn', function() {
    console.log('#new-memo-sharee-ajax-btn clicked');
    event.preventDefault();
    //공유자를 추가하기 위한 정보를 모은다.
    //memoNo 는 이 버튼의 value 다.
    let memoNo = $(this).val();
    //console.log('memoNo ='+memoNo)
    //nickname 는 가장 가까운 new-memo-sharee-input의 값이다.
    let nickname = $(this).closest('tr').find('.new-memo-sharee-input').val();
    //console.log('nickname = '+nickname);

    //만약 입력된 닉네임이 현재 공유중인 사람들 중에 있다면 얼럿을 띄우고 리턴한다.
    let sharingGuys = $('.memo-sharer').map(function() {
        return $(this).text();
    }).get();
    if (sharingGuys.includes(nickname)) {
        Swal.fire(
            '이런!',
            '이미 공유된 회원에게는 메모를 다시 공유할 수 없습니다!.',
            'error'
        );
        return;
    }
    if ($('#memo-user-nickname').val() === nickname) {
        Swal.fire(
            '이런!',
            '자기 자신에게는 메모를 공유할 수 없습니다!',
            'error'
        );
        return;
    }

    addMemoAccessRequest(memoNo,nickname);
});
//    let nickname = $(this).closest('tr').find('.new-memo-sharee-input').val();
//new-memo-sharee-input
$(document).on('change', '.new-memo-sharee-input', function() {
    //지금 입력된 값
    let nickname = $(this).val();
    let checkSpace = $(this).closest('tr').find('.nickname-valid-check');
    nicknameCheckRequest(nickname,checkSpace);
});
