package com.bit.motrip.evaluateList;

import com.bit.motrip.common.Page;
import com.bit.motrip.common.Search;
import com.bit.motrip.dao.user.UserDao;
import com.bit.motrip.domain.EvaluateList;
import com.bit.motrip.domain.User;
import com.bit.motrip.service.evaluateList.EvaluateListService;
import com.bit.motrip.service.user.UserService;
import com.bit.motrip.serviceimpl.evaluateList.EvaluateListServiceImpl;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static java.lang.Boolean.FALSE;
import static java.lang.Boolean.TRUE;

@SpringBootTest
class EvaluateListServiceImplTest {

    @Autowired
    private EvaluateListService evaluateListService;

//    @Test
    void addEvaluation() throws Exception {

        EvaluateList evaluateList = new EvaluateList();

        evaluateList.setEvaluaterId("testUser41");
        evaluateList.setEvaluatedUserId("testUser21");
        evaluateList.setIsScorePlus(-1);

        evaluateListService.addEvaluation(evaluateList);
    }

//    @Test
    void getEvaluation() throws Exception {
        EvaluateList evaluateList = new EvaluateList();

        evaluateList.setEvaluaterId("testUser41");

        //evaluaterId 값에 해당하는 모든 칼럼정보 가져온다.
        List<EvaluateList> getEvaluateList = evaluateListService.getEvaluation(evaluateList.getEvaluaterId());

        System.out.println(getEvaluateList);

        //모든 칼럼정보에서 원하는 값(blacklistUserId / evaluatedReviewNo / 등)만 가져온다
        List<String> blacklistUserId = new ArrayList<>();
        for (EvaluateList evaluateList1 : getEvaluateList) {
            if (evaluateList1.getBlacklistedUserId() != null) {
                blacklistUserId.add(evaluateList1.getBlacklistedUserId());
            }
        }
        System.out.println(blacklistUserId);
    }
//    @Test
    void deleteBlacklist() throws Exception {
        EvaluateList evaluateList = new EvaluateList();

        evaluateList.setEvaluaterId("testUser41");
        evaluateList.setBlacklistedUserId("testUser31");

        evaluateListService.deleteBlacklist(evaluateList);
    }

//    @Test
    void userEvaluateCancle() throws Exception {
        EvaluateList evaluateList = new EvaluateList();

        evaluateList.setEvaluaterId("testUser41");
        evaluateList.setEvaluatedUserId("testUser21");

        evaluateListService.userEvaluateCancle(evaluateList);

    }


}