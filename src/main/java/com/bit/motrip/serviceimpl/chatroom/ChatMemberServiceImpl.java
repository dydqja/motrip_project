package com.bit.motrip.serviceimpl.chatroom;

import com.bit.motrip.dao.chatroom.ChatMemberDao;
import com.bit.motrip.domain.ChatMember;
import com.bit.motrip.service.chatroom.ChatMemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
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
        //기존회원 참여 불가
        int chatRoomNo = chatMember.getChatRoomNo();
        List<ChatMember> chatMemberList=chatMemberDao.listChatMember(chatRoomNo);

        for(ChatMember ch:chatMemberList){
            boolean checker = ch.getUserId().equals(chatMember.getUserId());
            if(checker) {
                System.out.println("이미 참여한 회원");
                return;
            }
        }
        chatMemberDao.addChatMember(chatMember);
    }

    @Override
    public ChatMember getChatMember(int chatRoomNo) throws Exception {
        return chatMemberDao.getChatMember(chatRoomNo);
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
    public ArrayList<ChatMember> chatMemberList(int chatRoomNo) throws Exception {
        return chatMemberDao.listChatMember(chatRoomNo);
    }
}
