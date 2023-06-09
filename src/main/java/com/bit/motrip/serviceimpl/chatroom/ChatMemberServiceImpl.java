package com.bit.motrip.serviceimpl.chatroom;

import com.bit.motrip.dao.chatroom.ChatMemberDao;
import com.bit.motrip.dao.chatroom.ChatRoomDao;
import com.bit.motrip.domain.ChatMember;
import com.bit.motrip.domain.ChatRoom;
import com.bit.motrip.service.chatroom.ChatMemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("chatMemberServiceImpl")
public class ChatMemberServiceImpl implements ChatMemberService {

    @Autowired
    @Qualifier("chatMemberDao")
    ChatMemberDao chatMemberDao;

    @Autowired
    @Qualifier("chatRoomDao")
    private ChatRoomDao chatRoomDao;
    @Override
    public void addChatRoomMember(ChatMember chatMember) throws Exception{
        System.out.println("addChatRoomMember");
        chatMemberDao.addChatMember(chatMember);
    }
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
        System.out.println(chatRoomNo);
        //회원이 maxPersons 이면 참여불가 chatRoomStatus 가 0 이 아니면 참여 불가
        ChatRoom chatRoom = chatRoomDao.getChatRoom(chatRoomNo);

        int chatRoomMaxPersons = chatRoom.getMaxPersons();
        int chatRoomCurrentPersons = chatRoom.getCurrentPersons();
        int chatRoomStatus = chatRoom.getChatRoomStatus();

        if(chatRoomMaxPersons>chatRoomCurrentPersons && chatRoomStatus == 0){
            chatMemberDao.addChatMember(chatMember);
            chatRoomCurrentPersons+=1;
            chatRoom.setCurrentPersons(chatRoomCurrentPersons);
            chatRoomDao.updateChatRoom(chatRoom);
        }
        else{
            System.out.println("참여 불가능합니다.");
        }

    }
    @Override
    public ChatMember getChatMember(int chatRoomNo) throws Exception {
        return chatMemberDao.getChatMember(chatRoomNo);
    }
    //채팅 방장 id 가져오기
    @Override
    public ChatMember getChatMemberAuthor(int chatRoomNo) throws Exception {
        return chatMemberDao.getChatMemberAuthor(chatRoomNo);
    }

    //채팅 멤버 삭제 (나가기)
    @Override
    public void deleteChatMember(int chatRoomNo, String userId) throws Exception {
        chatMemberDao.deleteChatMember(chatRoomNo,userId);
        ChatRoom chatRoom = chatRoomDao.getChatRoom(chatRoomNo);
        chatRoom.setCurrentPersons(chatRoom.getCurrentPersons()-1);
        chatRoomDao.updateChatRoom(chatRoom);
    }
    //채팅 강제퇴장 (나가기)
    @Override
    public void kickChatMember(int chatRoomNo, String userId, boolean isChatRoomAuthor) throws Exception {
        chatMemberDao.kickChatMember(chatRoomNo,userId,isChatRoomAuthor);
        ChatRoom newChatRoom = chatRoomDao.getChatRoom(chatRoomNo);
        newChatRoom.setCurrentPersons(newChatRoom.getCurrentPersons()-1);
        chatRoomDao.updateChatRoom(newChatRoom);
//        for (ChatMember ch:chatMemberDao.listChatMember(chatRoomNo)) {
//            System.out.println(ch);
//        }
//        return chatMemberDao.listChatMember(chatRoomNo);
    }
    //채팅 멤버리스트 출력
    @Override
    public ArrayList<ChatMember> chatMemberList(int chatRoomNo) throws Exception {
        return chatMemberDao.listChatMember(chatRoomNo);
    }

}
