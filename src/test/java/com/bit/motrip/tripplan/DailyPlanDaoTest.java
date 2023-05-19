package com.bit.motrip.tripplan;

import com.bit.motrip.domain.DailyPlan;
import com.bit.motrip.service.tripplan.DailyPlanService;
import com.bit.motrip.service.tripplan.TripPlanService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class DailyPlanDaoTest {

    @Autowired
    @Qualifier("dailyPlanServiceImpl")
    private DailyPlanService dailyPlanService;

    //@Test //일차별 여행플랜 하루씩 저장 테스트
    public void addDailyPlan() {
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
    public void getDailyPlanList() {
    }
}