const chatForm = document.getElementById('chat-form');
const chatMessage = document.querySelector('.chat-messages');
const roomName = document.getElementById('room-name');
const userList = document.getElementById('users');


const queryString = window.location.search;
const params = new URLSearchParams(queryString);

const username = params.get("username");
const room = params.get("room");

console.log(username,room);


const socket = io.connect("http://192.168.0.28:3000", {
  cors:{origin:"http://192.168.0.28:3000"}
});
//join chatroom
socket.emit('joinRoom',{username,room});

//get room and users
socket.on('roomUsers', ({ room, users }) => {
  outputRoomName(room);
  outputUsers(users);
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
  
  //Emit message to server
  socket.emit('chatMessage',msg);

  //clear inpu
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

function outputUsers(users){
  userList.innerHTML = `
    ${users.map(user => `<li>${user.username}<li>`).join('')}
  `;
};

const leaveBtn = document.getElementById('leave-btn');

leaveBtn.addEventListener('click', () => {
  window.history.back();
});