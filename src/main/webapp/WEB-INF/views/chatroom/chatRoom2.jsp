<%@page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="com.bit.motrip.domain.*"%>
<%--<%--%>
<%--    String username = request.getParameter("username");--%>
<%--    String chatRoomNo = request.getParameter("chatRoomNo");--%>
<%--%>--%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <%--   <link--%>
  <%--      rel="stylesheet"--%>
  <%--      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css"--%>
  <%--      integrity="sha256-mmgLkCYLUQbXn0B1SRqzHar6dCnv9oZFPEC1g1cwlkk="--%>
  <%--      crossorigin="anonymous"--%>
  <%--    />--%>

  <link rel="stylesheet" href="/css/style.css">


  <link rel="stylesheet" href="/assets/css/min/bootstrap.min.css" media="all">
  <link rel="stylesheet" href="/assets/css/jqueryui.css" media="all">
  <link rel="stylesheet" href="/assets/css/main.css" media="all" id="maincss">

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script type="text/javascript">
    //업데이트 컨트롤러로 이동
    function fncUpdateChatroom(){
      $("#chat-room").attr("method","get").attr("action","/chatRoom/updateChatRoom").submit();
    }

    $(function() {
      $("#updateChatRoom").on("click", function() {
        fncUpdateChatroom();
      });
    });
    //사진 컨트롤러로 이동
    function fncPhotoChatroom(){
      $("#chat-room").attr("method","get").attr("action","/photos/roomPhotos").submit();
    }

    $(function() {
      $("#roomPhotos").on("click", function() {
        fncPhotoChatroom();
      });
    });

    //kick
    $(document).ready(function() {
      $(document).on("click", ".kick",function() {
        alert($(this).data("userid"));
        alert("kick!!!");
        $.ajax({
          url: "/chatMember/json/kickMember",
          method: "post",
          dataType: "json",
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          data: JSON.stringify({
            "chatRoomNo": $('input[name=chatRoomNo]').val(),
            "userId": $(this).data("userid"),
          }),
          success: function(JSONData, status) {

          }
        });
      });
    });

    //


    $(document).ready(function() {
      // AJAX 요청을 보내고 채팅 멤버 리스트를 받아와 처리하는 함수
      function fetchChatMembers() {
        $.ajax({
          url: '/chatMember/json/fetchChatMembers/'+chatRoomNo, // 서버의 채팅 멤버 리스트를 가져오는 경로로 수정해야 합니다.
          type: 'GET',
          dataType: 'json',
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          success: function(members) {
            console.log(chatRoomNo);
            console.log(members);
            let memberArray = [];
            // 채팅 멤버 리스트를 출력할 요소
            var chatUsers = $('#chatUsers');

            // 기존 리스트 초기화
            chatUsers.empty();

            // 멤버 리스트를 순회하며 <li> 요소 생성 및 추가
            $.each(members, function(index, member) {
              memberArray.push(member.userId);
              var li = $('<li>').attr("id", member.userId).text(member.userId);
              chatUsers.append(li);

              if (author === member.userId) {
                li.append('<img src="/imagePath/masetHat.png"/>'); // 방장
              }
              if (author === username && author !== member.userId) {
                var kickButton = $("<button>")
                        .addClass("kick")
                        .attr("data-userid", member.userId)
                        .text("강제 퇴장");

                li.append(kickButton);
              }
              chatUsers.append(li);
            });
            if(memberArray.includes(username)){
              console.log("you are member!!!")
            }else{
              window.location.href = "/chatRoom/chatRoomList";
            }
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error:', error);
          }
        });
      }
      // 페이지가 열리면 채팅 멤버 리스트를 받아와 출력
      fetchChatMembers();

      // 일정 간격으로 채팅 멤버 리스트 업데이트
      setInterval(function() {fetchChatMembers();}, 3000); // 5초마다 업데이트, 필요에 따라 적절한 간격으로 수정 가능
    });
    // function redirectToChatRoomList() {
    //     // Replace 'chatRoomListPage.html' with the actual URL or path of your chat room list page
    //     $("#chat-room").attr("method","get").attr("action","/chatRoom/chatRoomList").submit();
    // }
    //out
    function fncOutChatroom(){
      $("#chat-room").attr("method","get").attr("action","/chatMember/outMember").submit();
    }

    $(function() {
      $("#out").on("click", function() {
        fncOutChatroom();
      });
    });

    //delete
    function fncDeleteChatroom(){
      $("form").attr("method","get").attr("action","/chatRoom/deleteChatRoom").submit();
    }
    $(function() {$("#delete").on("click", function() {fncDeleteChatroom();});});
  </script>
  <script>
    const username = "${username}";
    const room = "${chatRoom.chatRoomNo}";
    const author = "${author.userId}";
    const chatRoomNo = "${chatRoom.chatRoomNo}";
   // const image = "${image}";
  </script>
  <title>ChatCord App</title>

</head>
<body>
<header class="nav-menu fixed" >

  <style>
    #memo-section .panel {
      background-color: transparent;
    }
    #memo-section .panel .panel-heading{
      background-color: transparent;
    }
    #memo-section .panel .panel-title{
      background-color: transparent;
    }
    #memo-section .panel .panel-title > a{
      color: white;
    }
    #memo-section .panel .panel-title > a::before{
      background-color: transparent;
    }
    #memo-section .panel .panel-title > a::after{
      background-color: transparent;
    }
  </style>
  <link rel="stylesheet" href="/css/alarm/alarm.css" media="all">
  <script src="/js/alarm/alarm.js"></script>

  <div class="pre-loader" style="display: none;">
    <div class="loading-img"></div>
  </div>

  <header class="nav-menu fixed">
    <nav class="navbar normal transparent">
      <div class="container-fluid" style="background-color: #477427">
        <div class="navbar-header">
          <a class="navbar-brand" href="/">
            <img src="/images/motrip-logo.gif" alt="" height="120" width="120">
            <br/>

          </a>
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#main-navbar">
            <i class="icon-microphone"></i>
            <span class="sr-only">Toggle navigations</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
        </div>

        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li class="dropdown">
              <a href="#">채팅방 Menu <i class="fa fa-chevron-down nav-arrow"></i></a>
              <ul class="dropdown-menu">
                <li><a href="home_default.html">채팅방 Menu</a></li>
                <li><a href="home_slider.html">채팅창 수정</a></li>
                <li><a href="home_slider_html">채팅방 삭제</a></li>
                <c:if test="${empty sessionScope.user}">
                  <li><a href="/test/login/user1">채팅방 나가기</a></li>
                </c:if>
                <li><a href="home_slider_html">사진첩</a></li>
              </ul>
            </li>
            <li class="dropdown">
              <a href="#">모두의 여행 <i class="fa fa-chevron-down nav-arrow"></i></a>
              <ul class="dropdown-menu">
                <li><a href="home_default.html">모두의 여행이란</a></li>
                <li><a href="home_slider.html">설계 포트폴리오</a></li>
                <li><a href="home_slider_with_searhbar.html">제작팀 소개</a></li>
                <c:if test="${empty sessionScope.user}">
                  <li><a href="/test/login/user1">유저1로 로그인</a></li>
                  <li><a href="/test/login/user2">유저2로 로그인</a></li>
                  <li><a href="/test/login/admin">admin 로그인</a></li>
                </c:if>
                <c:if test="${not empty sessionScope.user}">
                  <li><a href="/test/logout">${user.userId}님,로그아웃</a></li>
                </c:if>
              </ul>
            </li>
            <li class="dropdown">
              <a href="#">여행플랜</a>
              <ul class="dropdown-menu">
                <li><a href="/tripPlan/tripPlanList">여행플랜 목록</a>
                </li>
                <li><a href="/tripPlan/myTripPlanList">나의 여행플랜</a>
                </li>
                <li><a href="/tripPlan/myTripPlanList">나의 여행플랜</a>
                </li>
                <li><a href="/tripPlan/addTripPlanView">여행플랜 작성</a>
                </li>
              </ul>
            </li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle">채팅</a>
              <ul class="dropdown-menu">
                <li><a href="/chatRoom/chatRoomList">채팅 리스트</a>
                </li>
              </ul>
            </li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle">후기</a>
              <ul class="dropdown-menu">
                <li><a href="/review/addReviewView">후기 작성</a>
                </li>
                <li><a href="/review/getReviewList">모든 후기</a>
                </li>
                <li><a  href="/review/getMyReviewList">나의 후기</a>
                </li>
              </ul>
            </li>
            <li id="memo-section" class="dropdown">
              <a href="#" class="dropdown-toggle">메모</a>
              <ul id="memo-dropdown" class="dropdown-menu">
                <div class="panel-group" id="memo-accordion" role="tablist" aria-multiselectable="true">
                  <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="new-memo-btn">
                      <p class="panel-title">
                        <a role="button" data-parent="#memo-accordion" aria-expanded="false" aria-controls="collapseOne" class="collapsed">
                          + 새 메모
                        </a>
                      </p>
                    </div>
                  </div>
                  <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="heading1One">
                      <p class="panel-title">
                        <a role="button" data-toggle="collapse" data-parent="#memo-accordion" href="#my-memo-collapse" aria-expanded="true" aria-controls="collapseOne">
                          나의 메모 보기
                        </a>
                      </p>
                    </div>
                    <div id="my-memo-collapse" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                      <div class="panel-body">
                        <div class="btn-group-vertical" role="group" aria-label="...">
                          <div class="btn btn-line btn-sm btn-default" role="group" aria-label="...">ㅁaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa</div>
                          <div class="btn btn-line btn-sm btn-default" role="group" aria-label="...">ㅁaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa</div>
                          <div class="btn btn-line btn-sm btn-default" role="group" aria-label="...">ㅁaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa</div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="heading1Two">
                      <p class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#memo-accordion" href="#shared-memo-collapse" aria-expanded="false" aria-controls="collapseTwo">
                          공유받은 메모 보기
                        </a>
                      </p>
                    </div>
                    <div id="shared-memo-collapse" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                      <div class="panel-body">
                        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird
                        on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table,
                        raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
                      </div>
                    </div>
                  </div>
                  <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="heading1Three">
                      <p class="panel-title">

                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#memo-accordion" href="#del-memo-collapse" aria-expanded="false" aria-controls="collapseThree">
                          삭제된 메모 보기
                        </a>

                      </p>
                    </div>
                    <div id="del-memo-collapse" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                      <div class="panel-body">
                        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird
                        on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table,
                        raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
                      </div>
                    </div>
                  </div>
                </div>
              </ul>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="boardDropdown" role="button"
                 data-bs-toggle="dropdown" aria-expanded="false">
                게시판
              </a>
              <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="boardDropdown">
                <li>
                  <a class="dropdown-item" href="/notice/noticeList">공지사항</a>
                </li>
                <li>
                  <a class="dropdown-item" href="/qna/qnaList">질의응답</a>
                </li>
              </ul>
            </li>
            <c:if test="${empty sessionScope.user}">
            <li> <a href="/user/login"><span class="icon-user"></span>로그인</a>
              </c:if>
              <c:if test="${not empty sessionScope.user}">
            <li class="dropdown">
              <a class="icon-user" href="#">${sessionScope.user.nickname}</a>
              <ul class="dropdown-menu">
                <li><a href="#">MyPage</a>
                </li>
                <c:if test="${sessionScope.user.role == 0}">
                  <li><a href="/user/listUser">회원목록</a>
                  </li>
                </c:if>
                <li><a href="#">로그아웃</a>
                </li>
              </ul>
            </li>
            </c:if>
            </li>
            <li class="dropdown">
              <a id="alarm-set-area" href="#">
                <span id="alarm-bell"  class="icon-bell" data-toggle="popover" data-content="popoverContents" data-placement="top" data-trigger="focus" title=""></span>
                <span id="unreadAlarmCount" class="badge badge-danger">0</span></a>
              <ul id="alarm-thumbnail-area" class="dropdown-menu  dropdown-menu-right cart-menu">

              </ul>
            </li>
          </ul>
        </div>
      </div>
      <div class="alarm-info-area">
        <%--어플리케이션 스코프로부터 값을 받거나, 3이다.--%>
        <input type="hidden" id="pollingTime" value="${applicationScope.alarmPollingTime}">
        <input type="hidden" id="alarmUserId" value="${sessionScope.user.userId}">
        <input type="hidden" id="alarmUserNickname" value="${sessionScope.user.nickname}">
        <input type="hidden" id="alarmCurrentPage" value="1">
      </div>

    </nav>
  </header>
  <%--button trigger modal--%>
  <input type="hidden" data-toggle="modal" href="#alarm-modal"></input>
  <%--Modal--%>
  <div id="alarm-modal" class="modal" aria-labelledby="myModalLabel" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
          <h3 id="alarm-modal-title" class="modal-title">Modal Title</h3>
        </div>
        <div id="alarm-modal-contents" class="modal-body">
          Modal Content..
        </div>
        <div id="alarm-modal-footer" class="modal-footer">
          <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">닫기</button>
          <button type="button" id="alarm-confirm-btn" class="btn btn-sm btn-primary">읽음</button>
          <button type="button" id="alarm-navigate-btn" class="btn btn-sm btn-info">이동</button>
          <button type="button" id="alarm-accept-btn" class="btn btn-sm btn-primary">승인</button>
          <button type="button" id="alarm-hold-btn" class="btn btn-sm btn-warning">보류</button>
          <button type="button" id="alarm-reject-btn" class="btn btn-sm btn-danger">거절</button>
        </div>
      </div>
    </div>
  </div>

</header>
<div class="chat-container">
  <header class="chat-header">
    <h1><i class="fas fa-smile"></i> 이승현의 JSP 채팅방</h1>
    <c:if test="${author.userId eq username}">
      <button class="btn" id="updateChatRoom">채팅창 수정</button>
    </c:if>
    <a class="btn" id="leave-btn">채팅방 뒤로가기</a>
    <c:if test="${author.userId eq username}">
      <a class="btn" id="delete">채팅방 삭제</a>
    </c:if>
    <c:if test="${author.userId ne username}">
      <a class="btn" id="out">채팅방 나가기</a>
    </c:if>
    <a class="btn">음성챗(모달 예정)</a>
    <a class="btn" id="roomPhotos">사진첩(모달 예정)</a>
    <%--          <script>--%>
    <%--              const username = "<%= username %>";--%>
    <%--              const room = "<%= chatRoomNo %>";--%>
    <%--          </script>--%>

  </header>
  <form id="chat-room" onsubmit="return false;">
    <input type="hidden" name="chatRoomNo" value="${chatRoom.chatRoomNo}">
    <input type="hidden" name="userId" value="${username}">
    <main class="chat-main">
      <div class="chat-sidebar">
        <h3><i class="fas fa-comments"></i>채팅방 번호</h3>
        <h2 id="room-name"></h2>
        <h3><i class="fas fa-comments"></i>채팅방 이름</h3>
        <h2 id="chatRoomTtitle">${chatRoom.chatRoomTitle}</h2>
        <h3><i class="fas fa-users"></i>현재 참여 목록</h3>
        <ul id="users"></ul><td/>
        <h3 >참여 유저</h3>
        <ul id="chatUsers">
          <%--            <c:set var="i" value="0" />--%>
          <%--            <c:forEach var="chatMember" items="${chatMembers}">--%>
          <%--                <c:set var="i" value="${ i+1 }" />--%>
          <%--                    <li id="${chatMember.userId}">${chatMember.userId}--%>
          <%--                        <c:if test="${author.userId eq chatMember.userId}">--%>
          <%--                            <img src="/imagePath/masetHat.png"/> <!--방장-->--%>
          <%--                        </c:if>--%>
          <%--                        <c:if test="${author.userId eq username}">--%>
          <%--                            <c:if test="${author.userId ne chatMember.userId}">--%>
          <%--                                <button class="kick" data-userid="${chatMember.userId}">강제 퇴장</button>--%>
          <%--                            </c:if>--%>
          <%--                        </c:if>--%>
          <%--                    </li>--%>
          <%--            </c:forEach>--%>
        </ul>
      </div>
      <div class="chat-messages">
      </div>
    </main>
  </form>

  <div id="image-preview"></div> <!-- Container for image preview -->
  <div class="chat-form-container">
    <form id="chat-form" enctype="multipart/form-data">
      <input
              id="msg"
              type="text"
              placeholder="Enter Message"
              required
              autocomplete="off"
      />
      <input multiple="multiple" type="file" class="form-control"
             id="uploadFile" name="uploadFile"/>

      <button class="btn"><i class="fas fa-paper-plane"></i> Send</button>
    </form>
  </div>
</div>



<!--
    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/qs/6.9.2/qs.min.js"
      integrity="sha256-TDxXjkAUay70ae/QJBEpGKkpVslXaHHayklIVglFRT4="
      crossorigin="anonymous"
    ></script> -->
<script src="https://cdn.socket.io/4.3.2/socket.io.min.js"></script>
<script src="/js/main.js"></script>
<script src="/vendor/jquery/dist/jquery.min.js"></script>


<script src="/vendor/waypoints/lib/jquery.waypoints.min.js"></script>
<%--  <script src="/vendor/owlcarousel/owl.carousel.min.js"></script>--%>
<script src="/vendor/retina.min.js"></script>
<%--  <script src="/vendor/jquery.imageScroll.min.js"></script>--%>
<%--  <script src="/assets/js/min/responsivetable.min.js"></script>--%>
<%--  <script src="/assets/js/bootstrap-tabcollapse.js"></script>--%>
<script src="/assets/js/main.js"></script>

<%--    <script src="/js/imagepreview.js"></script>--%>
</body>
</html>