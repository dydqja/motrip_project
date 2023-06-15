package com.bit.motrip.controller.user;

import com.bit.motrip.common.Page;
import com.bit.motrip.common.Search;

import com.bit.motrip.domain.EvaluateList;
import com.bit.motrip.domain.Review;
import com.bit.motrip.domain.User;
import com.bit.motrip.service.chatroom.ChatRoomService;
import com.bit.motrip.service.evaluateList.EvaluateListService;
import com.bit.motrip.service.review.ReviewService;
import com.bit.motrip.service.tripplan.TripPlanService;
import com.bit.motrip.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;

import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user/*")
public class UserController {

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;
    @Autowired
    @Qualifier("tripPlanServiceImpl")
    private TripPlanService tripPlanService;
    @Autowired
    @Qualifier("reviewServiceImpl")
    private ReviewService reviewService;
    @Autowired
    @Qualifier("chatRoomServiceImpl")
    private ChatRoomService chatRoomService;
    @Autowired
    @Qualifier("evaluateListServiceImpl")
    private EvaluateListService evaluateListService;

    public UserController() {
        System.out.println(this.getClass());
    }

    @Value(value = "#{user['naver.client.id']}")
    String naverClientId;

    @Value(value = "#{user['naver.redirect.url']}")
    String naverCallbackUrl;

    @Value(value = "#{user['pageUnit']}")
    int pageUnit;
    @Value(value = "#{user['pageSize']}")
    int pageSize;

    @RequestMapping( value="login", method=RequestMethod.GET)
    public String login(HttpSession session) throws Exception{
        System.out.println("/user/login : GET");

        session.setAttribute("naverClientId", naverClientId);
        session.setAttribute("naverCallbackUrl", naverCallbackUrl);

        return "user/login.jsp";
    }

    @RequestMapping( value="naverLoginSuccess", method=RequestMethod.GET)
    public String naverLogin(HttpSession session) throws Exception{
        System.out.println("/user/naverLoginSuccess : GET");
        User user = (User) session.getAttribute("user");

        System.out.println(user);

        if(user.isSecession() == true) {
            return "user/restoreUser.jsp";
        }
        return "/index.jsp";
    }

    @RequestMapping( value="login", method=RequestMethod.POST )
    public String login(@ModelAttribute("user") User user , HttpSession session, HttpServletRequest request) throws Exception{
        System.out.println("/user/login : POST");


        //사용자가 입력한 아이디값이 DB에 저장된(회원가입된) 아이디인지 확인
        User dbUser=userService.getUserById(user.getUserId());
        System.out.println(dbUser);

        //아이디가 존재하지 않는경우
        if (dbUser == null) {
//            model.addAttribute("loginError", "아이디가 존재하지 않습니다.");
            request.setAttribute("idCheck", "fail");

            return "user/login.jsp"; // 로그인 페이지로 이동
        }

        //회원가입된 아이디에 저장된 비밀번호 값과, 사용자가 입력한 비밀번호값이 같은지 확인
        if( user.getPwd().equals(dbUser.getPwd())){
            //저장된 비밀번호와 입력한 비밀번호값이 같다면, session에 아이디값 저장
            session.setAttribute("user", dbUser);
            System.out.println("user stored in session: " + session.getAttribute("user"));
        } else {
            // 비밀번호가 일치하지 않는 경우
//            model.addAttribute("loginError", "비밀번호가 일치하지 않습니다.");
            request.setAttribute("pwdCheck", "fail");

            return "user/login.jsp"; // 로그인 페이지로 이동
        }

        if(dbUser.isSecession() == true) {
            return "user/restoreUser.jsp";
        }else {
            return "/index.jsp";
        }
    }

    @RequestMapping( value="addUser", method=RequestMethod.POST )
    public String addUser(@ModelAttribute("user") User user, HttpSession session) throws Exception {
        System.out.println("/user/addUser : POST");
        System.out.println("add 할 user 값은? : "+user);

        //Business Logic
        userService.addUser(user);

        session.setAttribute("user", user);

        return "redirect:/";
    }

    @RequestMapping( value="naverLogin", method=RequestMethod.GET )
    public String checkUser() throws Exception {
        System.out.println("/user/naverLogin : GET");

        return "user/naverLoginCallback.jsp";
    }

    @RequestMapping( value="addNaverUser", method=RequestMethod.GET )
    public String addNaverUser(HttpSession session, Model model) throws Exception {
        System.out.println("/user/addNaverUser : GET");

        User user = (User) session.getAttribute("user");
        model.addAttribute("user", user);

        System.out.println("addNaverUser.jsp 로 보내질 user의 값은? => "+user);

        return "user/addNaverUser.jsp";
    }

    @RequestMapping(value="listUser", method = RequestMethod.GET)
    public String listUser(@ModelAttribute("search") Search search, Model model) throws Exception{

        System.out.println("/user/listUser : GET");

//        Search search = new Search();
//        search.setCurrentPage(currentPage);

        if(search.getCurrentPage() == 0 ){
            search.setCurrentPage(1);
        }
        search.setPageSize(pageSize);

        // Business logic 수행
        Map<String , Object> map=userService.getList(search);

        Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
        System.out.println(map.get("list"));
        System.out.println(resultPage);
        System.out.println(search);

        // Model 과 View 연결
        model.addAttribute("list", map.get("list"));
        model.addAttribute("resultPage", resultPage);
        model.addAttribute("search", search);

        return "user/listUser.jsp";
    }

    @RequestMapping( value="getUser", method=RequestMethod.GET )
    public String getUser( @RequestParam(value="userId", required=false) String userId,
                           @RequestParam(value="nickname", required=false) String nickname,
                           @RequestParam(defaultValue = "1") int currentPage,
                           @RequestParam(value = "type", defaultValue = "all") String type, Model model, HttpSession session, HttpServletRequest request ) throws Exception {

        System.out.println("/user/getUser : GET");
        System.out.println("userId = [" + userId + "], nickname = [" + nickname + "]");
        //Business Logic
        if (userId != null) {
            User user = userService.getUserById(userId);
            System.out.println("getUserById로 가져온 user값은 ? " + user);
            // Model 과 View 연결
            model.addAttribute("getUser", user);
            request.setAttribute("getUser", user);


        } else if (nickname != null) {
            User user = userService.getUserByNickname(nickname);
            System.out.println("getUserByNickname으로 가져온 user값은 ? " + user);
            // Model 과 View 연결
            model.addAttribute("getUser", user);
            request.setAttribute("getUser", user);

        }

//        여행플랜 리스트 가져오는곳 #################################################################

        System.out.println("GET : tripPlanList()");

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

        Map<String, Object> tripPlanList = tripPlanService.selectTripPlanList(parameters);

        int totalCount = (int) tripPlanList.get("totalCount");
        int pageUnit = 3; // 화면 하단에 표시할 페이지 수

        Page page = new Page(currentPage, totalCount, pageUnit, pageSize); // maxPage, beginUnitPage, endUnitPage 연산
        int maxPage = page.getMaxPage(); // 총 페이지 수
        int beginUnitPage = page.getBeginUnitPage(); // 화면 하단에 표시할 페이지의 시작 번호
        int endUnitPage = page.getEndUnitPage(); // 화면 하단에 표시할 페이지의 끝 번호
        String tripPlanAuthor = (String) parameters.get("tripPlanAuthor");

        model.addAttribute("tripPlanList", tripPlanList.get("list"));
        model.addAttribute("page", page);
        model.addAttribute("maxPage", maxPage);
        model.addAttribute("beginUnitPage", beginUnitPage);
        model.addAttribute("endUnitPage", endUnitPage);
        model.addAttribute("tripPlanAuthor", tripPlanAuthor);
        System.out.println(tripPlanAuthor);
        if (tripPlanAuthor == null) {
            model.addAttribute("condition", "all");
        } else {
            model.addAttribute("condition", "my");
        }

//      채팅방목록 가져오는곳 #################################################################

        User sessionUser = (User) session.getAttribute("user");
        System.out.println(sessionUser);

        if (search.getCurrentPage() == 0) {

            search.setCurrentPage(1);
        }
//        if(search.getSearchKeyword() == null){
//            search.setSearchKeyword('');
//        }
        search.setPageSize(pageSize);

        Map<String, Object> chatRoomListData = chatRoomService.myChatRoomListPage(search, sessionUser.getUserId());

        int chatTotalCount = (int) chatRoomListData.get("totalCount");
        // maxPage, beginUnitPage, endUnitPage 연산
        Page chatPage = new Page(search.getCurrentPage(), chatTotalCount, pageUnit, pageSize);
        // 총 페이지 수
        int chatMaxPage = page.getMaxPage();
        // 화면 하단에 표시할 페이지의 시작 번호
        int chatBeginUnitPage = page.getBeginUnitPage();
        // 화면 하단에 표시할 페이지의 끝 번호
        int chatEndUnitPage = page.getEndUnitPage();

        model.addAttribute("chatRoomList", chatRoomListData.get("list"));
        model.addAttribute("chatRoomPage", chatPage);
        model.addAttribute("chatRoomMaxPage", chatMaxPage);
        model.addAttribute("chatRoomBeginUnitPage", chatBeginUnitPage);
        model.addAttribute("chatRoomEndUnitPage", chatEndUnitPage);
        model.addAttribute("chatRoomSearch", search);

//      후기목록 가져오는곳####################################################################

        System.out.println("getMyReviewList(): GET ");

        Search reviewSearch = new Search();
        reviewSearch.setCurrentPage(currentPage);

        reviewSearch.setPageSize(pageSize);

        User dbUser = (User) session.getAttribute("user");
        if (dbUser == null) {
            model.addAttribute("errorMessage", "로그인이 필요한 서비스입니다.");
            return "user/login.jsp";
        }

        Map<String, Object> reviewParameters = new HashMap<>();
        reviewParameters.put("search", reviewSearch);
        reviewParameters.put("user", dbUser);
        reviewParameters.put("condition", "myReviewList"); // 나의 후기 목록을 조회하기 위한 조건 설정

        Map<String, Object> reviewList = reviewService.selectReviewList(reviewParameters);
        List<Review> myReviewList = (List<Review>) reviewList.get("reviewList");

        int reviewTotalCount = (int) reviewList.get("totalCount");

        Page reviewPage = new Page(reviewSearch.getCurrentPage(), reviewTotalCount, pageUnit, pageSize); // maxPage, beginUnitPage, endUnitPage 연산
        int reviewMaxPage = reviewPage.getMaxPage(); // 총 페이지 수
        int reviewBeginUnitPage = reviewPage.getBeginUnitPage(); // 화면 하단에 표시할 페이지의 시작 번호
        int reviewEndUnitPage = reviewPage.getEndUnitPage(); // 화면 하단에 표시할 페이지의 끝 번호

        model.addAttribute("myReviewList", myReviewList);
        model.addAttribute("page", reviewPage);
        model.addAttribute("maxPage", reviewMaxPage);
        model.addAttribute("beginUnitPage", reviewBeginUnitPage);
        model.addAttribute("endUnitPage", reviewEndUnitPage);
        model.addAttribute("search", reviewSearch);

        model.addAttribute("reviewList", reviewList.get("myReviewList")); // 수정된 키 이름으로 변경

        return "/user/getUser.jsp";
    }

    @RequestMapping( value="secessionUser", method=RequestMethod.GET)
    public String secessionUser() throws Exception{
        System.out.println("/user/secessionUser : GET");

        return "/user/secessionUser.jsp";
    }

    @RequestMapping(value = "deleteUser", method = RequestMethod.POST)
    public String deleteUser(HttpSession session) throws Exception {
        System.out.println("/user/deleteUser : POST");

        User user = (User) session.getAttribute("user");
        System.out.println("회원탈퇴진행할 유저는 :: "+user);
        userService.secessionAndRestoreUser(user);

        return "/user/login.jsp";
    }

    @RequestMapping(value = "restoreUser", method = RequestMethod.POST)
    public String restoreUser(HttpSession session) throws Exception {
        System.out.println("/user/restoreUser : POST");

        User user = (User) session.getAttribute("user");
        userService.secessionAndRestoreUser(user);

        return "/user/login.jsp";
    }

    @RequestMapping(value = "logout", method = RequestMethod.GET)
    public String logout(HttpSession session) throws Exception {
        System.out.println("/user/logout : GET");

        session.invalidate();
        return "redirect:/";  // 매인페이지로 리다이렉트
    }
}
