package com.bit.motrip.controller.chatroom;

import com.bit.motrip.domain.ChatMember;
import com.bit.motrip.domain.ChatRoom;
import com.bit.motrip.service.chatroom.ChatMemberService;
import com.bit.motrip.service.chatroom.ChatRoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/chatMember/*")
public class ChatMemberController {
    @Autowired
    @Qualifier("chatRoomServiceImpl")
    private ChatRoomService chatRoomService;
    @Autowired
    @Qualifier("chatMemberServiceImpl")
    private ChatMemberService chatMemberService;

    @PostMapping("joinChatRoom")
    public String joinChatRoom(@ModelAttribute("chatMember") ChatMember chatMember,
                               Model model) throws Exception{
        System.out.println(chatMember); // ***(userId, chatroomNo) + Tripplanno
        ChatRoom chatRoom = chatRoomService.getChatRoom(chatMember.getChatRoomNo()); //chatroomno => chatroom
        chatMember.setTripPlanNo(chatRoom.getTripPlanNo()); // chatroom => gettripplanno => chatmember에 삽입
        System.out.println(chatMember); //
        chatMemberService.addChatMember(chatMember);
        return "redirect:/chatRoom/chatRoomList";
    }

    @GetMapping("outMember")
    public String outMember(@ModelAttribute("chatMember") ChatMember chatMember) throws Exception{
        System.out.println("outMember");

        chatMemberService.deleteChatMember(chatMember.getChatRoomNo(),chatMember.getUserId());
        return "redirect:/chatRoom/chatRoomList";
    }

}
