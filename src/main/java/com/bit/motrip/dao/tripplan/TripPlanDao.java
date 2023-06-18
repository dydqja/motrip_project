package com.bit.motrip.dao.tripplan;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.DailyPlan;
import com.bit.motrip.domain.Place;
import com.bit.motrip.domain.TripPlan;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface TripPlanDao {

    public List<TripPlan> selectTripPlanList(Map<String, Object> parameters) throws Exception; //
    public void addTripPlan(TripPlan tripPlan) throws Exception; //
    public int getTripPlan() throws Exception; //
    public TripPlan selectTripPlan(int tripPlanNo) throws Exception; //
    public void updateTripPlan(TripPlan tripPlan) throws Exception; //
    public void deleteTripPlan(int tripPlanNo) throws Exception; //
    public void tripPlanPublic(int tripPlanNo, boolean isPlanPublic) throws Exception; //
    public void tripPlanDownloadable(int tripPlanNo, boolean isPlanDownloadable) throws Exception;
    public void tripPlanDeleted(TripPlan tripPlan) throws Exception; //
    public void tripPlanCompleted(int tripPlanNo, boolean isTripCompleted) throws Exception; //
    public void tripPlanLikes(TripPlan tripPlan) throws Exception; //
    public void tripPlanViews(TripPlan tripPlan) throws Exception;
    public int tripPlanCount() throws Exception; //
    public int selectTripPlanTotalCount(Search search) throws Exception;
    public List<TripPlan> indexTripPlanLikes() throws Exception; //

}
