package com.bit.motrip.domain;

import java.util.ArrayList;
import java.util.List;

public class MemoDoc {
    //Constructor
    public MemoDoc(){
        //생성될때 리스트를 반드시 생성.
        this.memoList = new ArrayList<>();
    }

    //Field
    private int Category;
    // 0: 미부착 1: 여행계획, 2: 리뷰, 3: 채팅방
    private TripPlan tripPlan;
    private Review review;
    private ChatRoom chatRoom;
    private List<Memo> memoList;

    public int getCategory() {
        return Category;
    }

    public void setCategory(int category) {
        this.Category = category;
    }

    public TripPlan getTripPlan() {
        return tripPlan;
    }

    public void setTripPlan(TripPlan tripPlan) {
        this.tripPlan = tripPlan;
    }

    public Review getReview() {
        return review;
    }

    public void setReview(Review review) {
        this.review = review;
    }

    public ChatRoom getChatRoom() {
        return chatRoom;
    }

    public void setChatRoom(ChatRoom chatRoom) {
        this.chatRoom = chatRoom;
    }

    public List<Memo> getMemoList() {
        return memoList;
    }

    public void setMemoList(List<Memo> memoList) {
        this.memoList = memoList;
    }


    @Override
    public String toString() {
        String targetString = "";
        int innerMemos = this.memoList.size();
        if(this.tripPlan!=null){
            targetString = "플랜 : ";
            int tpn = this.tripPlan.getTripPlanNo();
            String tpt = this.tripPlan.getTripPlanTitle();
            targetString = targetString+tpn+"제목 : "+tpt+"안의 메모 개수 = "+innerMemos;
        } else if (this.review!=null) {
            targetString = "리뷰 : ";
            //여기도 똑같이
            int rvn = this.review.getReviewNo();
            String rvt = this.review.getReviewTitle();
            targetString = targetString+rvn+"제목 :"+rvt+"안의 메모 개수 = "+innerMemos;
        } else if (this.chatRoom!=null) {
            targetString = "채팅방 : ";
            //여기도 똑같이
            int crn = this.chatRoom.getChatRoomNo();
            String crt = this.chatRoom.getChatRoomTitle();
            targetString = targetString+crn+"제목 :"+crt+"안의 메모 개수 = "+innerMemos;
        } else {
            targetString = "미부착";
            targetString = targetString+"안의 메모 개수 = "+innerMemos;
        }
        return targetString;
    }
}
