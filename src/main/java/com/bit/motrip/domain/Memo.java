package com.bit.motrip.domain;

import java.sql.Date;
import java.util.List;

public class Memo {
    int memoNo;
    String memoTitle;
    String memoContents;
    Date memoRegDate;
    Date memoDelDate;
    int memoColor;
    String memoAuthor;
    List<User> memoAccessUserList;

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

    public List<User> getMemoAccessUserList() {
        return memoAccessUserList;
    }

    public void setMemoAccessUserList(List<User> memoAccessUserList) {
        this.memoAccessUserList = memoAccessUserList;
    }
}
