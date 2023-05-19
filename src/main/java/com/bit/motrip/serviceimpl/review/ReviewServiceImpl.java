package com.bit.motrip.serviceimpl.review;

import com.bit.motrip.dao.review.ReviewDao;
import com.bit.motrip.domain.Review;
import com.bit.motrip.service.review.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import javax.xml.stream.events.Comment;
import java.util.List;

@Service("reviewServiceImpl")
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    @Qualifier("reviewDao")
    private ReviewDao reviewDao;

    //후기 작성
    @Override
    public void addReview() throws Exception {

    }

    //후기 목록 조회
    @Override
    public List<Review> getReviewList() throws Exception {
        return reviewDao.getReviewList();
    }

    //특정 후기 조회
    @Override
    public Review getReview() throws Exception {
        return null;
    }

    //후기 수정
    @Override
    public int updateReview() throws Exception {
        return 0;
    }

    //후기 수정
    @Override
    public int updateReview(Review review) {
        return 0;
    }

    //후기 삭제
    @Override
    public int deleteReview(int reviewNo) {
        return 0;
    }

    //댓글
    //댓글 작성
    @Override
    public Void addComment() throws Exception {
        return null;
    }

    //댓글 목록 조회
    @Override
    public List<Comment> getCommentList() throws Exception {
        return null;
    }

    //특정 댓글 조회
    @Override
    public Comment getComment() throws Exception {
        return null;
    }

    //댓글 삭제
    @Override
    public int deleteComment(int commentNo) {
        return 0;
    }
}
