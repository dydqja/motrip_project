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
            System.out.println("receiver = "+receiver.getUserId());
            //보낼사람
            User sender = userService.getUserById(chatMember.getUserId());
            System.out.println("sender = "+sender.getUserId());
            //알람 내용
            String content = sender.getNickname() + "님이 " + chatRoom.getChatRoomTitle() + "에 참가 신청합니다.";
            //알람 제목
            String title = chatRoom.getChatRoomTitle()+"에 참가 신청이 있습니다.";
            //acceptUrl
            String acceptUrl = "/alarm/acceptChatRoomMember/"+chatRoomNo+"/"+sender.getUserId()+"/"+tripPlanNo;
            //rejectUrl
            String rejectUrl = "/alarm/rejectChatRoomMember/"+chatRoomNo+"/"+sender.getUserId()+"/"+tripPlanNo;
            alarmService.addAcceptableAlarm(sender,receiver, content, title, acceptUrl, rejectUrl);

        System.out.println(chatMember); //
//        chatMemberService.addChatMember(chatMember);
        return "redirect:/chatRoom/chatRoomList";
    }










    @GetMapping("outMember")
    public String outMember(@ModelAttribute("chatMember") ChatMember chatMember) throws Exception{
        System.out.println("outMember");

        chatMemberService.deleteChatMember(chatMember.getChatRoomNo(),chatMember.getUserId());
        return "redirect:/chatRoom/chatRoomList";
    }

}
