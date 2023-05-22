package com.bit.motrip.tripplan;

import com.bit.motrip.domain.DailyPlan;
import com.bit.motrip.domain.Place;
import com.bit.motrip.domain.TripPlan;
import com.bit.motrip.service.tripplan.DailyPlanService;
import com.bit.motrip.service.tripplan.PlaceService;
import com.bit.motrip.service.tripplan.TripPlanService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
@SpringBootTest
class TripPlanDaoTest {

    @Autowired
    @Qualifier("tripPlanServiceImpl")
    private TripPlanService tripPlanService;

    @Autowired
    @Qualifier("dailyPlanServiceImpl")
    private DailyPlanService dailyPlanService;

    @Autowired
    @Qualifier("placeServiceImpl")
    private PlaceService placeService;


    //@Test // 공유된 여행플랜 목록 확인 (join 이전)
    public void selectPublicTripPlanList() throws Exception {

        List<DailyPlan> dailyPlan = new ArrayList<DailyPlan>();
        List<Place> place = new ArrayList<>();
        List<TripPlan> tripPlan = tripPlanService.selectPublicTripPlanList();
        for (TripPlan trip : tripPlan) {
            System.out.println("===========================");
            System.out.println("tripPlan 번호: " + trip.getTripPlanNo());
            System.out.println("tripPlan 작성자: " + trip.getTripPlanAuthor());
            System.out.println("tripPlan 제목: " + trip.getTripPlanTitle());
            System.out.println("tripPlan 썸네일: " + trip.getTripPlanThumbnail());
            System.out.println("tripPlan 여행일수: " + trip.getTripDays());
            System.out.println("tripPlan 작성날짜: " + trip.getTripPlanRegDate());
            System.out.println("tripPlan 조회수: " + trip.getTripPlanViews());
            System.out.println("tripPlan 추천수: " + trip.getTripPlanLikes());

            dailyPlan = dailyPlanService.selectDailyPlan(trip.getTripPlanNo());
            for (DailyPlan daily : dailyPlan){
                System.out.println("----------------------------");
                System.out.println("dailyPlan 플랜번호: " + daily.getDailyPlanNo());
                System.out.println("dailyPlan TripPlan번호: " + daily.getTripPlanNo());
                System.out.println("dailyPlan 본문내용: " + daily.getDailyPlanContents());
                System.out.println("dailyPlan 총이동시간: " + daily.getTotalTripTime());

                place = placeService.selectPlace(daily.getDailyPlanNo());
                for(Place placeList : place){
                    System.out.println("===========================");
                    System.out.println("place 번호 : " + placeList.getPlaceNo());
                    System.out.println("place 태그 : " + placeList.getPlaceTags());
                    System.out.println("place 좌표 : " + placeList.getPlaceCoordinates());
                    System.out.println("place 이미지 : " + placeList.getPlaceImage());
                    System.out.println("place 전화번호 : " + placeList.getPlacePhoneNumber());
                    System.out.println("place 카테고리 : " + placeList.getPlaceCategory());
                    System.out.println("place 이동시간 : " + placeList.getTripTime());
                }

            }
        }
    }

    //@Test // 내가 작성한 여행플랜 목록 확인 (join 이전)
    public void selectMyTripPlanList() throws Exception {

        List<TripPlan> tripPlan = tripPlanService.selectMyTripPlanList("user2");
        for (TripPlan trip : tripPlan) {
            System.out.println("===========================");
            System.out.println("tripPlan 번호: " + trip.getTripPlanNo());
            System.out.println("tripPlan 작성자: " + trip.getTripPlanAuthor());
            System.out.println("tripPlan 제목: " + trip.getTripPlanTitle());
            System.out.println("tripPlan 썸네일: " + trip.getTripPlanThumbnail());
            System.out.println("tripPlan 여행일수: " + trip.getTripDays());
            System.out.println("tripPlan 작성날짜: " + trip.getTripPlanRegDate());
            System.out.println("tripPlan 조회수: " + trip.getTripPlanViews());
            System.out.println("tripPlan 추천수: " + trip.getTripPlanLikes());
        }
    }


    //@Test // 여행플랜, 일차별여행플랜, 명소 한번에 저장
    public void addTripPlan() throws Exception {
        TripPlan tripPlan = new TripPlan();
        DailyPlan dailyPlan = new DailyPlan();
        Place place = new Place();

        // 여행일수 및 일차별 여행플랜의 수
        int tripDays = 2;
        // 명소 갯수
        int placeNo = 3;

        tripPlan.setTripPlanAuthor("user2");
        tripPlan.setTripPlanTitle("용범과 함께하는 비트캠프 단일인입조 여행");
        tripPlan.setTripPlanThumbnail("Seoul_city");
        tripPlan.setTripDays(tripDays);
        tripPlan.setTripPlanRegDate(new Date());
        tripPlan.setTripPlanDelDate(null);
        tripPlan.setPlanDeleted(false);
        tripPlan.setPlanPublic(false);
        tripPlan.setPlanDownloadable(false);
        tripPlan.setTripCompleted(false);
        tripPlan.setTripPlanLikes(0);
        tripPlan.setTripPlanViews(0);

        tripPlanService.addTripPlan(tripPlan);
        int tripPlanNo = tripPlanService.getTripPlan();

        // 일차별 여행플랜 저장
        for(int dailyPlanCount=0; dailyPlanCount<tripDays; dailyPlanCount++) {
            dailyPlan.setTripPlanNo(tripPlanNo);
            dailyPlan.setDailyPlanContents(dailyPlanCount +"번째");
            dailyPlan.setTotalTripTime(null);
            dailyPlanService.addDailyPlan(dailyPlan);
            int dailyPlanNo = dailyPlanService.getDailyPlan();

            // 명소 저장
            for(int placeCount=0; placeCount<placeNo; placeCount++){
                place.setDailyPlanNo(dailyPlanNo);
                place.setPlaceTags("#" + placeCount + "확인");
                place.setPlaceCoordinates("33.242452,127.0124124");
                place.setPlaceImage("abcdef.jpg");
                place.setPlacePhoneNumber("010-2222-2222");
                place.setPlaceAddress("지하철1번출구");
                place.setPlaceCategory(0);
                place.setTripTime(null);
                placeService.addPlace(place);
            }
        }

        System.out.println("테스트 완료");
    }

    //@Test // 가장 최근에 저장된 여행플랜번호 확인 저장시 사용하기 위함
    public void getTripPlan() throws Exception {
        int tripPlanNo = tripPlanService.getTripPlan();
        System.out.println(tripPlanNo);
    }

    //@Test // 선택한 여행플렌에 대한 정보 확인 (join 이후)
    public void selectTripPlan() throws Exception {
       TripPlan tripPlan = tripPlanService.selectTripPlan(10);

        System.out.println(tripPlan.toString());
        for(DailyPlan daily : tripPlan.getDailyplanResultMap()) {
            System.out.println(daily.toString());
            for(Place place : daily.getPlaceResultMap()) {
                System.out.println(place.toString());
            }
        }
    }

    //@Test // 선택한 여행플랜 업데이트 및 일차별 여행플랜, 명소도 함께
    public void updateTripPlan() throws Exception {
        TripPlan tripPlan = tripPlanService.selectTripPlan(10);
        List<DailyPlan> dailyPlanList = new ArrayList<>();
        List<Place> placeList = new ArrayList<>();
        
        System.out.println(tripPlan.toString());
        tripPlan.setTripPlanTitle("은진과 함께하는 태국 여행");

        for(DailyPlan dailyPlan : tripPlan.getDailyplanResultMap()) {
            System.out.println(dailyPlan.toString());
            dailyPlanList.add(dailyPlan);
            for (Place place : dailyPlan.getPlaceResultMap()) {
                System.out.println(place.toString());
                placeList.add(place);
            }
        }

        System.out.println(dailyPlanList.get(0).toString());
        System.out.println(placeList.get(2).toString());

        dailyPlanList.get(0).setDailyPlanContents("업데이트");
        dailyPlanList.get(1).setDailyPlanContents("완료");
        placeList.get(0).setPlaceTags("서울");
        placeList.get(1).setPlaceTags("제주도");
        placeList.get(2).setPlaceTags("부산");
        placeList.get(3).setPlaceTags("여수");
        placeList.get(4).setPlaceTags("인천");

        System.out.println(dailyPlanList.get(0).toString());
        System.out.println(placeList.get(2).toString());

        // tripPlan 업데이트
        tripPlanService.updateTripPlan(tripPlan);
        // dailyPlans 업데이트
        for(int i=0; i<dailyPlanList.size(); i ++) {
            tripPlanService.updateDailyPlan(dailyPlanList.get(i));
        }
        // places 업데이트
        for(int i=0; i<placeList.size(); i++) {
            tripPlanService.updatePlace(placeList.get(i));
        }
        System.out.println("테스트 완료");
    }

    //@Test // 여행플랜 완전삭제(일차별 여행플랜, 명소 함께 삭제)
    public void deleteTripPlan() throws Exception {
        tripPlanService.deleteTripPlan(9);
        System.out.println("삭제 완료");
    }

}