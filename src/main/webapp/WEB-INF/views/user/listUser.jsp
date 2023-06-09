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

  <title>회원목록</title>



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

<div class="page-img" style="background-image: url('/images/user/userListTop.jpg');">

  <header class="nav-menu fixed">
  <%@ include file="/WEB-INF/views/layout/header.jsp" %>
  </header>


  <div class="container">
    <h1 class="main-head text-center board-title noticeZooming">회원목록</h1>
  </div>
</div>

<div class="page-img" style="background-image: url('/images/user/userListPage.jpg');">


  <div class="row">

    <div class="col-md-6 text-left">
      <p class="text-primary">
        전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
      </p>
    </div>

    <div class="col-md-11 text-right">
      <form class="form-inline" name="detailForm">

        <div class="form-group">
          <select class="form-control" name="searchCondition" >
            <option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>회원ID</option>
            <option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>회원명</option>
            <option value="2"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>닉네임</option>
          </select>
        </div>

        <div class="form-group">
          <label class="sr-only" for="searchKeyword">검색어</label>
          <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
                 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
        </div>

        <button type="button" class="btn btn-default" id="search">검색</button>

        <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
        <input type="hidden" id="currentPage" name="currentPage" value=""/>

      </form>
    </div>

  </div>


  <div class="container">

    <table class="table table-striped">

      <thead class="table-header">

      <tr>
        <th class="text-center">No</th>
        <th class="text-center">아이디</th>
        <th class="text-center">이 름</th>
        <th class="text-center">닉네임</th>
        <th class="text-center">가입일자</th>
        <th class="text-center">탈퇴유무</th>
      </tr>

      </thead>

      <tbody class="table-body">
      <c:set var="i" value="0" />
      <c:forEach var="user" items="${list}">
        <c:set var="i" value="${ i+1 }" />
        <tr>
          <td class="text-center">${ i }</td>
          <td class="text-center getUser">${user.userId}</td>
          <td class="text-center">${user.userName}</td>
          <td class="text-center">${user.nickname}</td>
          <td class="text-center"><fmt:formatDate value="${user.userRegDate}" pattern="yyyy.MM.dd" /></td>
          <td class="text-center">${user.secession}</td>
        </tr>
      </c:forEach>
      </tbody>

    </table>

    <div class="row">
      <div class="col-md-6">
        <nav aria-label="Page navigation example" class="d-flex justify-content-center">
          <ul class="pagination">
            <li class="page-item ${resultPage.currentPage == 1 ? 'disabled' : ''}">
              <c:choose>
                <c:when test="${resultPage.currentPage == 1}">
                  <a class="page-link" href="#" aria-label="Previous">
                    &laquo;
                  </a>
                </c:when>
                <c:otherwise>
                  <a class="page-link" href="/user/listUser?currentPage=${resultPage.currentPage - 1}" aria-label="Previous">
                    &laquo;
                  </a>
                </c:otherwise>
              </c:choose>
            </li>

            <c:forEach var="i" begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}">
              <li class="page-item ${i == resultPage.currentPage ? 'active' : ''}">
                <button type="button" class="page-link" data-page="${i}">${i}</button>
              </li>
            </c:forEach>




            <li class="page-item ${resultPage.currentPage == resultPage.maxPage ? 'disabled' : ''}">
              <c:choose>
                <c:when test="${resultPage.currentPage == resultPage.maxPage}">
                  <a class="page-link" href="#" aria-label="Next">
                    &raquo;
                  </a>
                </c:when>
                <c:otherwise>
                  <a class="page-link" href="/user/listUser?currentPage=${resultPage.currentPage + 1}" aria-label="Next">
                    &raquo;
                  </a>
                </c:otherwise>
              </c:choose>
            </li>
          </ul>
        </nav>
      </div>
    </div>
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
    //============= userId 에 회원정보보기  Event  처리(Click) =============
    $(function() {

      //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
      $( ".getUser" ).on("click" , function() {
        console.log("회원ID 클릭됨"+$(this).text().trim());
        self.location ="/user/getUser?userId="+$(this).text().trim();
      });

      //==> userId LINK Event End User 에게 보일수 있도록
      $( "td:nth-child(2)" ).css("color" , "red");
    });

    $(document).ready(function() {

      $(".page-link").click(function() {

        var page = $(this).data("page");
        window.location.href = "/user/listUser?currentPage=" + page;
      });
    });


</script>

</body>

</html>