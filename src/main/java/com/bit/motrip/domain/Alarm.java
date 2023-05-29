package com.bit.motrip.domain;

public class Alarm {
    private int alarmNo;
    //썸네일에 표시될 작은 요약 내용.
    private String alarmTitle;
    //자세히보기할 때 보여질 진짜 내용.
    private String alarmContents;

    private String alarmSender;
    private String alarmReceiver;
    private String alarmRegDate;
    private String alarmReadDate;
    private String alarmUriOne;
    private String alarmUriTwo;
    private String alarmUriThree;
    private String alarmBtnOne;
    private String alarmBtnTwo;
    private String alarmBtnThree;


    //getter, setter
    public int getAlarmNo() {
        return alarmNo;
    }

    public void setAlarmNo(int alarmNo) {
        this.alarmNo = alarmNo;
    }

    public String getAlarmTitle() {
        return alarmTitle;
    }

    public void setAlarmTitle(String alarmTitle) {
        this.alarmTitle = alarmTitle;
    }

    public String getAlarmContents() {
        return alarmContents;
    }

    public void setAlarmContents(String alarmContents) {
        this.alarmContents = alarmContents;
    }

    public String getAlarmSender() {
        return alarmSender;
    }

    public void setAlarmSender(String alarmSender) {
        this.alarmSender = alarmSender;
    }

    public String getAlarmReceiver() {
        return alarmReceiver;
    }

    public void setAlarmReceiver(String alarmReceiver) {
        this.alarmReceiver = alarmReceiver;
    }

    public String getAlarmRegDate() {
        return alarmRegDate;
    }

    public void setAlarmRegDate(String alarmRegDate) {
        this.alarmRegDate = alarmRegDate;
    }

    public String getAlarmReadDate() {
        return alarmReadDate;
    }

    public void setAlarmReadDate(String alarmReadDate) {
        this.alarmReadDate = alarmReadDate;
    }

    public String getAlarmUriOne() {
        return alarmUriOne;
    }

    public void setAlarmUriOne(String alarmUriOne) {
        this.alarmUriOne = alarmUriOne;
    }

    public String getAlarmUriTwo() {
        return alarmUriTwo;
    }

    public void setAlarmUriTwo(String alarmUriTwo) {
        this.alarmUriTwo = alarmUriTwo;
    }

    public String getAlarmUriThree() {
        return alarmUriThree;
    }

    public void setAlarmUriThree(String alarmUriThree) {
        this.alarmUriThree = alarmUriThree;
    }

    public String getAlarmBtnOne() {
        return alarmBtnOne;
    }

    public void setAlarmBtnOne(String alarmBtnOne) {
        this.alarmBtnOne = alarmBtnOne;
    }

    public String getAlarmBtnTwo() {
        return alarmBtnTwo;
    }

    public void setAlarmBtnTwo(String alarmBtnTwo) {
        this.alarmBtnTwo = alarmBtnTwo;
    }

    public String getAlarmBtnThree() {
        return alarmBtnThree;
    }

    public void setAlarmBtnThree(String alarmBtnThree) {
        this.alarmBtnThree = alarmBtnThree;
    }

    //toString

    @Override
    public String toString() {
        return "Alarm{" +
                "alarmNo=" + alarmNo +
                ", alarmTitle='" + alarmTitle + '\'' +
                ", alarmContents='" + alarmContents + '\'' +
                ", alarmSender='" + alarmSender + '\'' +
                ", alarmReceiver='" + alarmReceiver + '\'' +
                ", alarmRegDate='" + alarmRegDate + '\'' +
                ", alarmReadDate='" + alarmReadDate + '\'' +
                ", alarmUriOne='" + alarmUriOne + '\'' +
                ", alarmUriTwo='" + alarmUriTwo + '\'' +
                ", alarmUriThree='" + alarmUriThree + '\'' +
                ", alarmBtnOne='" + alarmBtnOne + '\'' +
                ", alarmBtnTwo='" + alarmBtnTwo + '\'' +
                ", alarmBtnThree='" + alarmBtnThree + '\'' +
                '}';
    }
}
