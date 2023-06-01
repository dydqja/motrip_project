package com.bit.motrip.controller;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.TripPlan;
import com.bit.motrip.service.tripplan.TripPlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
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

    @GetMapping("listTripPlan")
    public String tripPlanList(@ModelAttribute("search")Search search, Model model, HttpSession session) throws Exception {
        System.out.println("GET : listTripPlan()");

        if(search.getPageSize() == 0){
            search.setCurrentPage(1);
        } else {
            search.setCurrentPage(search.getCurrentPage());
        }
        System.out.println(session.getAttribute("user"));

        Map<String, Object> tripPlanList = tripPlanService.selectTripPlanList(search);
        tripPlanList.get("tripPlanList");

        System.out.println(tripPlanList.get("tripPlanList").toString());
        model.addAttribute("tripPlanList", tripPlanList.get("tripPlanList"));

        return "tripplan/listTripPlan.tiles";
    }

    @GetMapping("addTripPlanView") // addTripPlanView 일반 네비게이션
    public String addTripPlanView() {
        System.out.println("GET : addTripPlanView()");
        return "tripplan/addTripPlan.tiles";
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

}
