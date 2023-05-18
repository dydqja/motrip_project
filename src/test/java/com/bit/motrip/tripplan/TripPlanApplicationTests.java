package com.bit.motrip.tripplan;

import com.bit.MotripApplication;
import com.bit.motrip.domain.TripPlan;
import com.bit.motrip.service.tripplan.TripPlanService;
import org.junit.jupiter.api.Test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;

import java.util.Date;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
public class TripPlanApplicationTests {

    @Autowired
    @Qualifier("tripPlanServiceImpl")
    private TripPlanService tripPlanService;

    //@Test
    public void selectTest() throws Exception {
        List<TripPlan> tripPlans = tripPlanService.selectTripPlanList();
        System.out.println(tripPlans);
    }

    @Test
    public void insertTest() throws Exception {
        TripPlan tripPlan = new TripPlan();
        tripPlan.setTripPlanAuthor("user2");
        tripPlan.setTripPlanTitle("Trip Plan Title2");
        tripPlan.setTripPlanThumbnail("trip_plan_thumbnail2");
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

}
