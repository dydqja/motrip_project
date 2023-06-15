package com.bit.motrip.service.review;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.Review;
import com.bit.motrip.domain.TripPlan;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

public interface ReviewService {


    // 완료된 여행플랜 목록 가져오기
    public Map<String, Object> getCompletedTripPlanList(Map<String, Object> parameters) throws Exception;
    //후기 목록 조회
    public Map<String, Object> selectReviewList(Map<String, Object> parameters) throws Exception;

    //INSERT C 후기 등록
    public void addReview(Review review) throws Exception;

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

    public String fileUpload(MultipartFile file) throws  Exception;

    //public Map<String, Object> reviewListPage(Search search)throws Exception;
}//end of ReviewService
