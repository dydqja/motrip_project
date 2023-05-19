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
        String commitComments = "memo 조인된 Add 구현완료.MemoAccess 객체 추가 TestUtil추가";
        //수정파일
        String changedFiles = "(Memo.java, MemoDao.java, MemoDaoTest.java, MemoDao.xml, MemoMapper.xml)";
        gitCommitMSGBuilder(0,0,changedFiles,commitComments);
    }
}
