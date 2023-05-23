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

    public List<EvaluateList> getEvaluation(String evaluaterId) throws Exception {
        return evaluateListDao.getEvaluation(evaluaterId);
    }

    //아래에 여행플랜 & 리뷰 겟 필요할시 입력 ############################################
}
