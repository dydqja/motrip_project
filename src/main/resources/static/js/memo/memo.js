    //메모 섹션을 토글하는 펑션
    function toggleMemo() {
    $('#memoListSection').toggle();
}
    //현재 메모페이지의 상태를 세션에 저장하는 펑션
    //이거 아직 레스트컨트롤러에서 받는거 안만들었다.
    function saveMemoPage() {
    let searchCondition = $('#memoSearchCondition').val();
    let currentPage = $('#memoCurrentPage').val();
    let dialogCount = $('#memoDialogCount').val();

    $.ajax({
    type: 'POST',
    url: '/memo/saveMemoPageStatus',
    data:
{
    searchCondition: searchCondition
    ,currentPage: currentPage
    ,dialogCount: dialogCount
},
    dataType: 'json',
    success: function(response) {
    console.log(response);
}
});
}

    //메모 다이얼로그 카운트를 올리는 펑션
    function memoDialogCountUp() {
    let memoDialogCount = $('#memoDialogCount').val();
    memoDialogCount++;
    $('#memoDialogCount').val(memoDialogCount);
}
    //메모리스트 로드 펑션
    function getMemoList(){
    //리스트를 가져오기 위해 필요한 변수들을 설정.
    let searchCondition = $('#memoSearchCondition').val();
    let currentPage = $('#memoCurrentPage').val();
    let memoListArea = $('#memoListArea');

    //메모 리스트를 보여줄 영역을 비운다.
    memoListArea.empty();

    //에이작스 통신
    $.ajax({
    type: 'POST',
    url: '/memo/getMemoList',
    data:
{
    searchCondition: searchCondition
    ,currentPage: currentPage
},
    dataType: 'json',
    success: function(response) {
    let memoDocs = response; // 여러 개의 memoDoc 객체를 받아옴

    $.each(memoDocs, function(index, memoDoc) {
    //메모 부착 문서를 표현할 버튼을 만든다.
    let button = $('<button>');

    if (memoDoc.tripPlan) {
    button.text('Trip Plan No: ' + memoDoc.tripPlan.tripPlanNo + ', Title: ' + memoDoc.tripPlan.tripPlanTitle);
    button.val(memoDoc.tripPlan.tripPlanNo);
    button.addClass('memoAttachedTripPlanBtn');
} else if (memoDoc.review) {
    button.text('Review: ' + memoDoc.review.reviewNo + ', Title: ' + memoDoc.review.reviewTitle);
    button.val(memoDoc.review.reviewNo);
    button.addClass('memoAttachedReviewBtn');
} else if (memoDoc.chatRoom) {
    button.text('Chat Room: ' + memoDoc.chatRoom.chatRoomNo + ', Title: ' + memoDoc.chatRoom.chatRoomTitle);
    button.val(memoDoc.chatRoom.chatRoomNo);
    button.addClass('memoAttachedChatRoomBtn');
} else {
    button.text('무소속');
    button.addClass('memoAttachedNoneBtn');
}
    //목록영역에 만들어진 버튼을 붙인다.
    memoListArea.append(button);
    //한칸 띈다.
    let br = $('<br>');
    memoListArea.append(br);

    //각 메모부착문서에 부착된 메모들을 표현할 버튼을 만든다.
    $.each(memoDoc.memoList, function(index, memo) {
    //메모의 정보를 수집한다.
    let memoNo = memo.memoNo;
    let memoAuthor = memo.memoAuthor;
    let memoTitle = memo.memoTitle;
    //버튼에 정보 삽입.
    let button = $('<button>').text('ㄴMemo No: ' + memoNo + ', Author: ' + memoAuthor + ', Title: ' + memoTitle);
    let br = $('<br>');
    memoListArea.append(button);
    button.addClass('getMemoBtn'); // 버튼에 클래스 추가
    button.val(memoNo);
    memoListArea.append(br);

});
});
    //이전메모 불러오기 버튼을 생성
    let prevBtn = $('<button>').text('◀');
    prevBtn.addClass('prevMemoBtn');
    memoListArea.append(prevBtn);
    //다음메모 불러오기 버튼을 생성
    let nextBtn = $('<button>').text('▶');
    nextBtn.addClass('nextMemoBtn');
    memoListArea.append(nextBtn);

},
    error: function(xhr, status, error) {
    console.log('에러 발생:', error);
}
});
}

    // 새 메모 다이얼로그 생성 함수
    function buildMemoDialog() {

    // 다이얼로그가 추가될 영역을 가져온다.
    let memoDialogsArea = $('#memoDialogsArea');
    // 현재 다이얼로그 수를 가져온다.
    let memoDialogCount = $('#memoDialogCount').val();
    // 다이얼로그를 생성한다.
    let memoDialog = $('<div>');
    // 다이얼로그에 메모다이얼로그 클래스를 부여한다.
    memoDialog.addClass('memoDialog');
    //다이얼로그를 영역에 붙인다.
    memoDialogsArea.append(memoDialog);

    //방금 붙인 다이얼로그를 객체로 잡는다.
    memoDialog = $('.memoDialog').last();

    // 다이얼로그를 지울 버튼을 생성한다.
    let deleteMemoDialogBtn = $('<button>');
    deleteMemoDialogBtn.attr('name', memoDialogCount);
    deleteMemoDialogBtn.text('X');
    deleteMemoDialogBtn.addClass('deleteMemoDialogBtn');
    memoDialog.append(deleteMemoDialogBtn);

    //다이얼로그의 정보를 저장할 폼을 생성한다.
    let memoDialogForm = $('<form>');
    memoDialogForm.addClass('memoDialogForm');
    memoDialog.append(memoDialogForm);
    //방금 붙인 폼을 객체로 잡는다.
    memoDialogForm = $('.memoDialogForm').last();

    memoDialogForm.append('dialogNo:');
    //다이얼로그 번호를 저장해둘 인풋을 생성한다.
    let memoDialogNoInput = $('<input>');
    memoDialogNoInput.attr('type', 'text');
    memoDialogNoInput.attr('readonly', true);
    memoDialogNoInput.attr('name', 'memoDialogNo');
    memoDialogNoInput.addClass('memoDialogNoInput');
    memoDialogNoInput.val(memoDialogCount);
    memoDialogForm.append(memoDialogNoInput);
    memoDialogForm.append('<br>');

    memoDialogForm.append('memoNo:');
    //메모번호를 저장해둘 인풋을 생성한다.
    let memoNoInput = $('<input>');
    memoNoInput.attr('type', 'text');
    memoNoInput.attr('readonly', true);
    memoNoInput.attr('name', 'memoNo');
    memoNoInput.addClass('memoNoInput');
    memoDialogForm.append(memoNoInput);
    memoDialogForm.append('<br>');

    memoDialogForm.append('memoTitle:');
    //메모의 제목을 저장해둘 인풋을 생성한다.
    let memoTitleInput = $('<input>');
    memoTitleInput.attr('type', 'text');
    memoTitleInput.attr('name', 'memoTitle');
    memoTitleInput.addClass('memoTitleInput');
    memoDialogForm.append(memoTitleInput);
    memoDialogForm.append('<br>');

    memoDialogForm.append('memoAuthor:');
    //메모의 주인을 저장해둘 인풋을 생성한다.
    let memoAuthorInput = $('<input>');
    memoAuthorInput.attr('type', 'text');
    memoAuthorInput.attr('name', 'memoAuthor');
    memoAuthorInput.addClass('memoAuthorInput');
    memoDialogForm.append(memoAuthorInput);
    memoDialogForm.append('<br>');


    memoDialogForm.append('memoRegDate:');
    //메모의 작성일을 저장해둘 인풋을 생성한다.
    let memoRegDateInput = $('<input>');
    memoRegDateInput.attr('type', 'text');
    memoRegDateInput.attr('name', 'memoDate');
    memoRegDateInput.addClass('memoRegDateInput');
    memoDialogForm.append(memoRegDateInput)
    memoDialogForm.append('<br>');


    memoDialogForm.append('memoDelDate:');
    //메모의 삭제일을 저장해둘 인풋을 생성한다.
    let memoDelDateInput = $('<input>');
    memoDelDateInput.attr('type', 'text');
    memoDelDateInput.attr('name', 'memoDelDate');
    memoDelDateInput.addClass('memoDelDateInput');
    memoDialogForm.append(memoDelDateInput);
    memoDialogForm.append('<br>');

    memoDialogForm.append('memoContents:');
    //메모의 내용을 표시만 할 contentsDiv를 생성한다.
    let memoContentsDiv = $('<div>');
    memoContentsDiv.addClass('memoContentsDiv');
    memoDialogForm.append(memoContentsDiv);
    memoDialogForm.append('<br>');

    //메모의 수정을 담당할 textarea를 생성한다.
    let memoContentsText = $('<textarea>');
    memoContentsText.attr('name', 'memoContents');
    memoContentsText.addClass('memoContentsText');
    //텍스트에어리어를 보이지 않도록 한다.
    memoContentsText.css('display', 'none');
    memoDialogForm.append(memoContentsText);
    memoDialogForm.append('<br>');


    // 다이얼로그에 추가될 memoControlArea를 생성한다.
    let memoControlArea = $('<div>');
    memoControlArea.addClass('memoControlArea');
    //div를 알아볼 수 있게 테스트용 문구를 넣는다.
    memoControlArea.text('memoControlArea');
    memoDialog.append(memoControlArea);

    //메모 다이얼로그 카운트 수를 올린다.
    memoDialogCountUp();

    //메모 다이얼로그를 드래그 가능하게 한다.
    memoDialog.draggable({
    cancel: 'form, textarea, button' // 드래그를 취소할 요소들을 선택자로 지정
});

    //방금 만든 메모 다이얼로그의 번호를 리턴한다.
    return memoDialogCount;
}


    //메모 상세보기 펑션
    function getMemo(memoNo, memoDialogNo){

    //memoDialogNo와 같은 값을 가진 메모다이얼로그를 찾는다.
    let memoDialog = $('.memoDialog').filter(function(index){
    return $(this).children('.memoDialogForm').children('.memoDialogNoInput').val() == memoDialogNo;
});

    //아약스 통신
    $.ajax({
    type: 'POST',
    url: '/memo/getMemo',
    data: { memoNo: memoNo },
    dataType: 'json',
    success: function(response) {
    //메모의 정보를 확보한다.
    let memo = response;
    let memoNo = memo.memoNo;
    let memoAuthor = memo.memoAuthor;
    let memoTitle = memo.memoTitle;
    let memoContents = memo.memoContents;
    let memoRegDate = memo.memoRegDate;
    let regDate = new Date(memoRegDate);
    let memoDelDate = memo.memoDelDate;
    let delDate = memoDelDate ? new Date(memoDelDate) : null;

    //memoDialog의 자식인 memoDialogForm클래스를 객체로 잡는다.
    let memoDialogForm = memoDialog.children('.memoDialogForm');

    //memoDialogForm 안의 input들을 찾아서 값을 넣어준다.
    let memoNoInput = memoDialogForm.children('.memoNoInput');
    memoNoInput.val(memoNo);
    memoNoInput.attr('readonly', true);

    let memoTitleInput = memoDialogForm.children('.memoTitleInput');
    memoTitleInput.val(memoTitle);
    memoTitleInput.attr('readonly', true);

    let memoAuthorInput = memoDialogForm.children('.memoAuthorInput');
    memoAuthorInput.val(memoAuthor);
    memoAuthorInput.attr('readonly', true);

    let memoRegDateInput = memoDialogForm.children('.memoRegDateInput');
    memoRegDateInput.val(regDate);
    memoRegDateInput.attr('readonly', true);

    if(delDate !== null){
    let memoDelDateInput = memoDialogForm.children('.memoDelDateInput');
    memoDelDateInput.val(delDate);
    memoDelDateInput.attr('readonly', true);
} else {
    let memoDelDateInput = memoDialogForm.children('.memoDelDateInput');
    memoDelDateInput.remove();
}

    let memoContentsDiv = memoDialogForm.find('.memoContentsDiv').first();
    memoContentsDiv.html(memoContents);

    //memoContentsDiv.css('display', 'none') 를 취소한다.
    memoContentsDiv.css('display', '');

    let memoContentsText = memoDialogForm.children('.memoContentsText');
    memoContentsText.val(memoContents);

    // 다이얼로그의 자식인 memoControlArea를 객체로 잡는다.
    let memoControlArea = memoDialog.children('.memoControlArea');
    //memoControlArea를 비운다.
    memoControlArea.empty();

    //로그인중인 유저의 자격을 판단하기 위해 유저 아이디를 받는다.
    let userId = $('#memoUserId').val();
    //유저아이디가 현재 메모의 작성자와 같다면 수정버튼을 생성한다. 그러나, delDate 가 null이 아니라면 생성하지 않는다.
    if(userId === memoAuthor && delDate === null){
    //수정버튼을 만든다.
    let editButton = $('<button>');
    editButton.addClass('editMemoBtn');
    editButton.text('수정');
    memoControlArea.append(editButton);
    //삭제버튼을 만든다.
    let deleteButton = $('<button>');
    deleteButton.addClass('deleteMemoBtn');
    deleteButton.text('삭제');
    memoControlArea.append(deleteButton);
    //공유버튼을 만든다.
    let shareButton = $('<button>');
    shareButton.addClass('shareMemoBtn');
    shareButton.text('공유');
    memoControlArea.append(shareButton);
}
    //delDate 가 null이 아니라면 복구버튼을 만든다.
    if(delDate !== null){
    //복구버튼을 만든다.
    let restoreButton = $('<button>');
    restoreButton.addClass('restoreMemoBtn');
    restoreButton.text('복구');
    memoControlArea.append(restoreButton);
    //완전삭제버튼을 만든다.
    let removeButton = $('<button>');
    removeButton.addClass('removeMemoBtn');
    removeButton.text('완전삭제');
    memoControlArea.append(removeButton);
}
},
    error: function(error) {
    alert('메모 상세보기 실패');
}
});
}

    // 부착된 여행플랜 보러가기
    $(document).on('click', '.memoAttachedTripPlanBtn', function() {
    event.preventDefault();
    let tripPlanNo = $(this).val();
    let url = '/tripPlan/selectTripPlan?tripPlanNo=' + tripPlanNo;
    window.location.href = url;

});

    // 부착된 리뷰 보러가기
    $(document).on('click', '.memoAttachedReviewBtn', function() {
    event.preventDefault();
    let reviewNo = $(this).val();
    let url = '/review/getReview?reviewNo=' + reviewNo;
    window.location.href = url;
});

    // 부착된 채팅방 보러가기
    $(document).on('click', '.memoAttachedChatRoomBtn', function() {
    event.preventDefault();
    let chatRoomNo = $(this).val();
    let url = '/chatRoom/getChatRoom?chatRoomNo=' + chatRoomNo;
    alert(url);
    //window.location.href = url;
});
    // 유저 자세히보기 리스너 showDetailedUserBtn
    $(document).on('click', '.showDetailedUserBtn', function() {
    event.preventDefault();
    //해당 유저의 유저넘버를 가져온다.
    let userId = $(this).val();
    let url = '/user/getUser?userId=' + userId;
    window.location.href = url;
});




    //메모 상세보기 리스너
    $(document).on('click', '.getMemoBtn', function() {
    event.preventDefault();
    //메모 상세보기 펑션
    let memoNo = $(this).val();
    //새 다이얼로그를 만든다.
    let memoDialogNo = buildMemoDialog();
    getMemo(memoNo, memoDialogNo);
});

    //메모 공유 리스너
    $(document).on('click', '.shareMemoBtn', function() {
    event.preventDefault();
    //메모의 번호를 받는다.
    let memoNo = $(this).parent().parent().children('.memoDialogForm').children('.memoNoInput').val();

    //현재 이 메모를 공유중인 모든 사람을 받아온다.

    //공유할 유저의 아이디를 보낸다.
    $.ajax({
    type: 'post',
    url: '/memo/getMemoSharerList',
    dataType: 'json',
    data: {
    memoNo: memoNo,
},
    success: function(response) {
    let memoAccessList = response;
    //모달을 형성할 영역을 잡는다.
    let memoShareListModal = $('#memoShareListModal');
    //영역의 내용을 비운다.
    memoShareListModal.html('');
    //모달의 헤더를 만든다.
    let modalHeader = $('<div>');
    modalHeader.addClass('memo-modal-header');
    memoShareListModal.append(modalHeader);
    let modalTitle = $('<h5>');
    modalTitle.addClass('modal-title');
    modalTitle.text('이 메모를 공유중인 사람들');
    modalHeader.append(modalTitle);

    for(let memoAccess of memoAccessList){
    let userId = 'null';
    userId = memoAccess.memoAccessUser;
    let userNickname = 'null';
    userNickname = memoAccess.userNickname;
    let userEmail = 'null';
    userEmail = memoAccess.userEmail;
    let userGender = 'null';
    userGender = memoAccess.userGender;

    //모달에 공유중인 유저의 정보를 추가한다.
    let info = $('<span>');
    info.addClass('memo-modal-body');
    info.html('이름: ' + userNickname + ' 이메일: ' + userEmail + ' 성별: ' + userGender);
    memoShareListModal.append(info);
    let showDetailBtn = $('<button>');
    showDetailBtn.addClass('showDetailedUserBtn');
    showDetailBtn.text('자세히 보기');
    showDetailBtn.val(userId);
    memoShareListModal.append(showDetailBtn);
    let unShareBtn = $('<button>');
    unShareBtn.addClass('unShareMemoBtn');
    unShareBtn.text('공유 해제');
    unShareBtn.val(memoNo);
    memoShareListModal.append(unShareBtn);
}
    //모달에 공유할 사람 추가하는 div를 만든다.
    let addShareUserDiv = $('<div>');
    addShareUserDiv.addClass('memo-modal-body');
    memoShareListModal.append(addShareUserDiv);
    //거기에 공유할 사람 추가하는 input을 만든다.
    let addShareUserInput = $('<input>');
    addShareUserInput.addClass('addShareUserInput');
    addShareUserInput.attr('type', 'text');
    addShareUserInput.attr('placeholder', '공유할 유저의 아이디');
    addShareUserDiv.append(addShareUserInput);

    //공유할 유저를 추가하는 버튼을 만든다.
    let addShareUserBtn = $('<button>');
    addShareUserBtn.addClass('addMemoAccessBtn');
    addShareUserBtn.text('공유');
    addShareUserBtn.val(memoNo);
    addShareUserDiv.append(addShareUserBtn);
    //존재하지 않는 유저입니다. 를 띄울 div를 만든다.
    let idAvail = $('<div>');
    idAvail.addClass('memo-modal-body');
    idAvail.addClass('idAvail');
    memoShareListModal.append(idAvail);


    //모달을 연다
    $('#memoShareListModal').dialog({
    resizable: false,
    height: "auto",
    width: 400,
    modal: true
});
},
    error: function(error) {
    alert('메모 공유 실패');
}
});
});

    //공유 해제 리스너
    $(document).on('click', '.unShareMemoBtn', function() {
    event.preventDefault();
    //공유 해제할 유저의 아이디를 받는다.
    //이 객체의 형제인 .showDetailedUserBtn의 value값을 받는다.
    let userId = $(this).siblings('.showDetailedUserBtn').val();
    //공유 해제할 메모의 번호를 받는다.
    let memoNo = $(this).val();
    alert('공유 해제할 유저의 아이디: ' + userId + ' 공유 해제할 메모의 번호: ' + memoNo)
    //공유 해제할 유저의 아이디와 메모의 번호를 보낸다.
    $.ajax({
    type: 'post',
    url: '/memo/deleteMemoAccess',
    dataType: 'json',
    data: {
    memoNo: memoNo,
    userId: userId
},
    success: function(response) {
    alert('공유 해제 성공');
    //모달을 닫는다.
    $('#memoShareListModal').dialog('close');
},
    error: function(error) {
    alert('공유 해제 실패');
}
});
});
    //TODO
    //공유할 유저를 추가할 때 존재하는 아이디인지 체크하는 ajax 리스너

    //


    //메모에 유저를 공유하는 리스너
    $(document).on('click', '.addMemoAccessBtn', function() {
    event.preventDefault();
    //공유할 유저의 아이디를 받는다.
    let userId = $(this).siblings('.addShareUserInput').val();
    //공유할 메모의 번호를 받는다.
    let memoNo = $(this).val();
    //공유할 유저의 아이디와 메모의 번호를 보낸다.
    $.ajax({
    type: 'post',
    url: '/memo/addMemoAccess',
    dataType: 'json',
    data: {
    memoNo: memoNo,
    userId: userId
},
    success: function(response) {
    alert('메모 공유 성공');
    //모달을 닫는다.
    $('#memoShareListModal').dialog('close');
},
    error: function(error) {
    alert('메모 공유 실패');
}
});
});



    //메모 수정 리스너
    $(document).on('click', '.editMemoBtn', function() {
    event.preventDefault();
    //이 버튼을 저장 버튼으로 바꾼다.
    let editBtn = $(this);
    editBtn.text('저장');
    editBtn.attr('class', 'saveMemoBtn');
    //메모의 내용을 수정할 수 있도록 한다.
    //버튼의 부모인 다이얼로그를 객체로 잡는다.
    let memoDialog = editBtn.parent().parent();
    //다이얼로그의 자식인 폼을 객체로 잡는다.
    let memoDialogForm = memoDialog.children('.memoDialogForm');
    //폼의 자식인 메모 제목 인풋을 객체로 잡는다.
    let memoTitleInput = memoDialogForm.children('.memoTitleInput');
    //그것의 readonly 속성을 false로 바꾼다.
    memoTitleInput.attr('readonly', false);

    //폼의 자식인 memoContentsDiv를 객체로 잡는다.
    let memoContentsDiv = memoDialogForm.children('.memoContentsDiv');

    //폼의 자식인 memoContentsText를 객체로 잡는다.
    let memoContentsText = memoDialogForm.children('.memoContentsText');

    //메모의 내용을 수정할 수 있도록 써머노트를 켠다.
    $(memoContentsText).summernote({
    height: 100,
    minHeight: null,
    maxHeight: null,
    focus: true,
    lang: 'ko-KR'
});
//        $(summernote).summernote('pasteHTML',memoContents)
});

    //메모 저장 리스너
    $(document).on('click', '.saveMemoBtn', function() {
    event.preventDefault();

    //이 버튼의 부모인 다이얼로그를 객체로 잡는다.
    let memoDialog = $(this).parent().parent();
    //그 다이얼로그의 자식인 폼을 객체로 잡는다.
    let memoDialogForm = memoDialog.children('.memoDialogForm');
    //폼에서 다이얼로그 번호를 손에 넣는다.
    let memoDialogNo = memoDialogForm.children('.memoDialogNo').val();
    //폼에서 메모 번호를 손에 넣는다.
    let memoNo = memoDialogForm.children('.memoNoInput').val();
    //폼의 자식인 memoContentsText를 객체화한다.
    let memoContentsText = memoDialogForm.children('.memoContentsText');

    //폼 전체를 시리얼라이즈해서 객체로 만든다.
    let formData = memoDialogForm.serialize();

    //서머노트를 파괴한다.
    memoContentsText.summernote('destroy');
    memoContentsText.css('display', 'none');

    //저장버튼을 다시 수정버튼으로 만든다.
    let saveBtn = $(this);
    saveBtn.text('수정');
    saveBtn.attr('class', 'editMemoBtn');

    //서버로 폼 데이터를 전송한다.
    $.ajax({
    type: 'POST',
    url: '/memo/updateMemo',
    data: formData,
    dataType: 'json',
    success: function(response) {
    let memo = response
    getMemoList();
    let memoNo = memo.memoNo;
    let memoAuthor = memo.memoAuthor;
    let memoTitle = memo.memoTitle;
    let memoContents = memo.memoContents;
    let memoRegDate = memo.memoRegDate;
    let regDate = new Date(memoRegDate);
    let memoDelDate = memo.memoDelDate;
    let delDate = memoDelDate ? new Date(memoDelDate) : null;

    //memoDialog의 자식인 memoDialogForm클래스를 객체로 잡는다.
    let memoDialogForm = memoDialog.children('.memoDialogForm');

    //memoDialogForm 안의 input들을 찾아서 값을 넣어준다.
    let memoNoInput = memoDialogForm.children('.memoNoInput');
    memoNoInput.val(memoNo);
    memoNoInput.attr('readonly', true);

    let memoTitleInput = memoDialogForm.children('.memoTitleInput');
    memoTitleInput.val(memoTitle);
    memoTitleInput.attr('readonly', true);

    let memoAuthorInput = memoDialogForm.children('.memoAuthorInput');
    memoAuthorInput.val(memoAuthor);
    memoAuthorInput.attr('readonly', true);

    let memoRegDateInput = memoDialogForm.children('.memoRegDateInput');
    memoRegDateInput.val(regDate);
    memoRegDateInput.attr('readonly', true);

    if(delDate !== null){
    let memoDelDateInput = memoDialogForm.children('.memoDelDateInput');
    memoDelDateInput.val(delDate);
    memoDelDateInput.attr('readonly', true);
} else {
    let memoDelDateInput = memoDialogForm.children('.memoDelDateInput');
    memoDelDateInput.remove();
}

    let memoContentsDiv = memoDialogForm.find('.memoContentsDiv').first();
    memoContentsDiv.html(memoContents);

    let memoContentsText = memoDialogForm.children('.memoContentsText');
    memoContentsText.val(memoContents);

    // 다이얼로그의 자식인 memoControlArea를 객체로 잡는다.
    let memoControlArea = memoDialog.children('.memoControlArea');
    //memoControlArea를 비운다.
    memoControlArea.empty();

    //로그인중인 유저의 자격을 판단하기 위해 유저 아이디를 받는다.
    let userId = $('#memoUserId').val();
    //유저아이디가 현재 메모의 작성자와 같다면 수정버튼을 생성한다. 그러나, delDate 가 null이 아니라면 생성하지 않는다.
    if(userId === memoAuthor && delDate === null){
    //수정버튼을 만든다.
    let editButton = $('<button>');
    editButton.addClass('editMemoBtn');
    editButton.text('수정');
    memoControlArea.append(editButton);
    //삭제버튼을 만든다.
    let deleteButton = $('<button>');
    deleteButton.addClass('deleteMemoBtn');
    deleteButton.text('삭제');
    memoControlArea.append(deleteButton);
}
    //delDate 가 null이 아니라면 복구버튼을 만든다.
    if(delDate !== null){
    //복구버튼을 만든다.
    let restoreButton = $('<button>');
    restoreButton.addClass('restoreMemoBtn');
    restoreButton.text('복구');
    memoControlArea.append(restoreButton);
    //완전삭제버튼을 만든다.
    let removeButton = $('<button>');
    removeButton.addClass('removeMemoBtn');
    removeButton.text('완전삭제');
    memoControlArea.append(removeButton);
}
},
    error: function(error) {
    alert('메모 수정 실패');
}

});
});

    //메모 삭제신청 리스너
    $(document).on('click', '.deleteMemoBtn', function() {
    event.preventDefault();
    //이 버튼의 부모인 다이얼로그를 객체로 잡는다.
    let memoDialog = $(this).parent().parent();
    //그 다이얼로그의 자식인 폼을 객체로 잡는다.
    let memoDialogForm = memoDialog.children('.memoDialogForm');
    //폼에서 다이얼로그 번호를 손에 넣는다.
    let memoDialogNo = memoDialogForm.children('.memoDialogNo').val();
    //폼에서 메모 번호를 손에 넣는다.
    let memoNo = memoDialogForm.children('.memoNoInput').val();

    //서버로 폼 데이터를 전송한다.
    $.ajax({
    type: 'POST',
    url: '/memo/deleteMemo',
    data: {
    memoNo: memoNo
},
    dataType: 'json',
    success: function(response) {
    let noUse = response
    getMemoList();
    memoDialog.remove();
},
    error: function(error) {
    alert('메모 삭제 실패');
}

});
});

    //메모 완전삭제 리스너
    $(document).on('click', '.removeMemoBtn', function() {
    event.preventDefault();
    //이 버튼의 부모인 다이얼로그를 객체로 잡는다.
    let memoDialog = $(this).parent().parent();
    //그 다이얼로그의 자식인 폼을 객체로 잡는다.
    let memoDialogForm = memoDialog.children('.memoDialogForm');
    //폼에서 다이얼로그 번호를 손에 넣는다.
    let memoDialogNo = memoDialogForm.children('.memoDialogNo').val();
    //폼에서 메모 번호를 손에 넣는다.
    let memoNo = memoDialogForm.children('.memoNoInput').val();

    //서버로 폼 데이터를 전송한다.
    $.ajax({
    type: 'POST',
    url: '/memo/removeMemo',
    data: {
    memoNo: memoNo
},
    dataType: 'json',
    success: function(response) {
    let noUse = response
    getMemoList();
    memoDialog.remove();
},
    error: function(error) {
    alert('메모 제거 실패');
}
});
});

    //메모 복구 리스너
    //restoreMemoBtn클래스의 버튼이 눌리면 실행
    $(document).on('click', '.restoreMemoBtn', function() {
    event.preventDefault();
    //이 버튼의 부모인 다이얼로그를 객체로 잡는다.
    let memoDialog = $(this).parent().parent();
    //그 다이얼로그의 자식인 폼을 객체로 잡는다.
    let memoDialogForm = memoDialog.children('.memoDialogForm');
    //폼에서 다이얼로그 번호를 손에 넣는다.
    let memoDialogNo = memoDialogForm.children('.memoDialogNo').val();
    //폼에서 메모 번호를 손에 넣는다.
    let memoNo = memoDialogForm.children('.memoNoInput').val();

    //서버로 폼 데이터를 전송한다.
    $.ajax({
    type: 'POST',
    url: '/memo/restoreMemo',
    data: {
    memoNo: memoNo
},
    dataType: 'json',
    success: function(response) {
    let noUse = response
    getMemoList();
    memoDialog.remove();
},
    error: function(error) {
    alert('메모 복구 실패');
}
});
});



    //메모 다이얼로그 삭제 리스너
    //deleteMemoDialogBtn클래스의 버튼이 눌리면 실행할거다.
    $(document).on('click', '.deleteMemoDialogBtn', function() {
    event.preventDefault();
    //해당 버튼의 부모가 되는 메모 다이얼로그 div 를 객체로 잡는다.
    let memoDialog = $(this).parent();
    //해당 객체를 삭제한다.
    memoDialog.remove();
});

    //서치컨디션 변경 및 메모리스트 로드 리스너
    $(document).on('click', '.memoSearchBtn', function() {
    event.preventDefault();
    //버튼이 눌리면 서치컨디션의 값을 바꾼다.
    let searchCondition = $(this).attr('id');
    let memoSearchCondition = $('#memoSearchCondition');
    memoSearchCondition.val(searchCondition);
    //또한 커런트페이지를 1로 초기화한다.
    let memoCurrentPage = $('#memoCurrentPage');
    memoCurrentPage.val(1);

    //메모 리스트를 로드한다.
    getMemoList();
});

    //이전메모 불러오기 리스너
    $(document).on('click', '.prevMemoBtn', function() {
    event.preventDefault();
    //현재 페이지를 가져온다.
    let memoCurrentPage = $('#memoCurrentPage');
    let currentPage = memoCurrentPage.val();
    //현재 페이지가 1이면 더이상 불러올 메모가 없으므로 리턴한다.
    if(currentPage == 1) {
    return;
}
    //현재 페이지를 1 감소시킨다.
    currentPage--;
    //현재 페이지를 다시 저장한다.
    memoCurrentPage.val(currentPage);
    //메모 리스트를 로드한다.
    getMemoList();
});
    //다음메모 불러오기 리스너
    $(document).on('click', '.nextMemoBtn', function() {
    event.preventDefault();
    //현재 페이지를 가져온다.
    let memoCurrentPage = $('#memoCurrentPage');
    let currentPage = memoCurrentPage.val();
    //현재 페이지를 1 증가시킨다.
    currentPage++;
    //현재 페이지를 다시 저장한다.
    memoCurrentPage.val(currentPage);
    //메모 리스트를 로드한다.
    getMemoList();
});
    //새 메모 리스너
    $(document).on('click', '#addMemo', function() {
    event.preventDefault();
    //새 메모 다이얼로그를 생성한다.
    let memoDialogNo = buildMemoDialog();
    //서버에 새 메모 생성을 요청한다.
    $.ajax({
    type: 'POST',
    url: '/memo/addMemo',
    data: {
    memoDialogNo: memoDialogNo
},
    dataType: 'json',
    success: function(response) {
    let memoNo = response.memoNo;
    getMemo(memoNo, memoDialogNo);
},
    error: function(error) {
    alert('새 메모 생성 실패');
}
});
});



    //초기 다큐먼트 로드시 실행될 펑션들.
    $(document).ready(function() {
    $('#memoListSection').hide(); // div 일단 숨기기. 나중에는 User.isUsingMemoBar를 받아와서 true면 보여주기
});
