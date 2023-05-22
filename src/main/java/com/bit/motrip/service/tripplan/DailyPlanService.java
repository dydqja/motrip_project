package com.bit.motrip.service.tripplan;

import com.bit.motrip.domain.DailyPlan;

import java.util.List;

public interface DailyPlanService {
    public void addDailyPlan(DailyPlan dailyPlan) throws Exception;
    public int getDailyPlan() throws Exception;
    public List<DailyPlan> selectDailyPlan(int tripPlanNo) throws Exception;
    public int updateDailyPlan(DailyPlan dailyPlan) throws Exception;
    public int deleteDailyPlan(int dailyPlanNo) throws Exception;
}
