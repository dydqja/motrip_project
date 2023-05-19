package com.bit.motrip.tripplan;

import com.bit.motrip.domain.TripPlan;
import com.bit.motrip.service.tripplan.TripPlanService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Date;
import java.util.List;
@SpringBootTest
class TripPlanDaoTest {

    @Autowired
    @Qualifier("tripPlanServiceImpl")
    private TripPlanService tripPlanService;

    //@Test
    void selectTripPlanList() throws Exception {
        List<TripPlan> tripPlans = tripPlanService.selectTripPlanList();
        System.out.println(tripPlans);
    }

    //@Test
    void insertTripPlan() {
        TripPlan tripPlan = new TripPlan();
        tripPlan.setTripPlanAuthor("user3");
        tripPlan.setTripPlanTitle("Trip Plan Title3");
        tripPlan.setTripPlanThumbnail("trip_plan_thumbnail3");
        tripPlan.setTripDays(10);
        tripPlan.setTripPlanRegDate(new Date());
        tripPlan.setTripPlanDelDate(null);
        tripPlan.setPlanDeleted(false);
        tripPlan.setPlanPublic(true);
        tripPlan.setPlanDownloadable(true);
        tripPlan.setTripCompleted(false);
        tripPlan.setTripPlanLikes(0);
        tripPlan.setTripPlanViews(0);

        tripPlanService.insertTripPlan(tripPlan);
    }

    //@Test
    public void updateTripPlan() {
    }

    //@Test
    public void deleteTripPlan() {
    }
}