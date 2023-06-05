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
          const author = "${author.userId}"
          const chatRoomNo = "${chatRoom.chatRoomNo}"
      </script>
    <title>ChatCord App</title>

  </head>
  <body>

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
<%--    <script src="/js/imagepreview.js"></script>--%>
  </body>
</html>