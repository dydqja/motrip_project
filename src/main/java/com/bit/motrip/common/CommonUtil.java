package com.bit.motrip.common;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class CommonUtil {
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
        String commitTitle = "MemoDao CRUD 완성 but Page처리는 아직";
        //수정내역
        String commitBody = "MemoDao,Mapper,DaoTest : Search 와 join 을 활용한 메모리스트 조회 기능추가, delete에 유저검증기능 " +
                "MemoAttach 삭제,";
        //수정파일
        String changedFiles = "(memo 관련 파일 전부, Search updated, MemoAttach.java 삭제)";
        gitCommitMSGBuilder(committers[0],commitType[4],commitTitle,commitBody,changedFiles);
    }
}
