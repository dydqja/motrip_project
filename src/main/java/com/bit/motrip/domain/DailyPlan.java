package com.bit.motrip.domain;

import java.util.List;
import java.util.Map;

public class DailyPlan {
    private int dailyPlanNo;
    private int tripPlanNo;
    private String dailyPlanContents;
    private String totalTripTime;
    private List<Place> placeResultMap;

    public int getDailyPlanNo() {
        return dailyPlanNo;
    }

    public void setDailyPlanNo(int dailyPlanNo) {
        this.dailyPlanNo = dailyPlanNo;
    }

    public int getTripPlanNo() {
        return tripPlanNo;
    }

    public void setTripPlanNo(int tripPlanNo) {
        this.tripPlanNo = tripPlanNo;
    }

    public String getDailyPlanContents() {
        return dailyPlanContents;
    }

    public void setDailyPlanContents(String dailyPlanContents) {
        this.dailyPlanContents = dailyPlanContents;
    }

    public String getTotalTripTime() {
        return totalTripTime;
    }

    public void setTotalTripTime(String totalTripTime) {
        this.totalTripTime = totalTripTime;
    }

    public List<Place> getPlaceResultMap() {
        return placeResultMap;
    }

    public void setPlaceResultMap(List<Place> placeResultMap) {
        this.placeResultMap = placeResultMap;
    }

    @Override
    public String toString() {
        return "DailyPlan{" +
                "dailyPlanNo=" + dailyPlanNo +
                ", tripPlanNo=" + tripPlanNo +
                ", dailyPlanContents='" + dailyPlanContents + '\'' +
                ", totalTripTime='" + totalTripTime + '\'' +
                ", placeResultMap=" + placeResultMap +
                '}';
    }
}
