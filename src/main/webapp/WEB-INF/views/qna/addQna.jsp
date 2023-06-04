<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <head>

        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>질의응답 등록</title>

    </head>

    <body>

        <h1>질의응답 등록</h1>

        <br>
        <br>
        <br>

        <c:set var="formAction" value="${(qnaTitle == null && qnaContents == null) ? '/qna/addQna' : '/qna/updateQna'}" />
        <form action="${formAction}" method="post">

            <input type="hidden" name="qnaAuthor" value="${sessionScope.user.userId}" />

            <c:if test="${qnaNo != null}">

                <input type="hidden" name="qnaNo" value="${qnaNo}" />

            </c:if>

            <div>

                <input type="text" name="qnaTitle" id="qnaTitle" value="${qnaTitle}">

                <select name="qnaCategory">
                    <option value="0" ${qnaCategory == 0 ? 'selected' : ''}>계정문의</option>
                    <option value="1" ${qnaCategory == 1 ? 'selected' : ''}>기타문의</option>
                    <option value="2" ${qnaCategory == 2 ? 'selected' : ''}>여행플랜</option>
                    <option value="3" ${qnaCategory == 3 ? 'selected' : ''}>채팅</option>
                    <option value="4" ${qnaCategory == 4 ? 'selected' : ''}>메모</option>
                    <option value="5" ${qnaCategory == 5 ? 'selected' : ''}>후기</option>
                </select>

            </div>

            <br>

            <div>
                <textarea name="qnaContents" id="qnaContents">${qnaContents}</textarea>
            </div>

            <br>

            <div>
                <button id="addQna" type="submit">등록하기</button>
            </div>

            <br>

            <div>
                <button type="reset">초기화</button>
            </div>

            <br>

            <div>
                <button id="getQnaList" type="button">목록보기</button>
            </div>

        </form>

        <%-- Bootstrap --%>
        <script src="http://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

        <%-- Jquery --%>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script type="text/javascript">

            $(function() {

                $("#addQna").on("click", function() {

                    var qnaTitle = $("#qnaTitle").val();
                    var qnaContents = $("#qnaContents").val();

                    if (!qnaTitle && !qnaContents) {

                        alert("제목과 내용을 입력해주세요.");
                        return false;

                    } else if (!qnaTitle) {

                        alert("제목을 입력해주세요.");
                        return false;

                    } else if (!qnaContents) {

                        alert("내용을 입력해주세요.");
                        return false;

                    } else {

                        $('form').submit();
                    }
                });
            });

            $(function() {

                // DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
                $("#getQnaList").on("click" , function() {

                    window.location.href = "/qna/qnaList";
                });
            });

        </script>

    </body>

</html>