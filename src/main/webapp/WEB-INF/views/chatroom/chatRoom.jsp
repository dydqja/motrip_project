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
        function fncKickChatroom(){
            $("#chat-room").attr("method","get").attr("action","/photos/roomPhotos").submit();
        }

        $(function() {
            $(".kick").on("click", function() {
                fncKickChatroom();
            });
        });

        //out
        function fncKickChatroom(){
            $("#chat-room").attr("method","get").attr("action","/chatMember/outMember").submit();
        }

        $(function() {
            $("#out").on("click", function() {
                fncKickChatroom();
            });
        });
    </script>
      <script>
          const username = "${username}";
          const room = "${chatRoom.chatRoomNo}";
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
        <a class="btn" id="out">채팅방 나가기</a>
        <a class="btn">음성챗(모달 예정)</a>
        <a class="btn" id="roomPhotos">사진첩(모달 예정)</a>
<%--          <script>--%>
<%--              const username = "<%= username %>";--%>
<%--              const room = "<%= chatRoomNo %>";--%>
<%--          </script>--%>

      </header>
      <form id="chat-room">
          <input type="hidden" name="chatRoomNo" value="${chatRoom.chatRoomNo}">
      <main class="chat-main">
        <div class="chat-sidebar">
          <h3><i class="fas fa-comments"></i>채팅방 번호</h3>
          <h2 id="room-name"></h2>
            <h3><i class="fas fa-comments"></i>채팅방 이름</h3>
            <h2 id="chatRoomTtitle">${chatRoom.chatRoomTitle}</h2>
          <h3><i class="fas fa-users"></i>현재 참여 목록</h3>
          <ul id="users"></ul><td/>
          <h3 >참여 유저</h3>
            <ul id="members"></ul>
            <c:set var="i" value="0" />
            <c:forEach var="chatMember" items="${chatMembers}">
                <c:set var="i" value="${ i+1 }" />
                    <li id="${chatMember.userId}">${chatMember.userId}
                    <button class="kick" name="userId" value="${chatMember.userId}">강제 퇴장</button>
                    </li>
            </c:forEach>
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