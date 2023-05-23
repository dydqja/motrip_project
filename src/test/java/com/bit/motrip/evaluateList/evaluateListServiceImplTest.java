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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static java.lang.Boolean.FALSE;
import static java.lang.Boolean.TRUE;

@SpringBootTest
class EvaluateListServiceImplTest {

    @Autowired
    private EvaluateListService evaluateListService;

    @Test
    void addEvaluation() throws Exception {

        EvaluateList evaluateList = new EvaluateList();

        evaluateList.setEvaluaterId("testUser41");
        evaluateList.setBlacklistedUserId("testUser21");

        evaluateListService.addEvaluation(evaluateList);

    }



}