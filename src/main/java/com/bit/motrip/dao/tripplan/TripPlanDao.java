package com.bit.motrip.dao.tripplan;

import com.bit.motrip.domain.DailyPlan;
import com.bit.motrip.domain.Place;
import com.bit.motrip.domain.TripPlan;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TripPlanDao {

    public List<TripPlan> selectPublicTripPlanList() throws Exception;
    public List<TripPlan> selectMyTripPlanList(String userId) throws Exception;
    public void addTripPlan(TripPlan tripPlan) throws Exception;
    public int getTripPlan() throws Exception;
    public TripPlan selectTripPlan(int tripPlanNo) throws Exception;
    public void updateTripPlan(TripPlan tripPlan) throws Exception;
    public void deleteTripPlan(int tripPlanNo) throws Exception;
    public void tripPlanPublic(int tripPlanNo, boolean isPlanPublic) throws Exception;
    public void tripPlanDownloadable(int tripPlanNo, boolean isPlanDownloadable) throws Exception;
    public void tripPlanDeleted(int tripPlanNo, boolean isPlanDeleted) throws Exception;
    public void tripPlanCompleted(int tripPlanNo, boolean isTripCompleted) throws Exception;

}
