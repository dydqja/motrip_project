package com.bit.motrip.domain;

import java.util.Date;

public class ChatRoom { //채팅방 도메인
    //채팅방 field
    private int chatRoomNo; // 채팅방 번호
    private String chatRoomTitle; //채팅방 제목
    private Date travelStartDate; // 여행 시작일
    private String ageRange; // 나잇대 ??
    private int maxPersons; // 최대 인원수
    private int currentPersons; // 현재 인원수

    private int chatRoomStatus; // 0 모집중 1 모집완료
    //getter & setter
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

    public String getAgeRange() {
        return ageRange;
    }

    public void setAgeRange(String ageRange) {
        this.ageRange = ageRange;
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

    @Override
    public String toString() {
        return "ChatRoom{" +
                "chatRoomNo=" + chatRoomNo +
                ", chatRoomTitle='" + chatRoomTitle + '\'' +
                ", travelStartDate=" + travelStartDate +
                ", ageRange='" + ageRange + '\'' +
                ", maxPersons=" + maxPersons +
                ", currentPersons=" + currentPersons +
                ", chatRoomStatus=" + chatRoomStatus +
                '}';
    }
}
