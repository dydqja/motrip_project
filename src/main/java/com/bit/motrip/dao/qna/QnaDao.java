package com.bit.motrip.dao.qna;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.Qna;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface QnaDao {

    //질의응답 질의 등록 서비스
    public void addQna(Qna qna) throws Exception;

    //질의응답 응답 등록 서비스
    public void addQnaAnswer(Qna qna) throws Exception;

    //질의응답 상세 조회 서비스
    public Qna getQna(int qnaNo) throws Exception;

    //질의응답 상세 조회 시 조회수 증가 서비스
    public void increaseViews(Qna qna) throws Exception;

    //질의응답 목록 조회 서비스
    public List<Qna> getQnaList(Search search) throws Exception;

    //질의응답 총 게시물 조회 서비스
    public int getQnaTotalCount(Search search) throws Exception ;

    //질의응답 수정 서비스
    public void updateQna(Qna qna) throws Exception;

    //질의응답 삭제 서비스
    public void deleteQna(int qnaNo) throws Exception;
}
