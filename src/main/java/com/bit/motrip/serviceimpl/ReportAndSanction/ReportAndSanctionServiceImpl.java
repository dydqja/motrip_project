package com.bit.motrip.serviceimpl.ReportAndSanction;

import com.bit.motrip.common.Search;
import com.bit.motrip.dao.reportAndSanction.ReportAndSanctionDao;
import com.bit.motrip.domain.ReportAndSanction;
import com.bit.motrip.domain.User;
import com.bit.motrip.service.ReportAndSanction.ReportAndSanctionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("ReportAndSanctionServiceImpl")
public class ReportAndSanctionServiceImpl implements ReportAndSanctionService {

    ///Field
    @Autowired
    private ReportAndSanctionDao reportAndSanctionDao;
    public void setReportAndSanctionDao(ReportAndSanctionDao reportAndSanctionDao) {
        this.reportAndSanctionDao = reportAndSanctionDao;
    }

    ///Constructor
    public ReportAndSanctionServiceImpl() {
        System.out.println(this.getClass());
    }

    ///Method
    public void addReport(ReportAndSanction reportAndSanction) throws Exception {
        reportAndSanctionDao.addReport(reportAndSanction);
    }

    public Map<String , Object > getList(Search search) throws Exception {
        List<ReportAndSanction> list= reportAndSanctionDao.getList(search);
        int totalCount = reportAndSanctionDao.getTotalCount(search);

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("list", list );
        map.put("totalCount", new Integer(totalCount));

        return map;
    }

    public ReportAndSanction getReport(int reportNo) throws Exception {
        return reportAndSanctionDao.getReport(reportNo);

    }

    public void updateSanction(ReportAndSanction getReport) throws Exception {
        reportAndSanctionDao.updateSanction(getReport);

    }

}
