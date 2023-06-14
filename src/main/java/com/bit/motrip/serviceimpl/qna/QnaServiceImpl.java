package com.bit.motrip.serviceimpl.qna;

import com.bit.motrip.common.Search;
import com.bit.motrip.dao.qna.QnaDao;
import com.bit.motrip.domain.Qna;
import com.bit.motrip.domain.User;
import com.bit.motrip.service.alarm.AlarmService;
import com.bit.motrip.service.qna.QnaService;
import com.bit.motrip.service.user.UserService;
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
    @Autowired
    @Qualifier("alarmServiceImpl")
    private final AlarmService alarmService;
    @Autowired
    @Qualifier("userServiceImpl")
    private final UserService userService;

    ///Constructor
    public QnaServiceImpl(AlarmService alarmService, UserService userService){
        this.alarmService = alarmService;
        this.userService = userService;

        System.out.println("::"+getClass()+".setQnaDao Call.........");
    }

    ///Method

    //질의응답 목록 조회 서비스
    public Map<String , Object > getQnaList(Search search) throws Exception {

        List<Qna> list= qnaDao.getQnaList(search);

        int qnaTotalCount = qnaDao.getQnaTotalCount(search);

        Map<String, Object> map = new HashMap<String, Object>();

        map.put("list", list );
        map.put("totalCount", new Integer(qnaTotalCount));

        return map;
    }

    //질의응답 상세 조회 서비스
    @Override
    public Qna getQna(int qnaNo) throws Exception {

        return qnaDao.getQna(qnaNo);
    }

    //조회수 증가 서비스
    @Override
    public void increaseViews(int qnaNo) throws Exception {

        qnaDao.increaseViews(qnaNo);
    };

    //질의응답 질의 등록 서비스
    @Override
    public void addQna(Qna qna) throws Exception {

        qnaDao.addQna(qna);
/*
        System.out.println("질의응답의 내용을 확인합니다.");
        System.out.println("qnaNo : " + qna.getQnaNo());
        System.out.println("qnaTitle : " + qna.getQnaTitle());
        System.out.println("qnaAuthor : " + qna.getQnaAuthor());
        System.out.println("qnaCategory : " + qna.getQnaCategory());*/

        String realCategory = "";
        if(qna.getQnaCategory() == 0){
            realCategory = "계정문의";
        } else if (qna.getQnaCategory() == 1) {
            realCategory = "기타문의";
        } else if (qna.getQnaCategory() == 2) {
            realCategory = "여행플랜문의";
        } else if (qna.getQnaCategory() == 3) {
            realCategory = "채팅문의";
        } else if (qna.getQnaCategory() == 4) {
            realCategory = "메모문의";
        }else {
            realCategory = "후기문의";
        }


        //알림 등록
        //어드민 리스트를 가져온다(미구현)
        User receiver = userService.getUserById("admin");
        User sender = userService.getUserById(qna.getQnaAuthor());
        String alarmTitle = sender.getNickname() + "님의 "+realCategory+" :"+qna.getQnaTitle();
        String alarmContents = sender.getUserName() + "님이 "+realCategory+","+qna.getQnaTitle()+" 을 등록하셨습니다. 지금 확인해주세요";
        String alarmNaviUrl = "/qna/getQna?qnaNo="+qna.getQnaNo();

        alarmService.addNavigateAlarm(sender,receiver, alarmTitle, alarmContents, alarmNaviUrl);
    }

    //질의응답 응답 등록 서비스
    @Override
    public void addQnaAnswer(Qna qna) throws Exception {

        qnaDao.addQnaAnswer(qna);

        Qna gettingQna = qnaDao.getQna(qna.getQnaNo());
        //내용 확인
/*        System.out.println("질의응답의 내용을 확인합니다.");
        System.out.println("qnaNo : " + gettingQna.getQnaNo());
        System.out.println("qnaTitle : " + gettingQna.getQnaTitle());
        System.out.println("qnaAuthor : " + gettingQna.getQnaAuthor());
        System.out.println("qnaCategory : " + gettingQna.getQnaCategory());*/

        String realCategory = "";
        if(gettingQna.getQnaCategory() == 0){
            realCategory = "계정문의";
        } else if (gettingQna.getQnaCategory() == 1) {
            realCategory = "기타문의";
        } else if (gettingQna.getQnaCategory() == 2) {
            realCategory = "여행플랜문의";
        } else if (gettingQna.getQnaCategory() == 3) {
            realCategory = "채팅문의";
        } else if (gettingQna.getQnaCategory() == 4) {
            realCategory = "메모문의";
        }else {
            realCategory = "후기문의";
        }




        int qnaNo = gettingQna.getQnaNo();
        User receiver = userService.getUserById(gettingQna.getQnaAuthor());
        User fakeSender = new User();
        fakeSender.setUserId("admin");

        String alarmTitle = "문의하신 내용 "+gettingQna.getQnaTitle()+" 에 답변이 있습니다.";
        String alarmContents = receiver.getNickname()+" 님, "+realCategory+" 사항, "+gettingQna.getQnaTitle()+" 에 답변이 등록되었습니다. 지금 확인해주세요";
        String alarmNaviUrl = "/qna/getQna?qnaNo="+qna.getQnaNo();
        alarmService.addNavigateAlarm(fakeSender,receiver, alarmTitle, alarmContents, alarmNaviUrl);
    }

    //질의응답 응답 등록 서비스
    @Override
    public void updateQna(Qna qna) throws Exception {

        qnaDao.updateQna(qna);
    }

    //질의응답 삭제 서비스
    @Override
    public void deleteQna(int qnaNo) throws Exception{

        qnaDao.deleteQna(qnaNo);
    }
}
