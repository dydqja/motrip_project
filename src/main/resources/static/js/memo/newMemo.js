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

$(document).ready(function(){
    console.log("newMemo.js loaded");
    /*$(".memo-dialog").dialog({
        autoOpen: true,
        width: 400,
    });

    $(document).ready(function() {
        $('#summernote').summernote();
    });*/
});



function buildMemo(memo){
    console.log("buildMemo on");
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

}