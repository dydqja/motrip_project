package com.bit.motrip.service.alarm;

import com.bit.motrip.domain.Alarm;
import com.bit.motrip.domain.User;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class AlarmServiceTest {

    @Autowired
    AlarmService alarmService;

    User sender = new User("user1","유저1");
    User receiver = new User("user2","유저2");
    User admin = new User("admin","관리자");
    String AlarmTitle = "알람 제목";
    String AlarmContents = "알람 내용";

    String AcceptUrl = "/test/accept";
    String RejectUrl = "/test/reject";


    //@Test
    void addConfirmAlarm() {
        int result = alarmService.addConfirmAlarm(admin, receiver, "3일 이용 정지 통지", "유저2님께서는 6월 6일 00시부터 3일간 이용이 정지됩니다. 이용 정지 사유:부적절한 게시글 작성");
        assertEquals(1, result);
    }

    //@Test
    void addAcceptableAlarm() {
        int result = alarmService.addAcceptableAlarm(sender, receiver, "[7월 독도 여행방] 참가 요청", "유저1님이 [7월 독도 여행방에 참가를 요청했습니다.]", AcceptUrl,RejectUrl);
        assertEquals(1, result);
    }
    //@Test
    void addNavigateAlarm() {
        int result = alarmService.addNavigateAlarm(sender, receiver,"[12월 ㅁㅁ파크 하루종일 스키타실분] 참가 수락.","[12월 ㅁㅁ파크 하루종일 스키타실분] 방에 참가하실 수 있습니다. 바로 이동하시겠습니까?", AcceptUrl);
        assertEquals(1, result);
    }
   // @Test
    void removeAlarm() {
        int result = alarmService.removeAlarm(1);
        assertEquals(1, result);
    }
   // @Test
    void readAlarm() {
        int result = alarmService.readAlarm(3);
        assertEquals(1, result);
    }
  //  @Test
    void holdAlarm() {
        int result = alarmService.holdAlarm(2);
        assertEquals(1, result);
    }
  //  @Test
    void getUnreadAlarmCount() {
        int result = alarmService.getUnreadAlarmCount("user2");
        System.out.println("안읽은 알람 수는"+result);
    }
   // @Test
    void getAlarmList(){
        List<Alarm> alarmList = alarmService.getAlarmList("user2",2);
        for (Alarm alarm: alarmList) {
            System.out.println("알람은"+alarm.toString());
        }
    }



}