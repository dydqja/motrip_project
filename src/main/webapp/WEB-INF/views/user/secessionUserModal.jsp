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

            $("#SecessionUserCommit").on("click", function () {

                self.location.href = "/user/secessionUser";
            });
        });





    </script>
</head>

<body>





<!-- Modal -->
<div class="modal fade" id="secessionUserModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">회원 탈퇴 </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                회원 탈퇴시 회원정보는 <p style="color:orangered;">1년간 유지</p>되며<br/>
                유지기간 안에 <p style="color:orangered;">복구가 가능</p>합니다<br/>
                확인 클릭시 탈퇴 페이지로 이동합니다.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" id="SecessionUserCommit">확인</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>
