    //기본전제 : userId를 세션으로부터 받아서 hidden input에 넣어둔다.
    //기본전제 : 폴링 트라이 카운터도 히든 인풋에 넣어둔다. 시작은 언제나 0이다.
    //기본전제 : 폴링 타임의 값을 히든 인풋에 넣어둔다. 이 값은 서버가 올라갈때 어플리케이션 스코프로부터 가져온다.
    //기본전제 : 폴링 타임의 값이 없다면, 3으로 세팅한다.

    //기본전제 : {폴링 타임}초에 한번씩 폴링 트라이 카운터의 값을 올린다.
    //기본전제 : 폴링 트라이 카운터의 값이 올라가면 폴링을 한다.

    //기본전제 : 잠수하고 있는 유저를 걸러내기 위해, 폴링 카운터가 10이 넘어가면 더이상 폴링을 하지 않는다.

    //스타팅 펑션


    //!!폴링을 시도하는 부분
    //문서가 준비된 직후부터 폴링을 계속 하는 펑션이다.
    $(document).ready(function(){
    let pollingCount = 0;
    //몇 초에 한번씩 폴링을 시도할지 결정한다.
    let pollingTime = $("#pollingTime").val();
    console.log('서버로부터 받은 알람 폴링 시간은'+pollingTime+'초이다.');
    //폴링 타임이 falsy일 경우 기본값 3초로 세팅한다.
    if(!pollingTime){
        pollingTime = 50;
        console.log('서버로부터 알람 폴링 시간을 받지 못했으므로, 기본값 3초로 세팅한다.')
    }
    //서버에 연락할 유저의 Id는
    let userId = $("#alarmUserId").val();
    console.log('현재 로그인한 유저의 아이디는'+userId+'이다.');
    //유저 아이디가 없다면 폴링을 하지 않는다.
    if(!userId){
        console.log('유저 아이디가 없으므로 폴링을 하지 않는다.');
        return;
    }
    //id 폴링타임의 값을 폴링타임으로 세팅한다.
    $("#pollingTime").val(pollingTime);
    //매 초마다 유저의 이름으로 unread 알람을 가져온다.
    setInterval(function() {
        getUnreadAlarmCount(userId);
    }, pollingTime * 1000);

});

    //안 읽은 알람 갯수 파악. 폴링하는 부분에서 호출되면서 알람 카운터의 값들을 가져온다.
    function getUnreadAlarmCount(userId){
    //콘솔에 로그를 찍는다.
    console.log('getUnreadAlarmCount on.');
    $.ajax({
        url: "/alarm/getUnreadAlarmCount",
        type: "POST",
        dataType: "json",
        data: {userId: userId},
        success: function(data){
            //콘솔에 로그를 찍는다.
            console.log('getUnreadAlarmCount success.');
            //콘솔에 받은 데이터를 찍는다.
            let serverAlarmCount = data;
            console.log('안 읽은 알람의 갯수는'+serverAlarmCount+'개이다.');
            //현재 알람 카운터의 값을 가져온다.
            let clientAlarmCount = $("#unreadAlarmCount").text().trim();
            console.log('현재 클라이언트의 알람 카운터의 값은'+clientAlarmCount+'이다.');
            if(clientAlarmCount<serverAlarmCount){
                //클라이언트의 알람 카운터가 서버의 알람 카운터보다 작다면, 알람 카운터를 업데이트한다.
                $("#unreadAlarmCount").text(serverAlarmCount);
                let alarmCount = serverAlarmCount-clientAlarmCount;
                //새로운 알람 다이얼로그를 띄운다.
                //buildNewAlarmDialog(alarmCount);
            }
        }
    });
}



    //!!사용자의 클릭에 따라 알람의 목록을 가져오는 부분
    //알람목록보기 호버 리스너
    $(document).on('mouseenter', '#getAlarmListBtn', function() {
    //콘솔에 로그를 찍는다.
    console.log('getAlarmListBtn on.');
    //현재 페이지를 1로 세팅한다.
    $("#alarmCurrentPage").val(1);
    //서버와 통싱해서 알람의 정보를 가져온다.
    //서버에 보낼 변수를 확보한다.
    let userId = $("#alarmUserId").val();
    let currentPage = $("#alarmCurrentPage").val();

    $.ajax({
        url: "/alarm/getAlarmList",
        type: "POST",
        dataType: "json",
        data: {userId: userId
            ,currentPage: currentPage},
        success: function(data){
            buildAlarmThumbnail(data);
        },
        error: function(error) {
            console.error('Error occurred while getting alarm list:', error);
        }
    });
});

    //보류알람목록보기 호버 리스너
    $(document).on('mouseenter', '#getHoldAlarmListBtn', function() {
    //콘솔에 로그를 찍는다.
    console.log('getHoldAlarmListBtn on.');
    //현재 페이지를 1로 세팅한다.
    $("#alarmCurrentPage").val(1);
    //서버와 통싱해서 알람의 정보를 가져온다.
    //서버에 보낼 변수를 확보한다.
    let userId = $("#alarmUserId").val();
    let currentPage = $("#alarmCurrentPage").val();
    $.ajax({
        url: "/alarm/getHoldAlarmList",
        type: "POST",
        dataType: "json",
        data: {userId: userId
            ,currentPage: currentPage},
        success: function(data){
            buildAlarmThumbnail(data);
        },
        error: function(error) {
            console.error('Error occurred while getting alarm list:', error);
        }
    });
});

    //알람 목록 썸네일 형성
    function buildAlarmThumbnail(alarmList){
    //콘솔에 로그를 찍는다.
    console.log('buildAlarmThumbnail on.');
    //썸네일을 형성할 썸네일 에어리어를 객체로 잡는다.
    let alarmThumbnailArea = $("#alarm-thumbnail-area");
    //썸네일 에어리어 안의 모든 .alarm-thumbnail을 지운다.
    alarmThumbnailArea.children(".alarm-thumbnail").remove();

    //콘솔에 몇개의 알람을 받았는지 찍는다.
    console.log('총 '+alarmList.length+'개의 알람을 받았다.');

    //알람 리스트를 순회하며 썸네일을 형성한다.
    for(let i=0; i<alarmList.length; i++){
        let alarm = alarmList[i];
        //썸네일을 하나 만든다.
        let alarmThumbnail = $("<li></li>");
        //썸네일의 클래스를 알람 썸네일로 한다.
        alarmThumbnail.addClass("alarm-thumbnail");
        //썸네일을 붙인다.
        alarmThumbnailArea.append(alarmThumbnail);
        //썸네일에 정보를 담을 span들을 차례차례 형성한다.
        //알람 타이틀
        let alarmTitle = $("<span></span>");
        alarmTitle.addClass("alarm-thumbnail-title");
        alarmTitle.text(alarm.alarmTitle);
        alarmThumbnail.append(alarmTitle);
        //알람 번호
        let alarmNo = $("<span></span>");
        //콘솔에 몇번 알람인지 찍는다.
        console.log('알람 번호는 '+alarm.alarmNo+'번이다.');
        alarmNo.addClass("alarm-thumbnail-no");
        alarmNo.css("display", "none");
        alarmNo.text(alarm.alarmNo);
        alarmThumbnail.append(alarmNo);
        //송신자
        let alarmThumbnailSender = $("<span></span>");
        alarmThumbnailSender.addClass("alarm-thumbnail-sender");
        alarmThumbnailSender.css("display", "none");
        alarmThumbnailSender.text(alarm.sender);
        alarmThumbnail.append(alarmThumbnailSender);
        //수신자
        let alarmReceiver = $("<span></span>");
        alarmReceiver.addClass("alarm-thumbnail-receiver");
        alarmReceiver.css("display", "none");
        alarmReceiver.text(alarm.receiver);
        alarmThumbnail.append(alarmReceiver);
        //알람 내용
        let alarmContents = $("<span></span>");
        alarmContents.addClass("alarm-thumbnail-contents");
        alarmContents.css("display", "none");
        alarmContents.text(alarm.alarmContents);
        alarmThumbnail.append(alarmContents);
        //알람 등록일
        let alarmRegDate = $("<span></span>");
        alarmRegDate.addClass("alarm-thumbnail-regDate");
        alarmRegDate.css("display", "none");
        alarmRegDate.text(alarm.alarmRegDate);
        alarmThumbnail.append(alarmRegDate);
        //알람 읽힌 날
        let alarmReadDate = $("<span></span>");
        alarmReadDate.addClass("alarm-thumbnail-readDate");
        alarmReadDate.css("display", "none");
        alarmReadDate.text(alarm.alarmReadDate);
        alarmThumbnail.append(alarmReadDate);
        //알람 보류 여부
        let alarmHold = $("<span></span>");
        alarmHold.addClass("alarm-thumbnail-hold");
        alarmHold.css("display", "none");
        alarmHold.text(alarm.alarmHold);
        alarmThumbnail.append(alarmHold);
        //알람 레벨
        let alarmLevel = $("<span></span>");
        alarmLevel.addClass("alarm-thumbnail-level");
        alarmLevel.css("display", "none");
        alarmLevel.text(alarm.alarmLevel);
        alarmThumbnail.append(alarmLevel);

        //알람 승낙 url
        let alarmAcceptUrl = $("<span></span>");
        alarmAcceptUrl.addClass("alarm-thumbnail-acceptUrl");
        alarmAcceptUrl.css("display", "none");
        alarmAcceptUrl.text(alarm.alarmAcceptUrl);
        alarmThumbnail.append(alarmAcceptUrl);
        //알람 거절 url
        let alarmRejectUrl = $("<span></span>");
        alarmRejectUrl.addClass("alarm-thumbnail-rejectUrl");
        alarmRejectUrl.css("display", "none");
        alarmRejectUrl.text(alarm.alarmRejectUrl);
        alarmThumbnail.append(alarmRejectUrl);
        //알람 보류 url
        let alarmHoldUrl = $("<span></span>");
        alarmHoldUrl.addClass("alarm-thumbnail-holdUrl");
        alarmHoldUrl.css("display", "none");
        alarmHoldUrl.text(alarm.alarmHoldUrl);
        alarmThumbnail.append(alarmHoldUrl);
        //알람 네비게이트 url
        let alarmNavigateUrl = $("<span></span>");
        alarmNavigateUrl.addClass("alarm-thumbnail-navigateUrl");
        alarmNavigateUrl.css("display", "none");
        alarmNavigateUrl.text(alarm.alarmNavigateUrl);
        alarmThumbnail.append(alarmNavigateUrl);
    }
}

    //알람 썸네일 클릭 리스너
    $(document).on('click', 'li.alarm-thumbnail', function() {
    //콘솔에 로그를 찍는다.
        console.log('alarm-thumbnail clicked.');
        //알람 썸네일의 정보를 가져온다.
        let alarmNo = $(this).find(".alarm-thumbnail-no").text();
        let sender = $(this).find(".alarm-thumbnail-sender").text();
        let receiver = $(this).find(".alarm-thumbnail-receiver").text();
        let alarmTitle = $(this).find(".alarm-thumbnail-title").text();
        let alarmContents = $(this).find(".alarm-thumbnail-contents").text();
        let alarmRegDate = $(this).find(".alarm-thumbnail-regDate").text();
        let alarmReadDate = $(this).find(".alarm-thumbnail-readDate").text();
        let alarmHold = $(this).find(".alarm-thumbnail-hold").text();
        let alarmLevel = $(this).find(".alarm-thumbnail-level").text();
        let alarmAcceptUrl = $(this).find(".alarm-thumbnail-acceptUrl").text();
        let alarmRejectUrl = $(this).find(".alarm-thumbnail-rejectUrl").text();
        let alarmHoldUrl = $(this).find(".alarm-thumbnail-holdUrl").text();
        let alarmNavigateUrl = $(this).find(".alarm-thumbnail-navigateUrl").text();
        //알람 썸네일의 정보를 바탕으로 모달을 형성한다.
        buildAlarmModal(alarmNo,sender,receiver,alarmTitle,alarmContents,alarmRegDate,alarmReadDate,alarmHold,alarmLevel,alarmAcceptUrl,alarmRejectUrl,alarmHoldUrl,alarmNavigateUrl);
});

    //모달 형성(getAlarm)
    function buildAlarmModal(alarmNo,sender,receiver,alarmTitle,alarmContents,alarmRegDate,alarmReadDate,alarmHold,alarmLevel,alarmAcceptUrl,alarmRejectUrl,alarmHoldUrl,alarmNavigateUrl){
        event.preventDefault();
        //콘솔에 로그를 찍는다.
        console.log('buildAlarmModal on.');
        //받은 변수들을 나열한다.
        console.log('alarmNo : ' + alarmNo);
        console.log('sender : ' + sender);
        console.log('receiver : ' + receiver);
        console.log('alarmTitle : ' + alarmTitle);
        console.log('alarmContents : ' + alarmContents);
        console.log('alarmRegDate : ' + alarmRegDate);
        console.log('alarmReadDate : ' + alarmReadDate);
        console.log('alarmHold : ' + alarmHold);
        console.log('alarmLevel : ' + alarmLevel);
        console.log('alarmAcceptUrl : ' + alarmAcceptUrl);
        console.log('alarmRejectUrl : ' + alarmRejectUrl);
        console.log('alarmHoldUrl : ' + alarmHoldUrl);
        console.log('alarmNavigateUrl : ' + alarmNavigateUrl);
        //모달을 만들 영역을 잡는다.
        let alarmModalArea = $("#alarm-modal-area");
        //모달을 비운다.
        alarmModalArea.html('');

        //모달 내부에 타이틀 영역, 내용 영역, 버튼 영역을 만든다.
        //모달 타이틀 영역
        let alarmModalTitleArea = $("<div></div>");
        alarmModalTitleArea.addClass("alarm-modal-title-area");
        alarmModalArea.append(alarmModalTitleArea);
        //모달 타이틀 영역에 타이틀을 만든다.
        let alarmModalTitle = $("<div></div>");
        alarmModalTitle.addClass("alarm-modal-title");
        alarmModalTitle.text(alarmTitle);
        alarmModalTitleArea.append(alarmModalTitle);

        //모달 내용 영역
        let alarmModalContentsArea = $("<div></div>");
        alarmModalContentsArea.addClass("alarm-modal-contents-area");
        alarmModalArea.append(alarmModalContentsArea);
        //모달 버튼 영역
        let alarmModalBtnArea = $("<div></div>");
        alarmModalBtnArea.addClass("alarm-modal-btn-area");
        alarmModalArea.append(alarmModalBtnArea);


        //모달 내용 영역에 내용을 만든다.
        let alarmModalContents = $("<div></div>");
        alarmModalContents.addClass("alarm-modal-contents");
        alarmModalContents.text(alarmContents);
        alarmModalContentsArea.append(alarmModalContents);

        //값이 들어있는지 여부에 따라 버튼들을 만든다.
        if(alarmAcceptUrl){
        let alarmAcceptBtn = $("<button></button>");
        alarmAcceptBtn.addClass("alarm-accept-btn");
        alarmAcceptBtn.text("승낙");
        alarmAcceptBtn.val(alarmAcceptUrl);
        alarmModalBtnArea.append(alarmAcceptBtn);
    }
        if(alarmRejectUrl){
        let alarmRejectBtn = $("<button></button>");
        alarmRejectBtn.addClass("alarm-reject-btn");
        alarmRejectBtn.text("거절");
        alarmRejectBtn.val(alarmRejectUrl);
        alarmModalBtnArea.append(alarmRejectBtn);
    }
        //만약 거절url이 있다면 보류버튼을 만든다.
        if(alarmRejectUrl){
        let alarmHoldBtn = $("<button></button>");
        alarmHoldBtn.addClass("alarm-hold-btn");
        alarmHoldBtn.text("보류");
        alarmHoldBtn.val(alarmNo);
        alarmModalBtnArea.append(alarmHoldBtn);
    }
        //만약 네비게이트url이 있다면 이동버튼을 만든다.
        if(alarmNavigateUrl){
        let alarmNavigateBtn = $("<button></button>");
        alarmNavigateBtn.addClass("alarm-navigate-btn");
        alarmNavigateBtn.text("이동");
        alarmNavigateBtn.val(alarmNavigateUrl);
        alarmModalBtnArea.append(alarmNavigateBtn);
    }
        //기본척으로 확인버튼을 만든다.
        let alarmConfirmBtn = $("<button></button>");
        alarmConfirmBtn.addClass("alarm-confirm-btn");
        alarmConfirmBtn.text("확인");
        alarmConfirmBtn.val(alarmNo);
        alarmModalBtnArea.append(alarmConfirmBtn);

        //다 만들었다면 모달을 띄운다.
        alarmModalArea.dialog({
            autoOpen: false, // 초기에 자동으로 열리지 않도록 설정
            modal: true, // 모달 창으로 설정
            draggable: false, // 드래그 이동 비활성화
            resizable: false, // 크기 조절 비활성화
            closeOnEscape: false, // ESC 키로 창 닫기 비활성화
            show: {
                effect: "fade", // 페이드 인 효과
                duration: 300 // 애니메이션 지속 시간
            },
            position: {
                my: "center",
                at: "center",
                of: window
            },
            hide: {
                effect: "fade", // 페이드 아웃 효과
                duration: 300 // 애니메이션 지속 시간
            }
        });
        alarmModalArea.dialog("open");
    }
        //!!알람 썸네일 버튼들에 대한 클릭 리스너
        //수락 버튼
        $(".alarm-accept-btn").click(function(){
            event.preventDefault();
            //이 버튼의 값은 알람의 수락 url이다.
            let alarmAcceptUrl = $(this).val();
            //수락 url로 이동한다.
            window.location.href = alarmAcceptUrl;

    });
        //거절 버튼
        $(".alarm-reject-btn").click(function(){
            event.preventDefault();
            //이 버튼의 값은 알람의 거절 url이다.
            let alarmRejectUrl = $(this).val();
            //거절 url로 이동한다.
            window.location.href = alarmRejectUrl;

    });
        //보류 버튼
        $(".alarm-hold-btn").click(function(){
            event.preventDefault();
            //이 버튼의 값은 알람의 번호이다.
            let alarmNo = $(this).val();
            //보류 처리한다.
            console.log(alarmNo+"번 알람 보류처리");
            holdAlarm(alarmNo);
    });
        //확인 버튼
        $(".alarm-confirm-btn").click(function(){
            event.preventDefault();
            //이 버튼의 값은 알람의 번호이다.
            let alarmNo = $(this).val();
            //읽음 처리한다.
            console.log(alarmNo+"번 알람 읽음처리");
            readAlarm(alarmNo);
});


    //!!서버와 통신하여 정보를 가져오는 부분

    //알람 일반 목록보기. 알람의 정보를 갖고있는 알람 썸네일들을 형성한다.


    //알람 보류된 목록보기. 알람의 정보를 갖고있는 알람 썸네일들을 형성한다.
    //!!사용자의 클릭에 따라 알람의 상태를 변경하는 부분

    //알람 읽음처리
    function readAlarm(alarmNo){
    $.ajax({
        url: "/alarm/readAlarm",
        type: "POST",
        dataType: "json",
        data: {alarmNo: alarmNo},
        success: function(data){
            console.log(alarmNo+"번 알람 읽음처리 완료");
        }
    });
}
    //알람 보류처리
    function holdAlarm(alarmNo){
    $.ajax({
        url: "/alarm/holdAlarm",
        type: "POST",
        dataType: "json",
        data: {alarmNo: alarmNo},
        success: function(data){
            console.log(alarmNo+"번 알람 보류처리 완료");

        }
    });
}
