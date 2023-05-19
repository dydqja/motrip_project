package com.bit.motrip.domain;

public class DailyPlan {
    private int dailyPlanNo;
    private int tripPlanNo;
    private String dailyPlanContents;
    private String totalTripTime;

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
}
