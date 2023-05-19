package com.bit.motrip.common;
import ch.qos.logback.core.net.SyslogOutputStream;

import javax.swing.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class CommonUtil {
    public static void gitCommitMSGBuilder(int committer,int typeofCommit,String changedFiles,String commitComments){
        String commitMSG = "";
        //Fields
        String[] committers = {"alex6", "angie", "psw","sean","song","sso"};
        String[] commitType = {"Create", "Update", "Delete"};
        //make current time
        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yy/MM/dd HH:mm");
        String stringDate = currentDateTime.format(formatter);

        commitMSG = committers[committer]+"/"+commitType[typeofCommit]+" "+stringDate+" "+commitComments+changedFiles;
        System.out.println(commitMSG);
    }
    public static void main(String[] args) {
        //수정내역
        String commitComments = "이거했습니다.";
        //수정파일
        String changedFiles = "(MemoDao.java, MemoMapper.xml)";
        gitCommitMSGBuilder(0,0,changedFiles,commitComments);
    }
}
