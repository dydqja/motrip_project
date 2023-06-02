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
        String commitTitle = "템플릿 적용";
        //수정내역
        String commitBody = "각자 자기버튼 header에 다시 만드세요. 공용페이지는 이제 각자 조금씩 꾸밉시다.";
        //수정파일
        String changedFiles = "(assets, vendors, index, tiles.xml, footer, header)";
        gitCommitMSGBuilder(committers[0],commitType[0],commitTitle,commitBody,changedFiles);
    }
}
