package com.bit.motrip.dao.alarm;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.Alarm;
import com.bit.motrip.domain.Memo;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class AlarmDaoTest {

    //Field
    @Autowired
    private AlarmDao alarmDao;

    //@Test
    void addAlarm() {
        Alarm newAlarm = new Alarm();
        newAlarm.setAlarmTitle("알람 제목");
        newAlarm.setAlarmContents("알람 내용");
        newAlarm.setAlarmSender("admin");
        newAlarm.setAlarmReceiver("user1");
        newAlarm.setAlarmUriOne("uri1");
        newAlarm.setAlarmUriTwo("uri2");
        newAlarm.setAlarmUriThree("uri3");
        newAlarm.setAlarmBtnOne("btn1");
        newAlarm.setAlarmBtnTwo("btn2");
        newAlarm.setAlarmBtnThree("btn3");
        System.out.println("추가할 알람의 내용 "+newAlarm.toString());
        int isSuccess = alarmDao.addAlarm(newAlarm);
        System.out.println("추가된 알람의 내용"+newAlarm.toString());
        System.out.printf("성공 여부 : "+isSuccess);
    }

   // @Test
    void deleteAlarm() {
        int alarmNo = 2;
        int isSuccess = alarmDao.deleteAlarm(alarmNo);
        System.out.printf("성공 여부 : "+isSuccess);
    }
  //  @Test
    void removeAlarm() {
        int alarmNo = 2;
        int isSuccess = alarmDao.removeAlarm(alarmNo);
        System.out.printf("성공 여부 : "+isSuccess);
    }
   // @Test
    void getAlarm() {
        int alarmNo = 3;
        Alarm alarm = alarmDao.getAlarm(alarmNo);
        System.out.println("조회된 알람의 내용"+alarm.toString());
    }
   // @Test
    void getAlarmList() {
        //search 에는 검색 조건으로 사용될 유저의 Id와 커런트 페이지, 페이지 유닛과 페이지 사이즈 정보가 들어있다.
        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(10);
        search.setSearchKeyword("user1");

        System.out.println("시작행"+search.getStartRowNum());
        System.out.println("종료행"+search.getEndRowNum());
        System.out.println("검색어"+search.getSearchKeyword());

        //검색 조건에 맞는 알람 리스트를 가져온다.
        //목록 실행부
        List<Alarm> alarmList = alarmDao.getAlarmList(search);
        for(Alarm alarm : alarmList){
            System.out.println(alarm);
        }
    }

}