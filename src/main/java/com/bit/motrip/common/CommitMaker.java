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
        String commitTitle = "블랙리스트 추가 및 블랙리스트목록 구현 및 테스트 완료";
        //수정내역
        String commitBody = "타 회원 상세보기 페이지에서 블랙추가 및 취소 가능, 본인 회원 상세보기 페이지에서 블랙리스트목록 볼 수 있고, 목록에서 닉네임 클릭 시 해당 닉네임 회원 상세보기 페이지로 이동";
        //수정파일
        String changedFiles = "(listBlackModal.jsp/UserRestController.java/UserMapper.xml)";
        gitCommitMSGBuilder(committers[4],commitType[0],commitTitle,commitBody,changedFiles);
    }
}
