package com.bit.motrip.controller.review;


import com.bit.motrip.common.Page;
import com.bit.motrip.common.Search;
import com.bit.motrip.dao.chatroom.ChatRoomDao;
import com.bit.motrip.dao.tripplan.TripPlanDao;
import com.bit.motrip.domain.*;
import com.bit.motrip.service.evaluateList.EvaluateListService;
import com.bit.motrip.service.review.CommentService;
import com.bit.motrip.service.review.ReviewService;
import com.bit.motrip.service.tripplan.TripPlanService;
import com.bit.motrip.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/review/*")

public class ReviewController {
    ///Field
    @Autowired
    @Qualifier("reviewServiceImpl")
    private ReviewService reviewService;

    @Autowired
    @Qualifier("commentServiceImpl")
    private CommentService commentService;

    @Autowired
    @Qualifier("tripPlanServiceImpl")
    private  TripPlanService tripPlanService;

    @Autowired
    @Qualifier("userServiceImpl")
    private  UserService userService;

    @Autowired
    @Qualifier("chatRoomDao")
    ChatRoomDao chatRoomDao; //Chatroom

    @Autowired
    @Qualifier("evaluateListServiceImpl")
    private EvaluateListService evaluateListService; //Chatroom




    ///Contructor
    public ReviewController(){
        System.out.println("ReviewController 생성자");
        System.out.println(this.getClass());
    }

    @Value(value = "#{review['reviewPageSize']}")
    //@Value("#{commonProperties['pageUnit'] ?: 3}")
    int pageUnit;
    @Value(value = "#{review['reviewPageUnit']}")
    //@Value("#{commonProperties['pageSize'] ?: 2}")
    int pageSize;
    ///Contructor

    public ReviewController(TripPlanService tripPlanService,ReviewService reviewService) {
        this.tripPlanService = tripPlanService;
        this.reviewService = reviewService;
    }


    //1.입력폼에 앞서 모달로 '완료된 여행플랜리스트' 띄워서 다음 jsp에 Post
    @GetMapping("getCompletedTripPlanList")
    public String getCompletedTripPlanList(@RequestParam(defaultValue = "1") int currentPage, Model model, HttpSession session) throws Exception {
        System.out.println("getCompletedTripPlanList() : GET");

        User dbUser = (User) session.getAttribute("user");
        if (dbUser == null) {
            //model.addAttribute("errorMessage", "로그인이 필요한 서비스입니다.");
            return "user/login.jsp";
        }

        Search search = new Search();
        search.setCurrentPage(currentPage);
        int pageSize = 5;
        search.setPageSize(pageSize);

        Map<String, Object> parameters = new HashMap<>();
        parameters.put("search", search);
        parameters.put("user", dbUser);

        Map<String, Object> tripPlanList = reviewService.getCompletedTripPlanList(parameters);
        List<TripPlan> tripPlanList1 = (List<TripPlan>) tripPlanList.get("tripPlanList");
        //System.out.println("깐쮸롤러 tripPlanList11111>>>>>>>"+tripPlanList);
        int totalCount = (int) tripPlanList.get("totalCount");
        int pageUnit = 10; // 화면 하단에 표시할 페이지 수

        Page page = new Page(currentPage, totalCount, pageUnit, pageSize); // maxPage, beginUnitPage, endUnitPage 연산
        int maxPage = page.getMaxPage(); // 총 페이지 수
        int beginUnitPage = page.getBeginUnitPage(); // 화면 하단에 표시할 페이지의 시작 번호
        int endUnitPage = page.getEndUnitPage(); // 화면 하단에 표시할 페이지의 끝 번호

        System.out.println("깐쮸롤러 tripPlanList2222>>>>>>>"+tripPlanList);

        model.addAttribute("tripPlanList", tripPlanList1);
        System.out.println("tripPlanList@@@@@@@@@@ : " + model.getAttribute("tripPlanList"));
        model.addAttribute("user", dbUser);
        model.addAttribute("page", page);
        model.addAttribute("maxPage", maxPage);
        model.addAttribute("beginUnitPage", beginUnitPage);
        model.addAttribute("endUnitPage", endUnitPage);
        System.out.println("깐쮸롤러1111111 parameters>>>>>>"+parameters);


        return "/review/getCompletedTripPlanList.jsp";
    }



    //2.단순 입력폼에서 정보 입력받음 Get
    @GetMapping(value = "addReviewView")
    public String addReviewView(@RequestParam("tripPlanNo") int tripPlanNo,Review review,
                                Model model,HttpSession session) throws Exception {
        System.out.println("/review/addReviewView: GET");

        // 세션에서 로그인된 사용자 정보를 가져옴
        User user = (User) session.getAttribute("user");
        System.out.println("userId>>>"+user.getUserId());
        String reviewAuthor = user.getUserId();

        // 가져온 userId 값을 review 객체의 reviewAuthor에 설정
        review.setReviewAuthor(reviewAuthor);
        System.out.println("reviewAuthor>>>"+reviewAuthor);

        TripPlan tripPlan = tripPlanService.selectTripPlan(tripPlanNo);
        System.out.println("여기는 컨트롤러 addReviewView>>>>>>>>>"+tripPlan);

        model.addAttribute("tripPlan", tripPlan);
        System.out.println("컨트롤러 tripPlan>>>>>>>>>>>>>>>>>>>>>> "+tripPlan);
        model.addAttribute("reviewAuthor", reviewAuthor);
        model.addAttribute("tripPlanNo", tripPlanNo);
        System.out.println("2.tripPlanNo>>>>"+model.addAttribute("tripPlanNo", tripPlanNo));



        return "review/addReviewView.jsp";
    }

    //3.입력폼에서 입력받은 모든 값들을 Post
    @PostMapping(value = "addReview")
    public String addReview(@ModelAttribute("review") Review review,
                            @RequestParam("tripPlanNo") int tripPlanNo,
                            @RequestParam("tripPlanTitle") String tripPlanTitle,
                            Model model, HttpSession session) throws Exception {
        System.out.println("/review/addReview : POST");
        // 세션에서 로그인된 userId 값을 가져옴
        String userId = (String) session.getAttribute("userId");
        String reviewAuthor = userId;

        // Review 객체 생성 및 review_author 값 설정
        Review newReview = new Review();
        newReview.setReviewAuthor(review.getReviewAuthor());
        newReview.setReviewTitle(review.getReviewTitle());
        newReview.setReviewContents(review.getReviewContents());
        newReview.setReviewThumbnail(review.getReviewThumbnail());
        newReview.setisReviewPublic(review.getisReviewPublic());
        newReview.setReviewLikes(review.getReviewLikes());
        newReview.setViewCount(review.getViewCount());
        newReview.setReviewRegDate(new Date()); // CURRENT_TIMESTAMP 대신에 현재 날짜와 시간 설정
        newReview.setisReviewDeleted(review.getisReviewDeleted());
        newReview.setReviewDelDate(review.getReviewDelDate());

        System.out.println("newReview>>>>"+newReview);

        // tripPlanNo 설정
        newReview.setTripPlanNo(tripPlanNo);
        // tripPlan 객체 조회
        TripPlan tripPlan = tripPlanService.selectTripPlan(tripPlanNo);
        // 모델에 tripPlan 추가
        model.addAttribute("tripPlan", tripPlan);
        System.out.println("여기는 컨트롤러 addReview>>>>>>>>>"+tripPlan);
        reviewService.addReview(newReview);



        model.addAttribute("reviewAuthor", reviewAuthor);
        model.addAttribute("review", newReview);
        System.out.println("컨트롤러 review>>>>" + newReview);
        model.addAttribute("tripPlanTitle", tripPlanTitle);
        System.out.println("3.tripPlanTitle>>>>" + model.addAttribute("tripPlanTitle", tripPlanTitle));

        return "review/addReview.jsp"; // 등록된 후기 jsp
    }





    @GetMapping("getReviewList") // 공개된 모든 후기 목록 조회
    public String getReviewList(@RequestParam(defaultValue = "1") int currentPage,
                                @RequestParam(value = "type", defaultValue = "all") String type,
                                @RequestParam(value = "reviewCondition", defaultValue = "newDate") String reviewCondition,
                                @RequestParam(value = "searchKeyword", required = false) String searchKeyword,Model model, HttpSession session) throws Exception {
        System.out.println("/review/getReviewList : GET");

        Search search = new Search();
        search.setCurrentPage(currentPage);
        search.setReviewCondition(reviewCondition);

        System.out.println("currentPage>>>>>>>>"+currentPage);
        System.out.println(search);

        int pageSize = 3;
        search.setPageSize(pageSize);

        Map<String, Object> parameters = new HashMap<>();
        parameters.put("search", search);
        parameters.put("condition", "publicReviewList"); // 전체 공개 후기 목록을 조회하기 위한 조건 설정


        //######용범 추가 부분 시작(blackList 관련)##############
        if(session.getAttribute("user") != null) {
            User myUser = (User) session.getAttribute("user");
            Map<String, Object> evaluaterId = new HashMap<>();
            evaluaterId.put("evaluaterId", myUser.getUserId());

            System.out.println("세션에 등록된 아이디는? ::" + evaluaterId);
            List<String> getBlacklistAll = evaluateListService.getBlacklistAll(evaluaterId);
            System.out.println("세션유저를/가 블랙한 아이디리스트 = :: " + getBlacklistAll);

            parameters.put("blacklist", getBlacklistAll);
        }
        //######용범 추가 부분 끝(blackList 관련)##############

        Map<String, Object> reviewListData = reviewService.selectReviewList(parameters);
        List<Review> reviewList = (List<Review>) reviewListData.get("reviewList");
        for (Review review : reviewList) {
            int tripPlanNo = review.getTripPlanNo();
            int reviewNo = review.getReviewNo();
            int reviewLikes = review.getReviewLikes();
            int viewCount = review.getViewCount();

            TripPlan tripPlan = tripPlanService.selectTripPlan(tripPlanNo);
            model.addAttribute("reviewNo", reviewNo);
            System.out.println("reviewNo>>>"+reviewNo);
            model.addAttribute("tripPlan", tripPlan);
            model.addAttribute("reviewLikes", reviewLikes);
            model.addAttribute("viewCount", viewCount);
            System.out.println("tripPlan>>>>>"+tripPlan);
        }

        System.out.println("reviewListData 왜 못갖고와"+reviewListData);
        System.out.println("reviewList 왜 못갖고와"+reviewList);

        int totalCount = (int) reviewListData.get("totalCount");
        System.out.println("컨트롤러@@@@@ parameters>>>>>>>>>>>>>>>>" + parameters);

        int pageUnit = 10; // 화면 하단에 표시할 페이지 수
        Page page = new Page(search.getCurrentPage(), totalCount, pageUnit, pageSize); // maxPage, beginUnitPage, endUnitPage 연산
        int maxPage = page.getMaxPage(); // 총 페이지 수
        int beginUnitPage = page.getBeginUnitPage(); // 화면 하단에 표시할 페이지의 시작 번호
        int endUnitPage = page.getEndUnitPage(); // 화면 하단에 표시할 페이지의 끝 번호
        String reviewAuthor = (String) parameters.get("reviewAuthor");


        model.addAttribute("reviewList", reviewList);
        model.addAttribute("page", page);
        model.addAttribute("maxPage", maxPage);
        model.addAttribute("beginUnitPage", beginUnitPage);
        model.addAttribute("endUnitPage", endUnitPage);
        model.addAttribute("search", search);
        model.addAttribute("reviewAuthor", reviewAuthor);
        System.out.println("컨트롤러 reviewList >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + reviewList);
        System.out.println(page);
        System.out.println(maxPage);
        System.out.println(beginUnitPage);
        System.out.println(endUnitPage);
        System.out.println(totalCount);
        System.out.println(search);
        System.out.println("컨트롤러 parameters>>>>>>>>>>>>>>>>" + parameters);

        return "review/getReviewList.jsp";
    }



    @GetMapping("getMyReviewList") // 나의 후기 목록
    public String getMyReviewList(@RequestParam(defaultValue = "1") int currentPage, Model model, HttpSession session) throws Exception {
        System.out.println("getMyReviewList(): GET ");

        Search search = new Search();
        search.setCurrentPage(currentPage);
        System.out.println("currentPage>>>>>>>>"+currentPage);
        System.out.println(search);
        int pageSize = 3;
        search.setPageSize(pageSize);

        User dbUser = (User) session.getAttribute("user");
        if (dbUser == null) {
            model.addAttribute("errorMessage", "로그인이 필요한 서비스입니다.");
            return "user/login.jsp";
        }
        // 사용자의 userId를 세션에 저장
        session.setAttribute("userId", dbUser.getUserId());

        Map<String, Object> parameters = new HashMap<>();
        parameters.put("search", search);
        parameters.put("user", dbUser);
        parameters.put("condition", "myReviewList"); // 나의 후기 목록을 조회하기 위한 조건 설정

        Map<String, Object> reviewList = reviewService.selectReviewList(parameters);
        List<Review> myReviewList = (List<Review>) reviewList.get("reviewList");
        for (Review review : myReviewList) {
            int tripPlanNo = review.getTripPlanNo();
            TripPlan tripPlan = tripPlanService.selectTripPlan(tripPlanNo);
            model.addAttribute("tripPlan", tripPlan);
            System.out.println("tripPlan>>>>>"+tripPlan);
        }

        Map<String, Object> tripPlanList= tripPlanService.selectTripPlanList(parameters);

        System.out.println("myReviewList 왜 못갖고와"+myReviewList);
        System.out.println("reviewList 왜 못갖고와"+reviewList);

        int totalCount = (int) reviewList.get("totalCount");
        System.out.println(totalCount);
        System.out.println("컨트롤러getMyReviewList  parameters>>>>>>>>>>>>>>>>" + parameters);

        int pageUnit = 10; // 화면 하단에 표시할 페이지 수
        Page page = new Page(search.getCurrentPage(), totalCount, pageUnit, pageSize); // maxPage, beginUnitPage, endUnitPage 연산
        int maxPage = page.getMaxPage(); // 총 페이지 수
        int beginUnitPage = page.getBeginUnitPage(); // 화면 하단에 표시할 페이지의 시작 번호
        int endUnitPage = page.getEndUnitPage(); // 화면 하단에 표시할 페이지의 끝 번호
        String reviewAuthor = (String) parameters.get("reviewAuthor");

        model.addAttribute("tripPlanList",tripPlanList.get("list"));
        model.addAttribute("myReviewList", myReviewList);
        model.addAttribute("reviewAuthor", reviewAuthor);
        model.addAttribute("page", page);
        model.addAttribute("maxPage", maxPage);
        model.addAttribute("beginUnitPage", beginUnitPage);
        model.addAttribute("endUnitPage", endUnitPage);
        model.addAttribute("search", search);
        System.out.println(page);
        System.out.println(maxPage);
        System.out.println(beginUnitPage);
        System.out.println(endUnitPage);
        System.out.println(totalCount);
        System.out.println(search);
        System.out.println("컨트롤러 getMyReviewList parameters>>>>>>>>>>>>>>>>" + parameters);


        model.addAttribute("reviewList", reviewList.get("myReviewList")); // 수정된 키 이름으로 변경


        return "review/getMyReviewList.jsp";
    }



    @GetMapping("/getReview")
    public String getReview(@RequestParam("reviewNo") int reviewNo, Model model, HttpSession session) throws Exception {
        System.out.println("getReview (): GET ");
        // 리뷰 상세 조회
        Review review = reviewService.getReview(reviewNo);
        User user = userService.getUserById(review.getReviewAuthor());
        model.addAttribute("userPhoto", user.getUserPhoto()); // 닉네임만 찾으면 되는데 세션 겹칠까봐 key값을 별도로두었음


        // 썸네일 문자열 처리
        String reviewThumbnail = review.getReviewThumbnail();
        if (reviewThumbnail != null && reviewThumbnail.startsWith("'") && reviewThumbnail.endsWith("'")) {
            reviewThumbnail = reviewThumbnail.substring(1, reviewThumbnail.length() - 1);
            review.setReviewThumbnail(reviewThumbnail);
        }
        System.out.println("reviewThumbnail에 싱글쿼티션이 짤렸나요?>>>"+reviewThumbnail);

        // 해당 리뷰와 관련된 여행 계획 정보 가져오기
        TripPlan tripPlan = tripPlanService.selectTripPlan(review.getTripPlanNo());

        model.addAttribute("user", user);
        model.addAttribute("review", review);
        System.out.println("user>>>>"+user);
        System.out.println("review객체에 들어있는 reviewThumbnail는 싱글쿼티션이 짤렸나요?>>>"+reviewThumbnail);
        model.addAttribute("tripPlan", tripPlan);

        System.out.println(user.getUserPhoto());

        return "review/getReview.jsp";
    }

    @GetMapping(value = "/updateReviewView")//후기 수정
    public String updateReviewView(@RequestParam("reviewNo") int reviewNo,
                                   @RequestParam("tripPlanNo") int tripPlanNo,Model model, HttpSession session) throws Exception {
        System.out.println("/review/updateReviewView : GET");

        // 세션에서 로그인된 사용자 정보를 가져옴
        User user = (User) session.getAttribute("user");
        if (user == null) {
            model.addAttribute("errorMessage", "로그인이 필요한 서비스입니다.");
            return "user/login.jsp";
        }
        System.out.println("userId>>>"+user.getUserId());
        String reviewAuthor = user.getUserId();

        TripPlan tripPlan = tripPlanService.selectTripPlan(tripPlanNo);
        Review review = reviewService.getReview(reviewNo);

        // 가져온 userId 값을 review 객체의 reviewAuthor에 설정
        review.setReviewAuthor(reviewAuthor);

        System.out.println("reviewAuthor>>>"+reviewAuthor);

        model.addAttribute("reviewAuthor", reviewAuthor);
        model.addAttribute("review", review);
        model.addAttribute("tripPlan", tripPlan);

        return "review/updateReviewView.jsp";
    }

    @RequestMapping(method = RequestMethod.POST)//후기 수정
    public String updateReview(@ModelAttribute("review") Review review,
                               @RequestParam("reviewNo") int reviewNo,
                               @RequestParam("tripPlanTitle") String tripPlanTitle,
                               Model model, HttpSession session) throws Exception {
        System.out.println("/review/updateReview : POST");

        reviewService.updateReview(review);

        // 세션에서 로그인된 사용자 정보를 가져옴
        User user = (User) session.getAttribute("user");
        System.out.println("userId>>>"+user.getUserId());
        String reviewAuthor = user.getUserId();

        // 가져온 userId 값을 review 객체의 reviewAuthor에 설정
        review.setReviewAuthor(reviewAuthor);
        System.out.println("reviewAuthor>>>"+reviewAuthor);


        model.addAttribute("tripPlanTitle", tripPlanTitle);
        System.out.println("3.tripPlanTitle>>>>" + model.addAttribute("tripPlanTitle", tripPlanTitle));
        model.addAttribute("reviewAuthor", reviewAuthor);
        model.addAttribute("review", review);

        return "redirect:/review/getReview?reviewNo=" + reviewNo;

    }
    @RequestMapping("deleteReview")//후기완전삭제
    public String deleteReview(@RequestParam("reviewNo") int reviewNo)throws Exception {
        System.out.println("::");
        System.out.println("/review/deleteReview :");
        reviewService.deleteReview(reviewNo);

        return "redirect:/review/getMyReviewList";
    }
    @PostMapping(value = "recoverReview")//후기 복구
    public String recoverReview(@RequestParam("reviewNo") int reviewNo) {
        System.out.println("/review/recoverReview : POST");
        reviewService.recoverReview(reviewNo);

        return "redirect:/review/getMyReviewList.jsp";
    }
}//end of ReviewController

