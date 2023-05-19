package com.bit.motrip.dao.tripplan;

import com.bit.motrip.domain.DailyPlan;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper
public interface DailyPlanDao {
    public void addDailyPlan(DailyPlan dailyPlan);

    public int getDailyPlan() throws Exception;

    List<DailyPlan> getDailyPlanList(int tripPlanNo);
}
