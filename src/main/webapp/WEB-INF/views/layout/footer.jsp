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
            <input type="hidden" id="memoListBtn" value=""/>
            <input type="hidden" id="userId" value=""/>
        </c:if>
        <c:if test="${not empty sessionScope.user}">
            <input type="hidden" id="userId" value="${user.userId}"/>
            <input type="hidden" id="memoSearchCon" value="${sessionScope.memoSearchCon}">
            <input type="hidden" id="">
            <button type="button" id="memoListBtn" class="btn btn-primary" onclick="toggleMemo()">메모 토글</button>
            <div id="memoListOn">
                <button type="button" id="myMemo" value="">내 메모 보기</button>
                <button type="button" id="sharedMemo" value="">공유받은 메모 보기</button>
                <button type="button" id="delMemo" value="">삭제된 메모 보기</button>
                <div id="memoListArea">

                </div>
            </div>
        </c:if>
    </div>
    <div class = "middle-section">
        메모 자세히보기 칸임
    </div>
    <div class = "right-section">
        챗봇 칸임
    </div>
</footer>
<hr/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function toggleMemo() {
        $('#memoListOn').toggle();
    }

    $(document).ready(function() {
        $('#memoListOn').hide(); //초기에 메모리스트 온을 숨김.
    });
</script>
