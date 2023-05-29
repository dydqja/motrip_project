package com.bit.motrip.domain;

public class SmsMessage {
    private String to;
//    String content; ==> 별도의 문자메시지 보낼때 사용.

    public SmsMessage() {

    }

    public SmsMessage(String to) {
        this.to = to;
    }

    public String getTo() {
        return to;
    }

    @Override
    public String toString() {
        return "MessageDto {" +
                "to = '" + to + '\'' +
                '}';
    }
}
