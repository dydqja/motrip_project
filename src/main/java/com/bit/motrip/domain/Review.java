package com.bit.motrip.domain;

import java.util.Date;

public class Review {
    private int reviewNo;
    private int tripPlanNo;
    private String reviewAuthor;
    private String reviewTitle;
    private String reviewContents;
    private String reviewThumbnail;
    private String instaPostLink;
    private boolean isReviewPublic;
    private int reviewLikes;
    private int viewCount;
    private Date reviewRegDate;
    private boolean isReviewDeleted;
    private Date reviewDelDate;



    // 생성자, getter 및 setter 메서드


    public int getReviewNo() {
        return reviewNo;
    }

    public void setReviewNo(int reviewNo) {
        this.reviewNo = reviewNo;
    }

    public int getTripPlanNo() {
        return tripPlanNo;
    }

    public void setTripPlanNo(int tripPlanNo) {
        this.tripPlanNo = tripPlanNo;
    }

    public String getReviewAuthor() {
        return reviewAuthor;
    }

    public void setReviewAuthor(String reviewAuthor) {
        this.reviewAuthor = reviewAuthor;
    }

    public String getReviewTitle() {
        return reviewTitle;
    }

    public void setReviewTitle(String reviewTitle) {
        this.reviewTitle = reviewTitle;
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

    public Date getReviewRegDate() {
        return reviewRegDate;
    }

    public void setReviewRegDate(Date reviewRegDate) {
        this.reviewRegDate = reviewRegDate;
    }

    public boolean isReviewDeleted(boolean b) {
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

    @Override
    public String toString() {
        return "Review{" +
                "reviewNo=" + reviewNo +
                ", tripPlanNo=" + tripPlanNo +
                ", reviewAuthor='" + reviewAuthor + '\'' +
                ", reviewTitle='" + reviewTitle + '\'' +
                ", reviewContents='" + reviewContents + '\'' +
                ", reviewThumbnail='" + reviewThumbnail + '\'' +
                ", instaPostLink='" + instaPostLink + '\'' +
                ", isReviewPublic=" + isReviewPublic +
                ", reviewLikes=" + reviewLikes +
                ", viewCount=" + viewCount +
                ", reviewRegDate=" + reviewRegDate +
                ", isReviewDeleted=" + isReviewDeleted +
                ", reviewDelDate=" + reviewDelDate +
                '}';
    }
}
