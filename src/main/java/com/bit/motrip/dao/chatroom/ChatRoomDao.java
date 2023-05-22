package com.bit.motrip.dao.chatroom;
import java.util.List; // chatRoomList에서 사용

import com.bit.motrip.domain.ChatRoom;; //ChatRoom 도메인
import org.apache.ibatis.annotations.Mapper; //Mapper 연결

@Mapper
public interface ChatRoomDao { //채팅방 DAO
    public int addChatRoom(ChatRoom chatroom) throws Exception; // 채팅방 생성
    public ChatRoom getChatRoom(int chatRoomNo) throws Exception; // 채팅방 조회
    public void updateChatRoom(ChatRoom chatroom) throws Exception; // 채팅방 업데이트
    public void deleteChatRoom(int chatRoomNo) throws Exception; // 채팅방 삭제
    public List<ChatRoom> chatRoomList() throws Exception; // 채팅방 리스트 조회
    public void changeRoomStatus(int chatRoomStatus,int chatRoomNo) throws Exception;// 채팅방 상태 변경
} //end of interface
