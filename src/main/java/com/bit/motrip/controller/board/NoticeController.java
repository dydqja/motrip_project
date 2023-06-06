package com.bit.motrip.controller.board;

import com.bit.motrip.common.Page;
import com.bit.motrip.common.Search;
import com.bit.motrip.domain.Notice;
import com.bit.motrip.service.notice.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
@RequestMapping("/notice/*")
public class NoticeController {

    ///Field
    @Autowired
    @Qualifier("noticeServiceImpl")
    private NoticeService noticeService;

    ///Constructor
    public NoticeController(){

        System.out.println("::"+getClass()+".setNoticeService Call.........");
    }

    ///Method
    @RequestMapping("noticeList")
    public String getNoticeList(@RequestParam(defaultValue = "1") int currentPage, HttpServletRequest request, Model model) throws Exception {

        System.out.println("::");
        System.out.println("[NoticeController] 공지사항 목록 조회 서비스를 실행합니다.");

        Search search = new Search();

        // 현재 위치의 페이지 번호
        search.setCurrentPage(currentPage);

        // 한 페이지 당 출력되는 게시물 수
        int pageSize = 10;
        search.setPageSize(pageSize);

        // 리스트 데이터 및 전체 게시물 수
        Map<String, Object> noticeListData = noticeService.getNoticeList(search);

        // 위에서 전체 게시물 수 만 가져오기
        int totalCount = (int) noticeListData.get("totalCount");

        // 화면 하단에 표시할 페이지 수
        int pageUnit = 3;

        // maxPage, beginUnitPage, endUnitPage 연산
        Page page = new Page(currentPage, totalCount, pageUnit, pageSize);

        // 총 페이지 수
        int maxPage = page.getMaxPage();

        // 화면 하단에 표시할 페이지의 시작 번호
        int beginUnitPage = page.getBeginUnitPage();

        // 화면 하단에 표시할 페이지의 끝 번호
        int endUnitPage = page.getEndUnitPage();

        java.util.Date currentDate = new java.util.Date();

        System.out.println("testetestestestset" + currentDate);

        request.setAttribute("currentDate", currentDate);
        model.addAttribute("noticeListData", noticeListData);
        model.addAttribute("page", page);
        model.addAttribute("maxPage", maxPage);
        model.addAttribute("beginUnitPage", beginUnitPage);
        model.addAttribute("endUnitPage", endUnitPage);

        return "notice/noticeList.jsp";
    }

    @RequestMapping("getNotice")
    public String getNotice(@RequestParam("noticeNo") int noticeNo, Model model, HttpSession session) throws Exception {

        System.out.println("::");
        System.out.println("[NoticeController] 공지사항 상세 조회 서비스를 실행합니다.");

        Notice noticeGetData = noticeService.getNotice(noticeNo);

        // 공지사항 조회 세션 체크
        String sessionKey = "viewedNotice_" + noticeNo;

        if (session.getAttribute(sessionKey) == null) {

            System.out.println("::");
            System.out.println("[NoticeController] 조회수 증가 서비스를 실행합니다.");

            noticeService.increaseViews(noticeNo);

            session.setAttribute(sessionKey, true);
        }

        model.addAttribute("noticeGetData", noticeGetData);

        return "notice/getNotice.jsp";
    }

    @RequestMapping("addNoticeView")
    public String addNoticeView() throws Exception {

        System.out.println("::");
        System.out.println("[NoticeController] 공지사항 등록 화면 출력 서비스를 실행합니다.");

        return "notice/addNotice.jsp";
    }

    @RequestMapping("addNotice")
    public String addNotice(@ModelAttribute("notice") Notice notice ) throws Exception {

        System.out.println("::");
        System.out.println("[NoticeController] 공지사항 등록 서비스를 실행합니다.");

        noticeService.addNotice(notice);

        return "redirect:noticeList";
    }

    @RequestMapping("updateNoticeView")
    public String updateNoticeView(@RequestParam("noticeNo") int noticeNo,
                                   @RequestParam("noticeTitle") String noticeTitle,
                                   @RequestParam("noticeContents") String noticeContents, Model model) throws Exception {

        System.out.println("::");
        System.out.println("[NoticeController] 공지사항 수정 화면 출력 서비스를 실행합니다.");

        model.addAttribute("noticeNo", noticeNo);
        model.addAttribute("noticeTitle", noticeTitle);
        model.addAttribute("noticeContents", noticeContents);

        return "notice/addNotice.jsp";
    }

    @RequestMapping("updateNotice")
    public String updateNotice(@ModelAttribute("notice") Notice notice,
                               @RequestParam("noticeNo") int noticeNo) throws Exception {

        System.out.println("::");
        System.out.println("[NoticeController] 공지사항 수정 서비스를 실행합니다.");

        noticeService.updateNotice(notice);

        return "redirect:getNotice?noticeNo=" + noticeNo;
    }

    @RequestMapping("deleteNotice")
    public String deleteNotice(@RequestParam("noticeNo") int noticeNo) throws Exception {

        System.out.println("::");
        System.out.println("[NoticeController] 공지사항 삭제 서비스를 실행합니다.");

        noticeService.deleteNotice(noticeNo);

        return "redirect:noticeList";
    }
}
