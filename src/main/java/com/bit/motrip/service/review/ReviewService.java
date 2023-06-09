package com.bit.motrip.service.review;

import com.bit.motrip.domain.Review;
import com.bit.motrip.domain.TripPlan;

import java.util.List;
import java.util.Map;

public interface ReviewService {

    //후기 목록 조회
    public Map<String, Object> selectReviewList(Map<String, Object> parameters) throws Exception;
    // chatRoomNo가 제공되지 않은 경우 여행플랜들 가져오기
    public List<TripPlan> getPublicNonDeletedTripPlans() throws Exception;
    //완료된 플랜목록 가져옴(ajax)
    public List<TripPlan> getCompletedTripPlan(int chatRoomNo) throws Exception;
    //INSERT C 후기 등록
    public void addReview(Review review) throws Exception;
    //SELECT All My ReviewList 나의 후기 목록 조회
   // public Map<String, Object> getMyReviewList(Map<String, Object> parameters) throws Exception;
    //SELECT ONE R 특정 후기 조회
    public Review getReview(int reviewNo) throws Exception;

    //UPDATE U 후기 수정
    public void updateReview(Review review) throws Exception;

    //DELETE D 후기 삭제
    public void deleteReview(int reviewNo);

    //RECOVER 후기 복구
    public void recoverReview(int reviewNo);

    //후기 좋아요
    public int reviewLikes (Map<String, Object> tripPlanLikes) throws Exception;

    public int reviewCount() throws Exception;
}//end of ReviewService
