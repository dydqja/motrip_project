<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE HTML>
<html lang="ko">

    <head>

        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>질의응답 목록</title>

        <%-- CSS START --%>
        <link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
              integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

        <style>

            .centered-table {
                text-align: center;
            }

            .centered-table th,
            .centered-table td {
                text-align: center;
            }

        </style>
        <%-- CSS END --%>

    </head>

    <body>

        <h1>질의응답 목록</h1>

        <br>
        <br>
        <br>

        <table class="centered-table">

            <thead>
                <tr>
                    <th>카테고리</th>
                    <th>제목</th>
                    <th>답변여부</th>
                    <th>작성자</th>
                    <th>작성날짜</th>
                    <th>조회수</th>
                </tr>
            </thead>

            <tbody>

                <c:forEach var="qna" items="${qnaListData.list}">

                    <fmt:formatDate value="${qna.qnaRegDate}" pattern="yyyy-MM-dd" var="formattedDate" />

                    <tr>
                        <td>
                            <c:choose>
                                <c:when test="${qna.qnaCategory == 0}">계정문의</c:when>
                                <c:when test="${qna.qnaCategory == 1}">기타문의</c:when>
                                <c:when test="${qna.qnaCategory == 2}">여행플랜</c:when>
                                <c:when test="${qna.qnaCategory == 3}">채팅</c:when>
                                <c:when test="${qna.qnaCategory == 4}">메모</c:when>
                                <c:when test="${qna.qnaCategory == 5}">후기</c:when>
                            </c:choose>
                        </td>
                        <td><a href="#" onclick="viewDetail(${qna.qnaNo})">${qna.qnaTitle}</a></td>
                        <td>${qna.isQnaAnswered == 1 ? '답변완료' : ''}</td>
                        <td>${qna.qnaAuthor}</td>
                        <td>${formattedDate}</td>
                        <td>${qna.qnaViews}</td>
                    </tr>

                </c:forEach>

            </tbody>

        </table>

        <nav aria-label="Page navigation example">

            <ul class="pagination">

                <li class="page-item ${page.currentPage == 1 ? 'disabled' : ''}">

                    <a class="page-link" href="/qna/qnaList?currentPage=${page.currentPage - 1}" aria-label="Previous">
                        «
                    </a>

                </li>

                <c:forEach var="i" begin="${beginUnitPage}" end="${endUnitPage}">

                    <li class="page-item ${i == page.currentPage ? 'active' : ''}">

                        <a class="page-link" href="/qna/qnaList?currentPage=${i}">${i}</a>

                    </li>

                </c:forEach>

                <li class="page-item ${page.currentPage == maxPage ? 'disabled' : ''}">

                    <a class="page-link" href="/qna/qnaList?currentPage=${page.currentPage + 1}" aria-label="Next">
                        »
                    </a>

                </li>

            </ul>

        </nav>

        <c:if test="${sessionScope.user.userId != 'admin' && not empty sessionScope.user.userId}">

            <div>
                <button id="addQnaView" >질문 등록</button>
            </div>

        </c:if>

        <%-- Bootstrap --%>
        <script src="http://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

        <%-- Jquery --%>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script type="text/javascript">

            function viewDetail(qnaNo) {

                // 클릭한 공지 제목의 번호 파라미터를 컨트롤러로 전송하고 상세 조회 서비스 실행
                window.location.href = "/qna/getQna?qnaNo=" + qnaNo;
            }

            function goToPage(page) {

                // 페이지 번호를 컨트롤러로 전송하여 해당 페이지로 이동
                window.location.href = "/qna/qnaList?currentPage=" + page;
            }

            $(function() {

                // DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
                $("#addQnaView").on("click" , function() {

                    window.location.href = "/qna/addQnaView";
                });
            });

        </script>

    </body>

</html>