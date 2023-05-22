package com.bit.motrip.service.tripplan;

import com.bit.motrip.domain.DailyPlan;
import com.bit.motrip.domain.Place;
import com.bit.motrip.domain.TripPlan;
import org.springframework.stereotype.Service;

import java.util.List;

public interface TripPlanService {

    public List<TripPlan> selectPublicTripPlanList() throws Exception;
    public List<TripPlan> selectMyTripPlanList(String userId) throws Exception;
    public void addTripPlan(TripPlan tripPlan) throws Exception;
    public int getTripPlan() throws Exception;
    public TripPlan selectTripPlan(int tripPlanNo) throws Exception;

    public int updateTripPlan(TripPlan tripPlan) throws Exception;
    public int updateDailyPlan(DailyPlan dailyPlan) throws Exception;
    public int updatePlace(Place place) throws Exception;

    public int deleteTripPlan(int tripPlanNo) throws Exception;

}
