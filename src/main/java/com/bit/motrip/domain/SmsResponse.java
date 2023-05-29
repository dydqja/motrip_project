package com.bit.motrip.domain;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.time.LocalDateTime;

public class SmsResponse {

    private String requestId;
    private LocalDateTime requestTime;
    private String statusCode;
    private String statusName;
    private String smsConfirmNum;

    @JsonCreator
    public SmsResponse(@JsonProperty("requestId") String requestId,
                          @JsonProperty("requestTime") LocalDateTime requestTime,
                          @JsonProperty("statusCode") String statusCode,
                          @JsonProperty("statusName") String statusName,
                          @JsonProperty("smsComfirmNum") String smsConfirmNum) {

        this.requestId = requestId;
        this.requestTime = requestTime;
        this.statusCode = statusCode;
        this.statusName = statusName;
        this.smsConfirmNum = smsConfirmNum;
    }

    public SmsResponse(String smsConfirmNum) {

        this.smsConfirmNum = smsConfirmNum;

    }

    public String getRequestId() {
        return requestId;
    }

    public LocalDateTime getRequestTime() {
        return requestTime;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public String getStatusName() {
        return statusName;
    }

    public String getSmsConfirmNum() {
        return smsConfirmNum;
    }

    @Override
    public String toString() {
        return "SmsResponseDto : [smsConfirmNum] " +smsConfirmNum+
                ",[requestId] " +requestId+
                ",[requestTime] " +requestTime+
                ",[statusCode] " +statusCode+
                ",[statusName] " +statusName;

    }

}