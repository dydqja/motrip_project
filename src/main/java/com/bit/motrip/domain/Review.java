package com.bit.motrip.domain;

import org.springframework.format.annotation.DateTimeFormat;

import java.text.ParseException;
import java.text.SimpleDateFormat;
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
    @DateTimeFormat(pattern = "yyyyMMdd")
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

    public Date setReviewRegDate(Date reviewRegDate) {
        return reviewRegDate;
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
        if (reviewDelDate != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd"); // 날짜 형식을 지정하는 SimpleDateFormat 객체 생성
            String formattedDate = sdf.format(reviewDelDate); // 받아온 reviewDelDate를 yyyyMMdd 형식으로 변환하여 문자열로 저장
            try {
                this.reviewDelDate = sdf.parse(formattedDate); // yyyyMMdd 형식의 문자열을 Date 객체로 변환하여 reviewDelDate 필드에 설정
            } catch (ParseException e) { // 변환 중 예외가 발생한 경우 처리
                e.printStackTrace(); // 예외 내용 출력
            }
        } else {
            this.reviewDelDate = null; // reviewDelDate가 null인 경우 reviewDelDate 필드도 null로 설정
        }
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
