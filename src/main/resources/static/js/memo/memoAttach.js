//부착 버튼 리스너
$(document).on('click', '.memo-dialog-attach-btn', function() {
    event.preventDefault();
    //해당 다이얼로그를 변수로 잡는다.
    let memoDialog = $(this).closest('.memo-dialog');
    //그 메모 다이얼로그를 미니버튼화 한다.
    buildMiniMemoBtn(memoDialog);
});


//미니버튼을 만드는 펑션
function buildMiniMemoBtn(memoDialog) {
    //그 다이얼로그의 정보를 뽑아낸다.
    let infoJson = memoDialog.find('.memo-dialog-info').val();
    //info를 json으로 변환한다.
    let info = JSON.parse(infoJson);
    let miniMemoBtn =
}