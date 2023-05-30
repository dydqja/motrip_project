package com.bit.motrip.restcontroller;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.*;
import com.bit.motrip.service.memo.MemoService;
import com.fasterxml.jackson.core.JsonProcessingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.ArrayList;
import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/memo/*")
public class MemoRestController {

    //Constructor wiring
    public MemoRestController(MemoService memoService) {
        this.memoService = memoService;
    }
    //Field
    private final MemoService memoService;

    //Method
    /*@PostMapping("test")
    public String test(@RequestParam("searchCondition") String searchCondition, HttpSession session)  {

        User user = (User) session.getAttribute("user");
        System.out.println("로그인한 유저의 아이디는 "+user.getUserId()+"입니다.");
        System.out.println("검색조건은 "+searchCondition+"입니다.");

        List<MemoDoc> memoDocList = new ArrayList<>();

        MemoDoc memoDoc1 = new MemoDoc();
        Review review = new Review();
        review.setReviewNo(1);
        review.setReviewTitle("리뷰제목");
        review.setReviewAuthor("admin");
        memoDoc1.setReview(review);

        List<Memo> memoList1 = new ArrayList<>();
        Memo memo1 = new Memo();
        memo1.setMemoNo(1);
        memo1.setMemoAuthor("user1");
        memo1.setMemoTitle("일번메모제목");
        Memo memo2 = new Memo();
        memo2.setMemoNo(2);
        memo2.setMemoAuthor("user2");
        memo2.setMemoTitle("이번메모제목");
        Memo memo3 = new Memo();
        memo3.setMemoNo(3);
        memo3.setMemoAuthor("user3");
        memo3.setMemoTitle("삼번메모제목");
        memoList1.add(memo1);
        memoList1.add(memo2);
        memoList1.add(memo3);

        memoDoc1.setMemoList(memoList1);
        memoDocList.add(memoDoc1);

        MemoDoc memoDoc2 = new MemoDoc();

        TripPlan tripPlan = new TripPlan();
        tripPlan.setTripPlanNo(2);
        tripPlan.setTripPlanTitle("여행계획제목");
        tripPlan.setTripPlanAuthor("admin");
        memoDoc2.setTripPlan(tripPlan);

        List<Memo> memoList2 = new ArrayList<>();
        Memo memo4 = new Memo();
        memo4.setMemoNo(4);
        memo4.setMemoAuthor("user4");
        memo4.setMemoTitle("사번메모제목");
        Memo memo5 = new Memo();
        memo5.setMemoNo(5);
        memo5.setMemoAuthor("user5");
        memo5.setMemoTitle("오번메모제목");
        Memo memo6 = new Memo();
        memo6.setMemoNo(6);
        memo6.setMemoAuthor("user6");
        memo6.setMemoTitle("육번메모제목");
        memoList2.add(memo4);
        memoList2.add(memo5);
        memoList2.add(memo6);

        memoDoc2.setMemoList(memoList2);
        memoDocList.add(memoDoc2);

        //json 으로 변환
        ObjectMapper objectMapper = new ObjectMapper();
        String memoDocListJson = "";
        try {
            memoDocListJson = objectMapper.writeValueAsString(memoDocList);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
        System.out.println("이것은 변환된 쩨이쓴");
        System.out.println(memoDocListJson);

        return memoDocListJson;
    }*/

    @PostMapping("getMemoList")
    public String getMemoList(HttpSession session,
                              @RequestParam("searchCondition") String searchCondition,
                              @RequestParam("currentPage") String currentPage)  {

        User user = (User) session.getAttribute("user");
        if (currentPage == null || currentPage.equals("")){
            currentPage = "1";}
        session.setAttribute("memoCurrentPage", currentPage);

        System.out.println("로그인한 유저의 아이디는 "+user.getUserId()+"입니다.");
        System.out.println("검색조건은 "+searchCondition+"입니다.");
        System.out.println("현재페이지는 "+currentPage+"입니다.");

        Search search = new Search();
        search.setSearchCondition(searchCondition);
        search.setCurrentPage(Integer.parseInt(currentPage));

        List<MemoDoc> memoDocList = null;
        try {
            System.out.println("trying to get memoDocList on MemoRestController");
            memoDocList = memoService.getMemoList(user.getUserId(), search);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        //json 으로 변환
        ObjectMapper objectMapper = new ObjectMapper();
        String memoDocListJson = "";
        try {
            memoDocListJson = objectMapper.writeValueAsString(memoDocList);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
        System.out.println("이것은 변환된 쩨이쓴");
        System.out.println(memoDocListJson);

        return memoDocListJson;
    }

    @PostMapping("getMemo")
    public String getMemo(@RequestParam("memoNo") String memoNo, HttpSession session)  {

        User user = (User) session.getAttribute("user");
        int memoNoInt = Integer.parseInt(memoNo);

        System.out.println("로그인한 유저의 아이디는 "+user.getUserId()+"입니다.");
        System.out.println("메모번호는 "+memoNo+"입니다.");

        Memo memo = null;
        try {
            memo = memoService.getMemo(memoNoInt);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        ObjectMapper objectMapper = new ObjectMapper();
        String memoJson = "";
        try {
            memoJson = objectMapper.writeValueAsString(memo);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }

        return memoJson;
    }
    @PostMapping("updateMemo")
    public String updateMemo(HttpSession session
            ,@RequestParam("memoNo") String memoNo
            ,@RequestParam("memoContents") String memoContents
            ,@RequestParam("memoTitle") String memoTitle)  {

        System.out.println("메모번호는 "+memoNo+"입니다.");
        System.out.println("메모제목은 "+memoTitle+"입니다.");
        System.out.println("메모내용은 "+memoContents+"입니다.");

        User user = (User) session.getAttribute("user");
        int memoNoInt = Integer.parseInt(memoNo);

        Memo memo = new Memo();
        memo.setMemoNo(memoNoInt);
        memo.setMemoTitle(memoTitle);
        memo.setMemoContents(memoContents);
        memo.setMemoAuthor(user.getUserId());

        try {
            memoService.updateMemo(memo);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        ObjectMapper objectMapper = new ObjectMapper();
        String memoJson = "";

        return memoJson;
    }
}
