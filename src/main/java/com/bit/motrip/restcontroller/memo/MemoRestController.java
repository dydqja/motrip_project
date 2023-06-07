package com.bit.motrip.restcontroller.memo;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.*;
import com.bit.motrip.service.memo.MemoService;
import com.fasterxml.jackson.core.JsonProcessingException;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.sql.Date;
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
    private final String successJson = "{\"status\": \"success\", \"key2\": \"value2\", \"key3\": \"value3\"}";
    private final String failJson = "{\"status\": \"fail\", \"key2\": \"value2\", \"key3\": \"value3\"}";

    @PostMapping("getMemoList")
    public String getMemoList(HttpSession session,
                              @RequestParam("searchCondition") String searchCondition,
                              @RequestParam("currentPage") String currentPage)  {

        //System.out.println("레스트컨트롤러 겟메모리스트 동작");
        //리퀘스트 파람 둘과 유저를 모아서 필요한 데이터를 모두 수집했다.
        User user = null;
        try {
            user = (User) session.getAttribute("user");
            if (user == null) throw new RuntimeException("세션에 유저가 없습니다.");
        }catch (Exception e){
            throw new RuntimeException(e);
        }
        System.out.println("받은 유저아이디는"+user.getUserId());
        System.out.println("받은 서치컨디션은"+searchCondition);
        System.out.println("받은 현재페이지는"+currentPage);
        if (currentPage == null || currentPage.equals("")){
            currentPage = "1";
        }

        //검색조건을 세팅
        Search search = new Search();
        search.setSearchCondition(searchCondition);
        search.setCurrentPage(Integer.parseInt(currentPage));

        //비즈니스 로직 수행
        List<MemoDoc> memoDocList = null;
        try {
            //System.out.println("trying to get memoDocList on MemoRestController");
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
        //System.out.println(memoDocListJson);

        //세션에 현재조건을 저장
        MemoPage memoPage = new MemoPage();
        memoPage.setSearchCondition(searchCondition);
        memoPage.setCurrentPage(Integer.parseInt(currentPage));
        session.setAttribute("memoPage", memoPage);

        return memoDocListJson;
    }

    @PostMapping("getMemo")
    public String getMemo(@RequestParam("memoNo") String memoNo, HttpSession session)  {

        User user = (User) session.getAttribute("user");
        int memoNoInt = Integer.parseInt(memoNo);

        //System.out.println("로그인한 유저의 아이디는 "+user.getUserId()+"입니다.");
        //System.out.println("메모번호는 "+memoNo+"입니다.");

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
    public String updateMemo(
            HttpSession session
            ,@RequestParam("memoNo") String memoNo
            ,@RequestParam("memoContents") String memoContents
            ,@RequestParam("memoTitle") String memoTitle
            ,@RequestParam("memoDialogNo") String memoDialogNo
             )  {
        //System.out.println("레스트컨트롤러 업데이트메모 동작");
        //System.out.println("메모번호는 "+memoNo+"입니다.");
        //System.out.println("메모제목은 "+memoTitle+"입니다.");
        //System.out.println("메모내용은 "+memoContents+"입니다.");
        //System.out.println("메모다이얼로그번호는 "+memoDialogNo+"입니다.");

        User user = (User) session.getAttribute("user");
        int memoNoInt = Integer.parseInt(memoNo);

        Memo memo = new Memo();
        memo.setMemoNo(memoNoInt);
        memo.setMemoTitle(memoTitle);
        memo.setMemoContents(memoContents);
        memo.setMemoAuthor(user.getUserId());

        try {
            memo = memoService.updateMemo(memo);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        //memo를 직렬화
        ObjectMapper objectMapper = new ObjectMapper();
        String memoJson = "";
        try {
            memoJson = objectMapper.writeValueAsString(memo);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
        return memoJson;
    }
    @PostMapping("deleteMemo")
    public String deleteMemo(@RequestParam("memoNo") String memoNo)  {

        int memoNoInt = Integer.parseInt(memoNo);
        Memo memo = new Memo();
        memo.setMemoNo(memoNoInt);

        //System.out.println("메모번호는 "+memoNo+"입니다.");

        try {
            memoService.deleteMemo(memo);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return successJson;
    }
    @PostMapping("removeMemo")
    public String removeMemo(@RequestParam("memoNo") String memoNo)  {

        int memoNoInt = Integer.parseInt(memoNo);
        Memo memo = new Memo();
        memo.setMemoNo(memoNoInt);
        memo.setMemoDelDate(    new Date(System.currentTimeMillis())    );

        //System.out.println("메모번호는 "+memoNo+"입니다.");

        try {
            memoService.deleteMemo(memo);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return successJson;
    }
    //restore
    @PostMapping("restoreMemo")
    public String restoreMemo(
            @RequestParam("memoNo") String memoNo)  {

        int memoNoInt = Integer.parseInt(memoNo);

        Memo memo = new Memo();
        memo.setMemoNo(memoNoInt);
        memo.setMemoDelDate(new Date(System.currentTimeMillis()));

        //System.out.println("메모번호는 "+memoNo+"입니다.");

        try {
            memoService.restoreMemo(memo);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return successJson;
    }
    //새 메모 생성
    @PostMapping("addMemo")
    public String addMemo(
            HttpSession session,
            @RequestParam("memoDialogNo") String memoDialogNo) {
        //System.out.println("레스트컨트롤러 addMemo 동작");
        Memo memo = null;
        User user = (User) session.getAttribute("user");
        try {
            memo = memoService.addMemo(user);
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
    //getMemoSharerList
    @PostMapping("getMemoSharerList")
    public String getMemoSharerList(
            @RequestParam("memoNo") String memoNo)  {

        int memoNoInt = Integer.parseInt(memoNo);

        List<MemoAccess> memoAccessList = null;
        try {
            memoAccessList = memoService.getMemoSharerList(memoNoInt);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        ObjectMapper objectMapper = new ObjectMapper();
        String memoAccessListJson = "";
        try {
            memoAccessListJson = objectMapper.writeValueAsString(memoAccessList);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
        System.out.println(memoAccessListJson);
        return memoAccessListJson;
    }

    @PostMapping("deleteMemoAccess")
    public String deleteMemoAccess(
            @RequestParam("memoNo") String memoNo,
            @RequestParam("userId") String userId)  {

        int memoNoInt = Integer.parseInt(memoNo);


        try {
            memoService.deleteMemoAccess(userId,memoNoInt);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return successJson;
    }
    @PostMapping("addMemoAccess")
    public String addMemoAccess(
            @RequestParam("memoNo") String memoNo,
            @RequestParam("userId") String userId)  {

        int memoNoInt = Integer.parseInt(memoNo);

        int isSuccess = 0;
        try {
            isSuccess = memoService.addMemoAccess(userId,memoNoInt);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        if (isSuccess == 0) {
            return null;
        }
        return successJson;
    }
}
