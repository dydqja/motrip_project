package com.bit.motrip.controller;

import com.bit.motrip.common.Page;
import com.bit.motrip.common.Search;
import com.bit.motrip.domain.Qna;
import com.bit.motrip.service.qna.QnaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
@RequestMapping("/qna/*")
public class QnaController {

    ///Field
    @Autowired
    @Qualifier("qnaServiceImpl")
    private QnaService qnaService;

    ///Constructor
    public QnaController(){

        System.out.println("::"+getClass()+".setQnaService Call.........");
    }

    ///Method
    @RequestMapping("getQnaList")
    public String getQnaList(@RequestParam(defaultValue = "1") int currentPage, Model model) throws Exception {

        System.out.println("::");
        System.out.println("[QnaController] 질의응답 목록 조회 서비스를 실행합니다.");

        System.out.println("::");
        System.out.println("[QnaController] 현재 페이지: " + currentPage);

        Search search = new Search();

        // 현재 페이지
        search.setCurrentPage(currentPage);

        // 페이지당 게시물 수
        int pageSize = 10;
        search.setPageSize(pageSize);

        // 리스트 데이터 및 전체 게시물 수
        Map<String, Object> qnaListData = qnaService.getQnaList(search);

        // 전체 게시물 수
        int totalCount = (int) qnaListData.get("totalCount");

        // 부트스트랩 페이지네이션
        int pageUnit = 5; // 한 번에 표시할 페이지 수
        Page page = new Page(currentPage, totalCount, pageUnit, pageSize);

        // 총 페이지 수 계산
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);

        System.out.println("[QnaController] 질의응답 목록 정보를 listQna.jsp로 전달합니다. " + qnaListData);

        model.addAttribute("qnaListData", qnaListData);
        model.addAttribute("page", page);
        model.addAttribute("totalPages", totalPages);

        return "qna/listQna.jsp";
    }

    @RequestMapping("getQna")
    public String getQna(@RequestParam("qnaNo") int qnaNo, Model model) throws Exception {

        Qna qna = new Qna();

        System.out.println("::");
        System.out.println("[QnaController] 질의응답 상세 조회 서비스를 실행합니다.");

        System.out.println("::");
        System.out.println("[QnaController] 조회수 증가 서비스를 실행합니다.");

        qna.setQnaNo(qnaNo);
        qnaService.increaseViews(qna);



        Qna qnaGetData = qnaService.getQna(qnaNo);

        System.out.println("::");
        System.out.println("[QnaController] 질의응답 상세 정보를 getQna.jsp 으로 전달합니다.");

        model.addAttribute("qnaGetData", qnaGetData);

        return "qna/getQna.jsp";
    }

    @RequestMapping("addQnaView")
    public String addQnaView(String aaa) throws Exception {

        System.out.println("::");
        System.out.println("[QnaController] 질의응답 등록 화면 출력 서비스를 실행합니다.");

        return "qna/addQna.jsp";
    }

    @RequestMapping("addQna")
    public String addQna(@ModelAttribute("qna") Qna qna ) throws Exception {

        System.out.println("::");
        System.out.println("[QnaController] 질의응답 등록 서비스를 실행합니다.");

        qnaService.addQna(qna);

        return "redirect:getQnaList";
    }

    @RequestMapping("updateQnaView")
    public String updateQnaView(@RequestParam("qnaNo") String qnaNo,
                                   @RequestParam("qnaTitle") String qnaTitle,
                                   @RequestParam("isQnaImportant") int isQnaImportant,
                                   @RequestParam("qnaContents") String qnaContents, Model model) throws Exception {

        System.out.println("::");
        System.out.println("[QnaController] 질의응답 수정 화면 출력 서비스를 실행합니다.");

        model.addAttribute("qnaNo", qnaNo);
        model.addAttribute("qnaTitle", qnaTitle);
        model.addAttribute("isQnaImportant", isQnaImportant);
        model.addAttribute("qnaContents", qnaContents);

        return "/qna/addQna.jsp";
    }

    @RequestMapping("updateQna")
    public String updateQna(@ModelAttribute("qna") Qna qna,
                               @RequestParam("qnaNo") String qnaNo) throws Exception {

        System.out.println("::");
        System.out.println("[QnaController] 질의응답 수정 서비스를 실행합니다.");

        qnaService.updateQna(qna);

        return "redirect:getQna?qnaNo=" + qnaNo;
    }

    @RequestMapping("deleteQna")
    public String deleteQna(@RequestParam("qnaNo") int qnaNo) throws Exception {

        System.out.println("::");
        System.out.println("[QnaController] 질의응답 삭제 서비스를 실행합니다.");

        qnaService.deleteQna(qnaNo);

        return "redirect:getQnaList";
    }
}
