//도큐먼트에 달 리스너
$(document).ready(function () {
    console.log("document ready");
    //최초 1회, getMemoList 를 호출하여 myMemoList 를 가져온다.
    getMemoList('myMemo');
});
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
    console.log("searchCondition : " + searchCondition);
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
    console.log("getMemoList on");
    console.log("searchCondition : " + searchCondition);
    console.log("currentPage : " + currentPage);

    console.log("위의 조건으로 ajax를 날립니다.");
    // #my-memo-list 에 넣을 my memo 를 ajax로 받는다.
    $.ajax({
        type: "POST",
        url: "/memo/getMemoList",
        data: {searchCondition: searchCondition
            , currentPage: currentPage},
        dataType: "json",
        success: function (response) {
            let memoDocList = response;
            console.log("memoDocList : " + memoDocList);
            //buildMemoListThumbnail(searchCondition, memoDocList);
        }
    });
}

function buildMemoListThumbnail(searchCondition,memoDocList){
    // 썸네일 만들 곳을 객체로 잡는다.
    //기본 searchCondition 은 'myMemo'
    let listArea = document.querySelector("#my-memo-list");
    if(searchCondition == 'sharedMemo'){
        listArea = document.querySelector("#shared-memo-list");
    } else if (searchCondition == 'deletedMemo'){
        listArea = document.querySelector("#del-memo-list");
    }
    // listArea 에 있는 모든 자식을 지운다.
    while (listArea.hasChildNodes()){
        listArea.removeChild(listArea.firstChild);
    }
    memoDocList.forEach(memoDoc => {
        let memoDocThumbnailBtn = new MemoDocThumbnail(memoDoc.tripPlan, memoDoc.review, memoDoc.chatRoom, memoDoc.memoList).buildThumbnail();
        listArea.appendChild(memoDocThumbnailBtn);
        const thumbnailValueString = memoDocThumbnailBtn.value;
        // JSON 형식의 문자열을 JavaScript 객체로 변환
        const thumbnailValue = JSON.parse(thumbnailValueString);
        // memoList 속성에 접근
        const memoList = thumbnailValue.memoList;
        // memoList 에 있는 모든 메모를 썸네일로 만들어서 썸네일 버튼에 추가
        memoList.forEach(memo => {
            const memoThumbnailBtn = new MemoThumbnail(memo).buildThumbnail();
            memoDocThumbnailBtn.appendChild(memoThumbnailBtn);
        });
    });

}
class MemoDocThumbnail {
    constructor(tripPlan, review, chatRoom, memoList) {
        this.tripPlan = tripPlan;
        this.review = review;
        this.chatRoom = chatRoom;
        this.memoList = memoList;
    }

    buildThumbnail() {
        let memoDocThumbnail = document.createElement("button");
        memoDocThumbnail.setAttribute("type", "button");
        memoDocThumbnail.classList.add("memo-doc-thumbnail");
        memoDocThumbnail.classList.add("btn");
        memoDocThumbnail.classList.add("btn-line");
        memoDocThumbnail.classList.add("btn-sm");
        memoDocThumbnail.classList.add("btn-primary");
        memoDocThumbnail.setAttribute("role", "group");

            const thumbnailValue = {
                tripPlan: this.tripPlan,
                review: this.review,
                chatRoom: this.chatRoom,
                memoList: this.memoList
            };

            memoDocThumbnail.value = JSON.stringify(thumbnailValue);

        return memoDocThumbnail;
    }
}

class MemoThumbnail {
    constructor(memo) {
        this.memo = memo;
    }

    buildThumbnail() {
        let memoThumbnail = document.createElement("button");
        memoThumbnail.setAttribute("type", "button");
        memoThumbnail.classList.add("memo-thumbnail");
        memoThumbnail.classList.add("btn");
        memoThumbnail.classList.add("btn-line");
        memoThumbnail.classList.add("btn-sm");
        memoThumbnail.classList.add("btn-default");
        memoThumbnail.setAttribute("role", "group");

        const thumbnailValue = {
            memo: this.memo
        };

        memoThumbnail.value = JSON.stringify(thumbnailValue);

        return memoThumbnail;
    }
}
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