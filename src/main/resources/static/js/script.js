
const videoGrid = document.getElementById('video-grid'); //Grid 가져옴
const myPeer = new Peer(); //peer 생성
const myVideo = document.createElement('video'); //video 새로 생성
myVideo.muted = true;
let myStream;
const peers = {};
videoBtn.addEventListener("click",()=>{
    if (videoBtn.classList.contains('btn-on')) { //btn-on 이면? on
        videoBtn.classList.remove('btn-on'); //on 을 지우고
        videoBtn.classList.add('btn-off'); //off로 바꾼다.
        videoBtn.innerText = 'VideoOff'; //
        call.hidden=false;
        trip.hidden=true;
        handleCameraOnClick();
        handleMuteClick();
    } else { //처음 btn-off
        videoBtn.classList.remove('btn-off');
        videoBtn.classList.add('btn-on');
        videoBtn.innerText = 'VideoOn';
        call.hidden=true;
        trip.hidden=false;
        handleCameraOffClick();
        handleMuteClick();
    }
})
startVideo()
function startVideo() {
   navigator.mediaDevices.getUserMedia({
        video: true,
        audio: true,
    }).then((stream) => {
        myStream = stream;
        addVideoStream(myVideo, stream);

        myPeer.on('call', (call) => {
            console.log("myPeer.on(call)");
            call.answer(stream);
            const video = document.createElement('video');
            call.on('stream', (userVideoStream) => {
                console.log("myPeer.on(call) -> call.on(stream)");
                addVideoStream(video, userVideoStream);
            });
        });

        socket.on('user-connected', userId => {
            console.log("user-connected");
            connectToNewUser(userId, stream);
        });
    });

    socket.on('user-disconnected', (userId) => {
        if (peers[userId]) peers[userId].close();
    });

    myPeer.on('open', (id) => {
        console.log("My peer Id is: " + id);
        socket.emit('join-room', ROOM_ID, id);
    });
}



function connectToNewUser(userId, stream) {
    console.log("connectToNewUser");
    const call = myPeer.call(userId, stream);
    const video = document.createElement('video');
    call.on('stream', (userVideoStream) => {
        console.log("connecToNewUser -> call.on(stream)")
        addVideoStream(video, userVideoStream);
    });
    call.on('close', () => {
        video.remove();
    });

    peers[userId] = call;
}

function addVideoStream(video, stream) {
    console.log("addVideoStream")
    video.srcObject = stream;
    video.addEventListener('loadedmetadata', () => { //video가 로드되면 실행
        video.play();
    });
    videoGrid.append(video);
    handleCameraOffClick();
    handleMuteClick();
}
function handleCameraOffClick(){  //카메라 on off
    console.log(myStream);
    myStream.getVideoTracks().forEach(track => (track.enabled = !track.enabled)); //비디오 트랙정보를 가져와서 enabled를 반대로 설정한다.
}
function handleCameraOnClick(){  //카메라 on off
    console.log(myStream);
    myStream.getVideoTracks().forEach(track => (track.enabled = !track.enabled)); //비디오 트랙정보를 가져와서 enabled를 반대로 설정한다.
}
function handleMuteClick(){ // 소리 on off
    //console.log(myStream.getAudioTracks()); //track 정보를 가져온다.//labeled = 모델명
    myStream.getAudioTracks().forEach(track => (track.enabled = !track.enabled)); //enabled!!!! 를 반대로 설정한다.
}
    // PeerJS를 사용하여 서버에 연결합니다.
//     const peer = new Peer({ path: '/peerjs', host: '/', port: 3000 });
//
//     // 로컬 비디오 스트림을 표시합니다.
//     navigator.mediaDevices.getUserMedia({ video: true, audio: true })
//     .then((stream) => {
//     const localVideo = document.getElementById('localVideo');
//     localVideo.srcObject = stream;
//
//     // 피어 간의 연결을 수립하고 비디오 스트림을 전송합니다.
//     peer.on('call', (call) => {
//     call.answer(stream);
//     const video = document.createElement('video');
//     call.on('stream', (remoteStream) => {
//     video.srcObject = remoteStream;
//     document.getElementById('remoteVideos').appendChild(video);
// });
// });
// })
//     .catch((error) => {
//     console.error('Error accessing media devices:', error);
// });
