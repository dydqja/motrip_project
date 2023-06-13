package com.bit.motrip.controller.review;


import com.bit.motrip.common.Page;
import com.bit.motrip.common.Search;
import com.bit.motrip.dao.chatroom.ChatRoomDao;
import com.bit.motrip.domain.*;
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

    // 여행완료된 플랜목록 가져옴(ajax)

  /*  @RequestMapping("getCompletedTripPlan")
    @ResponseBody
    public ResponseEntity<List<TripPlan>> getCompletedTripPlan(@RequestParam(required = false) Integer chatRoomNo, HttpSession session) {
        try {
            List<TripPlan> tripPlans = new ArrayList<>();

            if (chatRoomNo != null) {
                // chatRoomNo가 제공된 경우
                tripPlans = reviewService.getCompletedTripPlan(chatRoomNo);
                System.out.println("chatRoomNo>>>>>>>>>>"+chatRoomNo);
                System.out.println("chatRoomNo가 제공된 경우 tripPlans?>>>>>>>"+tripPlans);
            } else {
                // chatRoomNo가 제공되지 않은 경우
                tripPlans = reviewService.getPublicNonDeletedTripPlans();
                System.out.println("chatRoomNo가 제공되지 않은 경우 tripPlans?>>>>>>>"+tripPlans);
            }
            // 첫 번째 tripPlanNo를 가져옴(@!!!!!!!!!!!!!원인 아니까 나중에 고치면 됨!!!!!!!!!!!!!!!!!!!!)
            int selectedTripPlanNo = 0;
            if (!tripPlans.isEmpty()) {
                selectedTripPlanNo = tripPlans.get(0).getTripPlanNo();
            }
            // 세션에 선택한 tripPlanNo 저장
            session.setAttribute("selectedTripPlanNo", selectedTripPlanNo);
            System.out.println("selectedTripPlanNo?>>>>>"+selectedTripPlanNo);

            return ResponseEntity.ok(tripPlans);
        } catch (Exception e) {
            // 예외 처리 로직 추가
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }*/

    //1.입력폼에 앞서 모달로 '완료된 여행플랜리스트' 띄워서 다음jsp에 Post
    @GetMapping("getCompletedTripPlanList")
    public String getCompletedTripPlanList(@RequestParam(defaultValue = "1") int currentPage, Model model, HttpSession session) throws Exception {
        System.out.println("getCompletedTripPlanList() : GET");

        Search search = new Search();
        search.setCurrentPage(currentPage);
        int pageSize = 5;
        search.setPageSize(pageSize);

        User dbUser = (User) session.getAttribute("user");
        if (dbUser == null) {
            //model.addAttribute("errorMessage", "로그인이 필요한 서비스입니다.");
            return "redirect:user/login.jsp";
        }

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
                                @RequestParam("tripPlanTitle") String tripPlanTitle,
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
        model.addAttribute("reviewAuthor", reviewAuthor);
        model.addAttribute("tripPlanNo", tripPlanNo);
        System.out.println("2.tripPlanNo>>>>"+model.addAttribute("tripPlanNo", tripPlanNo));
        model.addAttribute("tripPlanTitle", tripPlanTitle);
        System.out.println("2.tripPlanTitle>>>>"+model.addAttribute("tripPlanTitle", tripPlanTitle));

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
    public String getReviewList(@RequestParam(defaultValue = "1") int currentPage, Model model) throws Exception {
        System.out.println("/review/getReviewList : GET");

        Search search = new Search();
        search.setCurrentPage(currentPage);
        System.out.println("currentPage>>>>>>>>"+currentPage);
        System.out.println(search);
        int pageSize = 3;
        search.setPageSize(pageSize);

        Map<String, Object> parameters = new HashMap<>();
        parameters.put("search", search);
        parameters.put("condition", "publicReviewList"); // 전체 공개 후기 목록을 조회하기 위한 조건 설정

        Map<String, Object> reviewListData = reviewService.selectReviewList(parameters);
        List<Review> reviewList = (List<Review>) reviewListData.get("reviewList");
        System.out.println("reviewListData 왜 못갖고와"+reviewListData);
        System.out.println("reviewList 왜 못갖고와"+reviewList);

        int totalCount = (int) reviewListData.get("totalCount");
        System.out.println("컨트롤러@@@@@ parameters>>>>>>>>>>>>>>>>" + parameters);

        int pageUnit = 10; // 화면 하단에 표시할 페이지 수
        Page page = new Page(search.getCurrentPage(), totalCount, pageUnit, pageSize); // maxPage, beginUnitPage, endUnitPage 연산
        int maxPage = page.getMaxPage(); // 총 페이지 수
        int beginUnitPage = page.getBeginUnitPage(); // 화면 하단에 표시할 페이지의 시작 번호
        int endUnitPage = page.getEndUnitPage(); // 화면 하단에 표시할 페이지의 끝 번호

        model.addAttribute("reviewList", reviewList);
        model.addAttribute("page", page);
        model.addAttribute("maxPage", maxPage);
        model.addAttribute("beginUnitPage", beginUnitPage);
        model.addAttribute("endUnitPage", endUnitPage);
        model.addAttribute("search", search);
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

       Map<String, Object> parameters = new HashMap<>();
        parameters.put("search", search);
        parameters.put("user", dbUser);
        parameters.put("condition", "myReviewList"); // 나의 후기 목록을 조회하기 위한 조건 설정

        Map<String, Object> reviewList = reviewService.selectReviewList(parameters);
        List<Review> myReviewList = (List<Review>) reviewList.get("reviewList");

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

        model.addAttribute("myReviewList", myReviewList);
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



    @GetMapping("getReview") // 후기 단 1개 상세조회
    public String getReview(@RequestParam("reviewNo") int reviewNo, Model model, HttpSession session) {
        System.out.println("/review/getReview : GET");
        try {
            // 후기 상세 조회
            Review getReview = reviewService.getReview(reviewNo);
            if (getReview != null) {
                // 조회수 증가
                reviewService.getReview(reviewNo);

                // 댓글 목록 조회
                List<Comment> commentList = commentService.getCommentList(reviewNo);

                model.addAttribute("getReview", getReview);
                System.out.println("getReview >>>>>>>>" + getReview);
                model.addAttribute("commentList", commentList);
                System.out.println("commentList >>>>>>>>" + commentList);

                // 작성자 정보 설정
                String commentAuthor = (String) session.getAttribute("nickname");
                System.out.println("commentAuthor >>>>>>>>" + commentAuthor);
                model.addAttribute("commentAuthor", commentAuthor);

                return "review/getReview.jsp";
            } else {
                model.addAttribute("errorMessage", "해당 후기를 찾을 수 없습니다.");
                return "errorPage.jsp";
            }
        } catch (Exception e) {
            model.addAttribute("errorMessage", "후기 조회 중 오류가 발생했습니다.");
            e.printStackTrace();
            return "errorPage.jsp";
        }
    }




    @PostMapping(value = "updateReview")//후기 수정
    public String updateReview(@ModelAttribute("review") Review review, Model model) throws Exception {
        System.out.println("/review/updateReview : POST");
        reviewService.updateReview(review);
        model.addAttribute("review", review);
        System.out.println();

        return "review/updateReview.jsp";
    }
    @PostMapping(value = "deleteReview")//후기완전삭제
    public String deleteReview(@RequestParam("reviewNo") int reviewNo) {
        System.out.println("/review/deleteReview : POST");
        reviewService.deleteReview(reviewNo);

        return "redirect:/review/getMyReviewList.jsp";
    }
    @PostMapping(value = "recoverReview")//후기 복구
    public String recoverReview(@RequestParam("reviewNo") int reviewNo) {
        System.out.println("/review/recoverReview : POST");
        reviewService.recoverReview(reviewNo);

        return "redirect:/review/getMyReviewList.jsp";
    }
}//end of ReviewController

