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

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@CrossOrigin
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
    @GetMapping("chatRoomList")
    public String index(Model model) throws Exception{

        model.addAttribute("list",chatRoomService.chatRoomListPage());
        return "chatroom/chatRoomList2.jsp";
    }
    @PostMapping("chat")
    public String chat(@ModelAttribute("chatRoom") ChatRoom chatRoom,
                       @RequestParam("userId") String userId, Model model) throws Exception{
        ChatRoom ch = chatRoomService.getChatRoom(chatRoom.getChatRoomNo());
        System.out.println(ch);
        ChatMember author = chatMemberService.getChatMemberAuthor(chatRoom.getChatRoomNo());
        List<ChatMember> chatMemberList = chatMemberService.chatMemberList(chatRoom.getChatRoomNo());
        model.addAttribute("username",userId); //유저 name으로 userId 전송
        model.addAttribute("chatRoom",ch); //채팅방 객체 전송
        model.addAttribute("chatMembers",chatMemberList);
        model.addAttribute("author",author);
        System.out.println(chatRoom.getChatRoomNo());
        System.out.println(userId);
        System.out.println(author.getUserId());
        int flag = 0;
        //chatMemberService.getChatMember()
        for (ChatMember chm:chatMemberList) {
            if(chm.getUserId().equals(userId)){
                flag = 1;
                if(chm.getStatus() == 1 ){
                    flag = 2;
                }
            }
        }
        if(flag == 0){
            return "redirect:/chatRoom/chatRoomList";
        } else if (flag == 1) {
            return "chatroom/chatRoom.jsp";
        }else {
            return "redirect:/chatRoom/chatRoomList";
        }
    } // 채팅방
    //chatRoom/addChatRoom
    @GetMapping("addChatRoom")
    public String addChatRoom(@RequestParam("userId") String userId,Model model) throws Exception{
        System.out.println("/chatRoom/addChatRoom/GET");
        System.out.println(userId);
        model.addAttribute("userId",userId);
        return "chatroom/addChatRoom.jsp";
    }//채팅방 생성 페이지
    @PostMapping("addChatRoom")
    public String addChatRoom(@ModelAttribute("chatRoom") ChatRoom chatRoom,
                              @RequestParam("userId") String userId,
                              @RequestParam("tripPlanNo") int tripPlanNo,
                              @RequestParam("travelStartDateHtml") String travelStartDateHtml,
                              Model model) throws Exception{
        System.out.println("/chatRoom/addChatRoom/POST");
        System.out.println(travelStartDateHtml);
        //Date에 값 파싱해서 넣어주는 코드
        chatRoom.setTravelStartDate(new SimpleDateFormat("yyyy-MM-dd").parse(travelStartDateHtml));
        ChatRoom NewchatRoom = chatRoomService.getChatRoom(chatRoomService.addChatRoom(chatRoom,userId,tripPlanNo));
        model.addAttribute("chatRoom", NewchatRoom);
        model.addAttribute("chatMember",chatMemberService.getChatMember(NewchatRoom.getChatRoomNo()));
        return "chatroom/addChatRoomView.jsp";
    }//채팅방 생성 후

    @GetMapping("updateChatRoom")
    public String updateChatRoom(@RequestParam("chatRoomNo") int chatRoomNo,
                                 Model model) throws Exception{
        System.out.println("getUpdateChatRoom");
        model.addAttribute("chatRoom",chatRoomService.getChatRoom(chatRoomNo));
//        System.out.println(chatRoom);
//        model.addAttribute("chatRoom",chatRoom);
        //채팅방 이름 변경 x & 나이대,인원수,여행번호,날짜 변경 가능
        return "chatroom/updateChatRoom.jsp";
    }
    @PostMapping("updateChatRoom")
    public String updateChatRoom(@ModelAttribute("chatRoom") ChatRoom chatRoom,
                                 @RequestParam("travelStartDateHtml") String travelStartDateHtml,
                                 Model model) throws Exception{
        chatRoom.setTravelStartDate(new SimpleDateFormat("yyyy-MM-dd").parse(travelStartDateHtml));
        chatRoomService.updateChatRoom(chatRoom);
        //채팅방 이름 변경 x & 나이대,인원수,여행번호,날짜 변경 가능
        return "redirect:/chatRoom/chatRoomList";
    }

    @GetMapping("deleteChatRoom")
    public String deleteChatRoom(@RequestParam("userId") String userId,
                                  @RequestParam("chatRoomNo") int chatRoomNo ) throws Exception{
        //방장이고 채팅방 번호가 같다면 delete chatRoomNo => 멤버도 같이 삭제
        System.out.println("deleteChatRoomController");
        int flag = chatRoomService.deleteChatRoom(chatRoomNo,userId);
        if(flag == 1){
            System.out.println("success");
        }else{
            System.out.println("fail");
        }
        return "redirect:/chatRoom/chatRoomList";
    }


    // 완료 -> delete 완성 : 채팅방에 옮기기
    // 할 일--------------금----------------------------
    // 채팅방 -> update, ***kick  -> 오전
    // 멤버  -> 오후
    // chatRoomList -> 추가사항 적용해야 할 듯 ?
    // 사진 DB에 저장하기 (MYSQL) , 사진 불러오기 (MYSQL) !! 금방하고
    //--------------------토--------------------------
    // 추가 기능 > socket.io + webRTC 이용해서 음성채팅 구현
    // db에서 채팅방에 참여한 유저들 표시해주기
    // 현재 참여 유저 표시
    // 추가 기능 -> vision api 이용해서 검열하기


}// ChatRoomController 종료
