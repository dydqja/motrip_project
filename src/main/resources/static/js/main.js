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
const socket = io.connect("chat.motrip.co.kr", {
  cors:{origin:"chat.motrip.co.kr"}//"http://192.168.0.28:3000" "http://localhost:3000"}
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
    var previewContainer = document.getElementById("image-preview");
    previewContainer.innerHTML = ""
  });
});
//이미지 넣기
let messageTime;
let beforeUserName;
function isOneMinuteApart(time1, time2) { //1분 차이인지 판단하는 알고리즘
  const diff = Math.abs(
      Date.parse(`2000/01/01 ${time1}`) - Date.parse(`2000/01/01 ${time2}`)
  );
  const minutes = diff / (1000 * 60);
  return minutes <= 1;
}
// let minutes = messageTime.getMinutes();
function outputMessage(message){
  const isOneMinute = isOneMinuteApart(messageTime, message.time);

  const div = document.createElement('div');

  if(username==message.username){
    div.classList.add('message');
    if(message.username===beforeUserName && isOneMinute){
      div.innerHTML = ` 
        <p class="text">
        ${message.text}
        </p>`;
      document.querySelector('.chat-messages').appendChild(div);
      messageTime = message.time;
      beforeUserName=message.username;
    }else {
      div.innerHTML = `
      <div class="userbox" align="right">
      <span>${message.time}</span><p class="chat">${message.username}</p>
      <img src="https://via.placeholder.com/50x50" style="border-radius: 40%;"/>
      </div>
      <p class="text">
        ${message.text}
      </p>`;
      document.querySelector('.chat-messages').appendChild(div);
      messageTime = message.time;
      beforeUserName=message.username;
    }
  }else if(message.username !== "자동응답입니다."){
    div.classList.add('message2');
    if(message.username===beforeUserName && isOneMinute){
      div.innerHTML = ` 
        <p class="text2">
        ${message.text}
        </p>`;
      document.querySelector('.chat-messages').appendChild(div);
      messageTime = message.time;
      beforeUserName=message.username;
    }else{
    div.innerHTML = `<img src="https://via.placeholder.com/50x50" style="border-radius: 40%;"/>
    <p class="chat2">${message.username}</p><span>   ${message.time}</span><br/>
    <p class="text2">
      ${message.text}
    </p>`;
    document.querySelector('.chat-messages').appendChild(div);
    messageTime = message.time;
    beforeUserName=message.username;
    }
  }else{
    div.classList.add('message2');
    div.innerHTML = `
    <p style="text-decoration-color: #03e9f4">
      ${message.text}
    </p>`;
    document.querySelector('.chat-messages').appendChild(div);
    beforeUserName=message.username;
  }

};
//photo
function outputPhoto(message){

  const div = document.createElement('div');

  if(username==message.username){
    div.classList.add('message');
    div.innerHTML = `
    
    <div class="userbox" align="right">
    <span>   ${message.time}</span>
    <p class="chat">${message.username}</p>
    <img src="https://via.placeholder.com/50x50" style="border-radius: 40%;"/>
    </div>
    <p class="text">
     <img src="/imagePath/photos/${chatRoom.tripPlanThumbnail}'"/><br/>
     &nbsp&nbsp
      ${message.text}
    </p>`;
    document.querySelector('.chat-messages').appendChild(div);
  }else{
    div.classList.add('message2');
    div.innerHTML = `<img src="https://via.placeholder.com/50x50" style="border-radius: 40%;"/>
    <p class="chat2">${message.username}</p>
    <span>   ${message.time}</span><br/>
    <p class="text2">
        <img src="/imagePath/photos/${chatRoom.tripPlanThumbnail}'"/>
        &nbsp&nbsp
      ${message.text}`;
    document.querySelector('.chat-messages').appendChild(div);

  }
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

// const leaveBtn = document.getElementById('leave-btn');

// leaveBtn.addEventListener('click', () => {
//   window.history.back();
// });


