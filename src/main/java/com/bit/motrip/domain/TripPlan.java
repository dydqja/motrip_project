package com.bit.motrip.domain;

import java.util.Date;
import java.util.List;
import java.util.Map;

public class TripPlan {

    private int tripPlanNo;
    private String tripPlanAuthor;
    private String tripPlanTitle;
    private String tripPlanThumbnail;
    private int tripDays;
    private Date tripPlanRegDate;
    private Date tripPlanDelDate;
    private boolean isPlanDeleted;
    private boolean isPlanPublic;
    private boolean isPlanDownloadable;
    private boolean isTripCompleted;
    private int tripPlanLikes;
    private int tripPlanViews;
    private List<DailyPlan> dailyplanResultMap;
    private String strDate;
    private String tripPlanNickName;
    private int chatRoomNo;

    public TripPlan() {
    }

    public int getChatRoomNo() {
        return chatRoomNo;
    }

    public void setChatRoomNo(int chatRoomNo) {
        this.chatRoomNo = chatRoomNo;
    }

    public String getTripPlanNickName() {
        return tripPlanNickName;
    }

    public void setTripPlanNickName(String tripPlanNickName) {
        this.tripPlanNickName = tripPlanNickName;
    }

    public String getStrDate() {
        return strDate;
    }

    public void setStrDate(String strDate) {
        this.strDate = strDate;
    }

    public int getTripPlanNo() {
        return tripPlanNo;
    }

    public void setTripPlanNo(int tripPlanNo) {
        this.tripPlanNo = tripPlanNo;
    }

    public String getTripPlanAuthor() {
        return tripPlanAuthor;
    }

    public void setTripPlanAuthor(String tripPlanAuthor) {
        this.tripPlanAuthor = tripPlanAuthor;
    }

    public String getTripPlanTitle() {
        return tripPlanTitle;
    }

    public void setTripPlanTitle(String tripPlanTitle) {
        this.tripPlanTitle = tripPlanTitle;
    }

    public String getTripPlanThumbnail() {
        return tripPlanThumbnail;
    }

    public void setTripPlanThumbnail(String tripPlanThumbnail) {
        this.tripPlanThumbnail = tripPlanThumbnail;
    }

    public int getTripDays() {
        return tripDays;
    }

    public void setTripDays(int tripDays) {
        this.tripDays = tripDays;
    }

    public Date getTripPlanRegDate() {
        return tripPlanRegDate;
    }

    public void setTripPlanRegDate(Date tripPlanRegDate) {
        this.tripPlanRegDate = tripPlanRegDate;
    }

    public Date getTripPlanDelDate() {
        return tripPlanDelDate;
    }

    public void setTripPlanDelDate(Date tripPlanDelDate) {
        this.tripPlanDelDate = tripPlanDelDate;
    }

    public boolean getisPlanDeleted() {
        return isPlanDeleted;
    }

    public void setisPlanDeleted(boolean planDeleted) {
        isPlanDeleted = planDeleted;
    }

    public boolean getisPlanPublic() {
        return isPlanPublic;
    }

    public void setisPlanPublic(boolean planPublic) {
        isPlanPublic = planPublic;
    }

    public boolean getisPlanDownloadable() {
        return isPlanDownloadable;
    }

    public void setisPlanDownloadable(boolean planDownloadable) {
        isPlanDownloadable = planDownloadable;
    }

    public boolean getisTripCompleted() {
        return isTripCompleted;
    }

    public void setisTripCompleted(boolean tripCompleted) {
        isTripCompleted = tripCompleted;
    }

    public int getTripPlanLikes() {
        return tripPlanLikes;
    }

    public void setTripPlanLikes(int tripPlanLikes) {
        this.tripPlanLikes = tripPlanLikes;
    }

    public int getTripPlanViews() {
        return tripPlanViews;
    }

    public void setTripPlanViews(int tripPlanViews) {
        this.tripPlanViews = tripPlanViews;
    }

    public List<DailyPlan> getDailyplanResultMap() {
        return dailyplanResultMap;
    }

    public void setDailyplanResultMap(List<DailyPlan> dailyplanResultMap) {
        this.dailyplanResultMap = dailyplanResultMap;
    }

    @Override
    public String toString() {
        return "\n TripPlan{" +
                "tripPlanNo=" + tripPlanNo +
                ", tripPlanAuthor='" + tripPlanAuthor + '\'' +
                ", tripPlanTitle='" + tripPlanTitle + '\'' +
                ", tripPlanThumbnail='" + tripPlanThumbnail + '\'' +
                ", tripDays=" + tripDays +
                ", tripPlanRegDate=" + tripPlanRegDate +
                ", tripPlanDelDate=" + tripPlanDelDate +
                ", isPlanDeleted=" + isPlanDeleted +
                ", isPlanPublic=" + isPlanPublic +
                ", isPlanDownloadable=" + isPlanDownloadable +
                ", isTripCompleted=" + isTripCompleted +
                ", tripPlanLikes=" + tripPlanLikes +
                ", tripPlanViews=" + tripPlanViews +
                ", dailyplanResultMap=" + dailyplanResultMap +
                ", chatRoomNo=" + chatRoomNo +
                '}' + "\n";
    }
}
