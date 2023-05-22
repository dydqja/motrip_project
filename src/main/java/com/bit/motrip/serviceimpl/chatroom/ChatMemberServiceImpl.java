package com.bit.motrip.serviceimpl.chatroom;

import com.bit.motrip.dao.chatroom.ChatMemberDao;
import com.bit.motrip.domain.ChatMember;
import com.bit.motrip.service.chatroom.ChatMemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("chatMemberServiceImpl")
public class ChatMemberServiceImpl implements ChatMemberService {

    @Autowired
    @Qualifier("chatMemberDao")
    ChatMemberDao chatMemberDao;
    //멤버 더하기
    @Override
    public void addChatMember(ChatMember chatMember) throws Exception {
        System.out.println("addChatMember");
        chatMemberDao.addChatMember(chatMember);
    }
    //채팅 멤버 삭제 (나가기)
    @Override
    public void deleteChatMember(int chatRoomNo, String userId) throws Exception {
        chatMemberDao.deleteChatMember(chatRoomNo,userId);
    }
    //채팅 강제퇴장 (나가기)
    @Override
    public void outChatMember(int chatRoomNo, String userId, boolean isChatRoomAuthor) throws Exception {
        chatMemberDao.outChatMember(chatRoomNo,userId,isChatRoomAuthor);
    }
    //채팅 멤버리스트 출력
    @Override
    public List<ChatMember> chatMemberList(int chatRoomNo) throws Exception {
        return null;
    }
}
