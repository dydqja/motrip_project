package com.bit.motrip.review;

import com.bit.motrip.dao.review.CommentDao;
import com.bit.motrip.domain.Comment;
import com.bit.motrip.service.review.CommentService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Date;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class CommentDaoTest {

    @Autowired
    @Qualifier("commentServiceImpl")
    private CommentService commentService;

    //@Test
    void addComment() {
        // Comment 1
        Comment comment1 = new Comment();
        comment1.setCommentAuthor("재연쓰용범스은진스");
        comment1.setCommentContent("댓글내용쓰");
        comment1.setCommentRegDate(new Date());
        comment1.setParentCommentNo(0);
        System.out.println("댓글 작성일시: " + comment1.getCommentRegDate());
        System.out.println("추가된 댓글 정보: " + comment1);

        // Comment 2
        Comment comment2 = new Comment();
        comment2.setCommentAuthor("사용자2");
        comment2.setCommentContent("댓글 내용2");
        comment2.setCommentRegDate(new Date());
        comment2.setParentCommentNo(0);
        System.out.println("댓글 작성일시: " + comment2.getCommentRegDate());
        System.out.println("추가된 댓글 정보: " + comment2);

        // Comment 3 (Comment 1에 대한 대댓글)
        Comment comment3 = new Comment();
        comment3.setCommentAuthor("재연쓰용범스은진스");
        comment3.setCommentContent("대댓글 내용");
        comment3.setCommentRegDate(new Date());
        comment3.setParentCommentNo(1); // 대댓글의 부모 댓글 번호 설정
        System.out.println("댓글 작성일시: " + comment3.getCommentRegDate());
        System.out.println("추가된 댓글 정보: " + comment3);
    }



    //@Test
    void getCommentList() throws Exception {
        int reviewNo = 1;
        List<Comment> commentList =  commentService.getCommentList(reviewNo);
        //가져온 댓글 목록을 출력쓰
        System.out.println(commentList);
    }

    //@Test
    void getComment() throws Exception{
        int commentNo = 6; // 조회하고자 하는 댓글 번호를 입력
        Comment comment = commentService.getComment(commentNo);
        System.out.println(comment);
    }

    //@Test
    void deleteComment() {
        int commentNo = 4; // 삭제하고자 하는 댓글 번호를 입력하세요
        try {
            commentService.deleteComment(commentNo);
            System.out.println("댓글이 삭제되었습니다.");
        } catch (Exception e) {
            System.out.println("댓글 삭제에 실패했습니다. 다시 시도해주십시오");
        }
    }


}