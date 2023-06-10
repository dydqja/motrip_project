package com.bit.motrip.restcontroller.tripplan;

import com.bit.motrip.domain.TripPlan;
import com.bit.motrip.domain.User;
import com.bit.motrip.service.tripplan.TripPlanService;
import com.bit.motrip.service.user.UserService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;


@CrossOrigin
@RestController
@RequestMapping("/tripPlan/*")
public class TripPlanRestController {

    @Autowired
    @Qualifier("tripPlanServiceImpl")
    private TripPlanService tripPlanService;
    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

    public TripPlanRestController() {
        System.out.println(this.getClass());
    }

    @Value("${kakao.api.key}")
    private String kakaoApiKey;

    @PostMapping("addTripPlan") // 여행플랜 저장 (JSON 형태로 받기위해 ajax로 보냄)
    public void addTripPlan(@RequestBody TripPlan tripPlan, HttpSession session) throws Exception {
        System.out.println("POST : addTripPlan()");
        System.out.println(tripPlan.toString());

        User dbUser = (User) session.getAttribute("user");
        tripPlan.setTripPlanAuthor(dbUser.getUserId());

        tripPlanService.addTripPlan(tripPlan);
    }

    @PostMapping("updateTripPlan") // 여행플랜 저장 (JSON 형태로 받기위해 ajax로 보냄)
    public void updateTripPlan(@RequestBody TripPlan tripPlan, HttpSession session) throws Exception {
        System.out.println("POST : updateTripPlan()");

        User dbUser = (User) session.getAttribute("user");
        tripPlan.setTripPlanAuthor(dbUser.getUserId());

        System.out.println(tripPlan.toString());

        tripPlanService.updateTripPlan(tripPlan);
    }

    @GetMapping("tripPlanDeleted") /// 여행플랜 삭제(임시대기)
    public TripPlan tripPlanDeleted(@RequestParam("tripPlanNo") int tripPlanNo) throws Exception {
        System.out.println("GET : deleteTripPlan()");
        tripPlanService.tripPlanDeleted(tripPlanNo);
        return tripPlanService.selectTripPlan(tripPlanNo);
    }

    @GetMapping("tripPlanLikes") // 여행플랜 추천하기
    public int tripPlanLikes(@RequestParam("tripPlanNo") int tripPlanNo, HttpSession session) throws Exception {
        System.out.println("GET : tripPlanLikes()");

        User dbUser = (User) session.getAttribute("user");

        if(dbUser == null){ // 로그인 되어있지 않다면 비회원으로 간주
            return 0;
        } else { // 로그인 되어있다면 중복체크를 하기위해 확인 후 추천수를 올린다.
            Map<String, Object> tripPlanLikes = new HashMap<>();
            tripPlanLikes.put("tripPlanNo", tripPlanNo);
            tripPlanLikes.put("user", dbUser);
            return tripPlanService.tripPlanLikes(tripPlanLikes);
        }
    }

    @PostMapping("tripPlanCount") // 여행플랜 총 개수
    public int tripPlanCount() throws Exception {
        return tripPlanService.tripPlanCount();
    }

    @GetMapping("tripTime")
    public Map<String, Object> tripTime(@RequestParam("start") String start, @RequestParam("end") String end) {
        // 시작지점과 도착지점을 파라미터로 받아와서 REST API 요청에 사용
        System.out.println("시간 구하기 : " + start + "/" + end);

        String apiUrl = "https://apis-navi.kakaomobility.com/v1/directions?origin=+" + start + "+" +
                "&destination=" + end + "&waypoints=&priority=RECOMMEND&" +
                "alternatives=false&road_details=false";
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "KakaoAK " + kakaoApiKey); // 카카오 REST API 인증키 설정
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> responseEntity = restTemplate.exchange(apiUrl,
                HttpMethod.GET,
                new HttpEntity<>(headers),
                String.class);

        JSONObject response = new JSONObject(responseEntity.getBody());
        JSONArray routes = response.getJSONArray("routes");
        JSONObject Jsonobj = routes.getJSONObject(0);
        JSONObject summary = Jsonobj.getJSONObject("summary");
        System.out.println(summary);
        int distance = summary.getInt("distance");
        int duration = summary.getInt("duration");

        // 거리를 km 단위로 변환하고 소수점 둘째 자리까지 출력
        double distanceKm = (double) distance / 1000;
        String distanceStr = String.format("%.2f", distanceKm);

        // 시간을 분으로 변환하여 60분 이상인 경우 시간과 분으로 나누어 출력
        int hour = duration / 3600;
        int minute = (duration % 3600) / 60;

        Map<String, Object> responseBody = new HashMap<>();
        responseBody.put("distance", distanceStr + "km");
        responseBody.put("minute", minute);
        responseBody.put("hour", hour);

        System.out.println(responseBody);

        return responseBody;
    }

}