package com.bit.motrip.service.tripplan;

import com.bit.motrip.domain.DailyPlan;

import java.util.List;

public interface DailyPlanService {
    public void addDailyPlan(DailyPlan dailyPlan) throws Exception;
    public int getDailyPlan() throws Exception;
    public List<DailyPlan> selectDailyPlan(int tripPlanNo) throws Exception;
    public void updateDailyPlan(DailyPlan dailyPlan) throws Exception;
    public void deleteDailyPlan(int dailyPlanNo) throws Exception;
}
