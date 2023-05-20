package com.bit.motrip.service.tripplan;

import com.bit.motrip.domain.TripPlan;
import org.springframework.stereotype.Service;

import java.util.List;

public interface TripPlanService {

    public List<TripPlan> selectTripPlanList() throws Exception;

    public void addTripPlan(TripPlan tripPlan) throws Exception;

    public int getTripPlan() throws Exception;

    public int updateTripPlan(TripPlan tripPlan);

    public int deleteTripPlan(int tripPlanNo);

}
