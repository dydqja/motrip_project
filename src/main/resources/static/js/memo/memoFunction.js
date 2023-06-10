
function editMemo(memoDialog){
    //다이얼로그로부터 memoTitle을 추출한다.
    let memoTitle = memoDialog.dialog('option', 'title');

    //기존 다이얼로그에 title-input 이 있는지 확인한다.
    if(memoDialog.siblings('.ui-dialog-titlebar').find('.memo-dialog-title-input').length > 0){
        console.log("title input already exists");
        //기존 title input 을 드러낸다.
        memoDialog.siblings('.ui-dialog-titlebar').find('.memo-dialog-title-input').show();
    }else {
        //타이틀을 수정하기 위한 input을 만든다.
        let titleInput = $('<input>', {
            class: 'memo-dialog-title-input',
            type: 'text',
            value: memoTitle,
            mousedown: function(e) {
                e.stopPropagation(); // 입력 필드에서의 mousedown 이벤트 전파 중지
            }
        });
        //타이틀을 수정하기 위한 input을 붙인다.
        memoDialog.siblings('.ui-dialog-titlebar').append(titleInput);
    }

    //기존 타이틀을 숨긴다.
    memoDialog.siblings('.ui-dialog-titlebar').find('.ui-dialog-title').hide();


    //기존 다이얼로그에 color-input 이 있는지 확인한다.
    if(memoDialog.siblings('.ui-dialog-titlebar').find('.memo-dialog-color-input').length > 0){
        console.log("color input already exists");
        //기존 color input 을 드러낸다.
        memoDialog.siblings('.ui-dialog-titlebar').find('.memo-dialog-color-input').show();
    }else{
        //다이얼로그로부터 색을 추출한다.
        let memoColor = memoDialog.find('.memo-dialog-info').val();
        //색을 수정하기 위한 input을 만든다.
        let colorInput = $('<input>', {
            class: 'memo-dialog-color-input',
            type: 'color',
            value: memoColor,
            mousedown: function(e) {
                e.stopPropagation(); // 입력 필드에서의 mousedown 이벤트 전파 중지
            }
        });
        //색을 수정하기 위한 input을 붙인다.
        memoDialog.siblings('.ui-dialog-titlebar').prepend(colorInput);
    }
    //기존 컨텐츠를 숨긴다.
    memoDialog.find('.memo-contents-div').hide();
    //서머노트를 드러낸다.
    memoDialog.find('.summernote-container').show();
    //저장버튼을 드러낸다.
    memoDialog.find('.memo-dialog-save-btn').show();
    //수정버튼을 숨긴다.
    memoDialog.find('.memo-dialog-edit-btn').hide();
}

function unEditMemo(memoDialog){
    //다이얼로그의 title input 을 숨긴다.
    memoDialog.siblings('.ui-dialog-titlebar').find('.memo-dialog-title-input').hide();
    //다이얼로그의 title을 드러낸다.
    memoDialog.siblings('.ui-dialog-titlebar').find('.ui-dialog-title').show();
    //다이얼로그의 color input 을 숨긴다.
    memoDialog.siblings('.ui-dialog-titlebar').find('.memo-dialog-color-input').hide();
    //다이얼로그의 컨텐츠를 드러낸다.
    memoDialog.find('.memo-contents-div').show();
    //다이얼로그의 서머노트를 숨긴다.
    memoDialog.find('.summernote-container').hide();
    //저장버튼을 숨긴다.
    memoDialog.find('.memo-dialog-save-btn').hide();
    //수정버튼을 드러낸다.
    memoDialog.find('.memo-dialog-edit-btn').show();
    //삭제버튼을 드러낸다.
    memoDialog.find('.memo-dialog-delete-btn').show();
    //공유버튼을 드러낸다.
    memoDialog.find('.memo-dialog-share-btn').show();
    //부착버튼을 드러낸다.
    memoDialog.find('.memo-dialog-attach-btn').show();
}

function saveMemo(memoDialog){
//    console.log("saveMemoDialog on");
    //dialog의 info를 추출한다.
    let infoJson = memoDialog.find('.memo-dialog-info').val();
    //info를 json으로 변환한다.
    let info = JSON.parse(infoJson);
    //info 의 memoNo를 추출한다.
    let memoNo = info.memoNo;
    //memoNo가 없으면 새로운 메모이므로 서버에 저장한다.
    if(!memoNo){
        addMemo(memoDialog);
    }else {
        updateMemo(memoDialog);
    }
}

function addMemo(memoDialog){
//    console.log("addMemo on");
    //유저 아이디를 받는다.
    let userId = $('#memo-user-id').val();
    //유저 아이디가 없으면 얼럿창을 띄운다.
    if(!userId){
        swal.fire(
            '로그인이 필요합니다',
            '',
            'warning'
        );
        //alert('로그인이 필요합니다');
        return;
    }
    //다이얼로그로부터 입력된 title을 추출한다.
    let memoTitle = memoDialog.siblings('.ui-dialog-titlebar').find('.memo-dialog-title-input').val();
    //다이얼로그로부터 입력된 contents를 추출한다.
    let memoContents = memoDialog.find('.summernote-contents').val();
    //다이얼로그로부터 입력된 color 를 추출한다.
    let memoColor = memoDialog.siblings('.ui-dialog-titlebar').find('.memo-dialog-color-input').val();

    /*console.log("memoTitle : " + memoTitle);
    console.log("memoContents : " + memoContents);*/
    addMemoRequest(userId, memoTitle, memoContents,memoColor,memoDialog);
}

function updateMemo(memoDialog){
    //console.log("updateMemo on");
    //유저 아이디를 받는다.
    let userId = $('#memo-user-id').val();
    //유저 아이디가 없으면 얼럿창을 띄운다.
    if(!userId){
        alert('로그인이 필요합니다');
        return;
    }
    //다이얼로그로부터 입력된 title을 추출한다.
    let memoTitle = memoDialog.siblings('.ui-dialog-titlebar').find('.memo-dialog-title-input').val();
    //다이얼로그로부터 입력된 contents를 추출한다.
    let memoContents = memoDialog.find('.summernote-contents').val();
    //다이얼로그로부터 입력된 color 를 추출한다.
    let memoColor = memoDialog.siblings('.ui-dialog-titlebar').find('.memo-dialog-color-input').val();

    console.log("memoTitle : " + memoTitle);
    console.log("memoContents : " + memoContents);
    updateMemoRequest(userId, memoTitle, memoContents,memoColor,memoDialog);
}

function changeMemoColor(colorInput, selectedColor){
    console.log("changeMemoColor on");
    //버튼이 속한 dialog 요소를 잡는다.
}

function shareMemo(memoDialog){
    console.log("shareMemo on");
    //dialog의 info를 추출한다.
    let infoJson = memoDialog.find('.memo-dialog-info').val();
    //info를 json으로 변환한다.
    let info = JSON.parse(infoJson);
    //info 의 memoNo를 추출한다.
    let memoNo = info.memoNo;
    //info 의 memoAuthor를 추출한다.
    let memoAuthor = info.memoAuthor;
    //세션의 유저를 추출한다.
    let userId = $('#memo-user-id').val();
    console.log("공유할 메모의 memoNo : " + memoNo);
    console.log("공유할 메모의 memoAuthor : " + memoAuthor);
    console.log("현재 접속중인 userId : " + userId);

    //리스트 만들 곳 비워주고 히든 인풋 넣어주는 영역.
    //공유할 메모의 작성자와 현재 접속중인 유저가 같으면 공유 컨트롤 모달을 띄운다.
    if(memoAuthor === userId){
        $("#memo-share-modal-list-area").show();
        //또한 공유 해제 버튼을 숨긴다.
        $("#memo-share-modal-footer").find('#memo-share-modal-unShare-btn-for-shared').hide();
        //ajax를 통해 동적으로 공유자 목록을 만든다.
        getMemoShareListRequest(memoNo);
    }else {
        $("#memo-sharer-list-body").html('');
        $("#memo-sharer-list-body").append("<input type='hidden' id='memo-sharer-list-memoNo' value='"+memoNo+"'>");

        $("#memo-share-modal-footer").find('#memo-share-modal-unShare-btn-for-shared').show();
        //공유할 메모의 작성자와 현재 접속중인 유저가 다르면 공유 해제 모달을 띄운다.
//        console.log("공유 해제 절차로");
        $("#memo-share-modal-list-area").hide();
        $("#memo-share-modal-unShare-btn-for-shared").val(userId);
        $("#memo-share-modal").modal('show');
    }
}
function deleteMemo(memoDialog){
    //dialog의 info를 추출한다.
    let infoJson = memoDialog.find('.memo-dialog-info').val();
    //info를 json으로 변환한다.
    let info = JSON.parse(infoJson);
    //info 의 memoNo를 추출한다.
    let memoNo = info.memoNo;
    //info 의 memoAuthor를 추출한다.
    let memoAuthor = info.memoAuthor;
    //세션의 유저를 추출한다.
    let userId = $('#memo-user-id').val();
    if(memoAuthor === userId){
        //작성자와 현재 접속중인 유저가 같으면
        deleteMemoRequest(memoNo, memoDialog);
    }else {
        //작성자와 현재 접속중인 유저가 다르면
        console.log("세션유저와 작성자가 다릅니다. 삭제할 수 없습니다.");
    }
}

function restoreMemo(memoDialog){
    //dialog의 info를 추출한다.
    let infoJson = memoDialog.find('.memo-dialog-info').val();
    //info를 json으로 변환한다.
    let info = JSON.parse(infoJson);
    //info 의 memoNo를 추출한다.
    let memoNo = info.memoNo;
    //info 의 memoAuthor를 추출한다.
    let memoAuthor = info.memoAuthor;
    //세션의 유저를 추출한다.
    let userId = $('#memo-user-id').val();
    if(memoAuthor === userId){
        //작성자와 현재 접속중인 유저가 같으면
        restoreMemoRequest(memoNo, memoDialog);
    }else {
        //작성자와 현재 접속중인 유저가 다르면
        console.log("세션유저와 작성자가 다릅니다. 복구할 수 없습니다.");
    }
}

function removeMemo(memoDialog){
    //dialog의 info를 추출한다.
    let infoJson = memoDialog.find('.memo-dialog-info').val();
    //info를 json으로 변환한다.
    let info = JSON.parse(infoJson);
    //info 의 memoNo를 추출한다.
    let memoNo = info.memoNo;
    //info 의 memoAuthor를 추출한다.
    let memoAuthor = info.memoAuthor;
    //세션의 유저를 추출한다.
    let userId = $('#memo-user-id').val();
    if(memoAuthor === userId){
        //작성자와 현재 접속중인 유저가 같으면
        removeMemoRequest(memoNo, memoDialog);
    }else {
        //작성자와 현재 접속중인 유저가 다르면
        console.log("세션유저와 작성자가 다릅니다. 제거할 수 없습니다.");
    }

}
