package com.bit.motrip.service.evaluateList;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.EvaluateList;
import com.bit.motrip.domain.User;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public interface EvaluateListService {

    // insert
    public void addEvaluation(EvaluateList evaluateList) throws Exception;

    // select
    public List<EvaluateList> getEvaluation(Map evaluaterId) throws Exception;

    // delete
    public void deleteBlacklist(EvaluateList evaluateList) throws Exception;

    //update
    public void userEvaluateCancle(EvaluateList evaluateList) throws Exception;

}
