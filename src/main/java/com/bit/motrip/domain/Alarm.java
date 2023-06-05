package com.bit.motrip.domain;

public class Alarm {

    private int alarmNo;
    private String alarmCategory;
    // 1 수락,취소 알람 : 수락, 거절, 보류 / 채팅방 초대받음 = 알람의 목록 조건
    // 2 네비게이션 통지 알람 : 가보기, 확인 / 채팅방 = 긴급알람을 띄우지 않음.
    // 3 단순 통지 알람 : 확인 /경고받음, 제제, 채팅방 강퇴, 채팅방 초대거절됨 = 알람의 목록 조건

    //종류에 따라서 생기는 버튼과, 갖고있는 정보가 다르다.
    private String alarmLevel;
    //1 리스트에 출력된적도 없는 알람. (add 직후)
    //2 리스트에 출력은 됐으나, 상세보기된적은 없는 알람. (list Emerg 직후)
    //3 상세보기가 됐으나, 보류해둔 알람 (hold 직후)
    //4 읽혀서 삭제를 대기중인 알람 (read 직후)
    // 중요도에 따라   알람 색이 다르다.
    private String alarmTitle; //
    private String alarmContents; // 자세한 내용
    private String alarmSender;
    private String alarmSenderNick;
    private String alarmReceiver;
    private String alarmReceiverNick;
    private String alarmRegDate;
    private String alarmReadDate;
    private String alarmAcceptUrl;
    private String alarmRejectUrl;
    private String alarmNaviUrl;
    private int alarmHold;

    public int getAlarmNo() {
        return alarmNo;
    }

    public void setAlarmNo(int alarmNo) {
        this.alarmNo = alarmNo;
    }

    public String getAlarmCategory() {
        return alarmCategory;
    }

    public void setAlarmCategory(String alarmCategory) {
        this.alarmCategory = alarmCategory;
    }

    public String getAlarmLevel() {
        return alarmLevel;
    }

    public void setAlarmLevel(String alarmLevel) {
        this.alarmLevel = alarmLevel;
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

    public String getAlarmSenderNick() {
        return alarmSenderNick;
    }

    public void setAlarmSenderNick(String alarmSenderNick) {
        this.alarmSenderNick = alarmSenderNick;
    }

    public String getAlarmReceiver() {
        return alarmReceiver;
    }

    public void setAlarmReceiver(String alarmReceiver) {
        this.alarmReceiver = alarmReceiver;
    }

    public String getAlarmReceiverNick() {
        return alarmReceiverNick;
    }

    public void setAlarmReceiverNick(String alarmReceiverNick) {
        this.alarmReceiverNick = alarmReceiverNick;
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

    public String getAlarmAcceptUrl() {
        return alarmAcceptUrl;
    }

    public void setAlarmAcceptUrl(String alarmAcceptUrl) {
        this.alarmAcceptUrl = alarmAcceptUrl;
    }

    public String getAlarmRejectUrl() {
        return alarmRejectUrl;
    }

    public void setAlarmRejectUrl(String alarmRejectUrl) {
        this.alarmRejectUrl = alarmRejectUrl;
    }

    public String getAlarmNaviUrl() {
        return alarmNaviUrl;
    }

    public void setAlarmNaviUrl(String alarmNaviUrl) {
        this.alarmNaviUrl = alarmNaviUrl;
    }

    public int getAlarmHold() {
        return alarmHold;
    }

    public void setAlarmHold(int alarmHold) {
        this.alarmHold = alarmHold;
    }

    @Override
    public String toString() {
        return "Alarm{" +
                "alarmNo=" + alarmNo +
                ", alarmCategory='" + alarmCategory + '\'' +
                ", alarmLevel='" + alarmLevel + '\'' +
                ", alarmTitle='" + alarmTitle + '\'' +
                ", alarmContents='" + alarmContents + '\'' +
                ", alarmSender='" + alarmSender + '\'' +
                ", alarmSenderNick='" + alarmSenderNick + '\'' +
                ", alarmReceiver='" + alarmReceiver + '\'' +
                ", alarmReceiverNick='" + alarmReceiverNick + '\'' +
                ", alarmRegDate='" + alarmRegDate + '\'' +
                ", alarmReadDate='" + alarmReadDate + '\'' +
                ", alarmAcceptUrl='" + alarmAcceptUrl + '\'' +
                ", alarmRejectUrl='" + alarmRejectUrl + '\'' +
                ", alarmNaviUrl='" + alarmNaviUrl + '\'' +
                ", alarmHold=" + alarmHold +
                '}';
    }
}
