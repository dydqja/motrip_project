package com.bit.motrip.domain;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Notice {

    private int noticeNo;

    private String noticeAuthor;

    private String noticeTitle;

    private String noticeContents;

    private int noticeViews;

    private Date noticeRegDate;

    private int isNoticeImportant;

    private int boardCategory;


    public int getNoticeNo() {
        return noticeNo;
    }

    public void setNoticeNo(int noticeNo) {
        this.noticeNo = noticeNo;
    }

    public String getNoticeAuthor() {
        return noticeAuthor;
    }

    public void setNoticeAuthor(String noticeAuthor) {
        this.noticeAuthor = noticeAuthor;
    }

    public String getNoticeTitle() {
        return noticeTitle;
    }

    public void setNoticeTitle(String noticeTitle) {
        this.noticeTitle = noticeTitle;
    }

    public String getNoticeContents() {
        return noticeContents;
    }

    public void setNoticeContents(String noticeContents) {
        this.noticeContents = noticeContents;
    }

    public int getNoticeViews() {
        return noticeViews;
    }

    public void setNoticeViews(int noticeViews) {
        this.noticeViews = noticeViews;
    }

    public Date getNoticeRegDate() {
        return noticeRegDate;
    }

    public void setNoticeRegDate(Date noticeRegDate) {
        this.noticeRegDate = noticeRegDate;
    }

    public int getIsNoticeImportant() {
        return isNoticeImportant;
    }

    public void setIsNoticeImportant(int isNoticeImportant) {
        this.isNoticeImportant = isNoticeImportant;
    }

    public int getBoardCategory() {
        return boardCategory;
    }

    public void setBoardCategory(int boardCategory) {
        this.boardCategory = boardCategory;
    }

    @Override
    public String toString() {

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        return "Notice{" +
                "noticeNo=" + noticeNo +
                ", noticeAuthor='" + noticeAuthor +
                ", noticeTitle='" + noticeTitle +
                ", noticeContents='" + noticeContents +
                ", noticeViews=" + noticeViews +
                ", noticeRegDate=" + dateFormat.format(noticeRegDate) +
                ", isNoticeImportant=" + isNoticeImportant +
                ", boardCategory=" + boardCategory +
                '}';
    }
}
