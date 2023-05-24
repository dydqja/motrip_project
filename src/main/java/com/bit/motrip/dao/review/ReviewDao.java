package com.bit.motrip.dao.review;

import com.bit.motrip.domain.Review;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface ReviewDao {
    //후기 부분 CRUD
    //INSERT C 후기 작성
    public void addReview(Review review)throws Exception ;

    //SELECT LIST 후기 목록 조회
    public List<Review> getReviewList() throws Exception;

    //SELECT ONE R 특정 후기 조회
    public Review getReview(int reviewNo)throws Exception;

    //UPDATE U 후기 수정
    public Review updateReview() throws Exception;

    //DELETE D 후기 삭제
    public void deleteReview(int reviewNo);

    //RECOVER 후기 복구
    public void recoverReview(int reviewNo);


}//end of ReviewDao
