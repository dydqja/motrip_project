<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<!DOCTYPE html>
<html lang="ko">

    <head>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>공지사항 목록</title>

        <link rel="icon" type="image/png" href="/assets/img/favicon.png" />
        <link rel="stylesheet" href="/assets/css/min/bootstrap.min.css" media="all">
        <link rel="stylesheet" href="/assets/css/jqueryui.css" media="all">
        <link rel="stylesheet" href="/vendor/animate-css/animate.css" media="all">
        <link rel="stylesheet" href="/assets/font/iconfont/iconstyle.css" media="all">
        <link rel="stylesheet" href="/assets/font/font-awesome/css/font-awesome.css" media="all">
        <link rel="stylesheet" href="/assets/css/main.css" media="all" id="maincss">

        <link rel="stylesheet" href="/css/notice/noticeList.css">
    </head>

    <body>

        <%@ include file="/WEB-INF/views/layout/header.jsp" %>

        <h1 class="text-center">공지사항</h1>

        <br>
        <br>
        <br>

        <div class="container">

            <table class="table table-striped">

                <thead>

                    <tr>
                        <th class="text-center">번호</th>
                        <th class="text-center">말머리</th>
                        <th class="text-center">제목</th>
                        <th class="text-center">글쓴이</th>
                        <th class="text-center">작성일</th>
                        <th class="text-center">조회수</th>
                    </tr>

                </thead>

                <tbody>
                <c:set var="importantCount" value="0" />
                <c:forEach var="notice" items="${noticeListData.list}">
                    <fmt:formatDate value="${notice.noticeRegDate}" pattern="yyyy-MM-dd" var="formattedDate" />
                    <c:choose>
                        <c:when test="${notice.isNoticeImportant == 1 && importantCount < 3}">
                            <tr>
                                <td class="text-center important-row">${notice.noticeNo}</td>
                                <td class="text-center important-row">최신</td>
                                <td class="important-row">
                                    <a href="#" onclick="viewDetail(${notice.noticeNo})">
                                        <img src="/images/board/notice.gif" style="max-width: 25px; max-height: 25px;">
                                            ${notice.noticeTitle}
                                    </a>
                                </td>
                                <td class="text-center important-row">${notice.noticeAuthor == 'admin' ? '운영자' : ''}</td>
                                <td class="text-center important-row">${formattedDate}</td>
                                <td class="text-center important-row">${notice.noticeViews}</td>
                            </tr>
                            <c:set var="importantCount" value="${importantCount + 1}" />
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td class="text-center">${notice.noticeNo}</td>
                                <td class="text-center">일반</td>
                                <td>
                                    <a href="#" onclick="viewDetail(${notice.noticeNo})">${notice.noticeTitle}</a>
                                </td>
                                <td class="text-center">${notice.noticeAuthor == 'admin' ? '운영자' : ''}</td>
                                <td class="text-center">${formattedDate}</td>
                                <td class="text-center">${notice.noticeViews}</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                </tbody>

            </table>

            <nav aria-label="Page navigation example">

                <ul class="pagination justify-content-center">

                    <li class="page-item ${page.currentPage == 1 ? 'disabled' : ''}">

                        <a class="page-link" href="/notice/noticeList?currentPage=${page.currentPage - 1}" aria-label="Previous">
                            &laquo;
                        </a>

                    </li>

                    <c:forEach var="i" begin="${beginUnitPage}" end="${endUnitPage}">

                        <li class="page-item ${i == page.currentPage ? 'active' : ''}">

                            <a class="page-link" href="/notice/noticeList?currentPage=${i}">${i}</a>

                        </li>

                    </c:forEach>

                    <li class="page-item ${page.currentPage == maxPage ? 'disabled' : ''}">

                        <a class="page-link" href="/notice/noticeList?currentPage=${page.currentPage + 1}" aria-label="Next">
                            &raquo;
                        </a>

                    </li>

                </ul>

            </nav>

            <c:if test="${sessionScope.user.userId eq 'admin'}">

                <div>
                    <button id="addNoticeView" class="btn btn-primary">공지 등록</button>
                </div>

            </c:if>

        </div>

        <%@ include file="/WEB-INF/views/layout/footer.jsp" %>

        <script src="/vendor/jquery/dist/jquery.min.js"></script>
        <script src="/vendor/jqueryui/jquery-ui-1.10.3.custom.min.js"></script>
        <script src="/vendor/jquery.ui.touch-punch.min.js"></script>
        <script src="/vendor/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="/vendor/waypoints/lib/jquery.waypoints.min.js"></script>
        <script src="/vendor/owlcarousel/owl.carousel.min.js"></script>
        <script src="/vendor/retina.min.js"></script>
        <script src="/vendor/jquery.imageScroll.min.js"></script>
        <script src="/assets/js/min/responsivetable.min.js"></script>
        <script src="/assets/js/bootstrap-tabcollapse.js"></script>
        <script src="/assets/js/min/countnumbers.min.js"></script>
        <script src="/assets/js/main.js"></script>
        <script src="/assets/js/min/home.min.js"></script>

        <script type="text/javascript">

            function viewDetail(noticeNo) {

                // 클릭한 공지 제목의 번호 파라미터를 컨트롤러로 전송하고 상세 조회 서비스 실행
                window.location.href = "/notice/getNotice?noticeNo=" + noticeNo;
            }

            function goToPage(page) {

                // 페이지 번호를 컨트롤러로 전송하여 해당 페이지로 이동
                window.location.href = "/notice/noticeList?currentPage=" + page;
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