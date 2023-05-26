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

        //make commit msg
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
        String commitTitle = "MemoService 5단조인 목록보기 보완";
        //수정내역
        String commitBody = "MemoDoc = 메모가 부착된 문서를 표현하기 위한 DTO를 만들었다." +
                "MemoDocContainer = Memo들이 부착된 문서들을 중복을 제거하고 하나로 엮기 위한 메소드를 가진 객체를 만들었다." +
                "MemoMapper = 조인할 때 조건을 잘못 설정했었다. MemoAccess테이블을 기준으로 조인하여 논리오류 없이 목록을 가져올 수 있도록 수정했다." +
                "";
        //수정파일
        String changedFiles = "(Memo.java, MemoDoc.java, MemoDocContainer.java, MemoMapper.xml)";
        gitCommitMSGBuilder(committers[0],commitType[1],commitTitle,commitBody,changedFiles);
    }
}
