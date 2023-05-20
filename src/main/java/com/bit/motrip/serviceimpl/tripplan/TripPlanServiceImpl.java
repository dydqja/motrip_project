package com.bit.motrip.serviceimpl.tripplan;

import com.bit.motrip.dao.tripplan.TripPlanDao;
import com.bit.motrip.domain.TripPlan;
import com.bit.motrip.service.tripplan.TripPlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("tripPlanServiceImpl")
public class TripPlanServiceImpl implements TripPlanService {

    @Autowired
    @Qualifier("tripPlanDao")
    private TripPlanDao tripPlanDao;
    @Override
    public List<TripPlan> selectTripPlanList() throws Exception {
        return tripPlanDao.selectTripPlanList();
    }

    @Override
    public void addTripPlan(TripPlan tripPlan) throws Exception {
        tripPlanDao.addTripPlan(tripPlan);
    }

    @Override
    public int getTripPlan() throws Exception {
        return tripPlanDao.getTripPlan();
    }

    @Override
    public int updateTripPlan(TripPlan tripPlan) {
        return 0;
    }

    @Override
    public int deleteTripPlan(int tripPlanNo) {
        return 0;
    }
}
