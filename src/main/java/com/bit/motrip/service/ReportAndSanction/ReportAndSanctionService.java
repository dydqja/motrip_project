package com.bit.motrip.service.ReportAndSanction;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.ReportAndSanction;
import com.bit.motrip.domain.User;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public interface ReportAndSanctionService {

    // 신고추가
    public void addReport(ReportAndSanction reportAndSanction) throws Exception;

    // 신고 리스트
    public Map<String , Object> getList(Search search) throws Exception;

    public ReportAndSanction getReport(int reportNo) throws Exception;

    public void updateSanction(ReportAndSanction getReport) throws Exception;

}
