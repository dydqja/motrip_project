package com.bit.motrip.controller.tripplan;

import com.bit.motrip.common.Page;
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
import java.util.Date;
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

    @GetMapping("tripPlanList")
    public String tripPlanList(@ModelAttribute("search") Search search,
                               @ModelAttribute("type") String type, Model model, HttpSession session) throws Exception{
        System.out.println("GET : tripPlanList()");

        if(search.getCurrentPage() == 0){
            search.setCurrentPage(1);
        }
        if(search.getPlanCondition() == ""){
            search.setPlanCondition("newDate");
        }

        int pageSize = 3;
        search.setPageSize(pageSize);

        Map<String, Object> parameters = new HashMap<>();
        parameters.put("search", search);
        if (type.equals("my")) {
            User user = (User) session.getAttribute("user");
            parameters.put("user", user);
        }
        System.out.println("처음 페이지 들어왔을떄 : " + parameters);

        Map<String, Object> tripPlanList= tripPlanService.selectTripPlanList(parameters);

        int totalCount = (int) tripPlanList.get("totalCount");
        int pageUnit = 3; // 화면 하단에 표시할 페이지 수

        Page page = new Page(search.getCurrentPage(), totalCount, pageUnit, pageSize); // maxPage, beginUnitPage, endUnitPage 연산
        int maxPage = page.getMaxPage(); // 총 페이지 수
        int beginUnitPage = page.getBeginUnitPage(); // 화면 하단에 표시할 페이지의 시작 번호
        int endUnitPage = page.getEndUnitPage(); // 화면 하단에 표시할 페이지의 끝 번호
        String tripPlanAuthor = (String) parameters.get("tripPlanAuthor");

        System.out.println("page " + page);
        System.out.println("maxPage " + maxPage);
        System.out.println("beginUnitPage " + beginUnitPage);
        System.out.println("endUnitPage " + endUnitPage);
        System.out.println("tripPlanAuthor " + tripPlanAuthor);
        System.out.println("search " + search);

        model.addAttribute("tripPlanList",tripPlanList.get("list"));
        model.addAttribute("page", page);
        model.addAttribute("maxPage", maxPage);
        model.addAttribute("beginUnitPage", beginUnitPage);
        model.addAttribute("endUnitPage", endUnitPage);
        model.addAttribute("tripPlanAuthor", tripPlanAuthor);
        model.addAttribute("search",search);

        System.out.println(tripPlanAuthor);
        if(tripPlanAuthor == null) {
            model.addAttribute("condition", "all");
        } else {
            model.addAttribute("condition", "my");
        }

        return "tripplan/tripPlanList2.jsp";
    }

    @GetMapping("addTripPlanView") // addTripPlanView 일반 네비게이션
    public String addTripPlanView(Model model) {
        System.out.println("GET : addTripPlanView()");

        model.addAttribute("date", new Date());
        return "tripplan/addTripPlan2.jsp";
    }

    @GetMapping("selectTripPlan")
    public String selectTripPlan(@RequestParam("tripPlanNo") int tripPlanNo, Model model, HttpSession session) throws Exception {
        System.out.println("GET : selectTripPlan()");

        TripPlan tripPlan = tripPlanService.selectTripPlan(tripPlanNo); // 해당 여행플랜에 대한 정보를 가져옴
        User dbUser = userService.getUserById(tripPlan.getTripPlanAuthor()); // 해당 여행플랜에 작성자 닉네임을 위해 정보를 가져옴

        model.addAttribute("tripPlan", tripPlan);
        model.addAttribute("nickName", dbUser.getNickname()); // 닉네임만 찾으면 되는데 세션 겹칠까봐 key값을 별도로두었음

        return "tripplan/selectTripPlan2.jsp";
    }

    @GetMapping("updateTripPlanView")
    public String updateTripPlanView(@RequestParam("tripPlanNo") int tripPlanNo, Model model, HttpSession session) throws Exception {
        System.out.println("GET : updateTripPlanView()");

        TripPlan tripPlan = tripPlanService.selectTripPlan(tripPlanNo); // 해당 여행플랜에 대한 정보를 가져옴
        User dbUser = userService.getUserById(tripPlan.getTripPlanAuthor()); // 해당 여행플랜에 작성자 닉네임을 위해 정보를 가져옴

        model.addAttribute("tripPlan", tripPlan);
        model.addAttribute("nickName", dbUser.getNickname()); // 닉네임만 찾으면 되는데 세션 겹칠까봐 key값을 별도로두었음

        return "tripplan/updateTripPlan2.jsp";
    }


    @GetMapping("testPlan")
    public String testPlan() throws Exception {
        System.out.println("GET : selectTripPlan()");

        return "tripplan/selectTripPlan2.jsp";
    }

}
