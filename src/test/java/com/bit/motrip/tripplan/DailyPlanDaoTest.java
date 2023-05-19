package com.bit.motrip.tripplan;

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

    //@Test
    public void insertDailyPlan() {
    }

    //@Test
    public void getDailyPlanList() {
    }
}