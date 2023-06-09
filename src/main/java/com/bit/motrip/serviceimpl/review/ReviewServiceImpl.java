package com.bit.motrip.serviceimpl.review;
import com.bit.motrip.common.Search;
import com.bit.motrip.dao.evaluateList.EvaluateListDao;
import com.bit.motrip.dao.review.ReviewDao;
import com.bit.motrip.dao.tripplan.TripPlanDao;
import com.bit.motrip.dao.chatroom.ChatMemberDao;
import com.bit.motrip.domain.*;
import com.bit.motrip.service.review.ReviewService;
import com.bit.motrip.service.tripplan.TripPlanService;
import com.bit.motrip.service.user.UserService;
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

    @Autowired
    @Qualifier("evaluateListDao")
    private EvaluateListDao evaluateListDao;

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

    public ReviewServiceImpl() {
    }

    //화면에 보여줄 리스트의 수
    @Value("${tripPlanPageSize}")
    private int reviewPageSize;

    @Override
    public Map<String, Object> selectReviewList(Map<String, Object> parameters) throws Exception {

        Search search = (Search) parameters.get("search");
        int offset = (search.getCurrentPage() - 1) * reviewPageSize;
        search.setTotalCount(tripPlanDao.selectTripPlanTotalCount(search)); // 여행플랜 총 카운트
        search.setCurrentPage(search.getCurrentPage()); // 클라이언트에서 요청한 페이지 번호
        search.setLimit(reviewPageSize); // LIMIT 값은 페이지당 항목 수와 동일합니다.
        search.setOffset(offset);

        String condition = (String) parameters.get("condition");

        User dbUser = (User) parameters.get("user");
        if ("myReviewList".equals(condition)) { // 나의 후기
            parameters.put("reviewAuthor", dbUser.getUserId());
            parameters.put("search", search);
            parameters.put("reviewList", reviewDao.selectReviewList(parameters));
            System.out.println("여기는 서비스임쁠parameters>>>>" + parameters);
        } else if("publicReviewList".equals(condition)) { //전체 공개 후기
            List<Review> reviewList = reviewDao.selectReviewList(parameters);//후기목록조회
            System.out.println("서비스임쁠 reviewList>>>>>>" + reviewList);
            List<Review> updatedReviewList = new ArrayList<>();//후기 목록을 조회하여 reviewList에 저장

            for (Review review : reviewList) {
                User user = userService.getUserById(review.getReviewAuthor());
                review.setReviewAuthor(user.getNickname());
                updatedReviewList.add(review);
            }

            parameters.put("reviewList", updatedReviewList);

        }
        return parameters;
    }



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
/*


    @Override
    public Map<String, Object> getMyReviewList(Map<String, Object> parameters) throws Exception {

        Search search = (Search) parameters.get("search");
        int offset = (search.getCurrentPage() - 1) * reviewPageSize;
        search.setTotalCount(reviewDao.selectReviewCount()); // 여행플랜 총 카운트
        search.setCurrentPage(search.getCurrentPage()); // 클라이언트에서 요청한 페이지 번호
        search.setLimit(reviewPageSize); // LIMIT 값은 페이지당 항목 수와 동일합니다.
        search.setOffset(offset);

        User dbUser = (User) parameters.get("user");
        if (dbUser != null) { // 나의 여행플랜
            parameters.put("reviewAuthor", dbUser.getUserId());
            parameters.put("search", search);
            parameters.put("reviewList", reviewDao.selectReviewList(parameters));


        } else { // 전체 여행플랜
            List<Review> reviewList = reviewDao.selectReviewList(parameters); // nickname 필드를 별도 만들지 않았지만 플랜 작성자 정보를 통해 가져와서 넣어준다.
            List<Review> updatedReviewList = new ArrayList<>();
            for (Review review : reviewList) {
                User user = userService.getUserById(review.getReviewAuthor());
                review.setReviewAuthor(user.getNickname());
                updatedReviewList.add(review);
            }
            parameters.put("reviewList", updatedReviewList);

        }
        return parameters;
    }
*/

    //특정 후기 조회
    @Override
    public Review getReview(int reviewNo) throws Exception {
        Review review = reviewDao.getReview(reviewNo);
        review.setViewCount(review.getViewCount() + 1);

        reviewDao.getReview(reviewNo);
        return review;
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

    @Override
    public int reviewLikes(Map<String, Object> reviewLikes) throws Exception {
        Review review = new Review();
        EvaluateList evaluateList = new EvaluateList();
        reviewLikes.put("searchCondition", "review"); // 여행플랜을 기준으로 찾기 위해

        User dbUser = (User) reviewLikes.get("user");
        evaluateList.setEvaluaterId(dbUser.getUserId());
        evaluateList.setEvaluatedReviewNo((Integer) reviewLikes.get("reviewNo"));

        List<EvaluateList> reviewEvaluateList = evaluateListDao.getEvaluation(reviewLikes);
        for (int i=0; i<reviewEvaluateList.size(); i++){
            if(reviewEvaluateList.get(i).getEvaluaterId().equals(dbUser.getUserId())){
                System.out.println("이미 추천을 누른 후기입니다.");
                return -1;
            }
        }
        // 중복체크를 확인하여 이상이 없다면 새로운 테이블을 생성
        evaluateListDao.addEvaluation(evaluateList);
        // 추천수를 높이고 tripPlanEvaluateList의 숫자가 최근 추천수이기에 + 1을 더해주어 최종 저장
        review.setReviewLikes(reviewEvaluateList.size() + 1);
        review.setTripPlanNo((Integer) reviewLikes.get("reviewNo"));
        reviewDao.reviewLikes(review);
        return review.getReviewLikes();
    }
}



