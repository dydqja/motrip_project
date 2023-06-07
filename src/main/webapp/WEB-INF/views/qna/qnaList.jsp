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

        <title>질의응답 목록</title>

        <link rel="icon" type="image/png" href="/assets/img/favicon.png" />
        <link rel="stylesheet" href="/assets/css/min/bootstrap.min.css" media="all">
        <link rel="stylesheet" href="/assets/css/jqueryui.css" media="all">
        <link rel="stylesheet" href="/vendor/animate-css/animate.css" media="all">
        <link rel="stylesheet" href="/assets/font/iconfont/iconstyle.css" media="all">
        <link rel="stylesheet" href="/assets/font/font-awesome/css/font-awesome.css" media="all">
        <link rel="stylesheet" href="/assets/css/main.css" media="all" id="maincss">

        <link rel="stylesheet" href="/css/qna/qnaList.css">
    </head>

    <body>

        <%@ include file="/WEB-INF/views/layout/header.jsp" %>

        <div class="page-img">
            <div class="container">
                <div class="col-sm-8">
                    <h1 class="main-head">질의응답</h1>
                </div>
                <div class="col-sm-4">
                    <ul class="breadcrumb">
                        <li><a href=""><span class="icon-home"></span></a>
                        </li>
                        <li><a href="">List</a>
                        </li>
                    </ul>
                </div>

            </div>
        </div>

        <div class="container">

            <table class="table table-striped">

                <thead>
                    <tr>
                        <th class="text-center">카테고리</th>
                        <th class="text-center">제목</th>
                        <th class="text-center">답변여부</th>
                        <th class="text-center">작성자</th>
                        <th class="text-center">작성날짜</th>
                        <th class="text-center">조회수</th>
                    </tr>
                </thead>

                <tbody>

                    <c:forEach var="qna" items="${qnaListData.list}">
                        <fmt:formatDate value="${qna.qnaRegDate}" pattern="yyyy-MM-dd" var="formattedDate" />

                        <tr>
                            <td class="text-center">
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
                            <td class="text-center">${qna.isQnaAnswered == 1 ? '답변완료' : ''}</td>
                            <td class="text-center">${qna.qnaAuthor}</td>
                            <td class="text-center">${formattedDate}</td>
                            <td class="text-center">${qna.qnaViews}</td>
                        </tr>

                    </c:forEach>

                </tbody>

            </table>

            <div class="row">
                <div class="col-md-6">
                    <nav aria-label="Page navigation example">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${page.currentPage == 1 ? 'disabled' : ''}">
                                <c:choose>
                                    <c:when test="${page.currentPage == 1}">
                                        <a class="page-link" href="#" aria-label="Previous">
                                            &laquo;
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="page-link" href="/qna/qnaList?currentPage=${page.currentPage - 1}" aria-label="Previous">
                                            &laquo;
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </li>
                            <c:forEach var="i" begin="${beginUnitPage}" end="${endUnitPage}">
                                <li class="page-item ${i == page.currentPage ? 'active' : ''}">
                                    <a class="page-link" href="/qna/qnaList?currentPage=${i}">${i}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${page.currentPage == maxPage ? 'disabled' : ''}">
                                <c:choose>
                                    <c:when test="${page.currentPage == maxPage}">
                                        <a class="page-link" href="#" aria-label="Next">
                                            &raquo;
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="page-link" href="/qna/qnaList?currentPage=${page.currentPage + 1}" aria-label="Next">
                                            &raquo;
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </li>
                        </ul>
                    </nav>
                </div>

                <c:if test="${sessionScope.user.userId != 'admin' && not empty sessionScope.user.userId}">
                    <div class="col-md-6 text-right">
                        <button id="addQnaView" class="btn btn-primary">질문 등록</button>
                    </div>
                </c:if>
            </div>
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

            function viewDetail(qnaNo) {

                // 클릭한 공지 제목의 번호 파라미터를 컨트롤러로 전송하고 상세 조회 서비스 실행
                window.location.href = "/qna/getQna?qnaNo=" + qnaNo;
            }

            function goToPage(page) {

                // 페이지 번호를 컨트롤러로 전송하여 해당 페이지로 이동
                window.location.href = "/qna/qnaList?currentPage=" + page;
            }

            $(function() {

                // 질의응답 등록 페이지 출력 서비스 실행
                $("#addQnaView").on("click" , function() {

                    window.location.href = "/qna/addQnaView";
                });
            });

        </script>

    </body>