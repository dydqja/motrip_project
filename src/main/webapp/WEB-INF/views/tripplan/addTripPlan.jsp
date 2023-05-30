<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>motrip</title>
<!-- 지도용 스크립트 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c6ffa2721e097b8c38f9548c63f6e31a&libraries=services"></script>
<!-- jquery, css -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.0/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="/css/tripplan/tripplan.css">
</head>
<body>
    <div>
        여행플랜 제목 : <input type"text" id="tripPlanTitle" style='width:450px'/>
        <div>
            사용자태그 : 추후 저장예정 <div id="userTags"></div>
            명소태그 : 추후 저장예정 <div id="placeTags"></div>
        </div>
        <div>
            <button id="btnAddTripPlan">저장</button>
            <button id="btnAddTripDay">여행일수 추가</button>
            <button id="btnRemoveTripDay">여행일수 삭제</button>
        </div>
    </div>

    <div class="map_wrap" style="display: flex;">
        <input type"text" id="dailyPlanContents"/>
        <div id="menu_wrap">
            <div class="option">
                <input type="text" id="placeName" size="15">
                <button class="placeSearch" id="placeSearch">검색하기</button>
                <hr>
                <ul id="placesList"></ul>
                <div id="pagination"></div>
            </div>
        </div>
        <div id="map" style="width: 400px; height: 400px;"></div>
    </div>
    <div id="listPlaceTags" style="margin-top: 40px; padding-left: 40px; text-align: left;"></div>
</body>

<script type="text/javascript">

$(document).ready(function(){

    $("#btnAddTripPlan").click(function () {
        var tripPlanTitle = $('#tripPlanTitle').val(); // 여행플랜 제목
        var dailyPlanContents = []; // 일차별 여행플랜 본문과 명소들을 모두 저장하는곳
        var placesInfo; // 없어도될거같은데? 나중에확인

        for(var i=0; i<mapCounter; i++) {
            var dailyPlanContent; // 일차별 여행플랜 본문
            var placeInfo = [] // 명소를 저장하는 배열
            var hiddenCount = 0; // 명소의 갯수 파악

            if (i == 0) {
                dailyPlanContent = $('#dailyPlanContents').val();
                hiddenCount = $("#listPlaceTags").find("div[hidden]").length;
                console.log("hiddenCount : " + hiddenCount);
                for(var j=0; j<hiddenCount; j++){
                    var placeText = $("#listPlaceTags").find("#place"+(j+1)).text();
                    console.log(placeText);
                    placeInfo.push(placeText);
                }
            } else {
                dailyPlanContent = $('#dailyPlanContents' + i).val();
                hiddenCount = $("#listPlaceTags"+i).find("div[hidden]").length;
                console.log("hiddenCount : " + hiddenCount);
                for(var j=0; j<hiddenCount; j++){
                     var placeText = $("#listPlaceTags" + i).find("#place"+(j+1)).text();
                     console.log(placeText);
                     placeInfo.push(placeText);
                }
            }

            dailyPlanContents.push({
                dailyPlanContents: dailyPlanContent,
                placesInfo: placeInfo
            });
        }

        if(tripPlanTitle == null || tripPlanTitle.length<1){
        		alert("여행플랜 제목을 입력하여야 저장가능합니다.");
        		return;
        }
        if(dailyPlanContents == null || dailyPlanContents.length<1){
                alert("플랜본문은 1개 이상 입력하여야 저장가능합니다.");
                return;
        }

        var tripPlan = {
            tripPlanTitle: tripPlanTitle,
            tripDays: mapCounter,
            dailyplanResultMap: dailyPlanContents.map(function (dailyPlan) {
              return {
                dailyPlanContents: dailyPlan.dailyPlanContents,
                placeResultMap: dailyPlan.placesInfo.map(function (place) {
                  return JSON.parse(place); // JSON 문자열을 객체로 변환
                }),
              };
            }),
          };

        console.log(JSON.stringify(tripPlan));

        $.ajax({
                url: "/tripPlan/addTripPlan",
                type: "POST",
                data: JSON.stringify(tripPlan),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                },
                error: function (xhr, status, error) {

                }
        });

    });

    let mapOptions = []; // 지도 옵션을 저장할 배열
    let maps = []; // 생성    된 지도를 저장할 배열
    let mapCounter = 1; // 지도 갯수 카운트
    let markers = []; // 마커를 담을 배열입니다

    // 초기 지도를 생성합니다
    var startMapContainer = document.getElementById('map'); // 초기 지도를 표시할 div
    var startMapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };
    var startMap = new kakao.maps.Map(startMapContainer, startMapOption);
    maps = [startMap];

    // 추가 지도 생성
    $("#btnAddTripDay").click(function (){
        // 새로운 요소를 생성
          var newMapWrap = document.createElement('div');
          var newContentsInput = document.createElement('input');
          var newMenuWrap = document.createElement('div');
          var newOptionDiv = document.createElement('div');
          var newKeywordInput = document.createElement('input');
          var newSearchButton = document.createElement('button');
          var newHr = document.createElement('hr');
          var newPlacesList = document.createElement('ul');
          var newPaginationDiv = document.createElement('div');
          var newMapDiv = document.createElement('div'); // 새로운 지도를 담을 div 엘리먼트 생성
          var newPlaceTaglistDiv = document.createElement('div');
          var newMapOption = {
              center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
              level: 3 // 지도의 확대 레벨
          };

          // 각 요소에 속성 및 내용 설정
          newMapWrap.className = 'map_wrap';
          newMapWrap.style.display = 'flex';

          newContentsInput.setAttribute('type', 'text');
          newContentsInput.setAttribute('id', 'dailyPlanContents' + mapCounter);
          newContentsInput.style.width = '400px';
          newContentsInput.style.height = '400px';

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

          newPlaceTaglistDiv.setAttribute('id', 'listPlaceTags' + mapCounter);
          newPlaceTaglistDiv.style.marginTop = '40px';
          newPlaceTaglistDiv.style.paddingLeft = '40px';
          newPlaceTaglistDiv.style.textAlign = 'left';

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
    });


    $(document).on("click", ".placeSearch", function () {
       if(this.id == this.id){  // 내가 누르는 버튼이 일차별여행플랜 몇번의 해당하는 지 알기위한 if문

           var idCount = this.id.split('placeSearch')[1];
           var mapIndex = idCount;

           if(idCount == 0){ // startMap의 경우는 id 마지막에 숫자가 없기때문에 설정
             idCount = '';
             mapIndex = 0;
           }

           var ps = new kakao.maps.services.Places(); // 장소 검색 객체를 생성합니다
           var infowindow = new kakao.maps.InfoWindow({zIndex:1}); // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
           searchPlaces(); // 키워드로 장소를 검색합니다

           function searchPlaces() {  // 키워드 검색을 요청하는 함수입니다
               var keyword = document.getElementById('placeName'+idCount).value;
               if (!keyword.replace(/^\s+|\s+$/g, '')) {
                   alert('키워드를 입력해주세요!');
                   return false;
               }
               ps.keywordSearch(keyword, placesSearchCB);  // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
            }

            function placesSearchCB(data, status, pagination) {  // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
               if (status === kakao.maps.services.Status.OK) {
                   displayPlaces(data); // 검색 목록과 마커를 표출합니다
                   displayPagination(pagination); // 페이지 번호를 표출합니다
               } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
                   alert('검색 결과가 존재하지 않습니다.');
                   return;
               } else if (status === kakao.maps.services.Status.ERROR) {
                   alert('검색 결과 중 오류가 발생했습니다.');
                   return;
               }
            }

           function displayPlaces(places) {  // 검색 결과 목록과 마커를 표출하는 함수입니다
                var listEl = document.getElementById('placesList'+idCount),
                    menuEl = document.getElementById('menu_wrap'+idCount),
                    fragment = document.createDocumentFragment(),
                    bounds = new kakao.maps.LatLngBounds(),
                    listStr = '';
                var positions = []; // 위도, 경도 저장하는 배열

                   removeAllChildNods(listEl); // 검색 결과 목록에 추가된 항목들을 제거합니다
                   //removeMarker(); // 지도에 표시되고 있는 마커를 제거합니다 (나중에 삭제할때 사용)

                   for (var i = 0; i < places.length; i++) {
                       var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
                           marker = addMarker(placePosition, i),
                           itemEl = getListItem(i, places[i]); // 마커를 생성하고 지도에 표시합니다
                       var coordinates = placePosition.La+","+placePosition.Ma; // 반복문에 출력되는 위도 경도 모두 저장
                       positions.push({ coordinates : coordinates }); // 위도와 경도를 모두 저장

                       bounds.extend(placePosition); // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해 LatLngBounds 객체에 좌표를 추가합니다
                       (function (marker, title) {

                       kakao.maps.event.addListener(marker, 'mouseover', function () {
                           displayInfowindow(marker, title, idCount);
                       });
                       kakao.maps.event.addListener(marker, 'mouseout', function () {
                           infowindow.close();
                       });
                       itemEl.onmouseover = function () {
                           displayInfowindow(marker, title, idCount);
                       };
                       itemEl.onmouseout = function () {
                           infowindow.close();
                       };
                       itemEl.onclick = function () {
                           marker.setMap(maps[mapIndex]); // 해당 지도에 마커를 표출합니다
                           markers.push(marker); // 해당 지도의 마커 배열에 추가합니다

                           removeAllChildNods(listEl); // 검색목록 초기화
                           displayPagination(pagination); //
                           infowindow.close(); // 지도위 정보창 닫기
                           $("#placeName" + idCount).val(""); // 검색창 초기화

                           // 선택한 명소정보들에 대해서 파싱
                           var parser = new DOMParser();
                           var doc = parser.parseFromString(this.innerHTML, "text/html");
                           var placePositionId = this.innerHTML.split('marker_')[1].split('"')[0]; // 몇번째 id인지 파싱

                           var place = {
                             placeTags: doc.querySelector('.info h5').textContent.trim(),
                             placeAddress: doc.querySelector('.info span:not(.tel)').textContent.trim(),
                             placeCoordinates: positions[placePositionId - 1].coordinates,
                             placeCategory: 0,
                             placePhoneNumber: doc.querySelector('.info .tel').textContent.trim()
                           };

                           var placeCount = $("#listPlaceTags" + idCount + " div[hidden]").length; // 기존 hidden place 개수
                           var newPlaceId = "place" + (placeCount + 1);

                           $("#listPlaceTags" + idCount)
                                   .append("<div id='placeTags" + idCount + "'>#" + title + "</div>")
                                   .append("<div id='child' class='circle' />")
                                   .append("<div hidden id='" + newPlaceId + "'>" + JSON.stringify(place) + "</div>");

                           console.log(newPlaceId);

                           maps[mapIndex].setBounds(bounds);
                       };
                   })(marker, places[i].place_name);
                   fragment.appendChild(itemEl);
               }
               listEl.appendChild(fragment); // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
               menuEl.scrollTop = 0;

               maps[mapIndex].setBounds(bounds); // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
           }

           function addMarker(position, idx, mapIndex) {  // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
               var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png',
                   imageSize = new kakao.maps.Size(36, 37),
                   imgOptions = {
                       spriteSize: new kakao.maps.Size(36, 691),
                       spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10),
                       offset: new kakao.maps.Point(13, 37)
                   },
                   markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                   marker = new kakao.maps.Marker({
                       position: position,
                       image: markerImage
                   });
               return marker;
           }

           function getListItem(index, places) {  // 검색결과 항목을 Element로 반환하는 함수입니다
                var el = document.createElement('li'),
                itemStr = '<span class="markerbg marker_' + (index+1) + '"></span><div class="info"><h5>' + places.place_name + '</h5>';
                if (places.road_address_name) {
                    itemStr += '    <span>' + places.road_address_name + '</span><span class="jibun gray">' +  places.address_name  + '</span>';
                } else {
                    itemStr += '    <span>' +  places.address_name  + '</span>';
                }
                  itemStr += '  <span class="tel">' + places.phone  + '</span></div>';
                el.innerHTML = itemStr;
                el.className = 'item';
                return el;
           }

           function displayPagination(pagination) {  // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
                var paginationEl = document.getElementById('pagination'),
                    fragment = document.createDocumentFragment(),
                    i;
                // 기존에 추가된 페이지번호를 삭제합니다
                while (paginationEl.hasChildNodes()) {
                    paginationEl.removeChild (paginationEl.lastChild);
                }
                for (i=1; i<=pagination.last; i++) {
                    var el = document.createElement('a');
                    el.href = "#";
                    el.innerHTML = i;
                    if (i===pagination.current) {
                        el.className = 'on';
                    } else {
                        el.onclick = (function(i) {
                            return function() {
                                pagination.gotoPage(i);
                            }
                        })(i);
                    }
                    fragment.appendChild(el);
                }
                paginationEl.appendChild(fragment);
           }

           function displayInfowindow(marker, title, idCount) {  // 명소리스트 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
                var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
                infowindow.setContent(content); // 설명창 내부에 표시될 글
                infowindow.open(maps[idCount], marker); // 설명창 띄움
           }

           function removeAllChildNods(el) {  // 검색결과 목록의 자식 Element를 제거하는 함수입니다
                while (el.hasChildNodes()) {
                    el.removeChild (el.lastChild);
                }
           }

           function removeMarker() {  //지도 위에 표시되고 있는 마커를 모두 제거합니다
                for ( var i = 0; i < markers.length; i++ ) {
                    markers[i].setMap(null);
                }
                markers = [];
           }
       }
   });

});
</script>
</html>
