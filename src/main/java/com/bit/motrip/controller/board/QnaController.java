package com.bit.motrip.controller.board;

import com.bit.motrip.common.Page;
import com.bit.motrip.common.Search;
import com.bit.motrip.domain.Qna;
import com.bit.motrip.service.qna.QnaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
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
    @RequestMapping("qnaList")
    public String getQnaList(@ModelAttribute("search") Search search, Model model) throws Exception {

        System.out.println("::");
        System.out.println("[QnaController] 질의응답 목록 조회 서비스를 실행합니다.");

        // 현재 위치의 페이지 번호
        if(search.getCurrentPage() == 0){

            search.setCurrentPage(1);
        }

        // 한 페이지 당 출력되는 게시물 수
        int pageSize = 10;
        search.setPageSize(pageSize);

        // 리스트 데이터 및 전체 게시물 수
        Map<String, Object> qnaListData = qnaService.getQnaList(search);

        // 위에서 전체 게시물 수 만 가져오기
        int totalCount = (int) qnaListData.get("totalCount");

        // 화면 하단에 표시할 페이지 수
        int pageUnit = 3;

        // 총 페이지 수, 페이지 시작 번호, 페이지 끝 번호 연산
        Page page = new Page(search.getCurrentPage(), totalCount, pageUnit, pageSize);

        // 총 페이지 수
        int maxPage = page.getMaxPage();

        // 페이지 시작 번호
        int beginUnitPage = page.getBeginUnitPage();

        // 페이지 끝 번호
        int endUnitPage = page.getEndUnitPage();

        model.addAttribute("qnaListData", qnaListData);
        model.addAttribute("page", page);
        model.addAttribute("maxPage", maxPage);
        model.addAttribute("beginUnitPage", beginUnitPage);
        model.addAttribute("endUnitPage", endUnitPage);
        model.addAttribute("search",search);

        return "qna/qnaList.jsp";
    }

    @RequestMapping("getQna")
    public String getQna(@RequestParam("qnaNo") int qnaNo, Model model, HttpSession session) throws Exception {

        System.out.println("::");
        System.out.println("[QnaController] 질의응답 상세 조회 서비스를 실행합니다.");

        Qna qnaGetData = qnaService.getQna(qnaNo);

        // 질의응답 조회 세션 체크
        String sessionKey = "viewedQna_" + qnaNo;

        if (session.getAttribute(sessionKey) == null) {

            System.out.println("::");
            System.out.println("[QnaController] 조회수 증가 서비스를 실행합니다.");

            qnaService.increaseViews(qnaNo);

            session.setAttribute(sessionKey, true);
        }

        model.addAttribute("qnaGetData", qnaGetData);

        return "qna/getQna.jsp";
    }

    @RequestMapping("addQnaView")
    public String addQnaView() throws Exception {

        System.out.println("::");
        System.out.println("[QnaController] 질의응답 등록 화면 출력 서비스를 실행합니다.");

        return "qna/addQna.jsp";
    }

    @RequestMapping("addQna")
    public String addQna(@ModelAttribute("qna") Qna qna ) throws Exception {

        System.out.println("::");
        System.out.println("[QnaController] 질의응답 등록 서비스를 실행합니다.");

        qnaService.addQna(qna);

        return "redirect:qnaList";
    }

    @RequestMapping("addQnaAnswer")
    public String addQnaAnswer(@ModelAttribute("qna") Qna qna ) throws Exception {

        System.out.println("::");
        System.out.println("[QnaController] 질의응답 응답 등록 서비스를 실행합니다.");

        qnaService.addQnaAnswer(qna);

        return "redirect:qnaList";
    }

    @RequestMapping("updateQnaView")
    public String updateQnaView(@RequestParam("qnaNo") int qnaNo,
                                   @RequestParam("qnaTitle") String qnaTitle,
                                   @RequestParam("qnaCategory") int qnaCategory,
                                   @RequestParam("qnaContents") String qnaContents, Model model) throws Exception {

        System.out.println("::");
        System.out.println("[QnaController] 질의응답 수정 화면 출력 서비스를 실행합니다.");

        model.addAttribute("qnaNo", qnaNo);
        model.addAttribute("qnaTitle", qnaTitle);
        model.addAttribute("qnaCategory", qnaCategory);
        model.addAttribute("qnaContents", qnaContents);

        return "qna/addQna.jsp";
    }

    @RequestMapping("updateQna")
    public String updateNotice(@ModelAttribute("qna") Qna qna,
                               @RequestParam("qnaNo") int qnaNo) throws Exception {

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

        return "redirect:qnaList";
    }
}
