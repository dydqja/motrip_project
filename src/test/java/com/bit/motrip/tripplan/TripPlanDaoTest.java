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


    //@Test //@SelectTest
    public void SelectTripPlanList() throws Exception {

        List<DailyPlan> dailyPlan = new ArrayList<DailyPlan>();
        List<TripPlan> tripPlan = tripPlanService.selectTripPlanList();
        for (TripPlan trip : tripPlan) {
            System.out.println("플랜 번호: " + trip.getTripPlanNo());
            System.out.println("플랜 작성자: " + trip.getTripPlanAuthor());
            System.out.println("플랜 제목: " + trip.getTripPlanTitle());
            System.out.println("플랜 썸네일: " + trip.getTripPlanThumbnail());
            System.out.println("플랜 여행일수: " + trip.getTripDays());
            System.out.println("플랜 작성날짜: " + trip.getTripPlanRegDate());
            System.out.println("플랜 조회수: " + trip.getTripPlanViews());
            System.out.println("플랜 추천수: " + trip.getTripPlanLikes());

            dailyPlan = dailyPlanService.getDailyPlanList(trip.getTripPlanNo());
            for (DailyPlan daily : dailyPlan){
                System.out.println("일차별 플랜번호: " + daily.getDailyPlanNo());
                System.out.println("일차별 본문내용: " + daily.getDailyPlanContents());
                System.out.println("일차별 총이동시간: " + daily.getTotalTripTime());
            }

        }
    }

    //@Test //@AddTripPlanTest + @GetTripPlanTest + @AddDailyPlan
    public void addTripPlan() throws Exception {
        TripPlan tripPlan = new TripPlan();
        DailyPlan dailyPlan = new DailyPlan();
        Place place = new Place();

        // 여행일수 및 일차별 여행플랜의 수
        int tripDays = 3;

        tripPlan.setTripPlanAuthor("sean");
        tripPlan.setTripPlanTitle("용범과 함께하는 제주도 여행");
        tripPlan.setTripPlanThumbnail("Seoul_thumbnai");
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
        System.out.println(tripPlanNo);

        for(int i=0; i<tripDays; i++) {
            dailyPlan.setTripPlanNo(tripPlanNo);
            dailyPlan.setDailyPlanContents("프로젝트 앞으로 열심히 잘 할수있겠죠?? 모두 안되면 되게하십쇼" + i +"번째");
            dailyPlan.setTotalTripTime(null);
            dailyPlanService.addDailyPlan(dailyPlan);
        }

        System.out.println("테스트 완료");
    }

    //@Test //@GetTest
    public void getTripPlanList() throws Exception {
        int tripPlanNo = tripPlanService.getTripPlan();
        System.out.println(tripPlanNo);
    }

    //@Test
    public void updateTripPlan() {
    }

    //@Test
    public void deleteTripPlan() {
    }

}