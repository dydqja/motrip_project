package com.bit.motrip.controller;

import com.bit.motrip.domain.ChatRoom;
import com.bit.motrip.service.chatroom.ChatMemberService;
import com.bit.motrip.service.chatroom.ChatRoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
    @RequestMapping(value = "addChatRoom", method = RequestMethod.GET)
    public String addChatRoom() throws Exception{
        System.out.println("/chatRoom/addChatRoom/GET");
        return "/jsp/chatroom/addChatRoom";
    }//채팅방 생성 페이지

    @RequestMapping(value = "addChatRoom", method = RequestMethod.POST)
    public String addChatRoom(@ModelAttribute("chatRoom") ChatRoom chatRoom,
                              @RequestParam("userId") String userId,
                              @RequestParam("tripPlanNo") int tripPlanNo) throws Exception{
        System.out.println("/chatRoom/addChatRoom/POST");
        chatRoomService.addChatRoom(chatRoom,userId,tripPlanNo);
        return "/jsp/chatroom/addChatRoomView";
    }//채팅방 생성 후



}// ChatRoomController 종료
