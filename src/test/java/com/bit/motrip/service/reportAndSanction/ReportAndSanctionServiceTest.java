package com.bit.motrip.service.reportAndSanction;

import com.bit.motrip.common.Page;
import com.bit.motrip.common.Search;
import com.bit.motrip.domain.ReportAndSanction;
import com.bit.motrip.service.ReportAndSanction.ReportAndSanctionService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.sql.Timestamp;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@SpringBootTest
class ReportAndSanctionServiceTest {

    @Autowired
    private ReportAndSanctionService reportAndSanctionService;

   // @Test
    void addReport() throws Exception {

        ReportAndSanction reportAndSanction = new ReportAndSanction();

//        List<String> list = Arrays.asList("욕설 및 비하", "도배", "부적절한 내용");
//        Gson gson = new Gson();
//        String jsonArray = gson.toJson(list);

        List<String> list = Arrays.asList("욕설 및 비하", "도배", "부적절한 내용");
        ObjectMapper objectMapper = new ObjectMapper();
        String json = null;
        try{
            json = objectMapper.writeValueAsString(list);
            System.out.println(json);
        }catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        if(json != null) {

            reportAndSanction.setReporterId("testUser11");
            reportAndSanction.setReportedUserId("testUser21");
            reportAndSanction.setReportReason(json);
            reportAndSanction.setReportContents("욕설과 부적절한 내용을 도배했습니다.");
            reportAndSanction.setReportReviewNo(1);

            reportAndSanctionService.addReport(reportAndSanction);
        }
    }

//    @Test
    void getList() throws Exception {
        Search search = new Search();
        Page page = new Page();
        int pageSize = 3;
        int pageUnit = 5;

        if(search.getCurrentPage() ==0 ){
            search.setCurrentPage(1);
        }
        search.setPageSize(pageSize);

        Map<String , Object> map=reportAndSanctionService.getList(search);

        Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
        System.out.println(resultPage);
    }

//    @Test
    void getReport() throws Exception {

        ReportAndSanction reportAndSanction = new ReportAndSanction();

        reportAndSanction.setReportNo(4);

        ReportAndSanction getReport = reportAndSanctionService.getReport(reportAndSanction.getReportNo());

        System.out.println(getReport.toString());

    }

   // @Test
    void updateSanction() throws Exception {

        ReportAndSanction reportAndSanction = new ReportAndSanction();

        reportAndSanction.setReportNo(4);

        ReportAndSanction getReport = reportAndSanctionService.getReport(reportAndSanction.getReportNo());

        Timestamp sanctionDate = new Timestamp(System.currentTimeMillis());

        getReport.setSanctionDetail("경고");
        getReport.setSanctionResult(1);
        getReport.setSanctionDate(sanctionDate);

        System.out.println(getReport.toString());

        reportAndSanctionService.updateSanction(getReport);

    }



}