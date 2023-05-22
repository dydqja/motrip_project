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
    public void addDailyPlan(DailyPlan dailyPlan) throws Exception {
        dailyPlanDao.addDailyPlan(dailyPlan);
    }

    @Override
    public int getDailyPlan() throws Exception{
        return dailyPlanDao.getDailyPlan();
    }

    @Override
    public List<DailyPlan> selectDailyPlan(int tripPlanNo) throws Exception{
        return dailyPlanDao.selectDailyPlan(tripPlanNo);
    }

    @Override
    public int updateDailyPlan(DailyPlan dailyPlan) throws Exception {
        return dailyPlanDao.updateDailyPlan(dailyPlan);
    }

    @Override
    public int deleteDailyPlan(int dailyPlanNo) throws Exception {
        return dailyPlanDao.deleteDailyPlan(dailyPlanNo);
    }


}
