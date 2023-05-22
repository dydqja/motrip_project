package com.bit.motrip.serviceimpl.tripplan;

import com.bit.motrip.dao.tripplan.TripPlanDao;
import com.bit.motrip.domain.DailyPlan;
import com.bit.motrip.domain.Place;
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
    public List<TripPlan> selectPublicTripPlanList() throws Exception {
        return tripPlanDao.selectPublicTripPlanList();
    }

    @Override
    public List<TripPlan> selectMyTripPlanList(String userId) throws Exception {
        return tripPlanDao.selectMyTripPlanList(userId);
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
    public TripPlan selectTripPlan(int tripPlanNo) throws Exception {
        return tripPlanDao.selectTripPlan(tripPlanNo);
    }

    @Override
    public int updateTripPlan(TripPlan tripPlan) throws Exception{
        return tripPlanDao.updateTripPlan(tripPlan);
    }
    @Override
    public int updateDailyPlan(DailyPlan dailyPlan) throws Exception {
        return tripPlanDao.updateDailyPlan(dailyPlan);
    }
    @Override
    public int updatePlace(Place place) throws Exception {
        return tripPlanDao.updatePlace(place);
    }

    @Override
    public int deleteTripPlan(int tripPlanNo) throws Exception {
        return tripPlanDao.deleteTripPlan(tripPlanNo);
    }
}
