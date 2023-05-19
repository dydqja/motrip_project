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
    public ChatRoom addChatRoom(ChatRoom chatRoom) throws Exception {
        System.out.println("addChatRoom");
        chatRoomDao.addChatRoom(chatRoom);
        //chatMemberDao.addChatMember();
        return chatRoom;
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
}
