package com.bit.motrip.dao.reportAndSanction;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.ReportAndSanction;
import com.bit.motrip.domain.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ReportAndSanctionDao {

    //insert
    public void addReport(ReportAndSanction reportAndSanction) throws Exception;

    //select list
    public List<ReportAndSanction> getList(Search search) throws Exception;

    public int getTotalCount(Search search) throws Exception ;

    public ReportAndSanction getReport(int reportNo) throws Exception;

    public void updateSanction(ReportAndSanction getReport) throws Exception;

}
