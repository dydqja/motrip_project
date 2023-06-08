
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
    console.log("buildMemoDialog on");
    let memoNo = memo.memoNo;
    let memoTitle = memo.memoTitle;
    let memoContents = memo.memoContents;
    let memoRegDate = memo.memoRegDate;
    let memoDelDate = memo.memoDelDate;
    let memoColor = memo.memoColor;
    let memoAuthor = memo.memoAuthor;
    let tripPlan = memo.tripPlan;
    let review = memo.review;
    let chatRoom = memo.chatRoom;
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
        text: memoContents
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
        class: 'btn btn-sm btn-danger hvr-grow',
        text: '삭제'
    });
    let shareBtn = $('<button>', {
        type: 'button',
        class: 'btn btn-sm btn-info hvr-grow',
        text: '공유'
    });
    let attachBtn = $('<button>', {
        type: 'button',
        class: 'btn btn-sm btn-warning hvr-grow',
        text: '부착'
    });
    dialogControl.append(saveBtn,closeBtn, editBtn, deleteBtn,shareBtn,attachBtn);

    // memo-dialog에 모든 요소 추가
    memoDialog.append(memoNoInput, infoInput, dialogView, dialogControl);

    return memoDialog;
}



function buildMemo(userId){
    console.log("buildMemo on");
    let memo = new Memo();
    memo.memoAuthor = userId;
    memo.memoTitle = "제목을 입력하세요";
    memo.memoColor = "yellow";
    memo.memoContents = "내용을 입력하세요";
    memo.memoRegDate = new Date();
    let memoDialog = buildMemoDialog(memo);
    console.log("buildMemoDialog done");
    //반환받은 다이얼로그를 id="memo-dialogs" 에 추가한다.
    $('#memo-dialogs').append(memoDialog);
    //다이얼로그를 열어준다.
    memoDialog.dialog({
        autoOpen: true
    });


    //서머노트를 적용한다.
    memoDialog.find('.summernote-contents').summernote();
    //서머노트 div를 숨긴다.
    memoDialog.find('.summernote-container').hide();
    //contents-div 를 닫는다.
    //memoDialog.find('.memo-contents-div').hide();

    editMemo(memoDialog);
}


