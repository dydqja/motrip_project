package com.bit.motrip.domain;

public class Place {
    int placeNo;
    int dailyPlanNo;
    String placeTags;
    String placeCoordinates;
    String placeImage;
    String placePhoneNumber;
    String placeAddress;
    int placeCategory;
    String tripTime;

    public int getPlaceNo() {
        return placeNo;
    }

    public void setPlaceNo(int placeNo) {
        this.placeNo = placeNo;
    }

    public int getDailyPlanNo() {
        return dailyPlanNo;
    }

    public void setDailyPlanNo(int dailyPlanNo) {
        this.dailyPlanNo = dailyPlanNo;
    }

    public String getPlaceTags() {
        return placeTags;
    }

    public void setPlaceTags(String placeTags) {
        this.placeTags = placeTags;
    }

    public String getPlaceCoordinates() {
        return placeCoordinates;
    }

    public void setPlaceCoordinates(String placeCoordinates) {
        this.placeCoordinates = placeCoordinates;
    }

    public String getPlaceImage() {
        return placeImage;
    }

    public void setPlaceImage(String placeImage) {
        this.placeImage = placeImage;
    }

    public String getPlacePhoneNumber() {
        return placePhoneNumber;
    }

    public void setPlacePhoneNumber(String placePhoneNumber) {
        this.placePhoneNumber = placePhoneNumber;
    }

    public String getPlaceAddress() {
        return placeAddress;
    }

    public void setPlaceAddress(String placeAddress) {
        this.placeAddress = placeAddress;
    }

    public int getPlaceCategory() {
        return placeCategory;
    }

    public void setPlaceCategory(int placeCategory) {
        this.placeCategory = placeCategory;
    }

    public String getTripTime() {
        return tripTime;
    }

    public void setTripTime(String tripTime) {
        this.tripTime = tripTime;
    }
}
