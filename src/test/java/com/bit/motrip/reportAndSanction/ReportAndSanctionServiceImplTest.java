package com.bit.motrip.reportAndSanction;

import com.bit.motrip.domain.EvaluateList;
import com.bit.motrip.domain.ReportAndSanction;
import com.bit.motrip.service.ReportAndSanction.ReportAndSanctionService;
import com.bit.motrip.service.evaluateList.EvaluateListService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@SpringBootTest
class ReportAndSanctionServiceImplTest {

    @Autowired
    private ReportAndSanctionService reportAndSanctionService;

    @Test
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
            reportAndSanction.setReportChatRoomNo(1);

            reportAndSanctionService.addReport(reportAndSanction);
        }
    }

}