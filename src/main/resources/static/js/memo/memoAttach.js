let isCellMode = false;
let isInfoMessageDisplayed = false; // 메모 부착 안내 메시지 표시 여부
let memoNo = 0;
let tripPlanNo = 0;
let tripPlanTitle = '';
let memoTitle = '';
let chatRoomNo = 0;
let chatRoomTitle = '';

$(document).on('click', '.memo-dialog-attach-btn', function(event) {
    event.preventDefault();
    let memoDialog = $(this).closest('.ui-dialog');
    //info 를 찾아서 그 안의 memoNo 를 가져온다.
    let infoJson = memoDialog.find('.memo-dialog-info').val();
    let info = JSON.parse(infoJson);
    memoNo = info.memoNo;
    memoTitle = info.memoTitle;
    memoDialog.hide();

    enableCellMode();
});

function enableCellMode() {
    isCellMode = true;
    $('body').css('cursor', 'cell');
    $(document).on('contextmenu', disableCellMode);
}

function disableCellMode() {
    isCellMode = false;
    $('body').css('cursor', '');
    $(document).off('contextmenu', disableCellMode);
}
//isCellMode 가 true 일 시, 마우스 좌클릭 시 메모를 부착한다.
$(document).on('click', function(event) {
    if (isCellMode && !isInfoMessageDisplayed) {
        Swal.fire({
            icon: 'info',
            title: '부착 안내',
            text: '부착 모드에서 여행계획, 후기, 채팅방 목록에 마우스 좌클릭시 메모를 부착합니다.',
            footer: '우클릭시 부착 모드를 해제합니다.'
        });

        isInfoMessageDisplayed = true; // 메시지 표시 상태로 설정
    }
});




//트립플랜 리스너
$(document).on('mouseenter', '.trip-plan-item-list', function() {
    if(isCellMode){
        tripPlanNo = $(this).find('.tripPlanNo').val();
        tripPlanTitle = $(this).find('.item-title').text().trim();
    }
});

$(document).on('click', '.trip-plan-item-list', function() {
    if(isCellMode){
        disableCellMode();
        isInfoMessageDisplayed = false;
        attachMemoToTripPlanRequest(memoNo,tripPlanNo);
   }
});

//채팅방 리스너
$(document).on('mouseenter', '.chat-room-item-list', function() {
if(isCellMode){
        chatRoomNo = $(this).find('.chat-room-no-hidden-input').val();
        chatRoomTitle = $(this).find('.item-title').text().trim();
    }
});
$(document).on('click', '.chat-room-item-list', function() {
    if(isCellMode){
        disableCellMode();
        isInfoMessageDisplayed = false;
        attachMemoToChatRoomRequest(memoNo,chatRoomNo);
    }
});




function attachMemoToTripPlanRequest(memoNo,tripPlanNo){
    $.ajax({
        type: 'post',
        url: '/memo/attachMemoToTripPlan',
        dataType: 'json',
        data: {
            memoNo: memoNo,
            tripPlanNo: tripPlanNo
        },
        success: function (result) {
            if (result.status === 'success') {
                // 부착 성공
                swal.fire({
                    title: '메모 부착 성공',
                    text: '여행계획, ['+tripPlanTitle+']에 ['+memoTitle+'] 를 부착하였습니다.',
                    icon: 'success'
                });
                getMemoList('myMemo');
            } else {
                // 부착 실패
                swal.fire({
                    title: '메모 부착 실패',
                    text: '여행계획, ['+tripPlanTitle+']에 ['+memoTitle+'] 를 부착하는데 실패하였습니다.',
                    icon: 'error'
                });
            }
        },
        error: function (xhr, status, error) {
            console.error(error);
        }
    });
}

function attachMemoToChatRoomRequest(memoNo,chatRoomNo){
    $.ajax({
        type: 'post',
        url: '/memo/attachMemoToChatRoom',
        dataType: 'json',
        data: {
            memoNo: memoNo,
            chatRoomNo: chatRoomNo
        },
        success: function (result) {
            if (result.status === 'success') {
                // 부착 성공
                swal.fire({
                    title: '메모 부착 성공',
                    text: '채팅방, ['+chatRoomTitle+']에 ['+memoTitle+'] 를 부착하였습니다.',
                    icon: 'success'
                });
                getMemoList('myMemo');
            } else {
                // 부착 실패
                swal.fire({
                    title: '메모 부착 실패',
                    text: '채팅방, ['+chatRoomTitle+']에 ['+memoTitle+'] 를 부착하는데 실패하였습니다.',
                    icon: 'error'
                });
            }
        },
        error: function (xhr, status, error) {
            console.error(error);
        }
    });
}





























$(document).on('click', '.memo-dialog-detach-btn', function(event) {
    event.preventDefault();
    //이 버튼의 값은 detachInfo
    let memoNo = $(this).val();
    detachMemoRequest(memoNo);
    //이 버튼이 속한 dialog 를 닫는다.
    $(this).closest('.ui-dialog').hide();
});

function detachMemoRequest(memoNo){
    $.ajax({
        type: 'post',
        url: '/memo/detachMemo',
        dataType: 'json',
        data: {
            memoNo: memoNo
        }
    }).success(function(result){
        if(result.status === 'success'){
            // 부착 해제 성공
            swal.fire({
                title: '메모 부착 해제 성공',
                text: '메모 부착을 해제하였습니다.',
                icon: 'success'
            });
            getMemoList('myMemo');
        }else{
            // 부착 해제 실패
            swal.fire({
                title: '메모 부착 해제 실패',
                text: '메모 부착을 해제하는데 실패하였습니다.',
                icon: 'error'
            });
        }
    }).fail(function(xhr, status, error) {
        console.error(error);
    });
}