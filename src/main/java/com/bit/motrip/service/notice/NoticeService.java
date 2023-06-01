package com.bit.motrip.service.notice;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.Notice;

import java.util.Map;

public interface NoticeService {

    //공지사항 목록 조회 서비스
    public Map<String , Object> getNoticeList(Search search) throws Exception;

    //공지사항 상세 조회 서비스
    public Notice getNotice(int noticeNo) throws Exception;

    //조회수 증가 서비스
    public void increaseViews(int noticeNo) throws Exception;

    //공지사항 등록 서비스
    public void addNotice(Notice notice) throws Exception;

    //공지사항 수정 서비스
    public void updateNotice(Notice notice) throws Exception;

    //공지사항 삭제 서비스
    public void deleteNotice(int noticeNo) throws Exception;
}