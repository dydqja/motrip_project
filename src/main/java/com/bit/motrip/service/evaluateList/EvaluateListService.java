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

    // blacklist get
    public List<EvaluateList> getEvaluation(String evaluaterId) throws Exception;

    //아래에 여행플랜 & 리뷰 get 필요할시 입력 ############################################

}
