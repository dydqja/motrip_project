package com.bit.motrip.service.evaluateList;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.EvaluateList;
import com.bit.motrip.domain.User;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public interface EvaluateListService {

    // insert
    public void addEvaluation(EvaluateList evaluateList) throws Exception;

    // 누가 평가 하는지
//    public EvaluateList getEvaluation(String evaluaterId) throws Exception;

}
