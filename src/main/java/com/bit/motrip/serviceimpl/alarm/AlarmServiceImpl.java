package com.bit.motrip.serviceimpl.alarm;

import com.bit.motrip.common.Search;
import com.bit.motrip.dao.alarm.AlarmDao;
import com.bit.motrip.domain.Alarm;
import com.bit.motrip.domain.User;
import com.bit.motrip.service.alarm.AlarmService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class AlarmServiceImpl implements AlarmService {

    //Const inject
    public AlarmServiceImpl(AlarmDao alarmDao) {
        this.alarmDao = alarmDao;
    }

    //Field
    private final AlarmDao alarmDao;



    @Override
    public int addConfirmAlarm(User sender, User receiver, String alarmTitle, String alarmContents) {
        Alarm alarm = new Alarm();
        alarm.setAlarmCategory("1");
        alarm.setAlarmLevel("1");
        alarm.setAlarmTitle(alarmTitle);
        alarm.setAlarmContents(alarmContents);
        alarm.setAlarmReceiver(receiver.getUserId());
        alarm.setAlarmReceiverNick(receiver.getNickname());
        alarm.setAlarmSender(sender.getUserId());
        alarm.setAlarmSenderNick(sender.getNickname());

        int isSuccess=0;
        try {
            //알람 추가 시도해본다.
            isSuccess = alarmDao.addAlarm(alarm);
            //알람추가에 실패했다면 익셉션 발생
            if(isSuccess!=1){
                throw new Exception("AlarmServiceImpl:확인알람 추가 실패");
            }
            //알람추가에 성공했으니 성공 여부 반환
            return isSuccess;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int addAcceptableAlarm(User sender, User receiver, String alarmTitle, String alarmContents, String acceptUrl, String rejectUrl) {
        Alarm alarm = new Alarm();
        alarm.setAlarmCategory("3");
        alarm.setAlarmTitle(alarmTitle);
        alarm.setAlarmContents(alarmContents);
        alarm.setAlarmReceiver(receiver.getUserId());
        alarm.setAlarmReceiverNick(receiver.getNickname());
        alarm.setAlarmSender(sender.getUserId());
        alarm.setAlarmSenderNick(sender.getNickname());
        alarm.setAlarmAcceptUrl(acceptUrl);

        int isSuccess=0;
        try {
            //알람 추가 시도해본다.
            isSuccess = alarmDao.addAlarm(alarm);
            //알람추가에 실패했다면 익셉션 발생
            if(isSuccess!=1){
                throw new Exception("AlarmServiceImpl:수락/거절 알람 추가 실패");
            }
            //알람추가에 성공했으니 성공 여부 반환
            return isSuccess;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }


    @Override
    public int addNavigateAlarm(User sender, User receiver, String alarmTitle, String alarmContents, String navigateUrl) {
        Alarm alarm = new Alarm();
        alarm.setAlarmCategory("2");
        alarm.setAlarmTitle(alarmTitle);
        alarm.setAlarmContents(alarmContents);
        alarm.setAlarmReceiver(receiver.getUserId());
        alarm.setAlarmReceiverNick(receiver.getNickname());
        alarm.setAlarmSender(sender.getUserId());
        alarm.setAlarmSenderNick(sender.getNickname());
        alarm.setAlarmNaviUrl(navigateUrl);

        int isSuccess=0;
        try {
            //알람 추가 시도해본다.
            isSuccess = alarmDao.addAlarm(alarm);
            //알람추가에 실패했다면 익셉션 발생
            if(isSuccess!=1){
                throw new Exception("AlarmServiceImpl:네비알람 추가 실패");
            }
            //알람추가에 성공했으니 성공 여부 반환
            return isSuccess;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }

    }



    @Override
    public int readAlarm(int alarmNo) {
        int isSuccess=0;
        try{
            isSuccess = alarmDao.deleteAlarm(alarmNo);
            if(isSuccess!=1){
                throw new Exception("AlarmServiceImpl:알람 읽음처리 실패");
            }
            return isSuccess;
        } catch (Exception e){
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int holdAlarm(int alarmNo) {
        int alarmLevel = 3;
        int isSuccess = 0;
        try{
            isSuccess = alarmDao.updateAlarm(alarmNo, alarmLevel);
            if(isSuccess!=1){
                throw new Exception("AlarmServiceImpl:알람 보류처리 실패");
            }
            return isSuccess;
        } catch (Exception e){
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int removeAlarm(int alarmNo) {
        int isSuccess=0;
        try{
            isSuccess = alarmDao.deleteAlarm(alarmNo);
            if(isSuccess!=1){
                throw new Exception("AlarmServiceImpl:알람 영구삭제 실패");
            }
            return isSuccess;
        } catch (Exception e){
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public List<Alarm> getAlarmList(Search search) {
        alarmDao.getAlarmList(search);
        return null;
    }

    @Override
    public Alarm getEmergencyAlarm(String userId) {
        return null;
    }

    @Override
    public int getUnreadAlarms(String userId) {
        return 0;
    }
}
