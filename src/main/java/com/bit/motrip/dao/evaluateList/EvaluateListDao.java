package com.bit.motrip.dao.evaluateList;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.EvaluateList;
import com.bit.motrip.domain.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface EvaluateListDao {

    //update
    public void addEvaluation(EvaluateList evaluateList) throws Exception;

    public List<EvaluateList> getEvaluation(String evaluaterId) throws Exception;

}
