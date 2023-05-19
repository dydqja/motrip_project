package com.bit.motrip.serviceimpl.chatroom;

import com.bit.motrip.domain.ChatMember;
import com.bit.motrip.service.chatroom.ChatMemberService;

import java.util.List;

public class ChatMemberServiceImpl implements ChatMemberService {
    @Override
    public void addChatMember(ChatMember chatMemberDao) throws Exception {

    }

    @Override
    public void deleteChatMember(String chatRoomTitle, String userId) throws Exception {

    }

    @Override
    public void outChatMember(String chatRoomTitle, String userId, boolean isChatRoomAuthor) throws Exception {

    }

    @Override
    public List<ChatMember> chatMemberList(int chatRoomNo) throws Exception {
        return null;
    }
}
