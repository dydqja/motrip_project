package com.bit.motrip.service.alarm;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.Alarm;
import com.bit.motrip.domain.User;

import java.util.List;
import java.util.Map;

public interface AlarmService {
    public int addConfirmAlarm(User sender, User receiver, String alarmTitle, String alarmContents); //알람을 추가하고 success 여부만 반환한다.
    public int addAcceptableAlarm(User sender, User receiver, String alarmTitle, String alarmContents, String acceptUrl, String rejectUrl); //알람을 추가하고 success 여부만 반환한다.
    public int addNavigateAlarm(User sender, User receiver, String alarmTitle, String alarmContents, String navigateUrl); //알람을 추가하고 success 여부만 반환한다.

    public int readAlarm(int alarmNo); //알람을 삭제 대기 상태로 한다. readDate를 업데이트하는 작업이다.

    public int holdAlarm(int alarmNo); //알람을 보류 상태로 한다.

    public int removeAlarm(int alarmNo); //알람을 진짜 지우는 작업이다.
    public List<Alarm> getAlarmList(Search search); //알람의 목록을 만들어 화면에 던져주는 작업이다.
    public Alarm getEmergencyAlarm(String userId); //긴급 알람을 조회하는 작업이다.

    public int getUnreadAlarms(String userId);

    //sse
}
