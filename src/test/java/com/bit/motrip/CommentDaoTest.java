package com.bit.motrip;

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
        Comment comment = new Comment();
        //comment.setCommentNo(1);
        comment.setCommentAuthor("재연쓰용범스은진스");
        comment.setCommentContent("댓글내용쓰");
        comment.setCommentRegDate(new Date());
        System.out.println(new Date());
        comment.setParentCommentNo(0);
        System.out.println("Comment add 완료");
    }

    //@Test
    void getCommentList() throws Exception {
        int reviewNo = 1;
        List<Comment> commentList =  commentService.getCommentList(reviewNo);
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
        commentService.deleteComment(commentNo);
        System.out.println("댓글이 삭제되었습니다.");
    }
}