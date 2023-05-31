const chatForm = document.getElementById('chat-form');
const chatMessage = document.querySelector('.chat-messages');
const roomName = document.getElementById('room-name');
const userList = document.getElementById('users');

// const queryString = window.location.search;
// const params = new URLSearchParams(queryString);
// console.log(queryString);
// const username = params.get("username");
// const room = params.get("chatRoomNo");

console.log(username,room);

//cors 에러 해결
const socket = io.connect("http://localhost:3000", {
  cors:{origin:"http//localhost:3000"}//"http://192.168.0.28:3000"}
});
//join chatroom
socket.emit('joinRoom',{username,room});

//get room and users
socket.on('roomUsers', ({ room, users }) => {
  outputRoomName(room);
  outputUsers(users);
});
socket.on('roomUsersRemove', ({ room, users }) => {
  outputRoomName(room);
  removeUsers(users);
});
//client side
//Message from server
socket.on('message',message => {
  console.log(message);
  outputMessage(message);

  //SCROLL DOWN
  chatMessage.scrollTop=chatMessage.scrollHeight;
});

//message submit
chatForm.addEventListener('submit', (e) => {
  e.preventDefault();

  //get message text
  const msg = e.target.elements.msg.value;
  const photo = e.target.elements.uploadFile.value;
  //Emit message to server

  socket.emit('chatMessage',msg,photo);

  //clear input
  e.target.elements.msg.value='';
  //e.target.elements.msg.value.focus();
});

//out message to dom
function outputMessage(message){
  const div = document.createElement('div');
  div.classList.add('message');
  div.innerHTML = `<p class="meta">${message.username}<span>   ${message.time}</span></p>
  <p clas="text">
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
}
//현재 참여 유저 리스트

const leaveBtn = document.getElementById('leave-btn');

leaveBtn.addEventListener('click', () => {
  window.history.back();
});