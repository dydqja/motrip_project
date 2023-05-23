package com.bit.motrip.common;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class CommonUtil {
    public static void gitCommitMSGBuilder(int committer,int typeofCommit,String changedFiles,String commitComments){
        //Fields
        String[] committers = {"alex6", "angie", "psw","sean","song","sso"};
        String[] commitType = {"Create", "Update", "Delete"};
        //make current time
        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yy/MM/dd HH:mm");
        String stringDate = currentDateTime.format(formatter);

        String commitMSG = committers[committer]+"/"+commitType[typeofCommit]+" "+stringDate+" "+commitComments+changedFiles;
        System.out.println(commitMSG);
    }

    public static void main(String[] args) {
        //수정내역
        String commitComments = "service layer에 로직생성 + assertions test";
        //수정파일
        String changedFiles = "(ChatRoomServiceImpl.java, chatRoomTests)";
        gitCommitMSGBuilder(3,1,changedFiles,commitComments);
    }
}
