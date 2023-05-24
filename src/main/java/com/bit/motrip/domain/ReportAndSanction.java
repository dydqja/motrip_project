package com.bit.motrip.domain;

import java.util.Date;
import java.util.List;

public class ReportAndSanction {

    //Field
    private int reportNo;
    private String reporterId;
    private String reportedUserId;
    private Date reportDate;
    private String reportReason;
    private String reportContents;
    private Integer reportChatRoomNo;
    private Integer reportTripPlanNo;
    private Integer reportReviewNo;
    private String sanctionDetail;
    private Date sanctionDate;
    private int sanctionResult;

    public int getReportNo() {
        return reportNo;
    }

    public void setReportNo(int reportNo) {
        this.reportNo = reportNo;
    }

    public String getReporterId() {
        return reporterId;
    }

    public void setReporterId(String reporterId) {
        this.reporterId = reporterId;
    }

    public String getReportedUserId() {
        return reportedUserId;
    }

    public void setReportedUserId(String reportedUserId) {
        this.reportedUserId = reportedUserId;
    }

    public Date getReportDate() {
        return reportDate;
    }

    public void setReportDate(Date reportDate) {
        this.reportDate = reportDate;
    }

    public String getReportReason() {
        return reportReason;
    }

    public void setReportReason(String reportReason) {
        this.reportReason = reportReason;
    }

    public String getReportContents() {
        return reportContents;
    }

    public void setReportContents(String reportContents) {
        this.reportContents = reportContents;
    }

    public Integer getReportChatRoomNo() {
        return reportChatRoomNo;
    }

    public void setReportChatRoomNo(Integer reportChatRoomNo) {
        this.reportChatRoomNo = reportChatRoomNo;
    }

    public Integer getReportTripPlanNo() {
        return reportTripPlanNo;
    }

    public void setReportTripPlanNo(Integer reportTripPlanNo) {
        this.reportTripPlanNo = reportTripPlanNo;
    }

    public Integer getReportReviewNo() {
        return reportReviewNo;
    }

    public void setReportReviewNo(Integer reportReviewNo) {
        this.reportReviewNo = reportReviewNo;
    }

    public String getSanctionDetail() {
        return sanctionDetail;
    }

    public void setSanctionDetail(String sanctionDetail) {
        this.sanctionDetail = sanctionDetail;
    }

    public Date getSanctionDate() {
        return sanctionDate;
    }

    public void setSanctionDate(Date sanctionDate) {
        this.sanctionDate = sanctionDate;
    }

    public int getSanctionResult() {
        return sanctionResult;
    }

    public void setSanctionResult(int sanctionResult) {
        this.sanctionResult = sanctionResult;
    }

    @Override
    public String toString() {
        return "ReportAndSanction{" +
                "reportNo=" + reportNo +
                ", reporterId='" + reporterId + '\'' +
                ", reportedUserId='" + reportedUserId + '\'' +
                ", reportDate=" + reportDate +
                ", reportReason=" + reportReason +
                ", reportContents='" + reportContents + '\'' +
                ", reportChatRoomNo=" + reportChatRoomNo +
                ", reportTripPlanNo=" + reportTripPlanNo +
                ", reportReviewNo=" + reportReviewNo +
                ", sanctionDetail='" + sanctionDetail + '\'' +
                ", sanctionDate=" + sanctionDate +
                ", sanctionResult=" + sanctionResult +
                '}';
    }
}
