package com.bit.motrip.notice;

import com.bit.motrip.common.Search;
import com.bit.motrip.dao.notice.NoticeDao;
import com.bit.motrip.domain.Notice;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@SpringBootTest
class NoticeDaoTest {

    @Autowired
    private NoticeDao noticeDao;

    //공지 등록 테스트
    //@Test
    void addNoticeDaoTest() throws Exception {

        // Arrange
        Notice notice = new Notice();

        notice.setNoticeAuthor("user1");
        notice.setNoticeTitle("공지 테스트");
        notice.setNoticeContents("공지 테스트 입니다");
        notice.setIsNoticeImportant(1);

        // Act
        noticeDao.addNotice(notice);
    }

    //공지 상세 조회 테스트
    //@Test
    void getNoticeDaoTest() throws Exception {

        // Arrange
        Notice notice = new Notice();
        notice.setNoticeNo(5);

        // Increase views
        noticeDao.increaseViews(notice.getNoticeNo());

        // Act
        Notice getNotice = noticeDao.getNotice(notice.getNoticeNo());
        System.out.println(getNotice.toString());
    }

    //공지 목록 조회 테스트
    //@Test
    void getNoticeListDaoTest() throws Exception {

        // Arrange
        Search search = new Search();
        search.setPageSize(10);
        search.setCurrentPage(1);

        List<Notice> list = noticeDao.getNoticeList(search);
        int noticeTotalCount = noticeDao.getNoticeTotalCount(search);

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("list",list);
        map.put("totalCount", new Integer(noticeTotalCount));

        System.out.println(map);
    }

    //공지 수정 테스트
    //@Test
    void updateNoticeDaoTest() throws Exception {

        // Arrange
        Notice notice = new Notice();
        notice.setNoticeNo(5);

        Notice getNotice1 = noticeDao.getNotice(notice.getNoticeNo());

        getNotice1.setNoticeTitle("공지 수정 테스트");
        getNotice1.setNoticeContents("공지 수정 테스트입니다");
        getNotice1.setIsNoticeImportant(1);

        // Act
        noticeDao.updateNotice(getNotice1);

        Notice getNotice2 = noticeDao.getNotice(notice.getNoticeNo());
        System.out.println(getNotice2.toString());
    }

    //공지 삭제 테스트
    //@Test
    void deleteNoticeDaoTest() throws Exception {

        // Arrange
        Notice notice = new Notice();
        notice.setNoticeNo(2);

        // Act
        noticeDao.deleteNotice(notice.getNoticeNo());

    }
}