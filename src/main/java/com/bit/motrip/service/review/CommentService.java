package com.bit.motrip.service.review;

import com.bit.motrip.domain.Comment;
import java.util.List;

public interface CommentService {

    //INSERT C 댓글 작성
    public void addComment()throws Exception;

    //SELECT LIST 댓글 목록 조회
    public List<Comment> getCommentList(int reviewNo) throws Exception;

    //SELECT ONE R 특정 댓글 조회
    public Comment getComment(int commentNo) throws Exception;

    //DELETE D 댓글 삭제
    public void deleteComment(int commentNo);
}
