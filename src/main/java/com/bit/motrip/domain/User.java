package com.bit.motrip.domain;

import com.sun.xml.internal.fastinfoset.util.StringArray;

import java.util.Date;
import java.util.List;

public class User {

    //Field
    private String userId;
    private String nickname;
    private String pwd;
    private String userName;
    private String phone;
    private String addr;
    private String addrDetail;
    private String email;
    private String ssn;
    private String selfIntro;
    private String userPhoto;
    private String gender;
    private String age;
    private int role;
    private Date userRegDate;
    private boolean isSecession;
    private Date secessionDate;
    private boolean isSuspension;
    private Date suspensionDate;
    private int warningCount;
    private boolean isSelfIntroPublic;
    private boolean isUserPhotoPublic;
    private boolean isUsingMemoBar;
    private boolean isListingAttachedMemo;
    private boolean isListingSharedMemo;
//    private List<String> accessibleMemos;

    //constructor
    public User() {

    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getNickName() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public String getAddrDetail() {
        return addrDetail;
    }

    public void setAddrDetail(String addrDetail) {
        this.addrDetail = addrDetail;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSsn() {
        return ssn;
    }

    public void setSsn(String ssn) {
        this.ssn = ssn;
    }

    public String getSelfIntro() {
        return selfIntro;
    }

    public void setSelfIntro(String selfIntro) {
        this.selfIntro = selfIntro;
    }

    public String getUserPhoto() {
        return userPhoto;
    }

    public void setUserPhoto(String userPhoto) {
        this.userPhoto = userPhoto;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAge() {
        return age;
    }

    public void setAge(String age) {
        this.age = age;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public Date getUserRegDate() {
        return userRegDate;
    }

    public void setUserRegDate(Date userRegDate) {
        this.userRegDate = userRegDate;
    }

    public boolean isSecession() {
        return isSecession;
    }

    public void setIsSecession(boolean isSecession) {
        this.isSecession = isSecession;
    }

    public Date getSecessionDate() {
        return secessionDate;
    }

    public void setSecessionDate(Date secessionDate) {
        this.secessionDate = secessionDate;
    }

    public boolean isSuspension() {
        return isSuspension;
    }

    public void setIsSuspension(boolean isSuspension) {
        this.isSuspension = isSuspension;
    }

    public Date getSuspensionDate() {
        return suspensionDate;
    }

    public void setSuspensionDate(Date suspensionDate) {
        this.suspensionDate = suspensionDate;
    }

    public int getWarningCount() {
        return warningCount;
    }

    public void setWarningCount(int warningCount) {
        this.warningCount = warningCount;
    }

    public boolean isSelfIntroPublic() {
        return isSelfIntroPublic;
    }

    public void setIsSelfIntroPublic(boolean isSelfIntroPublic) {
        this.isSelfIntroPublic = isSelfIntroPublic;
    }

    public boolean isUserPhotoPublic() {
        return isUserPhotoPublic;
    }

    public void setIsUserPhotoPublic(boolean isUserPhotoPublic) {
        this.isUserPhotoPublic = isUserPhotoPublic;
    }

    public boolean isUsingMemoBar() {
        return isUsingMemoBar;
    }

    public void setIsUsingMemoBar(boolean isUsingMemoBar) {
        this.isUsingMemoBar = isUsingMemoBar;
    }

    public boolean isListingAttachedMeMo() {
        return isListingAttachedMemo;
    }

    public void setIsListingAttachedMemo(boolean isListingAttachedMemo) {
        this.isListingAttachedMemo = isListingAttachedMemo;
    }

    public boolean isListingSharedMemo() {
        return isListingSharedMemo;
    }

    public void setIsListingSharedMemo(boolean isListingSharedMemo) {
        this.isListingSharedMemo = isListingSharedMemo;
    }

//    public List<String> getAceessableMemos() {
//        return accessibleMemos;
//    }
//
//    public void setAceessableMemos(List<String> aceessableMemos) {
//        this.accessibleMemos = aceessableMemos;
//    }

    @Override
    public String toString() {
        return "User{" +
                "userId='" + userId + '\'' +
                ", nickName='" + nickname + '\'' +
                ", pwd='" + pwd + '\'' +
                ", userName='" + userName + '\'' +
                ", phone='" + phone + '\'' +
                ", gender='" + gender + '\'' +
                ", age='" + age + '\'' +
                ", isScession=" + isSecession +
                ", isSuspension=" + isSuspension +
                '}';
    }
}
