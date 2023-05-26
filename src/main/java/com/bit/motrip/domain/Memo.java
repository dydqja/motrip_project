package com.bit.motrip.domain;

import java.sql.Date;
import java.util.List;

public class Memo {
    private int memoNo;
    private String memoTitle;
    private String memoContents;
    private Date memoRegDate;
    private Date memoDelDate;
    private int memoColor;
    private String memoAuthor;

    //부착된 문서의 No
    private Integer attachedTripPlanNo;
    private Integer attachedReviewNo;
    private Integer attachedChatRoomNo;

    //부착된 문서의 전체정보
    private TripPlan attachedTripPlan;
    private Review attachedReview;
    private ChatRoom attachedChatRoom;

    //메모의 부착 카테고리
    // 0: 미부착 1: 여행계획, 2: 리뷰, 3: 채팅방

    //getter and setter


    public int getMemoNo() {
        return memoNo;
    }

    public void setMemoNo(int memoNo) {
        this.memoNo = memoNo;
    }

    public String getMemoTitle() {
        return memoTitle;
    }

    public void setMemoTitle(String memoTitle) {
        this.memoTitle = memoTitle;
    }

    public String getMemoContents() {
        return memoContents;
    }

    public void setMemoContents(String memoContents) {
        this.memoContents = memoContents;
    }

    public Date getMemoRegDate() {
        return memoRegDate;
    }

    public void setMemoRegDate(Date memoRegDate) {
        this.memoRegDate = memoRegDate;
    }

    public Date getMemoDelDate() {
        return memoDelDate;
    }

    public void setMemoDelDate(Date memoDelDate) {
        this.memoDelDate = memoDelDate;
    }

    public int getMemoColor() {
        return memoColor;
    }

    public void setMemoColor(int memoColor) {
        this.memoColor = memoColor;
    }

    public String getMemoAuthor() {
        return memoAuthor;
    }

    public void setMemoAuthor(String memoAuthor) {
        this.memoAuthor = memoAuthor;
    }

    public Integer getAttachedTripPlanNo() {
        return attachedTripPlanNo;
    }

    public void setAttachedTripPlanNo(Integer attachedTripPlanNo) {
        this.attachedTripPlanNo = attachedTripPlanNo;
    }

    public Integer getAttachedReviewNo() {
        return attachedReviewNo;
    }

    public void setAttachedReviewNo(Integer attachedReviewNo) {
        this.attachedReviewNo = attachedReviewNo;
    }

    public Integer getAttachedChatRoomNo() {
        return attachedChatRoomNo;
    }

    public void setAttachedChatRoomNo(Integer attachedChatRoomNo) {
        this.attachedChatRoomNo = attachedChatRoomNo;
    }

    public TripPlan getAttachedTripPlan() {
        return attachedTripPlan;
    }

    public void setAttachedTripPlan(TripPlan attachedTripPlan) {
        this.attachedTripPlan = attachedTripPlan;
    }

    public Review getAttachedReview() {
        return attachedReview;
    }

    public void setAttachedReview(Review attachedReview) {
        this.attachedReview = attachedReview;
    }

    public ChatRoom getAttachedChatRoom() {
        return attachedChatRoom;
    }

    public void setAttachedChatRoom(ChatRoom attachedChatRoom) {
        this.attachedChatRoom = attachedChatRoom;
    }


    @Override
    public String toString() {
        return "Memo{" +
                "memoNo=" + memoNo +
                ", memoTitle='" + memoTitle + '\'' +
                ", memoContents='" + memoContents + '\'' +
                ", memoRegDate=" + memoRegDate +
                ", memoDelDate=" + memoDelDate +
                ", memoColor=" + memoColor +
                ", memoAuthor='" + memoAuthor + '\'' +
                ", attachedTripPlanNo=" + attachedTripPlanNo +
                ", attachedReviewNo=" + attachedReviewNo +
                ", attachedChatRoomNo=" + attachedChatRoomNo +
                ", attachedTripPlan=" + attachedTripPlan +
                ", attachedReview=" + attachedReview +
                ", attachedChatRoom=" + attachedChatRoom +
                '}';
    }
}

