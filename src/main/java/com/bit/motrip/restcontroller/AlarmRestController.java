package com.bit.motrip.restcontroller;

import com.bit.motrip.domain.User;
import com.bit.motrip.service.alarm.AlarmService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;

@CrossOrigin
@RestController
@RequestMapping("/alarm/*")
public class AlarmRestController {
    //Constructor wiring
    public AlarmRestController(AlarmService alarmService) {
        this.alarmService = alarmService;
    }
    //Field
    private final AlarmService alarmService;

    //Method
    @PostMapping("addAlarmTest")
    public String addAlarmTest(HttpSession session){
        System.out.println("레스트컨트롤러 addAlarmTest 동작");
        User user = (User) session.getAttribute("user");
        System.out.println("받은 유저아이디는"+user.getUserId());
        User user2 = new User();
        user.setUserId("user2");
        user.setNickname("user2");

        alarmService.addAcceptableAlarm(user2, user, "알람테스트1", "알람을 테스트합니다.", "acceptUrl", "rejectUrl");

        return "{ result: \"success\" }";
    }
    @PostMapping("addAlarmTest2")
    public String addAlarmTest2(HttpSession session){
        System.out.println("레스트컨트롤러 addAlarmTest2 동작");
        User user = (User) session.getAttribute("user");
        System.out.println("받은 유저아이디는"+user.getUserId());
        User user2 = new User();
        user.setUserId("user1");
        user.setNickname("user1");

        alarmService.addNavigateAlarm(user2, user, "알람테스트2", "알람을 테스트합니다.", "navigateUrl");
        return "{ result: \"success\" }";
    }
    @PostMapping("addAlarmTest3")
    public String addAlarmTest3(HttpSession session){
        System.out.println("레스트컨트롤러 addAlarmTest3 동작");
        User user = (User) session.getAttribute("user");
        System.out.println("받은 유저아이디는"+user.getUserId());
        User user2 = new User();
        user.setUserId("admin");
        user.setNickname("admin");

        alarmService.addConfirmAlarm(user2, user, "알람테스트3", "알람을 테스트합니다.");
        return "{ result: \"success\" }";
    }

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
}
