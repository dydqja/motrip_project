package com.bit.motrip.dao.tripplan;

import com.bit.motrip.domain.TripPlan;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TripPlanDao {

    public List<TripPlan> selectPublicTripPlanList() throws Exception;

    public List<TripPlan> selectMyTripPlanList(String userId) throws Exception;

    public void addTripPlan(TripPlan tripPlan) throws Exception;

    public int getTripPlan() throws Exception;

    public int updateTripPlan(TripPlan tripPlan);

    public int deleteTripPlan (int tripPlanNo) throws Exception;

}
