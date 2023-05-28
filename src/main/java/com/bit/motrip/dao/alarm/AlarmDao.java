package com.bit.motrip.dao.alarm;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.Alarm;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface AlarmDao {
    public int addAlarm(Alarm alarm); //알람을 추가하고 success 여부만 반환한다.
    public int deleteAlarm(int alarmNo); //알람을 삭제 대기 상태로 한다. readDate를 업데이트하는 작업이다.
    public int removeAlarm(int alarmNo); //알람을 진짜 지우는 작업이다.

    public Alarm getAlarm(int alarmNo); //알람의 상세 내역을 조회하는 작업이다.
    public List<Alarm> getAlarmList(Search search);
    //알람의 목록을 만들어 화면에 던져주는 작업이다.
    //key에는 count 와 alarmList를 쓸 것이다.
    //count 에는 Integer 로 된 알람의 총 개수를 넣는다.
    //unread 에는 Integer 로 된 '안 읽은 알람'의 총 개수를 넣는다.
    //alarmList에는 List<Alarm> 으로 이번 페이지의 알람을 실어 넣을 것이다.

    //search 에는 검색 조건으로 사용될 유저의 Id와 커런트 페이지, 페이지 유닛과 페이지 사이즈 정보가 들어있다.

}
