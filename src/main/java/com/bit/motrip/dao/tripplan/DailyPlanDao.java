package com.bit.motrip.dao.tripplan;

import com.bit.motrip.domain.DailyPlan;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper
public interface DailyPlanDao {
    void insertDailyPlan(DailyPlan dailyPlan);
    List<DailyPlan> getDailyPlanList();
}
