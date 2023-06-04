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
    String AlarmTitle = "알람 제목";
    String AlarmContents = "알람 내용";

    String AccepUrl = "http://localhost:8080/accept";
    String RejectUrl = "http://localhost:8080/reject";


    @Test
    void addConfirmAlarm() {
        int result = alarmService.addConfirmAlarm(sender, receiver, AlarmTitle, AlarmContents);
        assertEquals(1, result);
    }

    @Test
    void addAcceptableAlarm() {
        int result = alarmService.addAcceptableAlarm(sender, receiver, AlarmTitle, AlarmContents,AccepUrl,RejectUrl);
        assertEquals(1, result);
    }
    @Test
    void addNavigateAlarm() {
        int result = alarmService.addNavigateAlarm(sender, receiver,AlarmTitle,AlarmContents ,AccepUrl);
        assertEquals(1, result);
    }
    @Test
    void removeAlarm() {
        int result = alarmService.removeAlarm(1);
        assertEquals(1, result);
    }
    @Test
    void readAlarm() {
        int result = alarmService.readAlarm(3);
        assertEquals(1, result);
    }
    @Test
    void holdAlarm() {
        int result = alarmService.holdAlarm(2);
        assertEquals(1, result);
    }
    @Test
    void getUnreadAlarmCount() {
        int result = alarmService.getUnreadAlarmCount("user2");
        System.out.println("안읽은 알람 수는"+result);
    }
    @Test
    void getAlarmList(){
        List<Alarm> alarmList = alarmService.getAlarmList("user2",2);
        for (Alarm alarm: alarmList) {
            System.out.println("알람은"+alarm.toString());
        }
    }



}