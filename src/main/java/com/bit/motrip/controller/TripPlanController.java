package com.bit.motrip.controller;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.DailyPlan;
import com.bit.motrip.domain.TripPlan;
import com.bit.motrip.service.tripplan.TripPlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
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

        if(search.getPageSize() == 0){search.setCurrentPage(0);}
        search.setCurrentPage(search.getCurrentPage());

        List<TripPlan> tripPlanList = tripPlanService.selectTripPlanList(search);

        System.out.println(tripPlanList.toString());
        model.addAttribute("tripPlanList", tripPlanList);

        return "tripplan/tripPlanList.jsp";
    }

    @GetMapping("addTripPlanView")
    public String addTripPlanView() {
        System.out.println("GET : addTripPlanView()");
        return "tripplan/addTripPlan.jsp";
    }

    @PostMapping("addTripPlan")
    public String addTripPlan() {
        System.out.println("POST : addTripPlan()");
        return "tripplan/tripPlanList.jsp";
    }

    @GetMapping("selectTripPlan")
    public String selectTripPlan(@RequestParam("tripPlanNo") int tripPlanNo, Model model) throws Exception {
        System.out.println("GET : selectTripPlan()");

        TripPlan tripPlan = tripPlanService.selectTripPlan(tripPlanNo);

        System.out.println(tripPlan.toString());
        model.addAttribute("tripPlan", tripPlan);

        return "tripplan/selectTripPlan.jsp";
    }

    @GetMapping("updateTripPlan")
    public String updateTripPlan() throws Exception {
        System.out.println("GET : updateTripPlan()");

        return "null";
    }

}
