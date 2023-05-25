package com.bit.motrip.serviceimpl.chatroom;

import com.bit.motrip.common.Search;
import com.bit.motrip.dao.chatroom.ChatMemberDao;
import com.bit.motrip.dao.chatroom.ChatRoomDao;
import com.bit.motrip.domain.ChatMember;
import com.bit.motrip.domain.ChatRoom;
import com.bit.motrip.service.chatroom.ChatMemberService;
import com.bit.motrip.service.chatroom.ChatRoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service("chatRoomServiceImpl")
public class ChatRoomServiceImpl implements ChatRoomService {

    //Field
    @Autowired
    @Qualifier("chatRoomDao")
    ChatRoomDao chatRoomDao; //Chatroom

    @Autowired
    @Qualifier("chatMemberServiceImpl")
    private ChatMemberService chatMemberService;
//    @Autowired
//    @Qualifier("chatMemberDao")
//    ChatMemberDao chatMemberDao; // chatmember

    @Override
    public int addChatRoom(ChatRoom chatRoom,String userId,int tripPlanNo) throws Exception {
        System.out.println("addChatRoom");
        int newChatRoomNo = chatRoomDao.addChatRoom(chatRoom);
        if(newChatRoomNo == 1) {
            ChatMember chatMember = new ChatMember();
            chatMember.setChatRoomNo(chatRoom.getChatRoomNo());
            chatMember.setUserId(userId);
            chatMember.setTripPlanNo(tripPlanNo);
            chatMember.setChatRoomAuthor(true);
            chatMemberService.addChatMember(chatMember);
        }
        else{
            System.out.println("채팅방 생성 실패하였습니다.");
        }
        //chatMemberDao.addChatMember();
        return chatRoom.getChatRoomNo();
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
    public List<ChatRoom> chatRoomList() throws Exception {
        List<ChatRoom> chatRoomList = chatRoomDao.chatRoomList();
        System.out.println(chatRoomList.get(1).getTravelStartDate());
        for (ChatRoom cr:chatRoomList) {
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy년 MM월 dd일");
            String strDate = simpleDateFormat.format(cr.getTravelStartDate());
            cr.setStrDate(strDate);
        }

        return chatRoomList;
    }

    //채팅 상태 변환
    @Override
    public int changeRoomStatus(int chatRoomStatus, int chatRoomNo) throws Exception {
        chatRoomDao.changeRoomStatus(chatRoomStatus,chatRoomNo);
        return chatRoomStatus;
    }
}
