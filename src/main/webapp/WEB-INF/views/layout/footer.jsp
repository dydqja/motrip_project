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
                <input type="text" id="memoUserId" value="${sessionScope.user.userId}" readonly><br/>
                <input type="text" id="memoSearchCondition" value="${empty sessionScope.memoPage.searchCondition ? 'myMemo' : sessionScope.memoPage.searchCondition}" readonly><br/>
                <input type="text" id="memoCurrentPage" value="${empty sessionScope.memoPage.currentPage ? '1' : sessionScope.memoPage.currentPage}" readonly><br/>
                <input type="text" id="memoDialogCount" value="${empty sessionScope.memoPage.dialogCount ? '0' : sessionScope.memoPage.dialogCount}" readonly><br/>
                <button type="button" id="memoListToggleBtn" class="btn btn-primary" onclick="toggleMemo()">메모 토글</button>
                <br/>
                <br/>
                <div id="memoListSection">
                    <div id="memoListArea">

                    </div>
                    <br/>
                    <br/>
                    <div id="memoSearchArea">
                        <button type="button" class="memoSearchBtn" id="myMemo">내 메모 보기</button>
                        <button type="button" class="memoSearchBtn" id="sharedMemo">공유받은 메모 보기</button>
                        <button type="button" class="memoSearchBtn" id="deletedMemo">삭제된 메모 보기</button>
                        <button type="button" class="addMemoBtn" id="addMemo">새 메모</button>
                    </div>
                </div>
            </form>
        </c:if>
    </div>
    <div class = "middle-section">
        <div id="memoModalArea">
            <div id="memoShareListModal"></div>
        </div>
        <div id="memoDialogsArea">
            <form class="memoDialog" name="memoDialogCount">
                <div id="memoDetailArea">

                </div>
                <div id="memoControlArea">

                </div>
            </form>
        </div>
    </div>
    <div class = "right-section">
        <div id="root"></div>
        <script src="/js/bot/bot.js"></script>
        <link href="/css/bot/bot.css" rel="stylesheet">
    </div>
</footer>
<hr/>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" />
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="/css/memo/memo.css"/>
<script src="/js/memo/memo.js"></script>
