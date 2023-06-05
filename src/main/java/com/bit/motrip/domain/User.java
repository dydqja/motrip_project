package com.bit.motrip.domain;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.Map;

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
    private Timestamp suspensionDate;
    private int warningCount;
    private boolean isSelfIntroPublic;
    private boolean isUserPhotoPublic;
    private boolean isUsingMemoBar;
    private boolean isListingAttachedMemo;
    private boolean isListingSharedMemo;
    private int evaluateCount;
//    private List<String> accessibleMemos;

    //constructor
    public User() {

    }

    public User(String userId, String nickname) {
        this.userId = userId;
        this.nickname = nickname;
    }

    public User(String phone) {
        this.phone = newphone(phone);
    }

    private String newphone(String phone) {
        return phone.substring(0, 3) + "-" + phone.substring(3, 7) + "-" + phone.substring(7);
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getNickname() {
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

    public void setSecession(boolean secession) {
        isSecession = secession;
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

    public void setSuspension(boolean suspension) {
        isSuspension = suspension;
    }

    public Timestamp getSuspensionDate() {
        return suspensionDate;
    }

    public void setSuspensionDate(Timestamp suspensionDate) {
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

    public void setSelfIntroPublic(boolean selfIntroPublic) {
        isSelfIntroPublic = selfIntroPublic;
    }

    public boolean isUserPhotoPublic() {
        return isUserPhotoPublic;
    }

    public void setUserPhotoPublic(boolean userPhotoPublic) {
        isUserPhotoPublic = userPhotoPublic;
    }

    public boolean isUsingMemoBar() {
        return isUsingMemoBar;
    }

    public void setUsingMemoBar(boolean usingMemoBar) {
        isUsingMemoBar = usingMemoBar;
    }

    public boolean isListingAttachedMemo() {
        return isListingAttachedMemo;
    }

    public void setListingAttachedMemo(boolean listingAttachedMemo) {
        isListingAttachedMemo = listingAttachedMemo;
    }

    public boolean isListingSharedMemo() {
        return isListingSharedMemo;
    }

    public void setListingSharedMemo(boolean listingSharedMemo) {
        isListingSharedMemo = listingSharedMemo;
    }

    public int getEvaluateCount() {
        return evaluateCount;
    }

    public void setEvaluateCount(int evaluateCount) {
        this.evaluateCount = evaluateCount;
    }
//    public List<String> getAceessableMemos() {
//        return accessibleMemos;
//    }
//
//    public void setAceessableMemos(List<String> aceessableMemos) {
//        this.accessibleMemos = aceessableMemos;
//    }

    public static User naverUser(Map<String, String> map) {
        User user = new User();
        user.setUserId(map.get("id"));
        user.setUserName(map.get("name"));
        user.setPhone(map.get("mobile"));
        user.setEmail(map.get("email"));
        user.setGender(map.get("gender"));
        user.setAge(map.get("age"));
        return user;
    }

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
                ", isSecession=" + isSecession +
                ", isSuspension=" + isSuspension +
                ", role=" + role +
                ", evaluateCount=" + evaluateCount +
                '}';
    }
}
