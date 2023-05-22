package com.bit.motrip.chatroom;

import com.bit.motrip.domain.ChatMember;
import com.bit.motrip.domain.ChatRoom;
import com.bit.motrip.service.chatroom.ChatMemberService;
import com.bit.motrip.service.chatroom.ChatRoomService;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Date;

@SpringBootTest
public class ChatRoomTests {
    @Autowired
    @Qualifier("chatRoomServiceImpl")
    private ChatRoomService chatRoomService;
    @Autowired
    @Qualifier("chatMemberServiceImpl")
    private ChatMemberService chatMemberService;

  //  @Test
    public void getTest() throws Exception{
        ChatRoom chatRoom = chatRoomService.getChatRoom(1);
        System.out.println(chatRoom);
    }

    //@Test
    public void addTest() throws Exception{
        //1.방 생성 후
        ChatRoom chatRoom = new ChatRoom();
        Date currentDate = new Date();

        chatRoom.setChatRoomTitle("test room2");
        chatRoom.setTravelStartDate(currentDate);
        chatRoom.setAgeRange("20-29");
        chatRoom.setMaxPersons(4);
        chatRoom.setCurrentPersons(0);
        int newChatRoomNo =chatRoomService.addChatRoom(chatRoom);
        System.out.println(newChatRoomNo);
        //2.방장추가
        if(newChatRoomNo == 1) {
            ChatMember chatMember = new ChatMember();
            chatMember.setChatRoomNo(chatRoom.getChatRoomNo());
            chatMember.setUserId("user101");
            chatMember.setTripPlanNo(2);
            chatMember.setChatRoomAuthor(true);
            chatMemberService.addChatMember(chatMember);
        }
    }

    //@Test
    public void updateTest() throws Exception{
        ChatRoom chatRoom = chatRoomService.getChatRoom(1);

        chatRoom.setChatRoomTitle("update room");

        chatRoomService.updateChatRoom(chatRoom);
        System.out.println(chatRoomService.getChatRoom(1));
    }
    @Test
    public void deleteTest() throws Exception{
        chatRoomService.deleteChatRoom(5);
    }

    //@Test
    public void changeStatusTest() throws Exception{
        chatRoomService.changeRoomStatus(1,1);
    }
}
