package com.bit.motrip.serviceimpl.qna;

import com.bit.motrip.common.Search;
import com.bit.motrip.dao.qna.QnaDao;
import com.bit.motrip.domain.Qna;
import com.bit.motrip.service.qna.QnaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("qnaServiceImpl")
public class QnaServiceImpl implements QnaService {

    ///Field
    @Autowired
    @Qualifier("qnaDao")
    private QnaDao qnaDao;

    ///Constructor
    public QnaServiceImpl(){

        System.out.println("::"+getClass()+".setQnaDao Call.........");
    }

    ///Method

    //질의응답 질의 등록 서비스
    @Override
    public void addQna(Qna qna) throws Exception {
        qnaDao.addQna(qna);
    }

    //질의응답 응답 등록 서비스
    @Override
    public void addQnaAnswer(Qna qna) throws Exception {
        qnaDao.addQnaAnswer(qna);
    }

    //질의응답 상세 조회 서비스
    @Override
    public Qna getQna(int qnaNo) throws Exception {
        return qnaDao.getQna(qnaNo);
    }

    //질의응답 목록 조회 서비스
    public Map<String , Object > getQnaList(Search search) throws Exception {
        List<Qna> list= qnaDao.getQnaList(search);
        int qnaTotalCount = qnaDao.getQnaTotalCount(search);

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("list", list );
        map.put("totalCount", new Integer(qnaTotalCount));

        return map;
    }

    //질의응답 수정 서비스
    @Override
    public void updateQna(Qna qna) throws Exception {
        qnaDao.updateQna(qna);
    }

    //질의응답 삭제 서비스
    @Override
    public void deleteQna(Qna qna) throws Exception{
        qnaDao.deleteQna(qna);
    }
}
