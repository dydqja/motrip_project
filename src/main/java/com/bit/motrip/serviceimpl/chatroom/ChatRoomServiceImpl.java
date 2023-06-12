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
import java.util.*;

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
        System.out.println(chatRoom.getGender());
        System.out.println(chatRoom.getMinAge());
        System.out.println(chatRoom.getMaxAge());
        chatRoom.setCurrentPersons(1);
        int newChatRoomNo = chatRoomDao.addChatRoom(chatRoom);
        if(newChatRoomNo == 1) {
            ChatMember chatMember = new ChatMember();
            chatMember.setChatRoomNo(chatRoom.getChatRoomNo());
            chatMember.setUserId(userId);
            chatMember.setTripPlanNo(tripPlanNo);
            chatMember.setChatRoomAuthor(true);
            chatMemberService.addChatRoomMember(chatMember);
        }
        else{
            System.out.println("채팅방 생성 실패하였습니다.");
        }

//        chatMemberDao.addChatMember(); 삭제예정
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
    public int deleteChatRoom(int chatRoomNo,String userId) throws Exception {
        System.out.println("deleteChatRoom");
        List<ChatMember> chatMemberList= chatMemberService.chatMemberList(chatRoomNo);
        for (ChatMember cm: chatMemberList) {
            System.out.println(cm);
            System.out.println(userId);
            if(cm.getUserId().equals(userId) && cm.isChatRoomAuthor() == true){
                chatRoomDao.deleteChatRoom(chatRoomNo);
                return 1;
            }
        }
        return 0;
    }

    @Override
    public List<ChatRoom> chatRoomList() throws Exception {
        List<ChatRoom> chatRoomList = chatRoomDao.chatRoomList();

        for (ChatRoom cr:chatRoomList) {
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy년 MM월 dd일");
            String strDate = simpleDateFormat.format(cr.getTravelStartDate());
            cr.setStrDate(strDate);
        }

        return chatRoomList;
    }
    @Override
    public Map<String , Object >  chatRoomListPage(Search search) throws Exception {

        List<ChatRoom> chatRoomList = chatRoomDao.chatRoomListPage(search); // listPage 에 서치조건
        for (ChatRoom cr:chatRoomList) {
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy년 MM월 dd일");
            String strDate = simpleDateFormat.format(cr.getTravelStartDate());
            cr.setStrDate(strDate);
        }
        int totalCount = chatRoomDao.getChatRoomTotalCount(search); //토탈 카운트
        System.out.println("totalcount in servicelayer : "+totalCount);
        Map<String, Object> map = new HashMap<String, Object>();

        map.put("list", chatRoomList );
        map.put("totalCount", new Integer(totalCount));
        return map;
    }

    //채팅 상태 변환
    @Override
    public int changeRoomStatus(int chatRoomStatus, int chatRoomNo) throws Exception {
        chatRoomDao.changeRoomStatus(chatRoomStatus,chatRoomNo);
        return chatRoomStatus;
    }

    @Override
    public Map<String , Object > myChatRoomListPage(Search search,String userId) throws Exception {
        Map<String,Object> map = new HashMap<>();
        map.put("search",search);
        map.put("userId",userId);
        List<ChatRoom> chatRoomList = chatRoomDao.myChatRoomListPage(map);

        int totalCount = chatRoomDao.getChatRoomTotalCount(search); //토탈 카운트
        System.out.println("totalcount in servicelayer : "+totalCount);
        Map<String, Object> map2 = new HashMap<String, Object>();

        map2.put("list", chatRoomList );
        map2.put("totalCount", new Integer(totalCount));
        return map2;
    }

    @Override
    public int chatRoomCount() throws Exception {
        return chatRoomDao.chatRoomCount();
    }
}
