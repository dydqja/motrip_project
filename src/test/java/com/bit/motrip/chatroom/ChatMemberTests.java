package com.bit.motrip.chatroom;

import com.bit.motrip.domain.ChatMember;
import com.bit.motrip.service.chatroom.ChatMemberService;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@SpringBootTest
public class ChatMemberTests {
    @Autowired
    @Qualifier("chatMemberServiceImpl")
    private ChatMemberService chatMemberService;
    @Test
    public void addTest() throws Exception{
        ChatMember chatMember = new ChatMember();
        chatMember.setChatRoomNo(1);
        chatMember.setUserId("user101");
        chatMember.setTripPlanNo(2);
        chatMember.setChatRoomAuthor(false);
        chatMemberService.addChatMember(chatMember);
    }
   // @Test
    public void getTest() throws Exception{
        ChatMember testChatMember = chatMemberService.getChatMember(1);
        System.out.println(testChatMember);
        Assertions.assertEquals(1,testChatMember.getMemberNo());
        Assertions.assertEquals(1,testChatMember.getChatRoomNo());
        Assertions.assertEquals(2,testChatMember.getTripPlanNo());
        Assertions.assertEquals(true,testChatMember.isChatRoomAuthor());
        Assertions.assertEquals("user1",testChatMember.getUserId());
    }

    //@Test
    public void deleteTest() throws Exception{
        chatMemberService.deleteChatMember(1,"user101");
    }

    //@Test
    public void outTest() throws Exception{//강퇴
        chatMemberService.outChatMember(1,"user2",true);
    }

    //@Test
    public void listTest() throws Exception{
        List<ChatMember> testList = chatMemberService.chatMemberList(1);
        for (ChatMember cm : testList) {
            System.out.println(cm);
        }
    }

}
