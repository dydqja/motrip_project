package com.bit.motrip.dao.tripplan;

import com.bit.motrip.domain.DailyPlan;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper
public interface DailyPlanDao {
    public void addDailyPlan(DailyPlan dailyPlan) throws Exception;

    public int getDailyPlan() throws Exception;

    public List<DailyPlan> selectDailyPlan(int tripPlanNo) throws Exception;

    public int updateDailyPlan(DailyPlan dailyPlan) throws Exception;

    public int deleteDailyPlan(int dailyPlanNo) throws Exception;

}
