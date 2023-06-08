package com.bit.motrip.controller.chatroom;

import com.bit.motrip.domain.ChatMember;
import com.bit.motrip.domain.ChatRoom;
import com.bit.motrip.domain.User;
import com.bit.motrip.service.alarm.AlarmService;
import com.bit.motrip.service.chatroom.ChatMemberService;
import com.bit.motrip.service.chatroom.ChatRoomService;
import com.bit.motrip.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/chatMember/*")
public class ChatMemberController {
    @Autowired
    @Qualifier("chatRoomServiceImpl")
    private ChatRoomService chatRoomService;
    @Autowired
    @Qualifier("chatMemberServiceImpl")
    private ChatMemberService chatMemberService;


    @Autowired
    @Qualifier("alarmServiceImpl")
    private AlarmService alarmService;
    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

    @PostMapping("joinChatRoom")
    public String joinChatRoom(@ModelAttribute("chatMember") ChatMember chatMember,
                               Model model) throws Exception{
        System.out.println(chatMember); // ***(userId, chatroomNo) + Tripplanno
        ChatRoom chatRoom = chatRoomService.getChatRoom(chatMember.getChatRoomNo()); //chatroomno => chatroom
        chatMember.setTripPlanNo(chatRoom.getTripPlanNo()); // chatroom => gettripplanno => chatmember에 삽입


            //받을 사람 확보
            //챗룸 번호
            int chatRoomNo = chatRoom.getChatRoomNo();
            //챗룸 방장을 가져옴
            ChatMember author = chatMemberService.getChatMemberAuthor(chatRoomNo);
            //챗룸 방장의 유저아이디를 가져옴
            String authorId = author.getUserId();
            //트립플랜번호
            int tripPlanNo = chatRoom.getTripPlanNo();

            //받을사람
            User receiver = userService.getUserById(authorId);
            //보낼사람
            User sender = userService.getUserById(chatMember.getUserId());
            //알람 내용
            String content = sender.getNickname() + "님이 " + chatRoom.getChatRoomTitle() + "에 참가 신청합니다.";
            //알람 제목
            String title = chatRoom.getChatRoomTitle()+"에 참가 신청이 있습니다.";
            //acceptUrl
            String acceptUrl = "/chatMember/acceptMember/"+chatRoomNo+"/"+sender.getUserId()+"/"+tripPlanNo;
            //rejectUrl
            String rejectUrl = "/미구현";
            alarmService.addAcceptableAlarm(receiver, sender, content, title, acceptUrl, rejectUrl);

        System.out.println(chatMember); //
//        chatMemberService.addChatMember(chatMember);
        return "redirect:/chatRoom/chatRoomList";
    }

    @GetMapping(value = "acceptMember/{chatRoomNo}/{userId}/{tripPlanNo}")
    public String acceptMember(
            @PathVariable int chatRoomNo,
            @PathVariable String userId,
            @PathVariable int tripPlanNo
            ) throws Exception {
        System.out.println("GET : acceptMember");
        System.out.println("받은 방번호"+chatRoomNo);
        System.out.println("받은 아이디"+userId);
        System.out.println("받은 트립플랜번호"+tripPlanNo);

        ChatMember chatMember = new ChatMember();
        chatMember.setChatRoomNo(chatRoomNo);
        chatMember.setUserId(userId);
        chatMember.setTripPlanNo(tripPlanNo);

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
