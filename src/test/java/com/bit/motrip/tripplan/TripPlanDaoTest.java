package com.bit.motrip.tripplan;

import com.bit.motrip.common.Search;
import com.bit.motrip.dao.evaluateList.EvaluateListDao;
import com.bit.motrip.dao.tripplan.DailyPlanDao;
import com.bit.motrip.dao.tripplan.PlaceDao;
import com.bit.motrip.dao.tripplan.TripPlanDao;
import com.bit.motrip.domain.DailyPlan;
import com.bit.motrip.domain.EvaluateList;
import com.bit.motrip.domain.Place;
import com.bit.motrip.domain.TripPlan;

import com.bit.motrip.service.evaluateList.EvaluateListService;
import org.apache.ibatis.annotations.Param;
import org.assertj.core.api.Assert;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.*;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
class TripPlanDaoTest {

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

    // 테스트용 값
    @Value("${tripPlanPageSize}")
    private int tripPlanPageSize; // 한화면에 보여질 여행계획 수
    private int currentPage = 0;
    int tripPlanNo = 18; // 여행플랜 번호
    String tripPlnaAuthor = "user1"; // 작성자 아이디
    String searchCondition = "trip_plan_views"; // 옵션

    //@Test // 여행플랜 목록 확인
    public void selectTripPlanList() throws Exception {
        // 페이징 처리 및 옵션에 따른 정렬을 위해 세팅
        Search search = new Search();
        search.setCurrentPage(currentPage);
        search.setSearchCondition(searchCondition);
        search.setLimit(tripPlanPageSize);
        search.setOffset(0);

        Map<String, Object> paramaters = new HashMap<>();
        paramaters.put("search", search);
        paramaters.put("tripPlanAuthor", "");

        List<TripPlan> tripPlan = tripPlanDao.selectTripPlanList(paramaters);

        System.out.println(tripPlan.toString());
    }

    //@Test // 여행플랜, 일차별여행플랜, 명소 한번에 저장
    public void addTripPlan() throws Exception {
        TripPlan tripPlan = new TripPlan();
        DailyPlan dailyPlan = new DailyPlan();
        Place place = new Place();

        // 여행일수 및 일차별 여행플랜의 수
        int tripDays = 4;
        // 명소 갯수
        int placeNo = 2;

        tripPlan.setTripPlanAuthor(tripPlnaAuthor);
        tripPlan.setTripPlanTitle("모여행 추가 테스트 입니다.");
        tripPlan.setTripPlanThumbnail("532434234.jpg");
        tripPlan.setTripDays(tripDays);
        tripPlan.setTripPlanRegDate(new Date());
        tripPlan.setTripPlanDelDate(null);
        tripPlan.setisPlanDeleted(false);
        tripPlan.setisPlanPublic(true);
        tripPlan.setisPlanDownloadable(false);
        tripPlan.setisTripCompleted(false);
        tripPlan.setTripPlanLikes(0);
        tripPlan.setTripPlanViews(0);

        //저장된 여행플랜 번호
        tripPlanDao.addTripPlan(tripPlan);
        int tripPlanNo = tripPlanDao.getTripPlan();

        // 일차별 여행플랜 저장
        for(int dailyPlanCount=0; dailyPlanCount<tripDays; dailyPlanCount++) {
            dailyPlan.setTripPlanNo(tripPlanNo);
            dailyPlan.setDailyPlanContents(dailyPlanCount +"번째");
            dailyPlan.setTotalTripTime(null);

            //저장된 일차별 여행플랜 번호
            dailyPlanDao.addDailyPlan(dailyPlan);
            int dailyPlanNo = dailyPlanDao.getDailyPlan();

            // 명소 저장
            for(int placeCount=0; placeCount<placeNo; placeCount++){
                place.setDailyPlanNo(dailyPlanNo);
                place.setPlaceTags("#" + placeCount + "태그 입력 테스트");
                place.setPlaceCoordinates("42.623242," + placeCount + "129.4323413");
                place.setPlaceImage("abcdef.jpg");
                place.setPlacePhoneNumber("010-5555-5555");
                place.setPlaceAddress("확인용 확인용");
                place.setPlaceCategory(0);
                place.setTripTime(null);
                placeDao.addPlace(place);
            }
        }
        System.out.println("저장 완료");
    }

    //@Test // 가장 최근에 저장된 여행플랜번호 확인 저장시 사용하기 위함
    public void getTripPlan() throws Exception {
        int maxNo = tripPlanDao.getTripPlan();
        System.out.println(maxNo);
    }

    //@Test // 선택한 여행플렌에 대한 정보 확인
    public void selectTripPlan() throws Exception {
       TripPlan tripPlan = tripPlanDao.selectTripPlan(tripPlanNo);
       System.out.println(tripPlan.toString());
    }

    //@Test // 선택한 여행플랜 업데이트 및 일차별 여행플랜, 명소도 함께
    public void updateTripPlan() throws Exception {
        TripPlan tripPlan = tripPlanDao.selectTripPlan(tripPlanNo);
        List<DailyPlan> dailyPlanList = tripPlan.getDailyplanResultMap();
        List<Place> placeList = new ArrayList<>();
        for(DailyPlan dailyPlan : dailyPlanList) {
            placeList = dailyPlan.getPlaceResultMap();
        }

        System.out.println(tripPlan.toString());
        System.out.println("변경전 ^^^^^^^^^^^^^^^^^^^^^^^^^");

        tripPlan.setTripPlanTitle("함께하는 국내 여행");
        // 여행플랜이 완료되었다면 더이상 수정이 불가능
        if(!tripPlan.getisTripCompleted()) {
            dailyPlanList.get(0).setDailyPlanContents("업데이트");
            dailyPlanList.get(1).setDailyPlanContents("완료");
            placeList.get(0).setPlaceTags("#서울 업데이트");
            placeList.get(1).setPlaceTags("#충북 업데이트");

            // tripPlan 업데이트
            tripPlanDao.updateTripPlan(tripPlan);
            // dailyPlans 업데이트
            for(DailyPlan dailyPlan : dailyPlanList) {
                dailyPlanDao.updateDailyPlan(dailyPlan);
            }
            // places 업데이트
            for (Place place : placeList) {
                placeDao.updatePlace(place);
            }
            System.out.println("변경후 vvvvvvvvvvvvvvvvvvvvvvvv");
            System.out.println(tripPlan.toString());
        }
    }

    //@Test // 여행플랜 완전삭제(일차별 여행플랜, 명소 함께 삭제)
    public void deleteTripPlan() throws Exception {
        tripPlanDao.deleteTripPlan(tripPlanNo);
        System.out.println("삭제 완료");
    }

    //@Test // 여행플랜 공유권한 설정(공유가 해제되면 가져가기유무도 자동해제)
    public void tripPlanPublic() throws Exception{
        TripPlan tripPlan = tripPlanDao.selectTripPlan(tripPlanNo);
        if(tripPlan.getisPlanPublic()){
            tripPlanDao.tripPlanPublic(tripPlan.getTripPlanNo(), false);
            tripPlanDao.tripPlanDownloadable(tripPlan.getTripPlanNo(), false);
            System.out.println("공유 취소");
        } else {
            tripPlanDao.tripPlanPublic(tripPlan.getTripPlanNo(), true);
            System.out.println("공유 허용");
        }
        System.out.println(tripPlan.toString());

    }

    //@Test // 여행플랜 가져가기 유무
    public void tripPlanDownloadable() throws Exception{
        TripPlan tripPlan = tripPlanDao.selectTripPlan(tripPlanNo);
        if(tripPlan.getisPlanPublic()) {
            if (tripPlan.getisPlanDownloadable()) {
                tripPlanDao.tripPlanDownloadable(tripPlan.getTripPlanNo(), !tripPlan.getisPlanDownloadable());
            } else {
                tripPlanDao.tripPlanDownloadable(tripPlan.getTripPlanNo(), !tripPlan.getisPlanDownloadable());
            }
        }
        System.out.println("가져가기 " + !tripPlan.getisPlanDownloadable());
        System.out.println(tripPlan.toString());
    }

    //@Test // 여행플랜 삭제유무
    public void tripPlanDeleted() throws Exception{
        TripPlan tripPlan = tripPlanDao.selectTripPlan(tripPlanNo);
        if(tripPlan.getisPlanDeleted()){
            tripPlan.setisPlanDeleted(false);
            tripPlan.setTripPlanDelDate(null);
            tripPlanDao.tripPlanDeleted(tripPlan);
        } else {
            tripPlan.setisPlanDeleted(true);
            tripPlan.setTripPlanDelDate(new Date());
            tripPlanDao.tripPlanDeleted(tripPlan);
        }
        System.out.println("삭제유무 " + tripPlan.getisPlanDeleted());
        System.out.println("삭제날짜 " + tripPlan.getTripPlanDelDate());
        System.out.println(tripPlan.toString());
    }

    //@Test // 여행플랜 완료로 변경
    public void tripPlanCompleted() throws Exception{
        TripPlan tripPlan = tripPlanDao.selectTripPlan(tripPlanNo);
        tripPlanDao.tripPlanCompleted(tripPlan.getTripPlanNo(), true);
        System.out.println("여행플랜 완료!");
        System.out.println(tripPlan.toString());
    }

    //@Test // 여행플랜 추천 중복체크 및 저장
    public void tripPlnaLikes() throws Exception {
        TripPlan tripPlan = new TripPlan();
        EvaluateList evaluate = new EvaluateList();
        Map<String, Object> paramaters = new HashMap<>();
        // 추천수를 가져오기 위해 옵션과 여행플랜번호를 Map에 삽입
        paramaters.put("evaluated_trip_plan_no", tripPlanNo);
        paramaters.put("searchCondition", "evaluated_trip_plan_no");
        // 목록을 확인하여 중복체크 -> 추천한 사람이면 더이상 추천할수없음
        List<EvaluateList> evaluateList = evaluateListDao.getEvaluation(paramaters);
        for (int i=0; i<evaluateList.size(); i++){
            if(evaluateList.get(i).getEvaluaterId().equals(tripPlnaAuthor)){
                System.out.println("이미 추천을 누른 여행플랜입니다.");
                return;
            }
        }
        // 중복체크를 확인하여 이상이없다면 추천수를 올린다.
        evaluate.setEvaluaterId(tripPlnaAuthor);
        evaluate.setEvaluatedTripPlanNo(tripPlanNo);
        evaluateListDao.addEvaluation(evaluate);
        // 추천수를 올리고 다시한번 조회하여 총 추천수를 저장
        tripPlan.setTripPlanLikes(evaluateListDao.getEvaluation(paramaters).size());
        tripPlan.setTripPlanNo(tripPlanNo);
        tripPlanDao.tripPlanLikes(tripPlan);
    }

    //@Test // 여행플랜 조회수
    public void tripPlanViews() throws Exception {
        TripPlan tripPlan = tripPlanDao.selectTripPlan(tripPlanNo);
        tripPlan.setTripPlanViews(tripPlan.getTripPlanViews() + 1);
        tripPlanDao.tripPlanViews(tripPlan);
        System.out.println(tripPlan.getTripPlanViews());
    }

}