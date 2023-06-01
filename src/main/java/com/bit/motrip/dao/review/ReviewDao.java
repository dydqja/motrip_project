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
    //INSERT C 후기 작성
    public void addReview(Review review)throws Exception ;

    public int selectReviewCount() throws Exception;

    public List<Review> selectReviewList(Map<String, Object> paramaters) throws Exception;

    //SELECT All Public ReviewList 공개된 후기 목록 조회
    public List<Review> getPublicReviewList(Search search) throws Exception;

    //SELECT All My ReviewList 나의 후기 목록 조회
    public List<Review> getMyReviewList(String reviewAuthor, Search search) throws Exception;

    //SELECT ONE R 특정 후기 조회
    public Review getReview(int reviewNo)throws Exception;

    //UPDATE U 후기 수정
    public int updateReview(Review review) throws Exception;

    //DELETE D 후기 삭제
    public void deleteReview(int reviewNo);

    //RECOVER 후기 복구
    public void recoverReview(int reviewNo);


}//end of ReviewDao
