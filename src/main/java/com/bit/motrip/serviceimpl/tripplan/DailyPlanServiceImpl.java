package com.bit.motrip.serviceimpl.tripplan;

import com.bit.motrip.dao.tripplan.DailyPlanDao;
import com.bit.motrip.domain.DailyPlan;
import com.bit.motrip.service.tripplan.DailyPlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;
@Service("dailyPlanServiceImpl")
public class DailyPlanServiceImpl implements DailyPlanService {
    @Autowired
    @Qualifier("dailyPlanDao")
    private DailyPlanDao dailyPlanDao;

    @Override
    public void insertDailyPlan(DailyPlan dailyPlan) {
        dailyPlanDao.insertDailyPlan(dailyPlan);
    }

    @Override
    public List<DailyPlan> getDailyPlanList() {
        return dailyPlanDao.getDailyPlanList();
    }
}
