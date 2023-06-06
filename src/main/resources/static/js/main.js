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

console.log(username,room);

//cors 에러 해결
const socket = io.connect("http://127.0.0.1:3000", {
  cors:{origin:"http://127.0.0.1:3000"}//"http://192.168.0.28:3000" "http://localhost:3000"}
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

//사진 업로드 방법 구상!!
//1. 자바스크립트에서 사진을 받아서 저장 2.이름을 소켓아이오로 전송 후 저장 3. 사진 필드가 널이 아니면 사진 출력 4. 사진 이름으로 경로에서 이미지 출력
// fileInput.addEventListener('change', (event) => {
//
//   const file = event.target.files[0];
//   console.log(file);
//   // Create a new FileReader object
//   const reader = new FileReader();
//
//   // Read the file data
//   reader.onload = (event) => {
//     // Create a new file object from the file data
//     const fileData = event.target.result;
//
//     // Send the file to the server
//     socket.emit('upload', fileData);
//   };
//
//   // Read the file data
//   reader.readAsArrayBuffer(file);
// });
//message submit
chatForm.addEventListener('submit', (e) => {
  e.preventDefault();
  //get message text
  const msg = e.target.elements.msg.value;

  let photo = e.target.elements.uploadFile.value;
  console.log(photo);
  //Emit message to server
  // console.log(msg);
  // console.log(photo);
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