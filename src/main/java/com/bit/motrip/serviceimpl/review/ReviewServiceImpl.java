package com.bit.motrip.serviceimpl.review;
import com.bit.motrip.common.Search;
import com.bit.motrip.dao.evaluateList.EvaluateListDao;
import com.bit.motrip.dao.review.ReviewDao;
import com.bit.motrip.dao.tripplan.DailyPlanDao;
import com.bit.motrip.dao.tripplan.PlaceDao;
import com.bit.motrip.dao.tripplan.TripPlanDao;
import com.bit.motrip.domain.*;
import com.bit.motrip.service.review.ReviewService;
import com.bit.motrip.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.*;

@Service("reviewServiceImpl")
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    @Qualifier("reviewDao")
    private ReviewDao reviewDao;

    @Autowired
    @Qualifier("tripPlanDao")
    private TripPlanDao tripPlanDao;

    @Autowired
    @Qualifier("dailyPlanDao")
    private DailyPlanDao dailyPlanDao;

    @Autowired
    @Qualifier("placeDao")
    private PlaceDao placeDao;

    @Autowired
    @Qualifier("evaluateListDao")
    private EvaluateListDao evaluateListDao;

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

    @Value(value = "${filePath}thumbnail")
    private Path fileStorageLocation; // 썸네일 경로

    public ReviewServiceImpl() {
    }

    //화면에 보여줄 리스트의 수
    @Value("${tripPlanPageSize}")
    private int reviewPageSize;

    @Override
    public Map<String, Object> getCompletedTripPlanList(Map<String, Object> parameters) throws Exception {
        Search search = (Search) parameters.get("search");
        int totalCount = tripPlanDao.selectTripPlanTotalCount(search);



        User dbUser = (User) parameters.get("user");
        if(dbUser != null) { // 나의 여행플랜
            parameters.put("tripPlanAuthor", dbUser.getUserId());
            parameters.put("search", search);
            parameters.put("tripPlanList", reviewDao.getCompletedTripPlanList(parameters));
            //System.out.println("여기는 임쁠 parameters>>>>"+parameters);

        } else { // 전체 여행플랜
            List<TripPlan> tripPlanList = reviewDao.getCompletedTripPlanList(parameters);
            List<TripPlan> updatedTripPlanList = new ArrayList<>();
            for (TripPlan tripPlan : tripPlanList) {
                User user = userService.getUserById(tripPlan.getTripPlanAuthor());
                tripPlan.setTripPlanAuthor(user.getNickname());
                updatedTripPlanList.add(tripPlan);
            }
            parameters.put("list", updatedTripPlanList);
            // System.out.println("임쁠 parameters>>>>>>"+parameters);
        }

        System.out.println("===================여기는 임쁠 지나가요=================");
        parameters.put("totalCount", totalCount);
        return parameters;
    }



    public TripPlan selectTripPlan(@RequestParam("tripPlanNo") int tripPlanNo) throws Exception{
        TripPlan tripPlan = tripPlanDao.selectTripPlan(tripPlanNo);
        tripPlan.setTripPlanViews(tripPlan.getTripPlanViews() + 1);
        System.out.println("여기는 임쁠 tripPlan>>>>"+tripPlan);

        tripPlanDao.tripPlanViews(tripPlan);

       return tripPlan;
    }

    //후기 작성
    @Override
    public void addReview(Review review) throws Exception {
        System.out.println("Review data in ServiceImpl: " + review.toString());

        reviewDao.addReview(review);

    }


    @Override//공개된 혹은 나의 후기 목록
    public Map<String, Object> selectReviewList(Map<String, Object> parameters) throws Exception {

        Search search = (Search) parameters.get("search");
        String condition = (String) parameters.get("condition");
        User dbUser = (User) parameters.get("user");

        List<Review> reviewList = reviewDao.selectReviewList(parameters);


        System.out.println("임쁠 search?>>>>"+search);
        System.out.println("임쁠 condition?>>>>"+condition);
        System.out.println("임쁠 dbUser?>>>>"+dbUser);

        if ("myReviewList".equals(condition)) { // 나의 후기
            System.out.println("myReviewList임쁠 if문안에 들어오나요");
            parameters.put("reviewAuthor", dbUser.getUserId());
            parameters.put("nickname", dbUser.getNickname());
            parameters.put("search", search);
            parameters.put("reviewList", reviewDao.selectReviewList(parameters));
            System.out.println("여기는myReviewList 서비스임쁠parameters>>>>" + parameters);

        } else { //전체 공개 후기
            System.out.println("publicReviewList임쁠 if문안에 들어오나요");
             // 후기 목록 조회
            parameters.put("reviewList", reviewDao.selectReviewList(parameters));
            System.out.println("publicReviewList서비스임쁠 reviewList>>>>>>" + reviewList);
            System.out.println("임쁠 reviewList?>>>>" + reviewList);
            List<Review> updatedReviewList = new ArrayList<>(); // 후기 목록을 조회하여 reviewList에 저장

            for (Review review : reviewList) {
                User user = userService.getUserById(review.getReviewAuthor());
                review.setReviewAuthor(user.getNickname());
                updatedReviewList.add(review);
            }

            int totalCount = reviewDao.selectReviewTotalCount(search);
            System.out.println("totalCount : " + totalCount);

            parameters.put("reviewList", updatedReviewList); // 수정된 부분: reviewList를 parameters에 추가
            parameters.put("totalCount", totalCount);
        }

        List<TripPlan> tripPlanList = tripPlanDao.selectTripPlanList(parameters);

        for (TripPlan tp : tripPlanList) {
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy년 MM월 dd일");
            String strDate = simpleDateFormat.format(tp.getTripPlanRegDate());
            tp.setStrDate(strDate);
            tp.setTripPlanNickName(userService.getUserById(tp.getTripPlanAuthor()).getNickname());
        }
        System.out.println(tripPlanList);

        System.out.println("임쁠 if문 밖>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
        int totalCount = reviewDao.selectReviewTotalCount(search);
        System.out.println("totalCount : " + totalCount);
        parameters.put("totalCount", totalCount);
        parameters.put("tripPlanList", tripPlanList);

        System.out.println("임쁠 parameters>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+parameters);
        return parameters;
    }


    //특정 후기 조회
    @Override
    public Review getReview(int reviewNo) throws Exception {
        Review review = reviewDao.getReview(reviewNo);
        review.setViewCount(review.getViewCount() + 1);


        TripPlan tripPlan = tripPlanDao.selectTripPlan(review.getTripPlanNo());
        System.out.println("tripPlan 임쁠>>>>>"+tripPlan);

        review.setTripPlanNo(tripPlan.getTripPlanNo()); // 리뷰에 해당하는 여행 계획 정보 설정
        System.out.println("review 임쁠>>>>>>>"+review);
        return review;
    }


    //후기 수정
    @Override
    public void updateReview(Review review) throws Exception {
        review.getReviewNo();

        reviewDao.updateReview(review);
    }

    //후기 삭제
    @Override
    public void deleteReview(int reviewNo) {
        reviewDao.deleteReview(reviewNo);
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

    @Override
    public int reviewCount() throws Exception {
        return reviewDao.reviewCount();
    }


    public String fileUpload(MultipartFile file) throws Exception {

        System.out.println("tripPlanfileUpload");
        // 파일이 비어있는지 체크
        if (file.isEmpty()) {
            throw new IllegalArgumentException("파일이 없습니다.");
        }

//        @Value(value = "${filePath}")
//        private Path fileStorageLocation;

        System.out.println("받은 파일의 경로는 => : " + file.getOriginalFilename());

        String fileName = StringUtils.cleanPath(file.getOriginalFilename());
        System.out.println("파일경로에서 파일이름만 뽑은 값은 => : " + fileName);

        String uniqueFileName = UUID.randomUUID().toString() + "_" + fileName;
        System.out.println("파일이름+UUID해서 준 임의파일이름은? => : " + uniqueFileName);

        /*파일이 저장될 기본 경로(this.fileStorageLocation)에 파일이름(uniqueFileName) 을 추가(resolve) 하여,
        새로운 경로 생성(Path targetLocation)*/
        Path targetLocation = this.fileStorageLocation.resolve(uniqueFileName);
        System.out.println("기본경로+파일이름으로 생성된 새로운경로는? => : " + targetLocation);

        System.out.println("업로드파일 데이터스트림 => : "+ file.getInputStream());
        /*업로드된 파일의 데이터 스트림을 가져오고(file.getInputStream()) 이 데이터 스트림을 지정된 경로(targetLocation)로 복사(Files.copy)한다.
        복사한 위치에 동일한 이름의 파일이 있다면 기존 파일을 새 파일로 대체(StandardCopyOption.REPLACE_EXISTING)한다. */
        try (InputStream is = file.getInputStream()) {
            Files.copy(is, targetLocation, StandardCopyOption.REPLACE_EXISTING);
        } catch (Exception e) {
            e.printStackTrace();
            throw new IOException("파일 저장에 실패했습니다. 파일 이름: " + fileName, e);
        }

        return uniqueFileName;
    }
}



