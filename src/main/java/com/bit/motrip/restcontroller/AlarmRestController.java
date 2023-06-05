package com.bit.motrip.restcontroller;

import com.bit.motrip.domain.Alarm;
import com.bit.motrip.domain.User;
import com.bit.motrip.service.alarm.AlarmService;
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
    @PostMapping("getHoldAlarmList")
    public String getHoldAlarmList(HttpSession session,
                               @RequestParam(value = "currentPage", defaultValue = "1") int currentPage){
        System.out.println("레스트컨트롤러 getHoldAlarmList 동작");
        User user = (User) session.getAttribute("user");
        System.out.println("받은 유저아이디는"+user.getUserId());
        System.out.println("받은 currentPage는"+currentPage);

        List<Alarm> alarmList = alarmService.getHoldAlarmList(user.getUserId(), currentPage);
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
    @PostMapping("holdAlarm")
    public String holdAlarm(HttpSession session,
                            @RequestParam(value = "alarmNo") int alarmId){
        System.out.println("레스트컨트롤러 holdAlarm 동작");
        User user = (User) session.getAttribute("user");
        System.out.println("받은 유저아이디는"+user.getUserId());
        System.out.println("받은 alarmId는"+alarmId);

        alarmService.holdAlarm(alarmId);

        return "{ result: \"success\" }";
    }

//    @PostMapping("Alarm")

}
