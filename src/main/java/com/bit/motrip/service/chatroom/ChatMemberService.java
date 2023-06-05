package com.bit.motrip.service.chatroom;

import com.bit.motrip.dao.chatroom.ChatMemberDao;
import com.bit.motrip.domain.ChatMember;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface ChatMemberService {
    public void addChatRoomMember(ChatMember chatMember) throws Exception;

    // 채팅 멤버 추가
    public void addChatMember(ChatMember chatMember) throws Exception;
    //
    public ChatMember getChatMember(int chatRoomNo) throws Exception;

    ChatMember getChatMemberAuthor(int chatRoomNo) throws Exception;

    // 채팅 멤버 삭제(채팅방 나가기)
    public void deleteChatMember(int chatRoomNo, String userId) throws Exception;
    // 채팅 멤버 강퇴
    public List<ChatMember> kickChatMember(int chatRoomNo, String userId, boolean isChatRoomAuthor) throws Exception;
    // 채팅 멤버 리스트 출력
    public ArrayList<ChatMember> chatMemberList(int chatRoomNo) throws Exception; // 멤버리스트

}
