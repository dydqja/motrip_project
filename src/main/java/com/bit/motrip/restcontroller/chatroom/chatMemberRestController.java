package com.bit.motrip.restcontroller.chatroom;

import com.bit.motrip.domain.ChatMember;
import com.bit.motrip.service.chatroom.ChatMemberService;
import com.bit.motrip.service.chatroom.ChatRoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@RestController
@RequestMapping("/chatMember/*")
public class chatMemberRestController {

    @Autowired
    @Qualifier("chatMemberServiceImpl")
    private ChatMemberService chatMemberService;
    public chatMemberRestController() {
        System.out.println(this.getClass());
    }


//    @RequestMapping(value = "/json/kickMember", method = RequestMethod.GET)
//    public void kickChatMember(@RequestParam("chatRoomNo") int chatRoomNo,
//                               @RequestParam("userId") String userId) throws Exception {
//        // 메서드 내용
//        System.out.println("GET : json/kickMember");
//        System.out.println("Chat Room No: " + chatRoomNo);
//        System.out.println("User ID: " + userId);
//
//        chatMemberService.kickChatMember(chatRoomNo, userId, true);
//    }
    @RequestMapping(value = "/json/kickMember", method = RequestMethod.POST)
    @ResponseBody
    public void  kickChatMember(@RequestBody ChatMember request) throws Exception {

            chatMemberService.kickChatMember(request.getChatRoomNo(), request.getUserId(), true);


    }

    @RequestMapping(value="json/fetchChatMembers/{chatRoomNo}" , method=RequestMethod.GET )
    public List<ChatMember> fetchChatMembers(@PathVariable int chatRoomNo) throws Exception {
        // 메서드 내용
        System.out.println("GET : json/fetchChatMembers");
        System.out.println(chatRoomNo);
        return chatMemberService.chatMemberList(chatRoomNo);
    }

}
