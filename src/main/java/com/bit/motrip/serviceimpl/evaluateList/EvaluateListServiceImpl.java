package com.bit.motrip.serviceimpl.evaluateList;

import com.bit.motrip.common.Search;
import com.bit.motrip.dao.evaluateList.EvaluateListDao;
import com.bit.motrip.dao.user.UserDao;
import com.bit.motrip.domain.EvaluateList;
import com.bit.motrip.domain.User;
import com.bit.motrip.service.evaluateList.EvaluateListService;
import com.bit.motrip.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("evaluateListServiceImpl")
public class EvaluateListServiceImpl implements EvaluateListService {

    ///Field
    @Autowired
    private EvaluateListDao evaluateListDao;
    public void setEvaluateListDao(EvaluateListDao evaluateListDao) {
        this.evaluateListDao = evaluateListDao;
    }

    ///Constructor
    public EvaluateListServiceImpl() {
        System.out.println(this.getClass());
    }

    ///Method
    public void addEvaluation(EvaluateList evaluateList) throws Exception {
        evaluateListDao.addEvaluation(evaluateList);
    }

    public List<EvaluateList> getEvaluation(Map evaluaterId) throws Exception {
        return evaluateListDao.getEvaluation(evaluaterId);

    }

    public void deleteBlacklist(EvaluateList evaluateList) throws Exception {
        evaluateListDao.deleteBlacklist(evaluateList);
    }

    public void userEvaluateCancle(String sessionUserId, String getUserId) throws Exception {
        evaluateListDao.userEvaluateCancle(sessionUserId,getUserId);
    }

    public String evaluateState(String sessionUserId,String getUserId) throws Exception {
        return evaluateListDao.evaluateState(sessionUserId,getUserId);
    }

    public String getScorePlus(String getUserId) throws Exception {
        return evaluateListDao.getScorePlus(getUserId);
    }

    public String blacklistState(String sessionUserId,String getUserId) throws Exception {
        return evaluateListDao.blacklistState(sessionUserId,getUserId);
    }

    public List<String> getBlacklistAll(Map evaluaterId) throws Exception {

        List<EvaluateList> myIdEvaluaterId = evaluateListDao.getEvaluation(evaluaterId);

        List<String> getBlacklistedList = new ArrayList<>();
        for (EvaluateList evaluateList1 : myIdEvaluaterId) {
            if (evaluateList1.getBlacklistedUserId() != null) {
                getBlacklistedList.add(evaluateList1.getBlacklistedUserId());
            }
        }
        System.out.println("내가 블랙 등록한 사람들은 :: " +getBlacklistedList);

        List<EvaluateList> myIdEvaluatedId = evaluateListDao.getEvaluaterId(evaluaterId);

        List<String> getBlacklisterList = new ArrayList<>();
        for (EvaluateList evaluateList2 : myIdEvaluatedId) {
            if (evaluateList2.getEvaluaterId() != null) {
                getBlacklisterList.add(evaluateList2.getEvaluaterId());
            }
        }
        System.out.println(("나를 블랙 등록한 사람들은 :: " +getBlacklisterList));

        List<String> getBlacklistAll = new ArrayList<>();
        getBlacklistAll.addAll(getBlacklistedList);
        getBlacklistAll.addAll(getBlacklisterList);


        return getBlacklistAll;

    }

}
