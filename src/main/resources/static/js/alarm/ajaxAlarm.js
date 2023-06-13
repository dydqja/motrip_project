function acceptAlarmRequest(alarmAcceptUrl){

    $.ajax({
        url: alarmAcceptUrl,
        type: 'GET',
        dataType: 'json',
        success: function (result) {
            if (result.result == 'success') {
                $("#alarm-modal").modal('hide');
                swal.fire({
                    title: '수락 완료',
                    text: '신청이 수락되었습니다!',
                    icon: 'success'
                });
            } else {
                swal.fire({
                    title: '이런!',
                    text: '신청을 수락하는데 문제가 발생했습니다!',
                    icon: 'error'
                });

            }
        },
        error: function () {
            alert('알람 수락 실패');
        }
    });
}

function rejectAlarmRequest(alarmRejectUrl){

    $.ajax({
        url: alarmRejectUrl,
        type: 'GET',
        dataType: 'json',
        success: function (result) {
            if (result.result == 'success') {
                $("#alarm-modal").modal('hide');
                swal.fire({
                    title: '거절 완료',
                    text: '신청이 거절되었습니다!',
                    icon: 'success'
                });
            } else {
                swal.fire({
                    title: '이런!',
                    text: '신청을 거절하는데 문제가 발생했습니다!',
                    icon: 'error'
                });

            }
        },
        error: function () {
            alert('알람 거절 실패');
        }
    });
}