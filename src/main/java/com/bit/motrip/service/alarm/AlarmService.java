package com.bit.motrip.service.alarm;

import com.bit.motrip.domain.Alarm;

import java.util.Map;

public interface AlarmService {
    public int addAlarm(Alarm alarm); //알람을 추가하고 success 여부만 반환한다.
    public int deleteAlarm(int alarmNo); //알람을 삭제 대기 상태로 한다. readDate를 업데이트하는 작업이다.
    public int removeAlarm(int alarmNo); //알람을 진짜 지우는 작업이다.
    public Alarm getAlarm(int alarmNo); //알람의 상세 내역을 조회하는 작업이다.
    public Map<String,Object> getAlarmListCount(String userId); //알람의 목록을 만들어 화면에 던져주는 작업이다.

    //sse
}
