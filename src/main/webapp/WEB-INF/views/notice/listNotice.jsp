<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE HTML>
<html lang="ko">

    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>공지사항 목록</title>

        <%-- CSS START --%>
        <link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
              integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
        <style>
            .selector-for-some-widget {
                box-sizing: content-box;
            }

            .centered-table {
                text-align: center;
            }
        </style>
        <%-- CSS END --%>

    </head>

    <body>

        <h1>공지사항 목록</h1>

        <br>
        <br>
        <br>

        <table class="centered-table">

            <thead>
                <tr>
                    <th>작성자</th>
                    <th>제목</th>
                    <th>중요</th>
                    <th>작성날짜</th>
                    <th>조회수</th>
                </tr>
            </thead>

            <tbody>
                <c:forEach var="notice" items="${noticeListData.list}">

                    <fmt:formatDate value="${notice.noticeRegDate}" pattern="yyyy-MM-dd" var="formattedDate" />

                    <tr>
                        <td>${notice.noticeAuthor}</td>
                        <td><a href="#" onclick="viewDetail(${notice.noticeNo})">${notice.noticeTitle}</a></td>
                        <td>${notice.isNoticeImportant != 0 ? notice.isNoticeImportant : ''}</td>
                        <td>${formattedDate}</td>
                        <td>${notice.noticeViews}</td>
                    </tr>

                </c:forEach>
            </tbody>

        </table>

        <nav aria-label="Page navigation example">
            <ul class="pagination">
                <li class="page-item">
                    <c:if test="${noticeListData.currentPage > 1}">
                        <a class="page-link" href="#" onclick="goToPage(${noticeListData.currentPage - 1})" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </c:if>
                </li>

                <c:forEach var="pageUnit" begin="1" end="${totalPages}">
                    <li class="page-item ${pageUnit eq noticeListData.currentPage ? 'active' : ''}">
                        <a class="page-link" href="#" onclick="goToPage(${pageUnit})">${pageUnit}</a>
                    </li>
                </c:forEach>

                <li class="page-item">
                    <c:if test="${noticeListData.currentPage < totalPages}">
                        <a class="page-link" href="#" onclick="goToPage(${noticeListData.currentPage + 1})" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </c:if>
                </li>
            </ul>
        </nav>

        <div>
            <button id="addNoticeView" >공지 등록</button>
        </div>

        <%--Bootstrap--%>
        <script src="http://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

        <%--Jquery--%>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script type="text/javascript">

            function viewDetail(noticeNo) {

                // 클릭한 공지 제목의 번호 파라미터를 컨트롤러로 전송하고 상세 조회 서비스 실행
                window.location.href = "/notice/getNotice?noticeNo=" + noticeNo;
            }

            function goToPage(page) {
                // 페이지 번호를 컨트롤러로 전송하여 해당 페이지로 이동
                window.location.href = "/notice/getNoticeList?currentPage=" + page;
            }

            $(function() {

                // DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
                $("#addNoticeView").on("click" , function() {

                    window.location.href = "/notice/addNoticeView";
                });
            });

        </script>
    </body>
</html>