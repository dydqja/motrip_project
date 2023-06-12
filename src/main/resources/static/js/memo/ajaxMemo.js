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
function getMemoShareListRequest(memoNo){
    $.ajax({
        type: 'post',
        url: '/memo/getMemoSharerList',
        dataType: 'json',
        data:{
            memoNo: memoNo
        }
    }).success(function (memoAccessList) {
        $("#memo-sharer-list-body").html('');
        $("#memo-sharer-list-body").append("<input type='hidden' id='memo-sharer-list-memoNo' value='"+memoNo+"'>");
        //shareList 의 구성원인 각 user 를 for 문으로 순회하며 buildMemoSharerTableRow() 를 호출한다.
        if(memoAccessList.length == 0){
            //공유자가 없음을 알리는 row 를 #memo-sharer-list-body 에 추가한다.
            let row = "<tr><td colspan='3' style='text-align:center;'> - 공유자가 없습니다. - </td></tr>";
            $("#memo-sharer-list-body").append(row);
        }else{
            //칼럼명을 표시할 첫 row를 생성한다.
            let row1 = $('<tr>');
            row1.append($('<td>').text("닉네임"));
            row1.append($('<td>').text("이메일"));
            row1.append($('<td>').text(""));
            row1.append($('<td>').text(''));
            $("#memo-sharer-list-body").append(row1);

            //for문 돌려서 공유자들 리스트를 만들어 붙인다.
            for(let i=0; i<memoAccessList.length; i++){
                let memoAccess = memoAccessList[i];
                let row = buildMemoSharerTableRow(memoAccess);
                //row 를 #memo-sharer-list-body 에 추가한다.
                $("#memo-sharer-list-body").append(row);
            }
        }
        //공유자 추가 부분을 생성하는 섹션
        //현재 비어있는 공유자 추가 칸이 있는지 확인하고, 비어있는 칸이 없다면 하나 만든다.
        let isEmpty = false;
        $('.new-memo-sharee-input').each(function() {
            if ($(this).val() === '') {
                isEmpty = true;
                return false;
            }
        });
        if (!isEmpty) {
            let newRow = buildMemoShareeTableRow(memoNo);
            $("#memo-sharee-list-body").append(newRow)
        }

        //#memo-sharer-list-body에 memoNo를 담을 hidden input 을 추가한다.
        $("#memo-share-modal").modal('show');
    }).fail(function (error) {
        alert(JSON.stringify(error));
    });
}

function unshareMemoReQuestForShared(memoNo,userId){
    $.ajax({
        type: 'post'
        ,url: '/memo/deleteMemoAccess'
        ,dataType: 'json'
        ,data: {
            memoNo: memoNo,
            userId: userId
        }
    }).success(function (result) {
        if(result){
            //alert("공유를 해제했습니다.");
            Swal.fire(
                '성공!',
                '이 메모를 보지 않게 되었습니다.',
                'success'
            )
            $("#memo-share-modal").modal('hide');
            getMemoList('sharedMemo');
        }
    }).fail(function (error) {
        alert(JSON.stringify(error));
    });
}

function unshareMemoRequest(memoNo,userId){
    $.ajax({
        type: 'post'
        ,url: '/memo/deleteMemoAccess'
        ,dataType: 'json'
        ,data: {
            memoNo: memoNo,
            userId: userId
        }
        }).success(function (result) {
            if(result){
                //alert("공유를 해제했습니다.");
                Swal.fire(
                    '성공!',
                    '대상이 이 메모를 볼 수 없게 되었습니다.',
                    'success'
                )
                $("#memo-share-modal").modal('hide');
                getMemoShareListRequest(memoNo);
            }
        }).fail(function (error) {
            alert(JSON.stringify(error));
        });
}

function deleteMemoRequest(memoNo, memoDialog){
    $.ajax({
        type: 'post',
        url: '/memo/deleteMemo',
        dataType: 'json',
        data:{
            memoNo: memoNo
        }
    }).success(function (result) {
        if(result){
            //alert("삭제되었습니다.");
            Swal.fire(
                '성공!',
                '메모가 완전히 삭제되었습니다. 복구하지 않으면 15일 뒤에 완전히 삭제됩니다.',
                'success'
            )
            getMemoList('myMemo');
            memoDialog.dialog('close');
        }
    }).fail(function (error) {
        alert(JSON.stringify(error));
    });
}

function restoreMemoRequest(memoNo, memoDialog){
    $.ajax({
        type: 'post',
        url: '/memo/restoreMemo',
        dataType: 'json',
        data:{
            memoNo: memoNo
        }
    }).success(function (result) {
        if(result){
            //alert("복구되었습니다.");
            Swal.fire(
                '성공!',
                '메모가 복구되었습니다.',
                'success'
            )
            getMemoList('deletedMemo');
            memoDialog.dialog('close');
        }
    }).fail(function (error) {
        alert(JSON.stringify(error));
    });
}

function removeMemoRequest(memoNo, memoDialog){
    $.ajax({
        type: 'post',
        url: '/memo/removeMemo',
        dataType: 'json',
        data:{
            memoNo: memoNo
        }
    }).success(function (result) {
        if(result){
            //alert("제거되었습니다.");
            Swal.fire(
                '성공!',
                '메모가 완전히 제거되었습니다.',
                'success'
            )
            getMemoList('deletedMemo');
            memoDialog.dialog('close');
        }
    }).fail(function (error) {
        alert(JSON.stringify(error));
    });
}
function addMemoAccessRequest(memoNo,nickname){
    console.log('addMemoAccessRequest on')
    $.ajax({
        type: 'post',
        url: '/memo/addMemoAccess',
        dataType: 'json',
        data:{
            memoNo: memoNo,
            nickname: nickname
        }
    }).success(function (data){
        if(data.status==='fail'){
            Swal.fire(
                '이런!',
                '존재하지 않는 회원에게 메모를 공유할순 없습니다!',
                'error'
            )
        }

        getMemoShareListRequest(memoNo);
    }).fail(function (){
        alert(JSON.stringify(error));
    });
}
function nicknameCheckRequest(nickname,checkSpace){
    $.ajax({
        type: 'post',
        url: '/user/checkNickname',
        dataType: 'json',
        data:{
            value: nickname
        }
    }).success(function (data){
        if(data===1){
            checkSpace.text('존재하지 않는 회원입니다.');
        }else{
            checkSpace.text('존재하는 회원입니다.');
        }
    }).fail(function (){
        alert(JSON.stringify(error));
    });
}

