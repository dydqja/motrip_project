package com.bit.motrip.serviceimpl.notice;

import com.bit.motrip.common.Search;
import com.bit.motrip.dao.notice.NoticeDao;
import com.bit.motrip.domain.Notice;
import com.bit.motrip.service.notice.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("noticeServiceImpl")
public class NoticeServiceImpl implements NoticeService {

    ///Field
    @Autowired
    @Qualifier("noticeDao")
    private NoticeDao noticeDao;

    ///Constructor
    public NoticeServiceImpl(){

        System.out.println("::"+getClass()+".setNoticeDao Call.........");
    }

    ///Method

    //공지 등록 서비스
    @Override
    public void addNotice(Notice notice) throws Exception {
        noticeDao.addNotice(notice);
    }
    
    //조회수 증가 서비스
    @Override
    public void increaseViews(Notice notice) throws Exception {
        noticeDao.increaseViews(notice);
    }

    //공지 상세 조회 서비스
    @Override
    public Notice getNotice(int noticeNo) throws Exception {
        return noticeDao.getNotice(noticeNo);
    }

    //공지 목록 조회 서비스
    public Map<String , Object > getNoticeList(Search search) throws Exception {

        List<Notice> list= noticeDao.getNoticeList(search);

        int totalCount = noticeDao.getNoticeTotalCount(search);

        Map<String, Object> map = new HashMap<String, Object>();

        map.put("list", list );

        map.put("totalCount", new Integer(totalCount));

        return map;
    }

    //공지 수정 서비스
    @Override
    public void updateNotice(Notice notice) throws Exception {
        noticeDao.updateNotice(notice);
    }

    //공지 삭제 서비스
    @Override
    public void deleteNotice(Notice notice) throws Exception{
        noticeDao.deleteNotice(notice);
    }
}
