
const videoGrid = document.getElementById('video-grid'); //Grid 가져옴
const myPeer = new Peer(); //peer 생성
const myVideo = document.createElement('video'); //video 새로 생성
myVideo.muted = true;

const peers = {};

navigator.mediaDevices
    .getUserMedia({
        video: true,
        audio: true,
    })
    .then((stream) => {
        addVideoStream(myVideo, stream); //myVideo에 스트림 추가

        myPeer.on('call', (call) => {
            call.answer(stream);
            const video = document.createElement('video');
            call.on('stream', (userVideoStream) => {
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
    console.log("My peer Id is : "+ id);
    socket.emit('join-room', ROOM_ID, id);
});



function connectToNewUser(userId, stream) {
    console.log("connectToNewUser");
    const call = myPeer.call(userId, stream);
    const video = document.createElement('video');
    call.on('stream', (userVideoStream) => {
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
}
// function handleCameraClick(){  //카메라 on off
//     myVideo.getVideoTracks().forEach(track => (track.enabled = !track.enabled)); //비디오 트랙정보를 가져와서 enabled를 반대로 설정한다.
//
//     if(cameraOff){ //카메라 꺼져있으면
//         cameraBtn.innerText = "Turn Camera Off"; // 카메라를 끄니까 켜진상태
//         cameraOff=false; //카메라 켠다.
//     }else{ //카메라가 켜져있으면
//         cameraBtn.innerText = "Turn Camera On"; //카메라를 켜니까 꺼진상태
//         cameraOff=true; //카메라 끈다.
//     }}

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
