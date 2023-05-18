package com.bit.motrip.service.tripplan;

import com.bit.motrip.domain.TripPlan;
import org.springframework.stereotype.Service;

import java.util.List;

public interface TripPlanService {

    public List<TripPlan> selectTripPlanList() throws Exception;

    public void insertTripPlan(TripPlan tripPlan);

    public int updateTripPlan(TripPlan tripPlan);

    public int deleteTripPlan(int tripPlanNo);

}
