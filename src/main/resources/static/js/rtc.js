
const myFace = document.getElementById("myFace");
const muteBtn = document.getElementById("mute");
const cameraBtn = document.getElementById("camera");
const cameraSelect = document.getElementById("cameras"); //select dom가져옴
const rtcRoom = room+"rtc";
//call

let myStream;
let muted = false;
let cameraOff = false;
let myPeerConnection;
//mediaDevices + webRTC를 이용한다.
async function getCameras(){ //카메라 정보를 select에 표시해주는 코드
    //promise
    try{
        const devices = await navigator.mediaDevices.enumerateDevices() //컴퓨터에 연결되어있는 모든 장치 정보를 가져온다. (await!!)
        //console.log(devices);
        const cameras = devices.filter(device => device.kind === "videoinput"); //카메라만 선택하는 코드 kind는 장치종류 videoinput은 카메라
        //confirm.log(cameras);
        //console.log(myStream.getVideoTracks( )); => 카메라 정보를 가져온다.
        const currentCamera = myStream.getVideoTracks()[0]; // 처음 정보를 가져온다.
        cameras.forEach(camera => { //카메라 선택하기 스크린에 노출시킬
            const option = document.createElement("option"); //select안에 넣을 option생성
            option.vale = camera.deviceId; //카메라 deviceId 를 value로
            option.innerText = camera.label; //카메라 label 를 이름으로 표현해준다.
            if(currentCamera.label = camera.label){
                option.selected = true; //사용하고있는 카메라를 selected하는 코드
            }
            cameraSelect.appendChild(option); //select 에 option을 append
        })
        console.log(cameras);
    }catch(e){
        console.log(e);
    }
}

async function getMedia(deviceId){ //video시작
    //constraints
    const initialConstraints = { //기본 constraints
        audio : true,
        video : {facingMode : "user"}, //카메라 선택한다.
    };

    const cameraConstraints = { //new constraints
        audio:true,
        video: {deviceId: { exact: deviceId}}, //deviceId 로 카메라 설정
    };

    try {
        //constrains => 무엇을 얻고싶은지!!
        //  audio:true,
        //  video:true
        myStream = await navigator.mediaDevices.getUserMedia( //유저의 미디어 정보를 얻어온다.
            deviceId ? cameraConstraints : initialConstraints //deviceId 가 있으면 cameraConstraints실행 없으면 initialConstraintstlfgod
        );

        //console.log(myStream);
        myFace.srcObject = myStream; //srcObject 속성은 일반적으로 웹캠, 마이크 등의 미디어 장치에서 (<video> 요소와 <audio> 요소에서 사용되는 속성)
        // 가져온 스트림을 비디오나 오디오 요소에 연결할 때 사용됩니다.
        // 이를 통해 웹페이지에서 실시간 비디오 또는 오디오 스트림을 재생하거나 녹화할 수 있습니다.
        if(!deviceId){
            await getCameras(); //select에 처음 deviceId가 없을때만 표시하도록 설정하는 코드
        }
    } catch(e){
        console.log(e);
    }
}

// getMedia(); //important
// 카메라 오디오 on off!!!
function handleMuteClick(){ // 소리 on off
    //console.log(myStream.getAudioTracks()); //track 정보를 가져온다.//labeled = 모델명
    myStream.getAudioTracks().forEach(track => (track.enabled = !track.enabled)); //enabled!!!! 를 반대로 설정한다.
    //so.. enabled : true 켜짐, enalbled : false 꺼짐,
    if(!muted){
        muteBtn.innerText = "Unmute";
        muted=true;
    }else{
        muteBtn.innerText = "Mute";
        muted=false;
    }
}
function handleCameraClick(){  //카메라 on off
    myStream.getVideoTracks().forEach(track => (track.enabled = !track.enabled)); //비디오 트랙정보를 가져와서 enabled를 반대로 설정한다.

    if(cameraOff){ //카메라 꺼져있으면
        cameraBtn.innerText = "Turn Camera Off"; // 카메라를 끄니까 켜진상태
        cameraOff=false; //카메라 켠다.
    }else{ //카메라가 켜져있으면
        cameraBtn.innerText = "Turn Camera On"; //카메라를 켜니까 꺼진상태
        cameraOff=true; //카메라 끈다.
    }}

async function handleCameraChange(){//카메라 변경
    //getMedia 불러오면 된다.
    //특정 카메라 불러오는법은 ?
    //getUserMedia(constraints) => constraints 를 통해 정보를 보내준다.
    console.log(cameraSelect.value);
    await getMedia(cameraSelect.value); // *(중요) 카메라 deviceId를 가져오는 부분
}

muteBtn.addEventListener("click",handleMuteClick);
cameraBtn.addEventListener("click",handleCameraClick);
cameraSelect.addEventListener("input",handleCameraChange); //input이 바뀌면 실행
//getUserMedia() => user camera, audio info
//enumerateDevices() => computer의 모든 장치 정보

// 내가 봤을때는 count를 node 서버에 두고
// node 서버에서 한명 들어올때마다 count를 증가시켜주고
// initCall 전에 회원이 들어올 자리를 설정해 줘야할듯?
// 그리고 나가면 거기 자리를 지워주고 자리를 당겨야할 것 같아 어떻게 생각해?
// 일단 한번 해보자



//backend  작업 (join room)
let count = 0;
async function initCall(){ //hidden을 바꾼다!
    if(call.hidden==false){
        // call.hidden=false;
        // trip.hidden=true;
        console.log(room);
        await getMedia();
        makeConnection();

        count += 1;
        var video = document.createElement('video');
        video.autoplay = true;
        video.playsinline = true;
        video.width = 300;
        video.height = 300;
        video.id = `peersFace${count}`;
        var div = document.getElementById('myStream');
        div.appendChild(video);
        //count += 1;
    }else{

        myPeerConnection.close();
        // call.hidden=true;
        // trip.hidden=false;
        var div = document.getElementById('myStream');
        var video = document.getElementById(`peersFace${count}`);
        if (video) {
            div.removeChild(video);
        }

        // socket.emit('leave_room', rtcRoom);
        console.log("video out!!");
    }
}

videoBtn.addEventListener("click",handleWelcomeSubmit);

async function handleWelcomeSubmit(event){
    event.preventDefault();
    // socket.emit("addVideo");
    //console.log(input.value);

    if(call.hidden==false) {
        await initCall();
        // backend submit
        socket.emit("join_room", rtcRoom); //payload = input.value
    }else{

        await initCall();
    }
}
/// Socket Code

socket.on("welcome",async ()=>{ //peer A
    console.log("someone join");
    const offer = await myPeerConnection.createOffer();
    myPeerConnection.setLocalDescription(offer);
    //console.log(offer);
    console.log("sent the offer");
    socket.emit("offer",offer,rtcRoom);
});

//peerB -> server에서 받은 offer
socket.on("offer",async(offer) => { // offer가 도착한 순간 myPeerConnection 존재하지않는다.(너무빠르기때문)
    console.log("received the offer");
    myPeerConnection.setRemoteDescription(offer); // 내 들어온 사람의 remoteDescription
    const answer = await myPeerConnection.createAnswer();
    console.log(answer);
    myPeerConnection.setLocalDescription(answer);
    socket.emit("answer",answer,rtcRoom);
    console.log("sent the answer");
});

socket.on("answer",answer => {
    //remoteDescription을 peerA가 가지게 되었다.
    console.log("received the answer");
    myPeerConnection.setRemoteDescription(answer);
})

socket.on("ice",ice => {
    console.log("received candidate");
    myPeerConnection.addIceCandidate(ice);
})

//RTC CODE
function makeConnection(){
    myPeerConnection = new RTCPeerConnection({
        iceServers:[
            {
                urls: [
                    "stun:stun.l.google.com:19302",
                    "stun:stun1.l.google.com:19302",
                    "stun:stun2.l.google.com:19302",
                    "stun:stun3.l.google.com:19302",
                    "stun:stun4.l.google.com:19302",
                ]
            }
        ]
    });  //peer 2 peer연결
    myPeerConnection.addEventListener("icecandidate",handleIce); //icecandidate 이벤트 발생시 실행
    myPeerConnection.addEventListener("addstream",handleAddStream); //addstream
    //console.log(myStream.getTracks());//트랙 정보들 ,  영상or오디오 데이터를 peerconnection에 넣어야한다.
    myStream.getTracks().forEach((track) => myPeerConnection.addTrack(track,myStream));
    //peer를 만드는 동시에 track을 커낵션 했다.
}

function handleIce(data){
    console.log("sent candidate");
    socket.emit("ice",data.candidate,rtcRoom); //candidate를 보낸다 다른 방에 서로 공유해야하므로
    // console.log("got ice candidate");
    // console.log(data);
}

function handleAddStream(data){

    const peersFace = document.getElementById(`peersFace${count}`);
    console.log("god a event from here");
    console.log("peer's stream",data.stream);
    console.log("myStream",myStream);
    peersFace.srcObject = data.stream;


}
