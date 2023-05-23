package com.bit.motrip.controller;

import com.bit.motrip.domain.ChatRoom;
import com.bit.motrip.service.chatroom.ChatMemberService;
import com.bit.motrip.service.chatroom.ChatRoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/chatRoom/*")
public class ChatRoomController {
    @Autowired
    @Qualifier("chatRoomServiceImpl")
    private ChatRoomService chatRoomService;
    @Autowired
    @Qualifier("chatMemberServiceImpl")
    private ChatMemberService chatMemberService;

    public ChatRoomController(){
        System.out.println("==> ChatRoomController default Constructor call....");
    }//chatroom 생성자
    //chatRoom/addChatRoom
    @GetMapping("addChatRoom")
    public String addChatRoom() throws Exception{
        System.out.println("/chatRoom/addChatRoom/GET");
        return "forward:addChatRoom";
    }//채팅방 생성 페이지

    @PostMapping("addChatRoom")
    public String addChatRoom(@ModelAttribute("chatRoom") ChatRoom chatRoom,
                              @RequestParam("userId") String userId,
                              @RequestParam("tripPlanNo") int tripPlanNo,
                              Model model) throws Exception{
        System.out.println("/chatRoom/addChatRoom/POST");
        ChatRoom NewchatRoom = chatRoomService.getChatRoom(chatRoomService.addChatRoom(chatRoom,userId,tripPlanNo));
        model.addAttribute("chatRoom", NewchatRoom);
        model.addAttribute("chatMember",chatMemberService.getChatMember(NewchatRoom.getChatRoomNo()));
        return "/jsp/chatroom/addChatRoomView";
    }//채팅방 생성 후



}// ChatRoomController 종료
