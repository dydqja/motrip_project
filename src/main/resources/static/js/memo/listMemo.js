//도큐먼트에 달 리스너
$(document).ready(function () {
    //console.log("document ready");

    let userId = $("#memo-user-id").val();
    //console.log("userId : " + userId);
    if (!userId){
        //console.log("userId is undefined");
        return;
    }
    //최초 1회, getMemoList 를 호출하여 myMemoList 를 가져온다.
    getMemoList('myMemo');
});

function changePage(searchCondition, change){
    let changeTarget = 0;
    if(searchCondition == 'myMemo'){
        changeTarget = $("#my-memo-current-page");
    }else if(searchCondition == 'sharedMemo'){
        changeTarget = $("#shared-memo-current-page");
    } else {
        changeTarget = $("#del-memo-current-page");
    }
    let currentPage = parseInt(changeTarget.text());
    let changePage = currentPage + change;
    if(changePage < 1){
        changePage = 1;
    }
    changeTarget.text(changePage);
    getMemoList(searchCondition,changePage);
}

//아이디값이 my-memo-btn, shared-memo-btn, del-memo-btn 인 세 버튼에 달린 리스너
$(document).on("click", "#my-memo-btn, #shared-memo-btn, #del-memo-btn", function () {
    //버튼의 아이디값을 가져온다.
    let searchCondition = $(this).attr("id");
    //버튼의 아이디값을 적절히 파싱한다.
    if(searchCondition == 'my-memo-btn'){
        searchCondition = 'myMemo';
    } else if (searchCondition == 'shared-memo-btn'){
        searchCondition = 'sharedMemo';
    } else {
        searchCondition = 'deletedMemo';
    }
    //memo-search-condition 에 searchCondition 을 담는다.
    $("#memo-search-condition").val(searchCondition);

    //해당 서치컨디션에 어울리는 currentPage 를 잡는다.
    let currentPage = 1;
    if(searchCondition == 'myMemo'){
        //my-memo-current-page 의 text를 가져온다.
        currentPage = $("#my-memo-current-page").text();
    }else if(searchCondition == 'sharedMemo'){
        //shared-memo-current-page 의 text를 가져온다.
        currentPage = $("#shared-memo-current-page").text();
    } else {
        //del-memo-current-page 의 text를 가져온다.
        currentPage = $("#del-memo-current-page").text();
    }
    //getMemoList 를 호출하여 myMemoList 를 가져온다.
    getMemoList(searchCondition,currentPage);
});


function getMemoList(searchCondition,currentPage){
    if (currentPage == undefined){
        currentPage = 1;
    }
/*    console.log("getMemoList on");
    console.log("searchCondition : " + searchCondition);
    console.log("currentPage : " + currentPage);
    console.log("위의 조건으로 ajax를 날립니다.");*/

    //searchCondition 에 맞는 list-container 를 잡는다.
    let listContainer = $("#my-memo-list-container");
    if(searchCondition == 'sharedMemo'){
        listContainer = $("#shared-memo-list-container");
    }else if(searchCondition == 'deletedMemo'){
        listContainer = $("#del-memo-list-container");
    }
    //list-container를 비운다.
    listContainer.html('');

    //userId 를 받는다.
    //memo 를 ajax로 받는다.
    $.ajax({
        type: "POST",
        url: "/memo/getMemoList",
        data: {searchCondition: searchCondition
            , currentPage: currentPage},
        dataType: "json",
        success: function (response) {
            let memoDocList = response;
            //console.log("memoDocList : " + memoDocList);
            //각 memoDoc마다 썸네일을 만든다.
            memoDocList.forEach(memoDoc => {
               buildMemoListThumbnail(memoDoc,listContainer)
            });
        }
    });
}

function buildMemoListThumbnail(memoDoc,listContainer){

    //memoDoc의 상태를 체크한다.
    let btnClass = "btn btn-sm btn-default";
    let btnText = "무소속";
    let btnValue = "none";
    if(memoDoc.tripPlan){
        btnClass = "btn btn-sm btn-primary trip-plan-memo-btn";
        btnText = memoDoc.tripPlan.tripPlanTitle;
        btnValue = memoDoc.tripPlan.tripPlanNo;
    }else if(memoDoc.chatRoom){
        btnClass = "btn btn-sm btn-info chat-room-memo-btn";
        btnText = memoDoc.chatRoom.chatRoomTitle;
        btnValue = memoDoc.chatRoom.chatRoomNo;
    }else if(memoDoc.review){
        btnClass = "btn btn-sm btn-warning review-memo-btn";
        btnText = memoDoc.review.reviewTitle;
        btnValue = memoDoc.review.reviewNo;
    }

    //눈물의 컷트

    //memoDoc를 담을 버튼을 만든다.
    let memoDocBtn = $('<div>').addClass('my-memo-thumbnail btn-group-justified').attr('role', 'group');
    let innerBtn = $('<a>').attr('href', '#').addClass(btnClass).attr('role', 'button').text(btnText);
    innerBtn.val(btnValue);
    memoDocBtn.append(innerBtn);
    //memoDocBtn를 list-container에 붙인다.
    listContainer.append(memoDocBtn);

    memoDoc.memoList.forEach(memo => {
        //memo의 정보를 콘솔에 찍어본다.
/*        console.log("memo : " + memo);
        console.log("memo.memoTitle : " + memo.memoTitle);
        console.log("memo.memoContents : " + memo.memoContents);
        console.log("memo.memoNo : " + memo.memoNo);
        console.log("memo.memoRegDate : " + memo.memoRegDate);
        console.log("memo.memoDelDate : " + memo.memoDelDate);
        console.log("memo.memoAuthor : " + memo.memoAuthor);
        */
        //memo를 Json으로 바꾼다.
        let memoJson = JSON.stringify(memo);
        //내부 메모를 담을 버튼을 만든다.
        let memoBtn = $('<div>').addClass('my-memo-thumbnail btn-group-justified').attr('role', 'group');
        let innerBtn = $('<a>').attr('href', '#').addClass('btn btn-line btn-sm btn-default memo-list-thumbnail-btn').attr('role', 'button').text(memo.memoTitle);
        innerBtn.val(memoJson);
        memoBtn.append(innerBtn);
        //memoBtn를 list-container에 붙인다.
        listContainer.append(memoBtn);
    });
}
