package com.bit.motrip.service.ReportAndSanction;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.ReportAndSanction;
import com.bit.motrip.domain.User;
import org.springframework.stereotype.Service;

import java.util.Map;


public interface ReportAndSanctionService {

    // 신고추가
    public void addReport(ReportAndSanction reportAndSanction) throws Exception;

}
