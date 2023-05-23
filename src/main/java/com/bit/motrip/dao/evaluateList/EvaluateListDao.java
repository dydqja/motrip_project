package com.bit.motrip.dao.evaluateList;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.EvaluateList;
import com.bit.motrip.domain.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface EvaluateListDao {

    //insert
    public void addEvaluation(EvaluateList evaluateList) throws Exception;

    //select
    public List<EvaluateList> getEvaluation(String evaluaterId) throws Exception;

    //delete
    public void deleteBlacklist(EvaluateList evaluateList) throws Exception;

    //delete
    public void userEvaluateCancle(EvaluateList evaluateList) throws Exception;

}
