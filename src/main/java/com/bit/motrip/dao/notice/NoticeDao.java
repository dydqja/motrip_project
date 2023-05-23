package com.bit.motrip.dao.notice;

import com.bit.motrip.common.Page;
import com.bit.motrip.common.Search;
import com.bit.motrip.domain.Notice;
import com.bit.motrip.domain.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface NoticeDao {

    //공지 등록 서비스
    public void addNotice(Notice notice) throws Exception;

    //공지 상세 조회 서비스
    public Notice getNotice(int noticeNo) throws Exception;

    //공지 상세 조회 시 조회수 증가 서비스
    public void increaseViews(Notice notice) throws Exception;

    //공지 목록 조회 서비스
    public List<Notice> getNoticeList(Search search) throws Exception;

    //공지 총 게시물 조회 서비스
    public int getNoticeTotalCount(Search search) throws Exception ;

    //공지 수정 서비스
    public void updateNotice(Notice notice) throws Exception;

    //공지 삭제 서비스
    public void deleteNotice(Notice notice) throws Exception;
}
