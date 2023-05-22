package com.bit.motrip.serviceimpl.chatroom;

import com.bit.motrip.dao.chatroom.ChatMemberDao;
import com.bit.motrip.dao.chatroom.ChatRoomDao;
import com.bit.motrip.domain.ChatMember;
import com.bit.motrip.domain.ChatRoom;
import com.bit.motrip.service.chatroom.ChatRoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("chatRoomServiceImpl")
public class ChatRoomServiceImpl implements ChatRoomService {

    //Field
    @Autowired
    @Qualifier("chatRoomDao")
    ChatRoomDao chatRoomDao; //Chatroom

//    @Autowired
//    @Qualifier("chatMemberDao")
//    ChatMemberDao chatMemberDao; // chatmember

    @Override
    public int addChatRoom(ChatRoom chatRoom) throws Exception {
        System.out.println("addChatRoom");
        int chatRoomNo = chatRoomDao.addChatRoom(chatRoom);

        //chatMemberDao.addChatMember();
        return chatRoomNo;
    }

    @Override
    public ChatRoom getChatRoom(int chatRoomNo) throws Exception {
        System.out.println("getChatRoom");
        return chatRoomDao.getChatRoom(chatRoomNo);
    }

    @Override
    public ChatRoom updateChatRoom(ChatRoom chatRoom) throws Exception {
        System.out.println("updateChatRoom");
        chatRoomDao.updateChatRoom(chatRoom);
        return chatRoom;
    }

    @Override
    public void deleteChatRoom(int chatRoomNo) throws Exception {
        System.out.println("deleteChatRoom");

        chatRoomDao.deleteChatRoom(chatRoomNo);
    }

    @Override
    public Map<String, Object> chatRoomList() throws Exception {
        return null;
    }

    //채팅 상태 변환
    @Override
    public int changeRoomStatus(int chatRoomStatus, int chatRoomNo) throws Exception {
        chatRoomDao.changeRoomStatus(chatRoomStatus,chatRoomNo);
        return chatRoomStatus;
    }
}
