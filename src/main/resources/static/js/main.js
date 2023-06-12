const chatForm = document.getElementById('chat-form');
const chatMessage = document.querySelector('.chat-messages');
const roomName = document.getElementById('room-name');
const userList = document.getElementById('users');
const fileInput = document.getElementById('uploadFile');
// const queryString = window.location.search;
// const params = new URLSearchParams(queryString);
// console.log(queryString);
// const username = params.get("username");
// const room = params.get("chatRoomNo");

//console.log(username,room);

//cors 에러 해결
const socket = io.connect("http://192.168.0.28:3000", {
  cors:{origin:"http://192.168.0.28:3000"}//"http://192.168.0.28:3000" "http://localhost:3000"}
});
//join chatroom
socket.emit('joinRoom',{username,room});

//get room and users
socket.on('roomUsers', ({ room, users }) => {
  outputRoomName(room);
  outputUsers(users);
});
// socket.on('roomUsersRemove', ({ room, users }) => {
//   removeUsers(users);
// });
//client side
//Message from server
socket.on('message',message => {
  console.log(message);
  if(message.photo){
    console.log(message.photo);
    outputPhoto(message);
  }else{
    outputMessage(message);
  }

  //SCROLL DOWN
  chatMessage.scrollTop=chatMessage.scrollHeight;
});
///webRTC이용

const muteBtn = document.getElementById("mute"); //mute를 받아옴
console.log(muteBtn);
let myStream;
let muted = false;
let myPeerConnection;
getMedia();
makeConnection();
async function getMedia(){ //video시작
  //constraints
  const initialConstraints = { //기본 constraints
    audio : true,
  };

  try {
    //constrains => 무엇을 얻고싶은지!!
    //  audio:true,
    //  video:true
    myStream = await navigator.mediaDevices.getUserMedia(initialConstraints);

    //console.log(myStream);
    myFace.srcObject = myStream; //srcObject 속성은 일반적으로 웹캠, 마이크 등의 미디어 장치에서 (<video> 요소와 <audio> 요소에서 사용되는 속성)
  } catch(e){
    console.log(e);
  }
}
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
muteBtn.addEventListener("click",handleMuteClick);
socket.on("welcome",async ()=>{ //peer A
  console.log("someone join");
  const offer = await myPeerConnection.createOffer();
  myPeerConnection.setLocalDescription(offer);
  //console.log(offer);
  console.log("sent the offer");
  socket.emit("offer",offer,room);
});

//peerB -> server에서 받은 offer
socket.on("offer",async(offer) => { // offer가 도착한 순간 myPeerConnection 존재하지않는다.(너무빠르기때문)
  console.log("received the offer");
  myPeerConnection.setRemoteDescription(offer); // 내 들어온 사람의 remoteDescription
  const answer = await myPeerConnection.createAnswer();
  console.log(answer);
  myPeerConnection.setLocalDescription(answer);
  socket.emit("answer",answer,room);
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
  socket.emit("ice",data.candidate,room); //candidate를 보낸다 다른 방에 서로 공유해야하므로
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
//사진 업로드 방법 구상!!
//1. 자바스크립트에서 사진을 받아서 저장 2.이름을 소켓아이오로 전송 후 저장 3. 사진 필드가 널이 아니면 사진 출력 4. 사진 이름으로 경로에서 이미지 출력

chatForm.addEventListener('submit', (e) => {
  e.preventDefault();
  //get message text
  const msg = e.target.elements.msg.value;

  let photo = e.target.elements.uploadFile.value;
  console.log(photo);

  const uploadFilePromise = new Promise((resolve, reject) => {
    if (photo) {
      let file = e.target.elements.uploadFile.files[0];
      const reader = new FileReader();
      console.log(file);

      reader.onload = (event) => {
        const fileData = event.target.result;
        socket.emit('upload', fileData);
     // Resolve the promise once the upload is complete
      };

      reader.readAsArrayBuffer(file);
      socket.on('uploadComplete', filepath => {
        console.log(filepath);
        photo = filepath;
        console.log(photo);
        resolve();
      });
    } else {
      resolve(); // Resolve the promise immediately if there is no photo
    }
  });
  uploadFilePromise.then(() => {
    socket.emit('chatMessage', msg, photo);

    //clear input
    e.target.elements.msg.value = '';
    //e.target.elements.msg.value.focus();
    e.target.elements.uploadFile.value= '';
  });
});
//이미지 넣기
function outputMessage(message){
  const div = document.createElement('div');
  div.classList.add('message');
  div.innerHTML = `<p class="meta">${message.username}<span>   ${message.time}</span></p>
  <p class="text">
    ${message.text}
  </p>`;
  document.querySelector('.chat-messages').appendChild(div);
};
//photo
function outputPhoto(message){
  const div = document.createElement('div');

  console.log(message.photo);
  div.classList.add('message');
  div.innerHTML = `<p class="meta">${message.username}<span>   ${message.time}</span></p>
   <img src="/imagePath/${message.photo}"/>
  <p class="text">
    ${message.text}
  </p>`;
  document.querySelector('.chat-messages').appendChild(div);
};


//방이름 더하기
function outputRoomName(room) {
  roomName.innerText = room;
}

function outputUsers(users){ //이거는 참여한 유저 리스트
  userList.innerHTML = `
    ${users.map(user => `<li id="${user.username}">${user.username}</li>`).join('')}
  `;
};
function removeUsers(users) {
    const userElement = document.getElementById(users);
    if (userElement) {
      userElement.innerHTML = "";
    };
};

//현재 참여 유저 리스트

const leaveBtn = document.getElementById('leave-btn');

leaveBtn.addEventListener('click', () => {
  window.history.back();
});


