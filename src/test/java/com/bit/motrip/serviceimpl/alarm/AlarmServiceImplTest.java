package com.bit.motrip.serviceimpl.alarm;

import com.bit.motrip.domain.SmsMessage;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class AlarmServiceImplTest {

    //constructor
    //field
    @Autowired
    private AlarmServiceImpl alarmService;
    @Test
    void sendSms() throws Exception {
        alarmService.sendSms(new SmsMessage("01077433465"), "안녕하세요");
    }
}