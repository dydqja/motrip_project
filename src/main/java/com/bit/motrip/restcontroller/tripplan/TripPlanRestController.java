package com.bit.motrip.restcontroller.tripplan;

import com.bit.motrip.domain.TripPlan;
import com.bit.motrip.service.tripplan.TripPlanService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;


@CrossOrigin
@RestController
@RequestMapping("/tripPlan/*")
public class TripPlanRestController {

    @Autowired
    @Qualifier("tripPlanServiceImpl")
    private TripPlanService tripPlanService;

    public TripPlanRestController() {
        System.out.println(this.getClass());
    }

    @Value("${kakao.api.key}")
    private String kakaoApiKey;

    @PostMapping("addTripPlan") // 여행플랜 저장 (JSON 형태로 받기위해 ajax로 보냄)
    public void addTripPlan(@RequestBody TripPlan tripPlan) throws Exception {
        System.out.println("POST : addTripPlan()");
        tripPlanService.addTripPlan(tripPlan);
    }

    @GetMapping("tripPlanDeleted") /// 여행플랜 삭제(임시대기)
    public TripPlan tripPlanDeleted(@RequestParam("tripPlanNo") int tripPlanNo) throws Exception {
        System.out.println("GET : deleteTripPlan()");
        tripPlanService.tripPlanDeleted(tripPlanNo);
        return tripPlanService.selectTripPlan(tripPlanNo);
    }

//    @GetMapping("tripTime")
//    public Map<String, Object> tripTime(@RequestParam String start, @RequestParam String end) {
//        // 시작지점과 도착지점을 파라미터로 받아와서 REST API 요청에 사용
//
//        System.out.println("들어오나요" + start + end);
//
//        String apiUrl = "https://apis-navi.kakaomobility.com/v1/directions?origin=+" + start + "+" +
//                "&destination=" + end + "&waypoints=&priority=RECOMMEND&" +
//                "alternatives=false&road_details=false";
//        HttpHeaders headers = new HttpHeaders();
//        headers.set("Authorization", "KakaoAK " + kakaoApiKey); // 카카오 REST API 인증키 설정
//        RestTemplate restTemplate = new RestTemplate();
//        ResponseEntity<String> responseEntity = restTemplate.exchange(apiUrl,
//                HttpMethod.GET,
//                new HttpEntity<>(headers),
//                String.class);
//
//        JSONObject response = new JSONObject(responseEntity.getBody());
//        JSONArray routes = response.getJSONArray("routes");
//        JSONObject Jsonobj = routes.getJSONObject(0);
//        JSONObject summary = Jsonobj.getJSONObject("summary");
//        System.out.println(summary);
//        int distance = summary.getInt("distance");
//        int duration = summary.getInt("duration");
//
//        // 거리를 km 단위로 변환하고 소수점 둘째 자리까지 출력
//        double distanceKm = (double) distance / 1000;
//        String distanceStr = String.format("%.2f", distanceKm);
//
//        // 시간을 분으로 변환하여 60분 이상인 경우 시간과 분으로 나누어 출력
//        int hour = duration / 3600;
//        int minute = (duration % 3600) / 60;
//        String durationStr = "";
//        if (hour > 0) {
//            durationStr = hour + " 시간 " + minute + " 분";
//        } else {
//            durationStr = minute + "분";
//        }
//
//        Map<String, Object> responseBody = new HashMap<>();
//        responseBody.put("distance", distanceStr + "km");
//        responseBody.put("duration", durationStr);
//
//        System.out.println(responseBody);
//
//        return responseBody;
//    }

}