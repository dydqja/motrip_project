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
    private Integer attachedTripPlanNo;
    private Integer attachedReviewNo;
    private Integer attachedChatRoomNo;

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
                '}';
    }
}
