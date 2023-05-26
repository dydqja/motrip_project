package com.bit.motrip.qna;

import com.bit.motrip.common.Search;
import com.bit.motrip.dao.qna.QnaDao;
import com.bit.motrip.domain.Notice;
import com.bit.motrip.domain.Qna;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@SpringBootTest
class QnaDaoTest {

    @Autowired
    private QnaDao qnaDao;
    
    //질의응답 질의 등록 테스트
    //@Test
    void addQnaDaoTest() throws Exception {

        // Arrange
        Qna qna = new Qna();

        qna.setQnaAuthor("user1");
        qna.setQnaTitle("질의응답 테스트");
        qna.setQnaContents("질의응답 테스트 입니다");
        qna.setQnaCategory(6);

        // Act
        qnaDao.addQna(qna);
    }

    //질의응답 응답 등록 테스트
    @Test
    void addQnaAnswerDaoTest() throws Exception {

        // Arrange
        Qna qna = new Qna();
        qna.setQnaNo(3);

        Qna getQna1 = qnaDao.getQna(qna.getQnaNo());

        getQna1.setQnaAnswerContents("질의응답 응답 등록  테스트입니다");

        // Act
        qnaDao.addQnaAnswer(getQna1);

        Qna getQna2 = qnaDao.getQna(qna.getQnaNo());
        System.out.println(getQna2.toString());
    }

    //질의응답 상세 조회 테스트
    //@Test
    void getQnaDaoTest() throws Exception {

        // Arrange
        Qna qna = new Qna();
        qna.setQnaNo(8);

        // Increase views
        qnaDao.increaseViews(qna);

        // Act
        Qna getQna = qnaDao.getQna(qna.getQnaNo());
        System.out.println(getQna.toString());
    }

    //질의응답 목록 조회 테스트
    //@Test
    void getQnaListDaoTest() throws Exception {

        // Arrange
        Search search = new Search();
        search.setPageSize(10);
        search.setCurrentPage(1);

        List<Qna> list = qnaDao.getQnaList(search);
        int qnaTotalCount = qnaDao.getQnaTotalCount(search);

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("list",list);
        map.put("totalCount", new Integer(qnaTotalCount));

        System.out.println(map);
    }

    //질의응답 수정 테스트
    //@Test
    void updateQnaDaoTest() throws Exception {

        // Arrange
        Qna qna = new Qna();
        qna.setQnaNo(4);

        Qna getQna1 = qnaDao.getQna(qna.getQnaNo());

        getQna1.setQnaTitle("질의응답 수정 테스트3");
        getQna1.setQnaContents("질의응답 수정 테스트입니다3");
        getQna1.setQnaCategory(3);

        // Act
        qnaDao.updateQna(getQna1);

        Qna getQna2 = qnaDao.getQna(qna.getQnaNo());
        System.out.println(getQna2.toString());
    }

    //질의응답 삭제 테스트
    //@Test
    void deleteQnaDaoTest() throws Exception {

        // Arrange
        Qna qna = new Qna();
        qna.setQnaNo(2);

        // Act
        qnaDao.deleteQna(qna.getQnaNo());

    }
}