package com.bit.motrip.dao.evaluateList;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.EvaluateList;
import com.bit.motrip.domain.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface EvaluateListDao {

    //insert
    public void addEvaluation(EvaluateList evaluateList) throws Exception;

    //select
    public List<EvaluateList> getEvaluation(Map evaluaterId) throws Exception;

    //delete
    public void deleteBlacklist(EvaluateList evaluateList) throws Exception;

    //delete
    public void userEvaluateCancle(String sessionUserId,String getUserId) throws Exception;

    //select
    public String evaluateState(String sessionUserId,String getUserId) throws Exception;

    //select
    public String getScorePlus(String getUserId) throws Exception;

    public String blacklistState(String sessionUserId,String getUserId) throws Exception;

}
