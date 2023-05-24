package com.bit.motrip.common;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class CommitMaker {
    public static void gitCommitMSGBuilder(String committer,String typeofCommit,String commitTitle,String commitComment,String changedFiles){
        //Fields

        //make current time
        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yy/MM/dd HH:mm");
        String stringDate = currentDateTime.format(formatter);

        String commitHeader = committer+"/"+typeofCommit+" "+stringDate+" "+commitTitle;
        String commitBody = commitComment;
        String commitFooter = changedFiles;
        System.out.println(commitHeader);
        System.out.println();
        System.out.println(commitBody);
        System.out.println();
        System.out.println(commitFooter);
    }

    public static void main(String[] args) {
        //                        0         1      2     3      4      5
        String[] committers = {"alex6", "angie", "psw","sean","song","sso"};
        //                        0         1          2            3                4                5
        String[] commitType = {"Create", "Update", "Delete", "Create&Update", "Update&Delete", "Create&Delete"};
        //커밋 소제목
        String commitTitle = "jsp 폴더만들고 chatRoom service Update 하였습니다.";
        //수정내역
        String commitBody = "jsp 폴더구조 생성" +
                "good" +
                "css/js 연결 하도록해야합니다.";
        //수정파일
        String changedFiles = "(Memo.java, MemoDao.java, MemoService.java, MemoMapper.xml,MemoAttachable 삭제";
        gitCommitMSGBuilder(committers[3],commitType[3],commitTitle,commitBody,changedFiles);
    }
}
