package com.bit.motrip.controller;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.TripPlan;
import com.bit.motrip.service.tripplan.TripPlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequestMapping("/tripPlan/*")
public class TripPlanController {

    @Autowired
    @Qualifier("tripPlanServiceImpl")
    private TripPlanService tripPlanService;

    public TripPlanController(){
        System.out.println(this.getClass());
    }

    @GetMapping("tripPlanList")
    public String tripPlanList(@ModelAttribute("search")Search search, Model model) throws Exception {
        System.out.println("GET : TripPlanList()");

        if(search.getPageSize() == 0){
            search.setCurrentPage(1);
        } else {
            search.setCurrentPage(search.getCurrentPage());
        }

        Map<String, Object> tripPlanList = tripPlanService.selectTripPlanList(search);
        tripPlanList.get("tripPlanList");

        System.out.println(tripPlanList.get("tripPlanList").toString());
        model.addAttribute("tripPlanList", tripPlanList.get("tripPlanList"));

        return "tripplan/tripPlanList.tiles";
    }

    @GetMapping("addTripPlanView") // addTripPlanView 일반 네비게이션
    public String addTripPlanView() {
        System.out.println("GET : addTripPlanView()");
        return "tripplan/addTripPlan.tiles";
    }

    @PostMapping("addTripPlan") // 여행플랜 저장
    public String addTripPlan(@RequestBody TripPlan tripPlan) throws Exception {
        System.out.println("POST : addTripPlan()");

        System.out.println(tripPlan.toString());

        tripPlanService.addTripPlan(tripPlan);
        System.out.println("여기까지오나요?");
        return "tripplan/tripPlanList.tiles";
    }

    @GetMapping("selectTripPlan")
    public String selectTripPlan(@RequestParam("tripPlanNo") int tripPlanNo, Model model) throws Exception {
        System.out.println("GET : selectTripPlan()");

        TripPlan tripPlan = tripPlanService.selectTripPlan(tripPlanNo);

        System.out.println(tripPlan.toString());
        model.addAttribute("tripPlan", tripPlan);

        return "tripplan/selectTripPlan.tiles";
    }

    @GetMapping("updateTripPlan")
    public String updateTripPlan() throws Exception {
        System.out.println("GET : updateTripPlan()");

        return "null";
    }

    @GetMapping("tripPlanDeleted")
    public void tripPlanDeleted(@RequestParam("tripPlanNo") int tripPlanNo) throws Exception {
        System.out.println("GET : deleteTripPlan()");
        tripPlanService.tripPlanDeleted(tripPlanNo);
        System.out.println("여행플랜 삭제 대기중 변경");
    }

}
