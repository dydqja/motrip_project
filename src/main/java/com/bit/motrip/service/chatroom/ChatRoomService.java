package com.bit.motrip.service.chatroom;

import java.util.Map;
import com.bit.motrip.domain.ChatRoom; // ChatRoom domain

public interface ChatRoomService { //service
    public int addChatRoom(ChatRoom chatRoom) throws Exception; // 채팅방 생성
    public ChatRoom getChatRoom(int chatRoomNo) throws Exception; // 채팅방 조회
    public ChatRoom updateChatRoom(ChatRoom chatRoom) throws Exception; // 채팅방 업데이트
    public void deleteChatRoom(int chatRoomNo) throws Exception; // 채팅방 삭제
    public Map<String, Object> chatRoomList() throws Exception; // 채팅방 리스트 조회
    //chage room_status
    public int changeRoomStatus(int chatRoomStatus,int chatRoomNo) throws Exception;
} //end of interface
