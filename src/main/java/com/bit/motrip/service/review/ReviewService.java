package com.bit.motrip.service.review;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.Review;
import java.util.List;

public interface ReviewService {
    //INSERT C 후기 등록
    public void addReview(Review review) throws Exception;

    //SELECT All Public ReviewList 공개된 후기 목록 조회
    public List<Review> getPublicReviewList(Search search) throws Exception;

    //SELECT All My ReviewList 나의 후기 목록 조회
    public List<Review> getMyReviewList(String reviewAuthor, Search search) throws Exception;

    //SELECT ONE R 특정 후기 조회
    public Review getReview(int reviewNo) throws Exception;

    //UPDATE U 후기 수정
    public void updateReview(Review review) throws Exception;

    //DELETE D 후기 삭제
    public void deleteReview(int reviewNo);

    //RECOVER 후기 복구
    public void recoverReview(int reviewNo);

}//end of ReviewService
