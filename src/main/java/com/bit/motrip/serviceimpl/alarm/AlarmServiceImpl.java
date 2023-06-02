package com.bit.motrip.serviceimpl.alarm;

import com.bit.motrip.domain.Alarm;
import com.bit.motrip.service.alarm.AlarmService;

import java.util.List;
import java.util.Map;

public class AlarmServiceImpl implements AlarmService {

    @Override
    public int addAlarm(Alarm alarm) {

        return 0;
    }

    @Override
    public int deleteAlarm(int alarmNo) {


        return 0;
    }

    @Override
    public int removeAlarm(int alarmNo) {
        return 0;
    }

    @Override
    public Alarm getAlarm(int alarmNo) {
        return null;
    }

    @Override
    public List<Alarm> getAlarmList(String userId) {
        return null;
    }

    @Override
    public Alarm getEmergencyAlarm(String userId) {
        return null;
    }

    @Override
    public Map<String, Object> getAlarmListCount(String userId) {
        return null;
    }
}
