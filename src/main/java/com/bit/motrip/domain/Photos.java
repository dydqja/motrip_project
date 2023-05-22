package com.bit.motrip.domain;

public class Photos { //사진 도메인
    private int photoNo; //사진 번호
    private String photoId; //사진 아이디
    private int chatRoomNo; //채팅방 번호

    public int getPhotoNo() {
        return photoNo;
    }

    public void setPhotoNo(int photoNo) {
        this.photoNo = photoNo;
    }

    public String getPhotoId() {
        return photoId;
    }

    public void setPhotoId(String photoId) {
        this.photoId = photoId;
    }

    public int getChatRoomNo() {
        return chatRoomNo;
    }

    public void setChatRoomNo(int chatRoomNo) {
        this.chatRoomNo = chatRoomNo;
    }
}
