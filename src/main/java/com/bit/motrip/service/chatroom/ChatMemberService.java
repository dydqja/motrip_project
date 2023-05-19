package com.bit.motrip.service.chatroom;

import com.bit.motrip.dao.chatroom.ChatMemberDao;
import com.bit.motrip.domain.ChatMember;

import java.util.List;

public interface ChatMemberService {
    public void addChatMember(ChatMember chatMemberDao) throws Exception;// 채팅 멤버 추가
    //public void
    public void deleteChatMember(String chatRoomTitle, String userId) throws Exception;

    public void outChatMember(String chatRoomTitle, String userId, boolean isChatRoomAuthor) throws Exception;
    public List<ChatMember> chatMemberList(int chatRoomNo) throws Exception; // 멤버리스트

}
