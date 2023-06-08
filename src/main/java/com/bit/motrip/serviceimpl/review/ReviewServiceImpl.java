package com.bit.motrip.serviceimpl.review;

import com.bit.motrip.common.Search;
import com.bit.motrip.controller.CommentController;
import com.bit.motrip.dao.review.ReviewDao;
import com.bit.motrip.dao.tripplan.TripPlanDao;
import com.bit.motrip.dao.chatroom.ChatMemberDao;
import com.bit.motrip.domain.ChatMember;
import com.bit.motrip.domain.Review;
import com.bit.motrip.domain.TripPlan;
import com.bit.motrip.service.review.ReviewService;
import com.bit.motrip.service.tripplan.TripPlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("reviewServiceImpl")
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    @Qualifier("reviewDao")
    private ReviewDao reviewDao;

    @Autowired
    @Qualifier("tripPlanDao")
    private TripPlanDao tripPlanDao;

    @Autowired
    @Qualifier("chatMemberDao")
    private ChatMemberDao chatMemberDao;

    public ReviewServiceImpl() {
    }

    //화면에 보여줄 리스트의 수
    @Value("${tripPlanPageSize}")
    private int reviewPageSize;


    @Override
// chatRoomNo가 제공되지 않은 경우 여행플랜들 가져오기
    public List<TripPlan> getPublicNonDeletedTripPlans() throws Exception {
        try {
            // trip_plan 테이블에서 is_plan_public이 true이고 is_plan_deleted가 false인 여행 계획을 조회하는 로직을 작성
            return reviewDao.getPublicNonDeletedTripPlans();
        } catch (Exception e) {
            // 예외 처리 로직 추가
            e.printStackTrace();
            throw new Exception("여기는 Review ServiceImpl>>>Failed to retrieve public non-deleted trip plans.");
        }
    }


    // 회원이 속한 채팅방으로 완료된 플랜목록 가져옴(ajax)
    @Override
    public List<TripPlan> getCompletedTripPlan(int chatRoomNo) throws Exception {
        try {
            List<ChatMember> chatMembers = chatMemberDao.listChatMember(chatRoomNo); // 해당 채팅방의 멤버들을 가져옵니다.
            List<Integer> tripPlanNos = new ArrayList<>(); // 여행플랜 번호를 저장할 리스트입니다.
            List<TripPlan> tripPlans = new ArrayList<>(); // 여행플랜 객체를 저장할 리스트입니다.

            for (ChatMember chatMember : chatMembers) {
                int tripPlanNo = chatMember.getTripPlanNo(); // 멤버의 여행플랜 번호를 가져옵니다.
                if (tripPlanNo != 0 && !tripPlanNos.contains(tripPlanNo)) {
                    tripPlanNos.add(tripPlanNo); // 0이 아니고 중복되지 않는 경우에만 여행플랜 번호를 리스트에 추가합니다.
                }
            }

            // 가져온 여행플랜 번호로 여행플랜을 조회하여 리스트에 저장합니다.
            for (int tripPlanNo : tripPlanNos) {
                TripPlan tripPlan = tripPlanDao.selectTripPlan(tripPlanNo);
                tripPlans.add(tripPlan);
            }

            return tripPlans;
        } catch (Exception e) {
            // 예외 처리 로직 추가
            e.printStackTrace();
            throw new Exception("여기는 Review ServiceImpl>>>Failed to retrieve completed trip plans for the chat room.");
        }
    }


    //후기 작성
    @Override
    public void addReview(Review review) throws Exception {
        // Debug: Print Review Object in Service
        System.out.println("Review data in Service: " + review.toString());
        reviewDao.addReview(review);
    }

    @Override // 공유된 여행플랜 목록
    public Map<String, Object> selectReviewList(Search search) throws Exception {

        int offset = (search.getCurrentPage() - 1) * reviewPageSize;

        search.setTotalCount(reviewDao.selectReviewCount()); // 여행플랜 총 카운트
        search.setCurrentPage(search.getCurrentPage()); // 클라이언트에서 요청한 페이지 번호
        search.setLimit(reviewPageSize); // LIMIT 값은 페이지당 항목 수와 동일합니다.
        search.setOffset(offset); //

        Map<String, Object> paramaters = new HashMap<>();
        paramaters.put("reviewAuthor", "");
        paramaters.put("search", search);
        paramaters.put("reviewList", reviewDao.selectReviewList(paramaters));

        return paramaters;
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

