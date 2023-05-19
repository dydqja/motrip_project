package com.bit.motrip.domain;


import java.util.Date;

//==>후기를 모델링(추상화/캡슐화)한 Bean
public class Review {

    ///Field
    private int reviewNo;
    private String reviewTitle;
    private String reviewAuthor;
    private String reviewContents;
    private String reviewThumbnail;
    private String instaPostLink;
    private boolean isReviewPublic;
    private int reviewLikes;
    private int viewCount;
    private Date reviewDate;
    private boolean isReviewDeleted;
    private Date reviewDelDate;

    //Comment 댓글
    private int commentNo;
    private String commentAuthor;
    private String commentContents;
    private Date commentRegDate;
    private int parentCommentNo;




    ///Constructor


    ///Method


    public int getReviewNo() {
        return reviewNo;
    }

    public void setReviewNo(int reviewNo) {
        this.reviewNo = reviewNo;
    }

    public String getReviewTitle() {
        return reviewTitle;
    }

    public void setReviewTitle(String reviewTitle) {
        this.reviewTitle = reviewTitle;
    }

    public String getReviewAuthor() {
        return reviewAuthor;
    }

    public void setReviewAuthor(String reviewAuthor) {
        this.reviewAuthor = reviewAuthor;
    }

    public String getReviewContents() {
        return reviewContents;
    }

    public void setReviewContents(String reviewContents) {
        this.reviewContents = reviewContents;
    }

    public String getReviewThumbnail() {
        return reviewThumbnail;
    }

    public void setReviewThumbnail(String reviewThumbnail) {
        this.reviewThumbnail = reviewThumbnail;
    }

    public String getInstaPostLink() {
        return instaPostLink;
    }

    public void setInstaPostLink(String instaPostLink) {
        this.instaPostLink = instaPostLink;
    }

    public boolean isReviewPublic() {
        return isReviewPublic;
    }

    public void setReviewPublic(boolean reviewPublic) {
        isReviewPublic = reviewPublic;
    }

    public int getReviewLikes() {
        return reviewLikes;
    }

    public void setReviewLikes(int reviewLikes) {
        this.reviewLikes = reviewLikes;
    }

    public int getViewCount() {
        return viewCount;
    }

    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }

    public Date getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(Date reviewDate) {
        this.reviewDate = reviewDate;
    }

    public boolean isReviewDeleted() {
        return isReviewDeleted;
    }

    public void setReviewDeleted(boolean reviewDeleted) {
        isReviewDeleted = reviewDeleted;
    }

    public Date getReviewDelDate() {
        return reviewDelDate;
    }

    public void setReviewDelDate(Date reviewDelDate) {
        this.reviewDelDate = reviewDelDate;
    }


    //Comment 댓글
    public int getCommentNo() {
        return commentNo;
    }

    public void setCommentNo(int commentNo) {
        this.commentNo = commentNo;
    }

    public String getCommentAuthor() {
        return commentAuthor;
    }

    public void setCommentAuthor(String commentAuthor) {
        this.commentAuthor = commentAuthor;
    }

    public String getCommentContents() {
        return commentContents;
    }

    public void setCommentContents(String commentContents) {
        this.commentContents = commentContents;
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
}//end of Review
