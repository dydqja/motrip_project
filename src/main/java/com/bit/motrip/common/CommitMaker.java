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
        String commitTitle = "MemoService 작성,MemoDao 보완";
        //수정내역
        String commitBody = "MemoService는 작성 종료." +
                "MemoDao는 Search 에 맞춰서 limit으로 끊어서 조회하는 기능이 추가되었으며 나 스스로도 감당이 안 되는" +
                "if문 잔뜩인 dynamic 쿼리문을, 내 수준에 맞춰서 method를 달리 하는 것으로 어느정도 해결하였다.";
        //수정파일
        String changedFiles = "(Memo.java, MemoDao.java, MemoService.java, MemoMapper.xml,MemoAttachable 삭제";
        gitCommitMSGBuilder(committers[0],commitType[4],commitTitle,commitBody,changedFiles);
    }
}
