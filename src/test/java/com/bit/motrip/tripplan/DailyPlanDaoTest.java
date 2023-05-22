package com.bit.motrip.tripplan;

import com.bit.motrip.domain.DailyPlan;
import com.bit.motrip.service.tripplan.DailyPlanService;
import com.bit.motrip.service.tripplan.TripPlanService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class DailyPlanDaoTest {

    @Autowired
    @Qualifier("dailyPlanServiceImpl")
    private DailyPlanService dailyPlanService;

    //@Test //일차별 여행플랜 하루씩 저장 테스트
    public void addDailyPlan() throws Exception{
        DailyPlan dailyPlan = new DailyPlan();
        int tripPlanNo = 2;

        dailyPlan.setTripPlanNo(tripPlanNo);
        dailyPlan.setDailyPlanContents("모트립 단일인입조 화이팅");
        dailyPlan.setTotalTripTime(null);
        dailyPlanService.addDailyPlan(dailyPlan);
    }

    //@Test //가장 최근에 저장된 일차별 여행플랜 저장번호 확인
    public void getDailyPlan() throws Exception {
        int dailyPlanNo = dailyPlanService.getDailyPlan();
        System.out.println(dailyPlanNo);
    }

    //@Test
    public void getDailyPlanList() throws Exception{
        List<DailyPlan> dailyPlan = new ArrayList<DailyPlan>();
        dailyPlan = dailyPlanService.selectDailyPlan(2);
        for (DailyPlan daily : dailyPlan) {
            System.out.println("----------------------------");
            System.out.println("dailyPlan 플랜번호: " + daily.getDailyPlanNo());
            System.out.println("dailyPlan TripPlan번호: " + daily.getTripPlanNo());
            System.out.println("dailyPlan 본문내용: " + daily.getDailyPlanContents());
            System.out.println("dailyPlan 총이동시간: " + daily.getTotalTripTime());
        }
    }

    //@Test
    public void selectDailyPlan() throws Exception{
        List<DailyPlan> dailyPlan = dailyPlanService.selectDailyPlan(2);
        System.out.println(dailyPlan.toString());
    }

    //@Test // 일차별 여행플랜 수정(여행플랜번호로 가져온 일차별 여행플랜 목록중 하나를 선택하여 내용 변경후 확인)
    public void updateDailyPlan() throws Exception{
        List<DailyPlan> dailyPlan1 = dailyPlanService.selectDailyPlan(1);
        DailyPlan getDaily1 = dailyPlan1.get(0);
        System.out.println(getDaily1.toString());
        getDaily1.setDailyPlanContents("왜 지멋대로 바뀌는지 업데이트 테스트 입니다.~~~");
        getDaily1.setTotalTripTime("3시간");

        dailyPlanService.updateDailyPlan(getDaily1);
        List<DailyPlan> dailyPlan2 = dailyPlanService.selectDailyPlan(1);
        DailyPlan getDaily2 = dailyPlan1.get(0);
        System.out.println(getDaily2.toString());
    }

    //@Test // 일차별 여행플랜 삭제
    public void deleteDailyPlan() throws Exception{
        dailyPlanService.deleteDailyPlan(2);
    }

}