
/*$(document).ready(function(){
    console.log("buildMemo.js loaded");
    $(".memo-dialog").dialog({
        autoOpen: true,
        width: 400
    });

    $(document).ready(function() {
        $('.summernote-contents').summernote();
    });
    //서머노트의 자식들 중
    $(".summernote-container").hide();
});*/

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
    let tripPlan = memo.tripPlan;
    if(!tripPlan){
        tripPlan = memo.attachedTripPlan;
    }
    let review = memo.review;
    if(!review){
        review = memo.attachedReview;
    }
    let chatRoom = memo.chatRoom;
    if(!chatRoom){
        chatRoom = memo.attachedChatRoom;
    }
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
    dialogControl.append(saveBtn,closeBtn, editBtn, deleteBtn,shareBtn,attachBtn,restoreBtn,removeBtn);

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
        removeBtn.hide()
    } else {
        saveBtn.hide();
        editBtn.hide();
        attachBtn.hide();
        deleteBtn.hide();
        shareBtn.hide();
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

function buildMemoSharerTableRow(memoAccess){
    let userId = memoAccess.memoAccessUser;
    let userNickname = memoAccess.userNickname;
    let userEmail = memoAccess.userEmail;

    let row = $('<tr>');
    row.append($('<td>').text(userNickname));
    row.append($('<td>').text(userEmail));
    row.append($('<td>').html('<a href="/user/getUser?userId="'+userId+'>자세히</a>'));
    row.append($('<td>').html('<button class="memo-share-modal-unShare-btn-for-sharer" value="'+userId+'">공유해제</button>'));
    return row;
}

