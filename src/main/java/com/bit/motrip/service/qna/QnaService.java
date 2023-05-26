package com.bit.motrip.service.qna;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.Notice;
import com.bit.motrip.domain.Qna;

import java.util.Map;

public interface QnaService {

    //질의응답 질의 등록 서비스
    public void addQna(Qna qna) throws Exception;

    //조회수 증가 서비스
    public void increaseViews(Qna qna) throws Exception;

    //질의응답 응답 등록 서비스
    public void addQnaAnswer(Qna qna) throws Exception;

    //질의응답 상세 조회 서비스
    public Qna getQna(int qnaNo) throws Exception;

    //공지 목록 조회 서비스
    public Map<String , Object> getQnaList(Search search) throws Exception;

    //공지 수정 서비스
    public void updateQna(Qna qna) throws Exception;

    //공지 삭제 서비스
    public void deleteQna(int qnaNo) throws Exception;
}