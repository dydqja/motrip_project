package com.bit.motrip.chatroom;

import com.bit.motrip.domain.ChatRoom;
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

  //  @Test
    public void getTest() throws Exception{
        ChatRoom chatRoom = chatRoomService.getChatRoom(1);
        System.out.println(chatRoom);
    }

    //@Test
    public void addTest() throws Exception{
        ChatRoom chatRoom = new ChatRoom();
        Date currentDate = new Date();

        chatRoom.setChatRoomTitle("test room");
        chatRoom.setTravelStartDate(currentDate);
        chatRoom.setAgeRange("30-39");
        chatRoom.setMaxPersons(4);
        chatRoom.setCurrentPersons(0);
        chatRoomService.addChatRoom(chatRoom);
    }

    //@Test
    public void updateTest() throws Exception{
        ChatRoom chatRoom = chatRoomService.getChatRoom(1);

        chatRoom.setChatRoomTitle("update room");

        chatRoomService.updateChatRoom(chatRoom);
        System.out.println(chatRoomService.getChatRoom(1));
    }

    //@Test
    public void deleteTest() throws Exception{
        chatRoomService.deleteChatRoom(4);
    }
}
