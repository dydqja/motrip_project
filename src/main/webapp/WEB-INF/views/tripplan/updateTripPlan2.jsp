<%@page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<!DOCTYPE html>
<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>Mold Discover . HTML Template</title>

  <!-- 구분선 -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c6ffa2721e097b8c38f9548c63f6e31a&libraries=services"></script>
    <link rel="stylesheet" href="/css/tripplan/tripplan.css">
    <link rel="stylesheet" href="/css/tripplan/overlay.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- 서머노트 CDN 링크 -->
    <link href="https://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
    <script src="https://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.js"></script>
  <!-- 구분선 -->

  <link rel="icon" type="image/png" href="assets/img/favicon.png" />
  <link rel="stylesheet" href="/assets/css/min/bootstrap.min.css" media="all">
  <link rel="stylesheet" href="/assets/css/jqueryui.css" media="all">
  <link rel="stylesheet" href="/vendor/animate-css/animate.css" media="all">
  <link rel="stylesheet" href="/assets/font/iconfont/iconstyle.css" media="all">
  <link rel="stylesheet" href="/assets/font/font-awesome/css/font-awesome.css" media="all">
  <link rel="stylesheet" href="/assets/css/main.css" media="all" id="maincss">

  <!-- 설정용 변수 -->
  <script>
    let mapOptions = []; // 지도 옵션을 저장할 배열
    let maps = []; // 생성    된 지도를 저장할 배열
    let mapCounter = 1; // 지도 갯수 카운트
    let markers = []; // 마커를 담을 배열입니다
    let isPlanPublic = false; // 공유여부
    let isPlanDownloadable = false; // 가져가기 여부
    let placeTripPositions = []; // 이동시간 구하기 위한 명소배열
    let totalTripTimes = [];
    let placeTripTimes = [];
  </script>

</head>

<body>

  <header class="nav-menu fixed">
    <%@ include file="/WEB-INF/views/layout/header.jsp" %>
  </header>

  <div class="post-single left">
    <div class="page-img" style="background-image: url('/images/tripImage.jpg');">
      <div class="page-img-txt container">
        <div class="row">
          <div class="col-sm-8">
            <div class="author-img">
              <img src="/images/tripImage.jpg" alt="">
            </div>
            <div class="author">
              <h4>
                <span class="italic">${user.userId}</span>
                <span class="dot">·</span>
                <span id="currentDate">${date}</span>
              </h4>
            </div>
          </div>
        </div>
      </div>
    </div>

    <main class="white">
      <div class="container">

      <div>
        <span><h4><input type="text" id="tripPlanTitle" placeholder="여행플랜 제목" style="color: black; width: 57%; height: 40px; opacity: 0.5;"></h4></span>
        <h5>
        공개<input type="checkbox" id="chbispublic" class="round" value="true"/>&nbsp;&nbsp;
        비공개<input type="checkbox" id="chbpublic" class="round" value="false" checked="true" disabled/>
        <span class="dot">·</span>
        가져가기 가능<input type="checkbox" id="chbIsDownloadle" class="round" value="true" disabled/>&nbsp;&nbsp;
        가져가기 불가능<input type="checkbox" id="chbDownloadle" class="round" value="false" disabled/>
        </h5>
      </div>

        <div class="row">
          <div class="col-sm-7">
            <textarea id="dailyPlanContents" name="dailyPlanContents" required>
            </textarea>
            <div class="share-box">
              <h5 class="title">Share this entry</h5>
              <div class="social-icon-wrap">
                <a href="#" class="social-icon"><span class="fa fa-facebook"></span></a>
                <a href="#" class="social-icon"><span class="fa fa-google"></span></a>
                <a href="#" class="social-icon"><span class="fa fa-twitter"></span></a>
                <a href="#" class="social-icon"><span class="fa fa-linkedin"></span></a>
              </div>
            </div>
          </div>

          <div class="col-sm-4 col-sm-offset-1">
            <div class="sidebar">
            <div style="text-align: center;">
              <div class="btn btn-primary">여행일수</div>
              <button class="icon-triangle-up" id="btnAddTripDay" style="background-color: #558B2F;"></button>
              <button class="icon-triangle-down" id="btnRemoveTripDay" style="background-color: #558B2F;"></button>
            </div>
              <div class="border-box">
                <div class="box-title">
                    <div class="input-group">
                      <input type="text" class="form-control" placeholder="Search Site">
                      <div class="input-group-btn">
                        <button class="btn btn-primary">Search</button>
                      </div>
                    </div>
                </div>
                <div id="map" style="width: 100%; height: 300px;"></div>
              </div>

              <div class="border-box">
                <div class="box-title">Categories</div>
                <ul class="list">
                  <li class="cat-item"><a href="#">Creative (2)</a>
                  </li>
                  <li class="cat-item"><a href="#">Design (9)</a>
                  </li>
                  <li class="cat-item"><a href="#">Image (2)</a>
                  </li>
                  <li class="cat-item"><a href="#">Photography (9)</a>
                  </li>
                  <li class="cat-item"><a href="#">Videos (4)</a>
                  </li>
                  <li class="cat-item"><a href="#">WordPress (4)</a>
                  </li>
                </ul>
              </div>

            </div>
          </div>
        </div>
      </div>
    </main>
  </div>

  <footer id="footer">
    <div class="container">
      <div class="row">
        <div class="col-sm-7 col-md-3">
          <h3>Mold Discover</h3>
          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Consequuntur, quia, architecto? A, reiciendis eveniet! Esse est eaque adipisci natus rerum laudantium accusamus magni.</p>
        </div>
        <div class="col-sm-5 col-md-2">
          <h3>Quick Link</h3>
          <ul>
            <li>Holiday Package</li>
            <li>Summer Adventure</li>
            <li>Bus and Trasnportation</li>
            <li>Ticket and Hotel Booking</li>
            <li>Trek and Hikings</li>
          </ul>
        </div>
        <div class="col-sm-7 col-md-4">
          <h3>Newsletter Signup</h3>
          <p>Subscribe to our weekly newsletter to get news and update</p>
          <br>
          <div class="input-group">
            <input type="text" class="form-control" placeholder="Your Email">
            <div class="input-group-btn">
              <button class="btn btn-primary">Subscribe</button>
            </div>
          </div>
        </div>
        <div class="col-sm-5 col-md-2">
          <h3>Contact Info</h3>
          <ul>
            <li>Mold Discover</li>
            <li>info@moldthemes.com</li>
          </ul>
          <div class="clearfix">
            <div class="social-icon-list">
              <ul>
                <li>
                  <a href="https://twitter.com/moldthemes" class="icon-twitter"></a>
                </li>
                <li>
                  <a href="mailto:info@moldthemes.com" class="icon-mail"></a>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="copy"><span>&copy;</span> Copyright Mold Discover, 2017</div>
  </footer>

    /////////////////////// 아래는 설정용 스크립트 입니다. ////////////////////////////

  <script>
     <!-- 서머노트 CDN 스크립트 -->
    $(document).ready(function() {
      $('#dailyPlanContents').summernote({
      });
    });

    <!-- 체크박스 true, false -->
    $("#chbispublic").click(function() {
      isPlanPublic = this.value;
      console.log(isPlanPublic);

      var chbispublic = $(this);
      var chbpublic = $("#chbpublic");
      var chbIsDownloadle = $("#chbIsDownloadle");
      var chbDownloadle = $("#chbDownloadle");

      if (chbispublic.prop("checked")) {
        chbispublic.prop("disabled", true);
        chbpublic.prop("disabled", false);
        chbpublic.prop("checked", false);
        chbIsDownloadle.prop("disabled", false);
        chbDownloadle.prop("checked", true);
        chbDownloadle.prop("disabled", true);
      }
    });

    // 비공개 체크박스 클릭 이벤트 핸들러
    $("#chbpublic").click(function() {
      isPlanPublic = this.value;
      isPlanDownloadable = false; // 가져가기 불가능으로 변경
      console.log(isPlanPublic);

      var chbpublic = $(this);
      var chbispublic = $("#chbispublic");
      var chbIsDownloadle = $("#chbIsDownloadle");
      var chbDownloadle = $("#chbDownloadle");

      if (chbpublic.prop("checked")) {
        chbpublic.prop("disabled", true);
        chbispublic.prop("disabled", false);
        chbispublic.prop("checked", false);
        chbIsDownloadle.prop("checked", false);
        chbDownloadle.prop("checked", false);
        chbIsDownloadle.prop("disabled", true);
        chbDownloadle.prop("disabled", true);
      }
    });

    // 가져가기 가능 체크박스 클릭 이벤트 핸들러
    $("#chbIsDownloadle").click(function() {
      isPlanDownloadable = this.value;
      console.log(isPlanDownloadable);
      var chbIsDownloadle = $(this);
      var chbDownloadle = $("#chbDownloadle");

      chbIsDownloadle.prop("disabled", true);
      chbDownloadle.prop("disabled", false);
      chbDownloadle.prop("checked", false);
    });

    // 가져가기 불가능 체크박스 클릭 이벤트 핸들러
    $("#chbDownloadle").click(function() {
      isPlanDownloadable = this.value;
      console.log(isPlanDownloadable);
      var chbDownloadle = $(this);
      var chbIsDownloadle = $("#chbIsDownloadle");

      chbDownloadle.prop("disabled", true);
      chbIsDownloadle.prop("disabled", false);
      chbIsDownloadle.prop("checked", false);
    });

  </script>

  <!-- 초기 지도를 생성 -->
  <script>
      var startMapContainer = document.getElementById('map'); // 초기 지도를 표시할 div
      startMapContainer.setAttribute('id', 'map0'); // id값 설정
      var startMapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
      };
      var startMap = new kakao.maps.Map(startMapContainer, startMapOption);
      maps = [startMap];
  </script>

    /////////////////////// 아래는 버 클릭시 동작되는 부분입니다 ////////////////////////////
  <script>
      $("#btnAddTripDay").click(function (){ // 추가 지도 생성 최대 10개까지
        // 버튼 비활성화
        $(this).prop('disabled', true);

        // 일정 시간후에 버튼 활성화
        setTimeout(function () {
          $("#btnAddTripDay").prop('disabled', false);
        }, 1500); // 1.5초 후에 버튼 활성화

        // 새로운 요소를 생성
        if(mapCounter < 10){
          console.log(mapCounter);
          var newMapWrap = document.createElement('div');
          var newContentsInput = document.createElement('textarea');
          var newMenuWrap = document.createElement('div');
          var newOptionDiv = document.createElement('div');
          var newKeywordInput = document.createElement('input');
          var newSearchButton = document.createElement('button');
          var newHr = document.createElement('hr');
          var newPlacesList = document.createElement('ul');
          var newPaginationDiv = document.createElement('div');
          var newMapDiv = document.createElement('div'); // 새로운 지도를 담을 div 엘리먼트 생성
          var newPlaceTaglistDiv = document.createElement('div');
          var totalTripTimeText = document.createElement('div');
          var totalTripTimeElement = document.createElement('div');

          var newMapOption = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
          };

          // 각 요소에 속성 및 내용 설정
          newMapWrap.className = 'map_wrap' + mapCounter;
          newMapWrap.style.display = 'flex';

          newContentsInput.setAttribute('type', 'text');
          newContentsInput.setAttribute('id', 'dailyPlanContents' + mapCounter);
          newContentsInput.style.width = '400px';
          newContentsInput.style.height = '400px';
          newContentsInput.style.resize = 'vertical'; // resize 속성 추가
          newContentsInput.style.overflow = 'auto'; // overflow 속성 추가

          newMenuWrap.setAttribute('id', 'menu_wrap' + mapCounter);

          newOptionDiv.className = 'option';

          newKeywordInput.setAttribute('type', 'text');
          newKeywordInput.setAttribute('id', 'placeName' + mapCounter);
          newKeywordInput.setAttribute('size', '15');

          newSearchButton.className = 'placeSearch';
          newSearchButton.setAttribute('id', 'placeSearch' + mapCounter);
          newSearchButton.textContent = '검색하기';

          newHr.style.display = 'block';
          newHr.style.height = '1px';
          newHr.style.border = '0';
          newHr.style.borderTop = '2px solid #5F5F5F';
          newHr.style.margin = '3px 0';

          newPlacesList.setAttribute('id', 'placesList' + mapCounter);
          newPaginationDiv.setAttribute('id', 'pagination' + mapCounter);

          newMapDiv.setAttribute('id', 'map' + mapCounter); // 고유한 ID 설정
          newMapDiv.style.width = '400px';
          newMapDiv.style.height = '400px';

          newPlaceTaglistDiv.setAttribute('id', 'placeTagsList' + mapCounter);
          newPlaceTaglistDiv.style.marginTop = '40px';
          newPlaceTaglistDiv.style.paddingLeft = '40px';
          newPlaceTaglistDiv.style.textAlign = 'left';

          totalTripTimeElement.setAttribute('id', 'totalTripTime' + mapCounter);
          totalTripTimeElement.className = 'totalTripTime';
          newPlaceTaglistDiv.appendChild(totalTripTimeText);
          newPlaceTaglistDiv.appendChild(totalTripTimeElement);

          // 요소들을 DOM에 추가
          newMenuWrap.appendChild(newOptionDiv);
          newOptionDiv.appendChild(newKeywordInput);
          newOptionDiv.appendChild(newSearchButton);
          newOptionDiv.appendChild(newHr);
          newOptionDiv.appendChild(newPlacesList);
          newOptionDiv.appendChild(newPaginationDiv);

          newMapWrap.appendChild(newContentsInput);
          newMapWrap.appendChild(newMenuWrap);
          newMapWrap.appendChild(newMapDiv);

          document.querySelector('body').appendChild(newMapWrap);
          document.querySelector('body').appendChild(newPlaceTaglistDiv);

          maps.push(new kakao.maps.Map(newMapDiv, newMapOption)); // 지도를 생성 및 옵션 설정하고 생성된 지도를 배열에 저장
          mapOptions.push(newMapOption); // 지도 옵션을 배열에 저장

          // mapCounter 증가
          mapCounter++;
        } else {
          alert("하나의 여행플랜의 일정은 10개가 최대입니다. \n추가적인 일정은 새로운 여행플랜을 작성하여 이용해주시기 바랍니다.");
        }
      });

      $("#btnRemoveTripDay").click(function () {
          // 버튼 비활성화
          $(this).prop('disabled', true);

          // 일정 시간후에 버튼 활성화
          setTimeout(function () {
              $("#btnRemoveTripDay").prop('disabled', false);
          }, 1500); // 1.5초 후에 버튼 활성화

        if (mapCounter > 1) {
          var lastMapIndex = mapCounter - 1; // 마지막으로 추가된 지도의 인덱스
          var mapWrap = document.querySelector('.map_wrap' + lastMapIndex);
          var placeTaglistDiv = document.querySelector('#placeTagsList' + lastMapIndex);
          mapWrap.parentNode.removeChild(mapWrap);
          placeTaglistDiv.parentNode.removeChild(placeTaglistDiv);
          maps.splice(lastMapIndex, 1); // maps 배열에서 해당 요소 제거
          mapOptions.splice(lastMapIndex, 1); // mapOptions 배열에서 해당 요소 제거
          mapCounter--; // mapCounter 감소
        } else {
          alert("하나의 여행플랜의 반드시 필요합니다.");
        }
      });
  </script>

    /////////////////////// 아래는 템플릿용 스크립트입니다. ////////////////////////////

  <!-- <script src="/vendor/jquery/dist/jquery.min.js"></script>  부트스트랩 에러로 인해 봉인 -->
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

</body>
</html>