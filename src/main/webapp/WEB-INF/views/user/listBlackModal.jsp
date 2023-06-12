<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>






<!DOCTYPE html>

<html lang="ko">

<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>블랙리스트</title>

    <link rel="icon" type="image/png" href="/assets/img/favicon.png">

    <link rel="stylesheet" href="/assets/css/jqueryui.css" media="all">
    <link rel="stylesheet" href="/assets/css/min/bootstrap.min.css" media="all">
    <link rel="stylesheet" href="/vendor/animate-css/animate.css" media="all">
    <link rel="stylesheet" href="/assets/font/iconfont/iconstyle.css" media="all">
    <link rel="stylesheet" href="/assets/font/font-awesome/css/font-awesome.css" media="all">
    <link rel="stylesheet" href="/assets/css/main.css" media="all" id="maincss">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">

</head>

<body>

  <!-- 블랙리스트 모달 -->
  <div id="listBlackModal" class="modal in" tabindex="-1" role="dialog" aria-hidden="true" style="display: none; padding-right: 17px;">
      <div class="modal-dialog modal-sm">
          <div class="modal-content">
              <div class="modal-header text-center" style="background-color: #558B2F;">
                  <h3 class="modal-title" style="color: white;">블랙리스트</h3>
                  <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color: #8B2955;">×</button>
              </div>
              <div class="modal-body" style="background-color: #F5F1E3;">
                  <form class="form-horizontal" style="margin-left: 20%; margin-right: 10%;">
                      <h3 class="text-right" style="margin-right: 50%" >닉네임</h3>

                      <br/>
                          <div class="text-left" id="blacklistBody">
                              <c:set var="i" value="0" />
                              <c:forEach var="user" items="${$blacklistBody}">
                                  <c:set var="i" value="${ i+1 }" />
                                  <div class="text-center getUser">${getUser.userId}</div>
                              </c:forEach>
                          </div>
                  </form>
              </div>
              <div class="modal-footer" style="background-color: #003049;">
                  <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
              </div>
          </div>
      </div>
  </div>


  <script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<%--  <script src="/assets/js/min/countnumbers.min.js"></script>--%>
<%--  <script src="/assets/js/main.js"></script>--%>


  <script type="text/javascript">


      $(document).ready(function() {

          fetchBlacklist();
      });


      let blacklistId;
      // 블랙리스트 가져오는 함수 (예시)
      function fetchBlacklist() {
          // 서버에 AJAX 요청을 보내어 블랙리스트를 가져옵니다.
          $.ajax({

              url: "/user/getBlacklist",
              type: "POST",
              contentType: "application/json; charset=utf-8",
              data: JSON.stringify({
                  evaluaterId: "${sessionScope.user.userId}"
              }),
              dataType: "json",
              success: function (response) {
                  var $blacklistBody = $('#blacklistBody');
                  $blacklistBody.empty();

                  for (var i = 0; i < response.length; i++) {
                      var nickname = response[i];
                      var userContainer = '<div class="userContainer" style="display: flex; justify-content: space-between;">' +
                          '<h3 class="getUser">' + nickname + '</h3>' +
                          '<button class="clickBlackId text-right" style="background-color: transparent; border: none;" ><img src="/images/X.png" style="width: 10px; height: 10px;"></button>' +
                          '</div>';

                      $blacklistBody.append(userContainer);
                  }
              },
              error: function (error) {
                  alert("다시 시도해주세요.");
              }
          });
      }

      // X표시 클릭시 블랙리스트 해제
      $(document).ready(function() {

          $('body').on('click', '.clickBlackId', function(event) {
              event.preventDefault();
              // .closest() 메소드를 사용해 가장 가까운 .userContainer 요소를 찾습니다.
              var $userContainer = $(this).closest('.userContainer');

              // .find() 메소드를 사용해 .getUser 요소를 찾고, 그 내용을 가져옵니다.
              var nickname = $userContainer.find('.getUser').text();

              $.ajax({
                  url: "/user/nicknameToUserId",
                  type: "POST",
                  contentType: "application/json; charset=utf-8",
                  data: JSON.stringify({
                      nickname: nickname
                  }),
                  dataType: "text",
                  success: function (response) {

                      $.ajax({
                          url: "/user/deleteBlacklist",
                          type: "POST",
                          contentType: "application/json; charset=utf-8",
                          data: JSON.stringify({
                              evaluaterId: "${sessionScope.user.userId}",
                              blacklistedUserId: response
                          }),
                          dataType: "text",
                          success: function (response) {

                              swal({
                                  title: "블랙리스트 해제가 완료되었습니다.",
                                  text: "이제 해당 회원과 소통이 가능합니다.",
                                  icon: "success",
                                  button: "확인",

                              }).then((value) => {
                                  $('#listBlackModal').modal('hide');  // 모달 창 종료
                                  location.reload();  // 페이지 새로고침
                              });
                          },
                          error: function (error) {
                              alert("다시 시도해주세요.");
                          }
                      });
                  },
                  error: function (error) {
                      alert("다시 시도해주세요.");
                  }
              })
          })
      });












      // 블랙리스트를 모달에 표시하는 함수
      function displayBlacklist() {
          var blacklist = fetchBlacklist();
          var $blacklistBody = $('#blacklistBody');
          $blacklistBody.empty();  // 기존 목록을 지웁니다.

          for (var i = 0; i < blacklist.length; i++) {
              $blacklistBody.append('<p>' + blacklist[i] + '</p>');  // 목록을 추가합니다.
          }
      }


  </script>

</body>
</html>
