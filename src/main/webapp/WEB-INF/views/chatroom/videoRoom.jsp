<%--
  Created by IntelliJ IDEA.
  User: sean
  Date: 2023/06/12
  Time: 12:35 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Noom</title>
  <link rel="stylesheet" href="https://unpkg.com/mvp.css@1.12/mvp.css">
</head>
<body>
<header>
  <h1>Noom</h1>
</header>
<main>
  <div id="welcome">
    <form>
      <input placeholder="room name" id="room-name" type="text" required>
      <button id="enterRoom">Enter Room</button>
    </form>
  </div>
  <div id="call">
    <div id="myStream">
      <video id="myFace" autoplay playsinline width="400" height="400"></video>
      <button id="mute">Mute</button>
      <button id="camera">Turn Camera Off</button>
      <select id="cameras"></select>
      <video id="peersFace" autoplay playsinline width="400" height="400"></video>
    </div>
  </div>
</main>
<script src="https://cdn.socket.io/4.3.2/socket.io.min.js"></script>
<script>

  const socket = io.connect("http://localhost:3000", {
    cors:{origin:"http://localhost:3000"}//"http://192.168.0.28:3000" "http://localhost:3000"}
  });
  const myFace = document.getElementById("myFace");
  const muteBtn = document.getElementById("mute");
  const cameraBtn = document.getElementById("camera");
  const cameraSelect = document.getElementById("cameras"); //select dom가져옴
  const call = document.getElementById("call");
  //call
    call.hidden = true;

  let myStream;
  let muted = false;
  let cameraOff = false;
  let roomName ;
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




  //backend  작업 (join room)

  const welcome = document.getElementById("welcome");
  const welcomeForm = welcome.querySelector("form");


  async function initCall(){ //hidden을 바꾼다!
    welcome.hidden=true;
    call.hidden=false;
    await getMedia();
    makeConnection();
  }

  async function handleWelcomeSubmit(event){
    event.preventDefault();
    const input = welcomeForm.querySelector("input"); //room name 을 받는다
    //console.log(input.value);
    await initCall();
    // backend submit
    socket.emit("join_room",input.value); //payload = input.value
    roomName = input.value; // 방이름 저장
    input.value = "";
  }

  welcomeForm.addEventListener("submit",handleWelcomeSubmit);


  /// Socket Code

  socket.on("welcome",async ()=>{ //peer A
    console.log("someone join");
    const offer = await myPeerConnection.createOffer();
    myPeerConnection.setLocalDescription(offer);
    //console.log(offer);
    console.log("sent the offer");
    socket.emit("offer",offer,roomName);
  });

  //peerB -> server에서 받은 offer
  socket.on("offer",async(offer) => { // offer가 도착한 순간 myPeerConnection 존재하지않는다.(너무빠르기때문)
    console.log("received the offer");
    myPeerConnection.setRemoteDescription(offer); // 내 들어온 사람의 remoteDescription
    const answer = await myPeerConnection.createAnswer();
    console.log(answer);
    myPeerConnection.setLocalDescription(answer);
    socket.emit("answer",answer,roomName);
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
    socket.emit("ice",data.candidate,roomName); //candidate를 보낸다 다른 방에 서로 공유해야하므로
    // console.log("got ice candidate");
    // console.log(data);
  }

  function handleAddStream(data){
    const peersFace = document.getElementById("peersFace");
    console.log("god a event from here");
    console.log("peer's stream",data.stream);
    console.log("myStream",myStream);
    peersFace.srcObject = data.stream;
  }
</script>
</body>
</html>
