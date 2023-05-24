package com.bit.motrip.dao.reportAndSanction;

import com.bit.motrip.domain.ReportAndSanction;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReportAndSanctionDao {

    //insert
    public void addReport(ReportAndSanction reportAndSanction) throws Exception;

}
