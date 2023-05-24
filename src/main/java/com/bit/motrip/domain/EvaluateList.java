package com.bit.motrip.domain;

import java.util.Map;

public class EvaluateList {

    //Field
    private int evaluateListNo;
    private String evaluaterId;
    private String evaluatedUserId;
    private Integer evaluatedTripPlanNo;
    private Integer evaluatedReviewNo;
    private int isScorePlus;
    private String blacklistedUserId;

    //Constructor
    public EvaluateList() {

    }

    public int getEvaluateListNo() {
        return evaluateListNo;
    }

    public void setEvaluateListNo(int evaluateListNo) {
        this.evaluateListNo = evaluateListNo;
    }

    public String getEvaluaterId() {
        return evaluaterId;
    }

    public void setEvaluaterId(String evaluaterId) {
        this.evaluaterId = evaluaterId;
    }

    public String getEvaluatedUserId() {
        return evaluatedUserId;
    }

    public void setEvaluatedUserId(String evaluatedUserId) {
        this.evaluatedUserId = evaluatedUserId;
    }

    public Integer getEvaluatedTripPlanNo() {
        return evaluatedTripPlanNo;
    }

    public void setEvaluatedTripPlanNo(Integer evaluatedTripPlanNo) {
        this.evaluatedTripPlanNo = evaluatedTripPlanNo;
    }

    public Integer getEvaluatedReviewNo() {
        return evaluatedReviewNo;
    }

    public void setEvaluatedReviewNo(Integer evaluatedReviewNo) {
        this.evaluatedReviewNo = evaluatedReviewNo;
    }

    public int getIsScorePlus() {
        return isScorePlus;
    }

    public void setIsScorePlus(int isScorePlus) {
        this.isScorePlus = isScorePlus;
    }

    public String getBlacklistedUserId() {
        return blacklistedUserId;
    }

    public void setBlacklistedUserId(String blacklistedUserId) {
        this.blacklistedUserId = blacklistedUserId;
    }

    @Override
    public String toString() {
        return "EvaluateList{" +
                "evaluateListNo=" + evaluateListNo +
                ", evaluaterId='" + evaluaterId + '\'' +
                ", evaluatedUserId='" + evaluatedUserId + '\'' +
                ", evaluatedTripPlanNo=" + evaluatedTripPlanNo +
                ", evaluatedReviewNo=" + evaluatedReviewNo +
                ", isScorePlus=" + isScorePlus +
                ", blacklistedUserId='" + blacklistedUserId + '\'' +
                '}';
    }
}
