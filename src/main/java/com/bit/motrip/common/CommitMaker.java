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
        String commitTitle = "MemoService 초벌 테스트& 보완완료";
        //수정내역
        String commitBody = "MemoService 간단 테스트 완료." +
                "MemoAccess 를 추가할 때 중복 체크가 없던 문제를 해결 " +
                "MemoService 단의 각종 메소드들의 리턴 타입을 Memo로 지정해서 화면단이 바뀐 것을 바로 받아보도록 수정" +
                "memo 프로퍼티로부터 각종 메타데이터를 받아와서 서비스에서 활용하도록 변경" +
                "";
        //수정파일
        String changedFiles = "(Memo.java, MemoDao.java, MemoService.java, MemoMapper.xml, MemoServiceImpl.java)";
        gitCommitMSGBuilder(committers[0],commitType[1],commitTitle,commitBody,changedFiles);
    }
}
