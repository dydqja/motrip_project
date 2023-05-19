package com.bit.motrip.service.tripplan;

import com.bit.motrip.domain.DailyPlan;

import java.util.List;

public interface DailyPlanService {
    void insertDailyPlan(DailyPlan dailyPlan);
    List<DailyPlan> getDailyPlanList();
}
