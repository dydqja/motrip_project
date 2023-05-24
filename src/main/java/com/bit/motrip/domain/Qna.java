package com.bit.motrip.domain;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Qna {

    private int qnaNo;

    private String qnaAuthor;

    private String qnaTitle;

    private String qnaContents;

    private int qnaViews;

    private Date qnaRegDate;

    private int qnaCategory;

    private int isQnaAnswered;

    private String qnaAnswerContents;

    private int boardCategory;


    public int getQnaNo() {
        return qnaNo;
    }

    public void setQnaNo(int qnaNo) {
        this.qnaNo = qnaNo;
    }

    public String getQnaAuthor() {
        return qnaAuthor;
    }

    public void setQnaAuthor(String qnaAuthor) {
        this.qnaAuthor = qnaAuthor;
    }

    public String getQnaTitle() {
        return qnaTitle;
    }

    public void setQnaTitle(String qnaTitle) {
        this.qnaTitle = qnaTitle;
    }

    public String getQnaContents() {
        return qnaContents;
    }

    public void setQnaContents(String qnaContents) {
        this.qnaContents = qnaContents;
    }

    public int getQnaViews() {
        return qnaViews;
    }

    public void setQnaViews(int qnaViews) {
        this.qnaViews = qnaViews;
    }

    public Date getQnaRegDate() {
        return qnaRegDate;
    }

    public void setQnaRegDate(Date qnaRegDate) {
        this.qnaRegDate = qnaRegDate;
    }

    public int getQnaCategory() {
        return qnaCategory;
    }

    public void setQnaCategory(int qnaCategory) {
        this.qnaCategory = qnaCategory;
    }

    public int getIsAnswerStatus() {
        return isQnaAnswered;
    }

    public void setIsAnswerStatus(int isQnaAnswered) {
        this.isQnaAnswered = isQnaAnswered;
    }

    public String getQnaAnswerContents() {
        return qnaAnswerContents;
    }

    public void setQnaAnswerContents(String qnaAnswerContents) {
        this.qnaAnswerContents = qnaAnswerContents;
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

        return "Qna{" +
                "qnaNo=" + qnaNo +
                ", qnaAuthor='" + qnaAuthor +
                ", qnaTitle='" + qnaTitle +
                ", qnaContents='" + qnaContents +
                ", qnaViews=" + qnaViews +
                ", qnaRegDate=" + dateFormat.format(qnaRegDate) +
                ", qnaCategory=" + qnaCategory +
                ", isQnaAnswered=" + isQnaAnswered +
                ", qnaAnswerContents='" + qnaAnswerContents +
                ", boardCategory=" + boardCategory +
                '}';
    }
}
