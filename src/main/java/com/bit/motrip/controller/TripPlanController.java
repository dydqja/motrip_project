package com.bit.motrip.controller;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.TripPlan;
import com.bit.motrip.domain.User;
import com.bit.motrip.service.tripplan.TripPlanService;
import com.bit.motrip.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/tripPlan/*")
public class TripPlanController {

    @Autowired
    @Qualifier("tripPlanServiceImpl")
    private TripPlanService tripPlanService;
    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

    public TripPlanController(){
        System.out.println(this.getClass());
    }

    @GetMapping("tripPlanList") // 기본 여행플랜 리스트 (비회원도 가능)
    public String tripPlanList(@ModelAttribute("search")Search search, Model model) throws Exception {
        System.out.println("GET : tripPlanList()");

        if(search.getPageSize() == 0){
            search.setCurrentPage(1);
        } else {
            search.setCurrentPage(search.getCurrentPage());
        }

        Map<String, Object> paramaters = new HashMap<>();
        paramaters.put("search", search);

        Map<String, Object> tripPlanList = tripPlanService.selectTripPlanList(paramaters);

        model.addAttribute("tripPlanList", tripPlanList.get("tripPlanList"));

        return "tripplan/tripPlanList.tiles";
    }

    @GetMapping("myTripPlanList") // 나의 여행플랜 리스트
    public String myTripPlanList(@ModelAttribute("search")Search search, Model model, HttpSession session) throws Exception {
        System.out.println("GET : tripPlanList()");

        if(search.getPageSize() == 0){
            search.setCurrentPage(1);
        } else {
            search.setCurrentPage(search.getCurrentPage());
        }

        User dbUser = (User) session.getAttribute("user");
        Map<String, Object> paramaters = new HashMap<>();
        paramaters.put("search", search);
        paramaters.put("user", dbUser);

        Map<String, Object> tripPlanList = tripPlanService.selectTripPlanList(paramaters);

        model.addAttribute("tripPlanList", tripPlanList.get("tripPlanList"));
        model.addAttribute("publicPlanList", true); // 전체 공유에서는 삭제버튼이 안보이게 하기위함

        return "tripplan/tripPlanList.tiles";
    }

    @GetMapping("addTripPlanView") // addTripPlanView 일반 네비게이션
    public String addTripPlanView() {
        System.out.println("GET : addTripPlanView()");
        return "tripplan/addTripPlan.tiles";
    }

    @GetMapping("selectTripPlan")
    public String selectTripPlan(@RequestParam("tripPlanNo") int tripPlanNo, Model model, HttpSession session) throws Exception {
        System.out.println("GET : selectTripPlan()");

        TripPlan tripPlan = tripPlanService.selectTripPlan(tripPlanNo); // 해당 여행플랜에 대한 정보를 가져옴
        User dbUser = userService.getUserById(tripPlan.getTripPlanAuthor()); // 해당 여행플랜에 작성자 닉네임을 위해 정보를 가져옴

        model.addAttribute("tripPlan", tripPlan);
        model.addAttribute("nickName", dbUser.getNickname()); // 닉네임만 찾으면 되는데 세션 겹칠까봐 key값을 별도로두었음

        return "tripplan/selectTripPlan.tiles";
    }

    @GetMapping("updateTripPlan")
    public String updateTripPlan() throws Exception {
        System.out.println("GET : updateTripPlan()");

        return "null";
    }

}
