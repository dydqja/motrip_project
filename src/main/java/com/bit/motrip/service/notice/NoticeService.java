package com.bit.motrip.service.notice;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.Notice;

import java.util.Map;

public interface NoticeService {

    //공지 등록 서비스
    public void addNotice(Notice notice) throws Exception;

    //공지 상세 조회 서비스
    public Notice getNotice(int noticeNo) throws Exception;

    //공지 목록 조회 서비스
    public Map<String , Object> getNoticeList(Search search) throws Exception;

    //공지 수정 서비스
    public void updateNotice(Notice notice) throws Exception;

    //공지 삭제 서비스
    public void deleteNotice(Notice notice) throws Exception;
}