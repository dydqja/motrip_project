function addMemoRequest(userId, memoTitle, memoContents,memoColor,memoDialog){
    //console.log("addMemoRequest on");

    $.ajax({
        type: 'post',
        url: '/memo/addMemo',
        dataType: 'json',
        data:
            {
            userId: userId,
            memoTitle: memoTitle,
            memoContents: memoContents,
            memoColor: memoColor
            }
        })
        .success(function (addedMemo) {
            /*console.log("addMemoRequest success");
            console.log("addedMemo : " + addedMemo);
            console.log("addedMemo.memoNo : " + addedMemo.memoNo);
            console.log("addedMemo.memoTitle : " + addedMemo.memoTitle);
            console.log("addedMemo.memoContents : " + addedMemo.memoContents);
            console.log("addedMemo.memoColor : " + addedMemo.memoColor);
            console.log("addedMemo.memoRegDate : " + addedMemo.memoRegDate);
            console.log("addedMemo.memoDelDate : " + addedMemo.memoDelDate);*/

            //받은 memoDialog 의 내용을 수정한다.
            //info를 수정한다.
            let info = new Memo(addedMemo.memoNo, addedMemo.memoTitle, addedMemo.memoContents, addedMemo.memoRegDate, addedMemo.memoDelDate, addedMemo.memoColor, addedMemo.memoAuthor, addedMemo.tripPlan, addedMemo.review, addedMemo.chatRoom);
            let infoJson = JSON.stringify(info);
            memoDialog.find('.memo-dialog-info').val(infoJson);
            //title을 수정한다.
            memoDialog.siblings('.ui-dialog-titlebar').find('.ui-dialog-title').text(addedMemo.memoTitle);
            //title Input을 수정한다.
            let memoTitle = memoDialog.siblings('.ui-dialog-titlebar').find('.memo-dialog-title-input').val(addedMemo.memoTitle);
            //contents를 수정한다.
            memoDialog.find('.memo-contents-div').html(addedMemo.memoContents);
            //summernote를 수정한다.
            let summernote = memoDialog.find('.summernote-contents');
            summernote.summernote('reset');
            summernote.summernote('pasteHTML', addedMemo.memoContents);
            //unEditMemo()를 호출한다.
            unEditMemo(memoDialog);
        })
        .fail(function (error) {
            //console.log("addMemoRequest fail");
            alert(JSON.stringify(error));
            return null;
        });
}

function updateMemoRequest(userId, memoTitle, memoContents,memoColor,memoDialog){
    console.log("updateMemoRequest on");
    //info를 가져온다.
    let infoJson = memoDialog.find('.memo-dialog-info').val();
    let info = JSON.parse(infoJson);
    let memoNo = info.memoNo;
    let memoAuthor = info.memoAuthor;

    $.ajax({
        type: 'post',
        url: '/memo/updateMemo',
        dataType: 'json',
        data:
            {
                memoNo: memoNo,
                memoAuthor: memoAuthor,
                userId: userId,
                memoTitle: memoTitle,
                memoContents: memoContents,
                memoColor: memoColor
            }
    })
        .success(function (updatedMemo) {
            /*console.log("updateMemoRequest success");
            console.log("updatedMemo : " + updatedMemo);
            console.log("updatedMemo.memoNo : " + updatedMemo.memoNo);
            console.log("updatedMemo.memoTitle : " + updatedMemo.memoTitle);
            console.log("updatedMemo.memoContents : " + updatedMemo.memoContents);
            console.log("updatedMemo.memoColor : " + updatedMemo.memoColor);
            console.log("updatedMemo.memoRegDate : " + updatedMemo.memoRegDate);
            console.log("updatedMemo.memoDelDate : " + updatedMemo.memoDelDate);*/

            //받은 memoDialog 의 내용을 수정한다.
            //info를 수정한다.
            let info = new Memo(updatedMemo.memoNo, updatedMemo.memoTitle, updatedMemo.memoContents, updatedMemo.memoRegDate, updatedMemo.memoDelDate, updatedMemo.memoColor, updatedMemo.memoAuthor, updatedMemo.tripPlan, updatedMemo.review, updatedMemo.chatRoom);
            let infoJson = JSON.stringify(info);
            memoDialog.find('.memo-dialog-info').val(infoJson);
            //title을 수정한다.
            memoDialog.siblings('.ui-dialog-titlebar').find('.ui-dialog-title').text(updatedMemo.memoTitle);
            //title Input을 수정한다.
            let memoTitle = memoDialog.siblings('.ui-dialog-titlebar').find('.memo-dialog-title-input').val(updatedMemo.memoTitle);
            //contents를 수정한다.
            memoDialog.find('.memo-contents-div').html(updatedMemo.memoContents);
            //summernote를 수정한다.
            let summernote = memoDialog.find('.summernote-contents');
            summernote.summernote('reset');
            summernote.summernote('pasteHTML', updatedMemo.memoContents);
            //unEditMemo()를 호출한다.
            unEditMemo(memoDialog);
        })
        .fail(function (error) {
            //console.log("updateMemoRequest fail");
            alert(JSON.stringify(error));
            return null;
        });
}