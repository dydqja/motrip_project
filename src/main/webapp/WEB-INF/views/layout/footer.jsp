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
            <button type="button" id="memoListBtn" class="btn btn-primary">메모목록 로드</button>
            <div id="content"></div>
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
    var userId = $("#userId").val();
    $(document).ready(function() {
        $("#memoListBtn").click(function() {
            $.ajax({
                url: "/memo/test/"+userId,
                type: "GET",
                dataType: "json",
                success: function(response) {
                    var jsonString = JSON.stringify(response);
                    var newParagraph = $("<p></p>").text(jsonString);
                    $("#content").append(newParagraph);
                },
                error: function(xhr, status, error) {
                    console.log("AJAX Error:", error);
                }
            });
        });
    });
</script>
