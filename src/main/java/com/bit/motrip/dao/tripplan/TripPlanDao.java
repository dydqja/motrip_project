package com.bit.motrip.dao.tripplan;

import com.bit.motrip.domain.TripPlan;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TripPlanDao {

    public List<TripPlan> selectTripPlanList() throws Exception;

    public void insertTripPlan(TripPlan tripPlan);

    public int updateTripPlan(TripPlan tripPlan);

    public int deleteTripPlan(int tripPlanNo);

}
