package com.bit.motrip.serviceimpl.ReportAndSanction;

import com.bit.motrip.dao.reportAndSanction.ReportAndSanctionDao;
import com.bit.motrip.domain.ReportAndSanction;
import com.bit.motrip.service.ReportAndSanction.ReportAndSanctionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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



}
