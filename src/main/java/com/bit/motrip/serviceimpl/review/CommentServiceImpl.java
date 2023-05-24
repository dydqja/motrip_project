package com.bit.motrip.serviceimpl.review;

import com.bit.motrip.dao.review.CommentDao;
import com.bit.motrip.domain.Comment;
import com.bit.motrip.service.review.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("commentServiceImpl")
public class CommentServiceImpl implements CommentService {

    @Autowired
    @Qualifier("commentDao")
    private CommentDao commentDao;

    //댓글작성
    @Override
    public void addComment() throws Exception {
    }

    //댓글 목록 조회
    @Override
    public List<Comment> getCommentList(int reviewNo) throws Exception {
        return commentDao.getCommentList(reviewNo);
    }

    //특정 댓글 조회
    @Override
    public Comment getComment(int commentNo)throws Exception {
        return commentDao.getComment(commentNo);
    }

    //댓글 삭제
    @Override
    public void deleteComment(int commentNo) {

    }
}
