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
<footer>

<div>
    <c:if test="${empty sessionScope.user}">
        로그인되지 않은 사람은 메모를 사용할 수 없습니다.
    </c:if>
    <c:if test="${not empty sessionScope.user}">
        ${user.userId}님의 메모 바입니다.
        <button type="button" class="btn btn-primary" onclick="footerBtnClick()">메모목록 로드</button>
    </c:if>
</div>

</footer>
<hr/>

<script type="text/javascript">
    function footerBtnClick(){
        console.log("footer btn click")
    }
</script>