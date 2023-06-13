package com.bit.motrip.controller.tripplan;

import com.bit.motrip.common.Page;
import com.bit.motrip.common.Search;
import com.bit.motrip.domain.EvaluateList;
import com.bit.motrip.domain.TripPlan;
import com.bit.motrip.domain.User;
import com.bit.motrip.service.evaluateList.EvaluateListService;
import com.bit.motrip.service.tripplan.TripPlanService;
import com.bit.motrip.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@RequestMapping("/tripPlan/*")
public class TripPlanController {

    @Autowired
    @Qualifier("tripPlanServiceImpl")
    private TripPlanService tripPlanService;
    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;
    @Autowired
    @Qualifier("evaluateListServiceImpl")
    private EvaluateListService evaluateListService;

    public TripPlanController(){
        System.out.println(this.getClass());
    }

//    @GetMapping("tripMyPlanList") // 기본 여행플랜 리스트 (비회원도 가능)
//    public String tripPlanList(@ModelAttribute("search")Search search, Model model) throws Exception {
//        System.out.println("GET : tripPlanList()");
//
//        if(search.getPageSize() == 0){
//            search.setCurrentPage(1);
//        } else {
//            search.setCurrentPage(search.getCurrentPage());
//        }
//
//        Map<String, Object> paramaters = new HashMap<>();
//        paramaters.put("search", search);
//
//        Map<String, Object> tripPlanList = tripPlanService.selectMyTripPlanList(paramaters);
//
//        model.addAttribute("tripPlanList", tripPlanList.get("tripPlanList"));
//
//        return "tripplan/tripPlanList.jsp";
//    }

//    @GetMapping("myTripPlanList") // 나의 여행플랜 리스트
//    public String myTripPlanList(@ModelAttribute("search")Search search, Model model, HttpSession session) throws Exception {
//        System.out.println("GET : myTripPlanList()");
//
//        if(search.getPageSize() == 0){
//            search.setCurrentPage(1);
//        } else {
//            search.setCurrentPage(search.getCurrentPage());
//        }
//
//        User dbUser = (User) session.getAttribute("user");
//        Map<String, Object> paramaters = new HashMap<>();
//        paramaters.put("search", search);
//        paramaters.put("user", dbUser);
//
//        Map<String, Object> tripPlanList = tripPlanService.selectTripPlanList(paramaters);
//
//        model.addAttribute("tripPlanList", tripPlanList.get("tripPlanList"));
//        model.addAttribute("publicPlanList", true); // 전체 공유에서는 삭제버튼이 안보이게 하기위함
//
//        return "tripplan/tripPlanList.jsp";
//    }

    @GetMapping("tripPlanList")
    public String tripPlanList(@RequestParam(defaultValue = "1") int currentPage,
                               @RequestParam(value = "type", defaultValue = "all") String type, Model model, HttpSession session) throws Exception{
        System.out.println("GET : tripPlanList()");

//        용범 추가부분 시작 ########################################
        User myUser = (User) session.getAttribute("user");
        Map<String,Object> evaluaterId = new HashMap<>();
        evaluaterId.put("evaluaterId",myUser.getUserId());

        System.out.println("세션에 등록된 아이디는? ::" + evaluaterId);
        List<String> getBlacklistAll = evaluateListService.getBlacklistAll(evaluaterId);
        System.out.println("세션유저를/가 블랙한 아이디리스트 = :: "+ getBlacklistAll);

//        용범 추가부분 끝 ##########################################

        Search search = new Search();
        search.setCurrentPage(currentPage);

        int pageSize = 5;
        search.setPageSize(pageSize);

        Map<String, Object> parameters = new HashMap<>();
        parameters.put("search", search);
        if (type.equals("my")) {
            User user = (User) session.getAttribute("user");
            parameters.put("user", user);
        }
        System.out.println("처음 페이지 들어왔을떄 : " + parameters);

        Map<String, Object> tripPlanList= tripPlanService.selectTripPlanList(parameters);


//        용범 추가부분 시작 ########################################
        System.out.println("Map<String, Object> tripPlanList 의 값은?? :: "+ tripPlanList);
        // 새로운 리스트를 저장할 Map<String, Object>을 초기화합니다.
        Map<String, Object> newTripPlanList = new HashMap<>();
        // "list"라는 키로 리스트를 꺼냅니다.
        List<TripPlan> tripPlans = (List<TripPlan>) tripPlanList.get("list");
        // 필터링된 TripPlan들을 저장할 리스트를 생성합니다.
        List<TripPlan> filteredTripPlans = new ArrayList<>();
        // 리스트를 반복 처리합니다.
        for (TripPlan tripPlan : tripPlans) {
            // tripPlanAuthor 필드가 블랙리스트에 포함되어 있지 않다면 리스트에 추가합니다.
            if (!getBlacklistAll.contains(tripPlan.getTripPlanAuthor())) {
                filteredTripPlans.add(tripPlan);
            }
        }
        // 필터링된 리스트를 새로운 Map에 "list"라는 키로 저장합니다.
        newTripPlanList.put("list", filteredTripPlans);
        // totalCount 값을 복사합니다.
        newTripPlanList.put("totalCount", tripPlanList.get("totalCount"));
        // 필터링된 리스트의 크기를 totalCount로 설정합니다.
//        newTripPlanList.put("totalCount", filteredTripPlans.size());

        System.out.println("블랙리스트 제외한 플랜목록 :: "+newTripPlanList);

//        용범 추가부분 끝 ##########################################


        int totalCount = (int) newTripPlanList.get("totalCount");
        int pageUnit = 3; // 화면 하단에 표시할 페이지 수

        Page page = new Page(search.getCurrentPage(), totalCount, pageUnit, pageSize); // maxPage, beginUnitPage, endUnitPage 연산
        int maxPage = page.getMaxPage(); // 총 페이지 수
        int beginUnitPage = page.getBeginUnitPage(); // 화면 하단에 표시할 페이지의 시작 번호
        int endUnitPage = page.getEndUnitPage(); // 화면 하단에 표시할 페이지의 끝 번호
        String tripPlanAuthor = (String) parameters.get("tripPlanAuthor");

        model.addAttribute("tripPlanList",newTripPlanList.get("list"));
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

//    @GetMapping("myTripPlanList") // 나의 여행플랜 리스트
//    public String myTripPlanList(@RequestParam(defaultValue = "1") int currentPage, Model model, HttpSession session) throws Exception {
//        System.out.println("GET : myTripPlanList()");
//
//        Search search = new Search();
//        search.setCurrentPage(currentPage);
//        int pageSize = 5;
//        search.setPageSize(pageSize);
//
//        User dbUser = (User) session.getAttribute("user");
//
//        Map<String, Object> parameters = new HashMap<>();
//        parameters.put("search", search);
//        parameters.put("user", dbUser);
//
//        Map<String, Object> tripPlanList = tripPlanService.selectMyTripPlanList(parameters);
//
//        int totalCount = (int) tripPlanList.get("totalCount");
//        int pageUnit = 3; // 화면 하단에 표시할 페이지 수
//
//        Page page = new Page(currentPage, totalCount, pageUnit, pageSize); // maxPage, beginUnitPage, endUnitPage 연산
//        int maxPage = page.getMaxPage(); // 총 페이지 수
//        int beginUnitPage = page.getBeginUnitPage(); // 화면 하단에 표시할 페이지의 시작 번호
//        int endUnitPage = page.getEndUnitPage(); // 화면 하단에 표시할 페이지의 끝 번호
//
//        model.addAttribute("tripPlanList", tripPlanList.get("list"));
//        model.addAttribute("user", dbUser);
//        model.addAttribute("publicPlanList", true); // 전체 공유에서는 삭제버튼이 안보이게 하기위함
//        model.addAttribute("page", page);
//        model.addAttribute("maxPage", maxPage);
//        model.addAttribute("beginUnitPage", beginUnitPage);
//        model.addAttribute("endUnitPage", endUnitPage);
//
//
//        return "tripplan/tripPlanList2.jsp";
//    }

    @GetMapping("addTripPlanView") // addTripPlanView 일반 네비게이션
    public String addTripPlanView(Model model, HttpSession session) {
        System.out.println("GET : addTripPlanView()");

        if (session.getAttribute("user") == null) {
            return "user/login.jsp";
        }

        //model.addAttribute("date", new Date());
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

        if (session.getAttribute("user") == null) {
            return "user/login.jsp";
        }

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
