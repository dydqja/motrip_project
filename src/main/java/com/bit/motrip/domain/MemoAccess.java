package com.bit.motrip.domain;

public class MemoAccess {
    //constructor
    public MemoAccess() {
    }
    public MemoAccess(int memoNo, String userId, boolean isAuthor) {
        this.memoNo = memoNo;
        this.userId = userId;
        this.isAuthor = isAuthor;
    }
    int memoNo;
    String userId;
    boolean isAuthor;

    public int getMemoNo() {
        return memoNo;
    }

    public void setMemoNo(int memoNo) {
        this.memoNo = memoNo;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public boolean isAuthor() {
        return isAuthor;
    }

    public void setAuthor(boolean author) {
        isAuthor = author;
    }
}
