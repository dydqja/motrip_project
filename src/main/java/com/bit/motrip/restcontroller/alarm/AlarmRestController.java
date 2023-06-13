package com.bit.motrip.restcontroller.alarm;

import com.bit.motrip.domain.Alarm;
import com.bit.motrip.domain.ChatMember;
import com.bit.motrip.domain.ChatRoom;
import com.bit.motrip.domain.User;
import com.bit.motrip.service.alarm.AlarmService;
import com.bit.motrip.service.chatroom.ChatMemberService;
import com.bit.motrip.service.chatroom.ChatRoomService;
import com.bit.motrip.service.user.UserService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/alarm/*")
public class AlarmRestController {
    //Constructor wiring
    public AlarmRestController(AlarmService alarmService, ChatMemberService chatMemberService, ChatRoomService chatRoomService, UserService userService) {
        this.alarmService = alarmService;
        this.chatMemberService = chatMemberService;
        this.chatRoomService = chatRoomService;
        this.userService = userService;
    }
    //Field
    private final AlarmService alarmService;

    private final ChatMemberService chatMemberService;
    private final ChatRoomService chatRoomService;
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final UserService userService;
    private final String successJson = "{ \"result\": \"success\" }";
    private final String failJson = "{ \"result\": \"fail\" }";

    //Method

    @PostMapping("getUnreadAlarmCount")
    public String getUnreadAlarmCount(HttpSession session){
        System.out.println("레스트컨트롤러 getUnreadAlarmCount 동작");
        User user = (User) session.getAttribute("user");
        System.out.println("받은 유저아이디는"+user.getUserId());

        int unreadCount = alarmService.getUnreadAlarmCount(user.getUserId());

        //JSON 변환부
        ObjectMapper objectMapper = new ObjectMapper();
        String unreadCountJson = "";
        try {
            unreadCountJson = objectMapper.writeValueAsString(unreadCount);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
        return unreadCountJson;
    }

    @PostMapping("getAlarmList")
    public String getAlarmList(HttpSession session,
                               @RequestParam(value = "currentPage", defaultValue = "1") int currentPage){
        System.out.println("레스트컨트롤러 getAlarmList 동작");
        User user = (User) session.getAttribute("user");
        System.out.println("받은 유저아이디는"+user.getUserId());
        System.out.println("받은 currentPage는"+currentPage);

        List<Alarm> alarmList = alarmService.getAlarmList(user.getUserId(), currentPage);
        //for 문으로 내부 데이터를 출력한다.
        for (Alarm alarm : alarmList){
            System.out.println(alarm.getAlarmTitle());
        }

        //JSON 변환부
        ObjectMapper objectMapper = new ObjectMapper();
        String alarmListJson = "";
        try {
            alarmListJson = objectMapper.writeValueAsString(alarmList);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
        return alarmListJson;
    }

    @PostMapping("readAlarm")
    public String readAlarm(HttpSession session,
                            @RequestParam(value = "alarmNo") int alarmId){
        System.out.println("레스트컨트롤러 readAlarm 동작");
        User user = (User) session.getAttribute("user");
        System.out.println("받은 유저아이디는"+user.getUserId());
        System.out.println("받은 alarmId는"+alarmId);

        alarmService.readAlarm(alarmId);

        return "{ result: \"success\" }";
    }

    @GetMapping("acceptChatRoomMember/{chatRoomNo}/{userId}/{tripPlanNo}")
    public String acceptChatRoomMember(
            @PathVariable int chatRoomNo,
            @PathVariable String userId,
            @PathVariable int tripPlanNo
    ) throws Exception {
        System.out.println("레스트컨트롤러 acceptChatRoomMember 동작");
        //debug
        System.out.println("GET : acceptMember");
        System.out.println("받은 방번호"+chatRoomNo);
        System.out.println("받은 아이디"+userId);
        System.out.println("받은 트립플랜번호"+tripPlanNo);

        //채팅방에 참가신청한 사람을 채팅방에 추가한다.
        ChatMember chatMember = new ChatMember();
        chatMember.setChatRoomNo(chatRoomNo);
        chatMember.setUserId(userId);
        chatMember.setTripPlanNo(tripPlanNo);

        try {
            chatMemberService.addChatMember(chatMember);
        }catch (Exception e) {
            e.printStackTrace();
            System.out.println("채팅방에 참가신청한 사람을 채팅방에 추가하는데 실패했습니다.");
            return failJson;
        }
        /*수락한 뒤 신청자에게 알람을 보내는 로직 추가*/

        //알람을 받을 사람.
        User fakeSender = new User();
        User receiver = userService.getUserById(userId);
        //채팅방 이름
        ChatRoom chatRoom = chatRoomService.getChatRoom(chatRoomNo);
        String chatRoomTitle = chatRoom.getChatRoomTitle();

        //알람 내용
        String contents = receiver.getNickname()+"님, "+chatRoomTitle + "에 참가 신청이 수락되었습니다. 지금 바로 참가하실 수 있습니다.";
        //알람 제목
        String title = chatRoomTitle+"에 참가 신청이 수락되었습니다.";
        //naviUrl
        String naviUrl = "/chatRoom/getChat?chatRoomNo="+chatRoomNo+"&userId="+userId;
        alarmService.addNavigateAlarm(fakeSender, receiver, title, contents, naviUrl);

        System.out.println("successJson 을 리턴함.");
        return successJson;
    }

}
