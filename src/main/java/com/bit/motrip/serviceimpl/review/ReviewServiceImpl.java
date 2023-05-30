package com.bit.motrip.serviceimpl.review;

import com.bit.motrip.common.Search;
import com.bit.motrip.dao.review.ReviewDao;
import com.bit.motrip.domain.Review;
import com.bit.motrip.service.review.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("reviewServiceImpl")
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    @Qualifier("reviewDao")
    private ReviewDao reviewDao;

    //후기 작성
    @Override
    public void addReview(Review review) throws Exception {
        // Debug: Print Review Object in Service
        System.out.println("Review data in Service: " + review.toString());
        reviewDao.addReview(review);
    }


    //공개된 후기 목록 조회
    @Override
    public List<Review> getPublicReviewList(Search search) throws Exception {
        return reviewDao.getPublicReviewList(search);
    }

    //나의 후기 목록 조회
    @Override
    public List<Review> getMyReviewList(String reviewAuthor, Search search) throws Exception {
        return reviewDao.getMyReviewList(reviewAuthor, search);
    }

    //특정 후기 조회
    @Override
    public Review getReview(int reviewNo) throws Exception {
        return reviewDao.getReview(reviewNo);
    }

    //후기 수정
    @Override
    public void updateReview(Review review) throws Exception {
    }

    //후기 삭제
    @Override
    public void deleteReview(int reviewNo) {
    }

    //후기 복구
    @Override
    public void recoverReview(int reviewNo) {
    }
}

