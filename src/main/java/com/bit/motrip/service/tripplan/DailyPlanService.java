package com.bit.motrip.service.tripplan;

import com.bit.motrip.domain.DailyPlan;

import java.util.List;

public interface DailyPlanService {
    void addDailyPlan(DailyPlan dailyPlan);

    public int getDailyPlan() throws Exception;
    List<DailyPlan> getDailyPlanList(int TripPlanNo);
}
