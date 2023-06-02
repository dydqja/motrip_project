package com.bit.motrip.domain;

public class Alarm {
    private int alarmNo;
    private String alarmCategory;
    // 1 수락,취소 알람 : 수락, 거절, 보류 / 채팅방 초대받음
    // 2 네비게이션 통지 알람 : 가보기, 확인 / 채팅방
    // 3 단순 통지 알람 : 확인 /경고받음, 제제, 채팅방 강퇴, 채팅방 초대거절됨,

    //종류에 따라서 생기는 버튼과, 갖고있는 정보가 다르다.
    private String alarmImportant;
    //1 긴급알람
    //2 일반알람
    //3 보류알람

    // 중요도에 따라 알람 색이 다르다.
    private String alarmTitle; //

    private String alarmContents; // 자세한 내용

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

    public String getAlarmCategory() {
        return alarmCategory;
    }

    public void setAlarmCategory(String alarmCategory) {
        this.alarmCategory = alarmCategory;
    }

    public String getAlarmImportant() {
        return alarmImportant;
    }

    public void setAlarmImportant(String alarmImportant) {
        this.alarmImportant = alarmImportant;
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
