
class Memo{
    constructor(memoNo, memoTitle, memoContents, memoRegDate, memoDelDate, memoColor, memoAuthor,tripPlan,review, chatRoom){
        this.memoNo = memoNo;
        this.memoTitle = memoTitle;
        this.memoContents = memoContents;
        this.memoRegDate = memoRegDate;
        this.memoDelDate = memoDelDate;
        this.memoColor = memoColor;
        this.memoAuthor = memoAuthor;
        this.tripPlan = tripPlan;
        this.review = review;
        this.chatRoom = chatRoom;
    }
}

function buildMemoDialog(memo){
    //console.log("buildMemoDialog on");
    let memoNo = memo.memoNo;
    let memoTitle = memo.memoTitle;
    let memoContents = memo.memoContents;
    let memoRegDate = memo.memoRegDate;
    let memoDelDate = memo.memoDelDate;
    let memoColor = memo.memoColor;
    let memoAuthor = memo.memoAuthor;
    let tripPlan = memo.attachedTripPlan;
    let review = memo.attachedReview;
    let chatRoom = memo.attachedChatRoom;
//    alert('tripPlan : ' + tripPlan.tripPlanNo + ' review : ' + review.reviewNo + ' chatRoom : ' + chatRoom);

    let infoJson = JSON.stringify(memo);
    let memoDialog =  $('<div>', {
        class: 'memo-dialog',
        title: memoTitle
    });

    // memono 입력란 생성
    let memoNoInput = $('<input>', {
        class: 'memo-dialog-memoNo',
        type: 'hidden',
        value: memoNo
    });
    let infoInput = $('<input>', {
        class: 'memo-dialog-info',
        type: 'hidden',
        value: infoJson
    });
    let contentsDiv = $('<div>', {
        class: 'memo-contents-div',
        html: memoContents
    });
    let summernoteContainer = $('<div>', {
        class: 'summernote-container'
    });
    let summernoteContents = $('<textarea>', {
        class: 'summernote-contents',
        text: memoContents
    });
    let dialogView = $('<div>', {
        class: 'memo-dialog-view modal-body'
    });
    dialogView.append(contentsDiv, summernoteContainer.append(summernoteContents));

    let dialogControl = $('<div>', {
        class: 'memo-dialog-control modal-footer'
    });
    let closeBtn = $('<button>', {
        type: 'button',
        class: 'btn btn-sm btn-default hvr-grow memo-dialog-close-btn',
        text: '닫기'
    });
    let editBtn = $('<button>', {
        type: 'button',
        class: 'btn btn-sm btn-primary hvr-grow memo-dialog-edit-btn',
        text: '수정'
    });
    let saveBtn = $('<button>', {
        type: 'button',
        class: 'btn btn-sm btn-primary hvr-grow memo-dialog-save-btn',
        text: '저장'
    });
    let deleteBtn = $('<button>', {
        type: 'button',
        class: 'btn btn-sm btn-danger hvr-grow memo-dialog-delete-btn',
        text: '삭제'
    });
    let shareBtn = $('<button>', {
        type: 'button',
        class: 'btn btn-sm btn-info hvr-grow memo-dialog-share-btn',
        text: '공유'
    });
    let attachBtn = $('<button>', {
        type: 'button',
        class: 'btn btn-sm btn-warning hvr-grow memo-dialog-attach-btn',
        text: '부착'
    });
    let detachBtn = $('<button>', {
        type: 'button',
        class: 'btn btn-sm btn-warning hvr-grow memo-dialog-detach-btn',
        text: '탈착'
    });
    let restoreBtn = $('<button>', {
        type: 'button',
        class: 'btn btn-sm btn-primary hvr-grow memo-dialog-restore-btn',
        text: '복구'
    });
    let removeBtn = $('<button>', {
        type: 'button',
        class: 'btn btn-sm btn-danger hvr-grow memo-dialog-remove-btn',
        text: '제거'
    });
    dialogControl.append(saveBtn,closeBtn, editBtn, deleteBtn,shareBtn,attachBtn,detachBtn,restoreBtn,removeBtn);

    // memo-dialog에 모든 요소 추가
    memoDialog.append(memoNoInput, infoInput, dialogView, dialogControl);

    //현재 서치 컨디션을 갖고온다.
    let searchCondition = $('#memo-search-condition').val();
    if(searchCondition == 'myMemo'){
        restoreBtn.hide();
        removeBtn.hide()
    }else if(searchCondition == 'sharedMemo'){
        saveBtn.hide();
        editBtn.hide();
        deleteBtn.hide();
        attachBtn.hide();
        restoreBtn.hide();
        removeBtn.hide();
    } else {
        saveBtn.hide();
        editBtn.hide();
        attachBtn.hide();
        deleteBtn.hide();
        shareBtn.hide();
    }
    detachBtn.hide();
    if (tripPlan && tripPlan.tripPlanNo != 0 && tripPlan.tripPlanNo != null && tripPlan.tripPlanNo != undefined) {
        // If tripPlan is not null and tripPlanNo is not 0, null, or undefined
        attachBtn.hide();
        detachBtn.show();
        detachBtn.val(memoNo);
    } else if (review && review.reviewNo != 0 && review.reviewNo != null && review.reviewNo != undefined) {
        // If review is not null and reviewNo is not 0, null, or undefined
//        alert('reviewNo: ' + review.reviewNo);
        attachBtn.hide();
        detachBtn.show();
        detachBtn.val(memoNo);
    } else if (chatRoom && chatRoom.chatRoomNo != 0 && chatRoom.chatRoomNo != null && chatRoom.chatRoomNo != undefined) {
        // If chatRoom is not null and chatRoomNo is not 0, null, or undefined
//        alert('chatRoomNo: ' + chatRoom.chatRoomNo);
        attachBtn.hide();
        detachBtn.show();
        detachBtn.val(memoNo);
    } else {
//        alert('미부착');
        attachBtn.show();
    }



    return memoDialog;
}



function buildNewMemo(userId){
    console.log("buildMemo on");
    let memo = new Memo();
    memo.memoAuthor = userId;
    memo.memoTitle = "제목을 입력하세요";
    memo.memoColor = "yellow";
    memo.memoContents = "내용을 입력하세요";
    memo.memoRegDate = new Date();
    let memoDialog = buildMemoDialog(memo);
    console.log("buildMemoDialog done");
    //반환받은 메모 다이얼로그에서 버튼들을 숨긴다.
    memoDialog.find('.memo-dialog-edit-btn').hide();
    memoDialog.find('.memo-dialog-delete-btn').hide();
    memoDialog.find('.memo-dialog-share-btn').hide();
    memoDialog.find('.memo-dialog-attach-btn').hide();
    memoDialog.find('.memo-dialog-detach-btn').hide();
    memoDialog.find('.memo-dialog-restore-btn').hide();
    memoDialog.find('.memo-dialog-remove-btn').hide();


    //반환받은 다이얼로그를 id="memo-dialogs" 에 추가한다.
    $('#memo-dialogs').append(memoDialog);
    //다이얼로그를 열어준다.
    memoDialog.dialog({
        autoOpen: true,
        autoResize: true,
        width: 400,
        height: 'auto'
    });


    //서머노트를 적용한다.
    memoDialog.find('.summernote-contents').summernote();
    //서머노트 div를 숨긴다.
    memoDialog.find('.summernote-container').hide();
    //contents-div 를 닫는다.
    //memoDialog.find('.memo-contents-div').hide();

    editMemo(memoDialog);
}

function showMemoDialog(memo){
    let memoDialog = buildMemoDialog(memo);
    //반환받은 다이얼로그를 id="memo-dialogs" 에 추가한다.
    $('#memo-dialogs').append(memoDialog);
    //다이얼로그를 열어준다.
    memoDialog.dialog({
        autoOpen: true,
        autoResize: true,
        width: 400,
        height: 'auto'
    });
    //서머노트를 적용한다.
    memoDialog.find('.summernote-contents').summernote();
    //메모다이얼로그에서 서머노트를 숨긴다.
    memoDialog.find('.summernote-container').hide();
    //메모다이얼로그에서 저장 버튼을 숨긴다.
    memoDialog.find('.memo-dialog-save-btn').hide();

}

function buildMemoSharerTableRow(memoAccess) {
    let userId = memoAccess.memoAccessUser;
    let userNickname = memoAccess.userNickname;
    let userEmail = memoAccess.userEmail;

    let row = $('<tr>');
    row.append($('<td>').html('<span class="memo-sharer">' + userNickname + '</span>'));
    row.append($('<td>').text(userEmail));
    row.append($('<td>').html('<a href="/user/getUser?userId=' + userId + '">자세히</a>'));
    row.append($('<td>').html('<button class="memo-share-modal-unShare-btn-for-sharer" value="' + userId + '">공유해제</button>'));
    return row;
}

function buildMemoShareeTableRow(memoNo){

    let row = $('<tr>');
    row.append($('<td>').html('<input class="new-memo-sharee-input" placeholder="nickname">'));
    row.append($('<td>').html('_'));
    row.append($('<td>').html('<span class="nickname-valid-check"></span>'));
    row.append($('<td>').html('<button class="new-memo-sharee-ajax-btn" value="'+memoNo+'">공유</button>'));
    return row;
}

