package com.bit.motrip.dao.review;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.Review;
import com.bit.motrip.domain.TripPlan;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import java.util.Map;

@Mapper
public interface ReviewDao {
    //후기 부분 CRUD
    // 완료된 여행플랜 목록 가져오기
    public List<TripPlan> getCompletedTripPlanList(Map<String, Object> parameters) throws Exception ;


    //INSERT C 후기 작성
    public void addReview(Review review)throws Exception ;

    public int selectReviewCount() throws Exception;

    public List<Review> selectReviewList(Map<String, Object> parameters) throws Exception;

    //SELECT ONE R 특정 후기 조회
    public Review getReview(int reviewNo)throws Exception;

    //UPDATE U 후기 수정
    public int updateReview(Review review) throws Exception;

    //DELETE D 후기 삭제
    public void deleteReview(int reviewNo);

    //RECOVER 후기 복구
    public void recoverReview(int reviewNo);
    //후기 좋아요
    public void reviewLikes(Review review) throws Exception;
    //후기 조회수
    public void reviewViews(Review review) throws Exception;


    public int reviewCount() throws Exception;
}//end of ReviewDao
