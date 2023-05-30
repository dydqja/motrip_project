<%--
  Created by IntelliJ IDEA.
  User: ksg
  Date: 2023-05-29
  Time: 오후 2:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<hr/>
<footer class="three-sections">

    <div class = left-section>
        <c:if test="${empty sessionScope.user}">
            로그인되지 않은 사람은 메모를 사용할 수 없습니다.
        </c:if>
        <c:if test="${not empty sessionScope.user}">
            <form id="memoListForm">
                <input type="text" id="userId" value="${user.userId}" placeholder="유저아이디"/>                <br/>
                <input type="text" id="memoSearchCon" value="${sessionScope.memoSearchCon}" placeholder="검색조건">                <br/>
                <input type="text" id="memoCurrentPage" value="${sessionScope.memoCurrentPage}" placeholder="현재페이지">                <br/>
                <button type="button" id="memoListBtn" class="btn btn-primary" onclick="toggleMemo()">메모 토글</button>
                <br/>
                <br/>
                <div id="memoListOn">
                    <div id="memoListArea">

                    </div>
                    <br/>
                    <br/>
                    <div id="memoSearchArea">
                        <button type="button" class="memoSearchBtn" id="myMemo">내 메모 보기</button>
                        <button type="button" class="memoSearchBtn" id="sharedMemo">공유받은 메모 보기</button>
                        <button type="button" class="memoSearchBtn" id="deletedMemo">삭제된 메모 보기</button>
                    </div>
                </div>
            </form>
        </c:if>
    </div>
    <div class = "middle-section">
        <form id="memoDetailForm">
            <div id="memoDetailArea">

            </div>
            <div id="memoControlArea">

            </div>
        </form>
    </div>
    <div class = "right-section">
        챗봇 칸임
    </div>
</footer>
<hr/>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script>
    function toggleMemo() {
        $('#memoListOn').toggle();
    }
    // 부착된 여행플랜 보러가기
    $(document).on('click', '.memoAttachedTripPlanBtn', function() {
        let tripPlanNo = $(this).attr('id');
        let url = '/selectTripPlanList?tripPlanNo=' + tripPlanNo;
        alert(url);
    });

    // 부착된 리뷰 보러가기
    $(document).on('click', '.memoAttachedReviewBtn', function() {
        let reviewNo = $(this).attr('id');
        let url = '/selectReviewList?reviewNo=' + reviewNo;
        alert(url);
    });

    // 부착된 채팅방 보러가기
    $(document).on('click', '.memoAttachedChatRoomBtn', function() {
        let chatRoomNo = $(this).attr('id');
        let url = '/selectChatRoomList?chatRoomNo=' + chatRoomNo;
        alert(url);
        //window.location.href = url;
    });

    //메모 상세보기 핸들러
    $(document).on('click', '.memoDetailBtn', function() {
        event.preventDefault();
        //메모 상세보기 펑션
        let memoNo = $(this).attr('id');
        getMemo(memoNo);
    });

    //메모 수정 펑션
    $(document).on('click', '.memoEditBtn', function() {
        event.preventDefault();
        //이 버튼을 저장 버튼으로 바꾼다.
        let editBtn = $(this);
        editBtn.text('저장');
        editBtn.attr('class', 'memoSaveBtn');

        let memoNo = $('#nowMemoNo').val();
        let memoContentsArea = $('#memoContentsArea');
        let memoContents = memoContentsArea.text();

        // 이전 내용 비우기
        memoContentsArea.empty();
        let textarea = $('<textarea>');
        textarea.attr('id', 'summernote');
        textarea.attr('name', 'memoContents')
        memoContentsArea.append(textarea);
        $('#summernote').summernote({
            height: 150,
            minHeight: null,
            maxHeight: null,
            focus: true,
            lang: 'ko-KR'
        });
        $('#summernote').summernote('pasteHTML', memoContents);
    });

    //메모 저장 펑션
    $(document).on('click', '.memoSaveBtn', function() {
        event.preventDefault();
        let query = $('#memoDetailForm').serialize();
        //서버에 쿼리스트링을 전송해본다.
        $.ajax({
            type: 'POST',
            url: '/memo/updateMemo',
            data: query,
            dataType: 'json',
            success: function(response) {
                memoListLoad();
                //성공하면 수정된 메모리스트를 다시 보여주고, 해당 메모에 대한 상세보기를 다시 보여준다.
            },
            error: function(error) {
            }
        });
    });

    //메모 상세보기 펑션
    function getMemo(memoNo){
        let memoDetailArea = $('#memoDetailArea');
        memoDetailArea.empty();
        let memoControlArea = $('#memoControlArea');
        memoControlArea.empty();

        $.ajax({
            type: 'POST',
            url: '/memo/getMemo',
            data: { memoNo: memoNo },
            dataType: 'json',
            success: function(response) {
                let memo = response;
                let memoNo = memo.memoNo;
                let memoAuthor = memo.memoAuthor;
                let memoTitle = memo.memoTitle;
                let memoContents = memo.memoContents;
                let memoRegDate = memo.memoRegDate;
                let regDate = new Date(memoRegDate);
                let memoDelDate = memo.memoDelDate;
                let delDate = new Date(memoDelDate);

                let memoNoInput = $('<input>');
                memoNoInput.attr('type', 'text');
                memoNoInput.attr('id', 'nowMemoNo');
                memoNoInput.attr('name', 'memoNo');
                memoNoInput.attr('value', memoNo);
                let titleInput = $('<input>');
                titleInput.attr('type', 'text');
                titleInput.attr('id', 'nowMemoTitle');
                titleInput.attr('name', 'memoTitle');
                titleInput.attr('value', memoTitle);
                let regDateDiv = $('<div>');
                regDateDiv.text('작성일: ' + regDate.toLocaleString());
                let authorDiv = $('<div>');
                authorDiv.text('작성자: ' + memoAuthor);
                let contentsDiv = $('<div>');
                contentsDiv.text(memoContents);
                contentsDiv.attr('id', 'memoContentsArea');

                memoDetailArea.append(memoNoInput);
                memoDetailArea.append(titleInput);
                memoDetailArea.append(regDateDiv);
                memoDetailArea.append(authorDiv);
                memoDetailArea.append(contentsDiv);

                let memoSearchCon = $('#memoSearchCon');
                let searchConVal = memoSearchCon.val();
                let searchConDiv = $('<div>');
                searchConDiv.text('현재 검색조건: ' + searchConVal);
                memoControlArea.append(searchConDiv);

                if (searchConVal === "myMemo") {
                    //수정버튼을 만든다.
                    let editBtn = $('<button>');
                    editBtn.text('수정');
                    editBtn.attr('class', 'memoEditBtn');
                    memoControlArea.append(editBtn);
                    //삭제버튼을 만든다.
                    let deleteBtn = $('<button>');
                    deleteBtn.text('삭제');
                    deleteBtn.attr('class', 'memoDeleteBtn');
                    memoControlArea.append(deleteBtn);
                } else if (searchConVal === "sharedMemo") {

                } else if (searchConVal === "deletedMemo") {
                    //삭제 신청일 표시 div 를 만든다.
                    let delDateDiv = $('<div>');
                    delDateDiv.text('삭제 신청일: ' + delDate.toLocaleString());
                    delDateDiv.attr('name', 'memoDelDate');
                    memoDetailArea.append(delDateDiv);

                    //복구버튼을 만든다.
                    let restoreBtn = $('<button>');
                    restoreBtn.text('복구');
                    restoreBtn.attr('class', 'memoRestoreBtn');
                    memoControlArea.append(restoreBtn);
                } else {
                    let errorDiv = $('<div>');
                    errorDiv.text('검색조건 비교 실패.');
                    memoControlArea.append(errorDiv);
                }
            },
            error: function(error) {
                alert('메모 상세보기 실패');
            }
        });

    }


    //메모 리스트를 로드하는 펑션
    function memoListLoad(){
        //리스트를 보기 위해 필요한 변수들을 설정.
        let searchCondition = $('#memoSearchCon').val();
        let memoCurrentPage = $('#memoCurrentPage').val();
        //메모 리스트를 보여줄 영역을 비운다.
        let memoListArea = $('#memoListArea');
        memoListArea.empty();
        //에이작스 통신
        $.ajax({
            type: 'POST',
            url: '/memo/getMemoList',
            data:
                {
                searchCondition: searchCondition
                , memoCurrentPage: memoCurrentPage
                },
            dataType: 'json',
            success: function(response) {
                let memoDocs = response; // 여러 개의 memoDoc 객체를 받아옴

                $.each(memoDocs, function(index, memoDoc) {
                    let button = $('<button>');

                    if (memoDoc.tripPlan) {
                        button.text('Trip Plan No: ' + memoDoc.tripPlan.tripPlanNo + ', Title: ' + memoDoc.tripPlan.tripPlanTitle);
                        button.attr('id', memoDoc.tripPlan.tripPlanNo);
                        button.addClass('memoAttachedTripPlanBtn');
                    } else if (memoDoc.review) {
                        button.text('Review: ' + memoDoc.review.reviewNo + ', Title: ' + memoDoc.review.reviewTitle);
                        button.attr('id', memoDoc.review.reviewNo);
                        button.addClass('memoAttachedReviewBtn');
                    } else if (memoDoc.chatRoom) {
                        button.text('Chat Room: ' + memoDoc.chatRoom.chatRoomNo + ', Title: ' + memoDoc.chatRoom.chatRoomTitle);
                        button.attr('id', memoDoc.chatRoom.chatRoomNo);
                        button.addClass('memoAttachedChatRoomBtn');
                    } else {
                        button.text('무소속');
                    }
                    memoListArea.append(button);
                    let br = $('<br>');
                    memoListArea.append(br);

                    $.each(memoDoc.memoList, function(index, memo) {
                        let memoNo = memo.memoNo;
                        let memoAuthor = memo.memoAuthor;
                        let memoTitle = memo.memoTitle;
                        let button = $('<button>').text('ㄴMemo No: ' + memoNo + ', Author: ' + memoAuthor + ', Title: ' + memoTitle);
                        let br = $('<br>');
                        memoListArea.append(button);
                        button.addClass('memoDetailBtn'); // 버튼에 클래스 추가
                        button.attr('id', memoNo);
                        memoListArea.append(br);
                    });
                });
            },
            error: function(xhr, status, error) {
                console.log('에러 발생:', error);
            }
        });
    }




    //메모 리스트를 여는 펑션
    $(document).ready(function() {

        $('#memoListOn').hide(); // div 일단 숨기기. 나중에는 User.isUsingMemoBar를 받아와서 true면 보여주기

        $('.memoSearchBtn').click(function() {
            //버튼이 눌리면 서치컨디션의 값을 바꾼다.
            let searchCondition = $(this).attr('id');
            let memoSearchCon = $('#memoSearchCon');
            memoSearchCon.val(searchCondition);
            //메모 리스트를 로드한다.
            memoListLoad();
        });
    });
</script>
