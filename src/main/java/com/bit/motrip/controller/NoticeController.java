package com.bit.motrip.controller;

import com.bit.motrip.common.Page;
import com.bit.motrip.common.Search;
import com.bit.motrip.domain.Notice;
import com.bit.motrip.service.notice.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
    @RequestMapping("getNoticeList")
    public String getNoticeList(@RequestParam(defaultValue = "1") int currentPage, Model model) throws Exception {

        System.out.println("::");
        System.out.println("[NoticeController] 공지 목록 조회 서비스를 실행합니다.");

        System.out.println("::");
        System.out.println("[NoticeController] 현재 페이지: " + currentPage);

        Search search = new Search();

        // 현재 페이지
        search.setCurrentPage(currentPage);

        // 페이지당 게시물 수
        int pageSize = 10;
        search.setPageSize(pageSize);

        // 리스트 데이터 및 전체 게시물 수
        Map<String, Object> noticeListData = noticeService.getNoticeList(search);

        // 전체 게시물 수
        int totalCount = (int) noticeListData.get("totalCount");

        // 부트스트랩 페이지네이션
        int pageUnit = 5; // 한 번에 표시할 페이지 수
        Page page = new Page(currentPage, totalCount, pageUnit, pageSize);

        // 총 페이지 수 계산
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);

        System.out.println("[NoticeController] 공지 목록 정보를 listNotice.jsp로 전달합니다. " + noticeListData);

        model.addAttribute("noticeListData", noticeListData);
        model.addAttribute("page", page);
        model.addAttribute("totalPages", totalPages);

        return "notice/listNotice.jsp";
    }

    @RequestMapping("getNotice")
    public String getNotice(@RequestParam("noticeNo") int noticeNo, Model model) throws Exception {

        System.out.println("::");
        System.out.println("[NoticeController] 조회수 증가 서비스를 실행합니다.");

        Notice notice = new Notice();

        notice.setNoticeNo(noticeNo);
        noticeService.increaseViews(notice);

        System.out.println("::");
        System.out.println("[NoticeController] 공지 상세 조회 서비스를 실행합니다.");

        Notice noticeGetData = noticeService.getNotice(noticeNo);

        System.out.println("::");
        System.out.println("[NoticeController] 공지 상세 정보를 getNotice.jsp 으로 전달합니다." + noticeGetData);

        model.addAttribute("noticeGetData", noticeGetData);

        return "notice/getNotice.jsp";
    }

    @RequestMapping("addNoticeView")
    public String addNoticeView() throws Exception {

        System.out.println("::");
        System.out.println("[NoticeController] 공지 등록 화면 출력 서비스를 실행합니다.");

        return "notice/addNotice.jsp";
    }

    @RequestMapping("addNotice")
    public String addNotice(@ModelAttribute("notice") Notice notice ) throws Exception {

        System.out.println("::");
        System.out.println("[NoticeController] 공지 등록 서비스를 실행합니다.");

        noticeService.addNotice(notice);

        return "redirect:getNoticeList";
    }

    @RequestMapping("updateNoticeView")
    public String updateNoticeView(@ModelAttribute("notice") Notice notice) throws Exception {

        System.out.println(notice);

        return "/notice/addNotice.jsp";
    }

//    @RequestMapping("updateNotice")
//    public String updateNotice(@RequestParam("noticeTitle") String noticeTitle, @RequestParam("noticeContents") String noticeContents) throws Exception {
//
//        System.out.println("::");
//        System.out.println("[NoticeController] 공지 수정 서비스를 실행합니다.");
//
//        return "redirect:addNotice";
//    }

}
