package com.bit.motrip.domain;

import java.text.SimpleDateFormat;
import java.util.Date;

public class ChatRoom { //채팅방 도메인
    //채팅방 field
    private int chatRoomNo; // 채팅방 번호
    private String chatRoomTitle; //채팅방 제목
    private Date travelStartDate; // 여행 시작일
    private int minAge;
    private int maxAge;
    private String gender; // 0=MF,1=M,2=F
    private int maxPersons; // 최대 인원수
    private int currentPersons; // 현재 인원수
    //tripPlan 가져오기 쉽게
    private int tripPlanNo;
    private String tripPlanTitle;
    private int tripDays;
    private int chatRoomStatus; // 0 모집중 1 모집완료
    //getter & setter
    private String strDate;

    public int getMinAge() {
        return minAge;
    }

    public void setMinAge(int minAge) {
        this.minAge = minAge;
    }

    public int getMaxAge() {
        return maxAge;
    }

    public void setMaxAge(int maxAge) {
        this.maxAge = maxAge;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
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

    public int getChatRoomNo() {
        return chatRoomNo;
    }
    public int getChatRoomStatus() {
        return chatRoomStatus;
    }

    public void setChatRoomStatus(int chatRoomStatus) {
        this.chatRoomStatus = chatRoomStatus;
    }

    public void setChatRoomNo(int chatRoomNo) {
        this.chatRoomNo = chatRoomNo;
    }

    public String getChatRoomTitle() {
        return chatRoomTitle;
    }

    public void setChatRoomTitle(String chatRoomTitle) {
        this.chatRoomTitle = chatRoomTitle;
    }

    public Date getTravelStartDate() {
        return travelStartDate;
    }

    public void setTravelStartDate(Date travelStartDate) {
        this.travelStartDate = travelStartDate;

    }


    public int getMaxPersons() {
        return maxPersons;
    }

    public void setMaxPersons(int maxPersons) {
        this.maxPersons = maxPersons;
    }

    public int getCurrentPersons() {
        return currentPersons;
    }

    public void setCurrentPersons(int currentPersons) {
        this.currentPersons = currentPersons;
    }

    public String getTripPlanTitle() {
        return tripPlanTitle;
    }

    public void setTripPlanTitle(String tripPlanTitle) {
        this.tripPlanTitle = tripPlanTitle;
    }

    public int getTripDays() {
        return tripDays;
    }

    public void setTripDays(int tripDays) {
        this.tripDays = tripDays;
    }

    @Override
    public String toString() {
        return "ChatRoom{" +
                "chatRoomNo=" + chatRoomNo +
                ", chatRoomTitle='" + chatRoomTitle + '\'' +
                ", travelStartDate=" + travelStartDate +
                ", minAge=" + minAge +
                ", maxAge=" + maxAge +
                ", gender='" + gender + '\'' +
                ", maxPersons=" + maxPersons +
                ", currentPersons=" + currentPersons +
                ", tripPlanNo=" + tripPlanNo +
                ", chatRoomStatus=" + chatRoomStatus +
                ", strDate='" + strDate + '\'' +
                '}';
    }
}
