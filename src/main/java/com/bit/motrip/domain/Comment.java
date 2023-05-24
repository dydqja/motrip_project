package com.bit.motrip.domain;

import java.util.Date;

public class Comment {

    //Comment 댓글
    private int commentNo;
    private  int reviewNo;
    private String commentAuthor;
    private String commentContent;
    private Date commentRegDate;
    private int parentCommentNo;


    //Comment 댓글


    public int getCommentNo() {
        return commentNo;
    }

    public void setCommentNo(int commentNo) {
        this.commentNo = commentNo;
    }

    public int getReviewNo() {
        return reviewNo;
    }

    public void setReviewNo(int reviewNo) {
        this.reviewNo = reviewNo;
    }

    public String getCommentAuthor() {
        return commentAuthor;
    }

    public void setCommentAuthor(String commentAuthor) {
        this.commentAuthor = commentAuthor;
    }

    public String getCommentContent() {
        return commentContent;
    }

    public void setCommentContent(String commentContent) {
        this.commentContent = commentContent;
    }

    public Date getCommentRegDate() {
        return commentRegDate;
    }

    public void setCommentRegDate(Date commentRegDate) {
        this.commentRegDate = commentRegDate;
    }

    public int getParentCommentNo() {
        return parentCommentNo;
    }

    public void setParentCommentNo(int parentCommentNo) {
        this.parentCommentNo = parentCommentNo;
    }

    @Override
    public String toString() {
        return "Comment{" +
                "commentNo=" + commentNo +
                ", reviewNo=" + reviewNo +
                ", commentAuthor='" + commentAuthor + '\'' +
                ", commentContent='" + commentContent + '\'' +
                ", commentRegDate=" + commentRegDate +
                ", parentCommentNo=" + parentCommentNo +
                '}';
    }
}
