<%@ page contentType="text/html;charset=UTF-8" language="java" %>






<!DOCTYPE html>

<html lang="ko">

<head>
    <title>블랙리스트</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

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
                    alert(response);
                    var $blacklistBody = $('#blacklistBody');
                    $blacklistBody.empty();

                    for (var i = 0; i < response.length; i++) {
                        var nickname = response[i];
                        var userContainer = '<div class="userContainer">' +
                            '<span>' + (i + 1) + '. </span>' +
                            '<span class="getUser">' + nickname + '</span>' +
                            '</div>';

                        $blacklistBody.append(userContainer);
                    }
                },
                error: function (error) {
                    alert("실패");
                }
            });
        }

        $(function() {
            $('#blacklistBody').on('click', '.getUser', function() {
                console.log("회원ID 클릭됨" + $(this).text().trim());
                window.location.href = "/user/getUser?nickname=" + $(this).text().trim();
            });
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
</head>

<body>

  <!-- 블랙리스트 모달 -->
  <div id="listBlackModal" class="modal fade" role="dialog">
    <div class="modal-dialog">

      <!-- 블랙리스트 모달 내용 -->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">블랙리스트</h4>
        </div>

        <div class="modal-body">

          <form class="form-horizontal">

              <div id="blacklistBody">
                  <!-- 여기에 블랙리스트 유저의 닉네임이 <p> 태그로 추가됩니다 -->
                  <div align="left" >아이디</div>
                  <br/>
                  <div>
                  <c:set var="i" value="0" />
                  <c:forEach var="user" items="${$blacklistBody}">
                      <c:set var="i" value="${ i+1 }" />
                          <div align="center">${ i }</div>
                          <div align="left"  class="getUser">${modelUser.userId}</div>
                  </c:forEach>
                  </div>
              </div>

          </form>

        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        </div>
      </div>

    </div>
  </div>

</body>
</html>
