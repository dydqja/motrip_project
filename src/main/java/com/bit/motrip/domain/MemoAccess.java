package com.bit.motrip.domain;

public class MemoAccess {
    //constructor
    public MemoAccess() {
    }
    public MemoAccess(int memoNo, String memoAccessUser, boolean isMemoAuthor) {
        this.memoNo = memoNo;
        this.memoAccessUser = memoAccessUser;
        this.isMemoAuthor = isMemoAuthor;
    }



    //fields
    private int memoAccessNo;
    private int memoNo;
    private String memoAccessUser;
    private boolean isMemoAuthor;

    //getter and setter

    public int getMemoAccessNo() {
        return memoAccessNo;
    }

    public void setMemoAccessNo(int memoAccessNo) {
        this.memoAccessNo = memoAccessNo;
    }

    public int getMemoNo() {
        return memoNo;
    }

    public void setMemoNo(int memoNo) {
        this.memoNo = memoNo;
    }

    public String getMemoAccessUser() {
        return memoAccessUser;
    }

    public void setMemoAccessUser(String memoAccessUser) {
        this.memoAccessUser = memoAccessUser;
    }

    public boolean isMemoAuthor() {
        return isMemoAuthor;
    }

    public void setMemoAuthor(boolean memoAuthor) {
        isMemoAuthor = memoAuthor;
    }

    @Override
    public String toString() {
        return "MemoAccess{" +
                "memoAccessNo=" + memoAccessNo +
                ", memoNo=" + memoNo +
                ", memoAccessUser='" + memoAccessUser + '\'' +
                ", isMemoAuthor=" + isMemoAuthor +
                '}';
    }
}
