package com.bit.motrip.domain;

public class ChatMember {
    //미정
    private int memberNo; //멤버 아이디 pri (no use)
    private int chatRoomNo; //채팅방 번호
    private String userId; // 유저 아이디
    private int tripPlanNo; // 플랜번호
    private boolean isChatRoomAuthor; //방장여부

    public int getMemberNo() {
        return memberNo;
    }

    public void setMemberNo(int memberNo) {
        this.memberNo = memberNo;
    }

    public int getChatRoomNo() {
        return chatRoomNo;
    }

    public void setChatRoomNo(int chatRoomNo) {
        this.chatRoomNo = chatRoomNo;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public int getTripPlanNo() {
        return tripPlanNo;
    }

    public void setTripPlanNo(int tripPlanNo) {
        this.tripPlanNo = tripPlanNo;
    }

    public boolean isChatRoomAuthor() {
        return isChatRoomAuthor;
    }

    public void setChatRoomAuthor(boolean chatRoomAuthor) {
        isChatRoomAuthor = chatRoomAuthor;
    }
}
