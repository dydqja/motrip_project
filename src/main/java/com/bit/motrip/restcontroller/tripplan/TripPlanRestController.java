package com.bit.motrip.restcontroller.tripplan;

import com.bit.motrip.domain.TripPlan;
import com.bit.motrip.domain.User;
import com.bit.motrip.service.tripplan.TripPlanService;
import com.bit.motrip.service.user.UserService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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

    @GetMapping("tripPlanCompleted") /// 여행플랜 완료
    public TripPlan tripPlanCompleted(@RequestParam("tripPlanNo") int tripPlanNo) throws Exception {
        System.out.println("GET : tripPlanCompleted()");
        tripPlanService.tripPlanCompleted(tripPlanNo);
        return tripPlanService.selectTripPlan(tripPlanNo);
    }

    @GetMapping("tripPlanDrop") /// 여행플랜 완전 삭제
    public void tripPlanDrop (@RequestParam("tripPlanNo") int tripPlanNo) throws Exception {
        System.out.println("GET : tripPlanDrop()");
        tripPlanService.deleteTripPlan(tripPlanNo);
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

    @PostMapping("indexTripPlanLikes")
    public List<TripPlan> indexTripPlanLikes() throws Exception {
        return tripPlanService.indexTripPlanLikes();
    }

    @PostMapping(value = "fileUpload")
    public ResponseEntity<?> fileUpload(@RequestParam("file") MultipartFile file) throws Exception {
        System.out.println("/tripPlan/fileUpload : POST");

        System.out.println("client에서 넘어온 file 값은 => : " + file);
        String fileName = tripPlanService.fileUpload(file);

        System.out.println("ServiceImpl에서 리턴한 fileName => : " + fileName);

        return ResponseEntity.ok().body("/imagePath/" + fileName);
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
        JSONObject route = routes.getJSONObject(0);
        JSONObject summary = route.getJSONObject("summary");
        JSONArray sections = route.getJSONArray("sections");

        List<Map<String, Double>> polylineCoordinates = new ArrayList<>();

        for (int i = 0; i < sections.length(); i++) {
            JSONObject section = sections.getJSONObject(i);
            JSONArray guides = section.getJSONArray("guides");

            for (int j = 0; j < guides.length(); j++) {
                JSONObject guide = guides.getJSONObject(j);
                double lat = guide.getDouble("y");
                double lng = guide.getDouble("x");

                Map<String, Double> coordinate = new HashMap<>();
                coordinate.put("lat", lat);
                coordinate.put("lng", lng);
                polylineCoordinates.add(coordinate);
            }
        }

        int duration = summary.getInt("duration");
        int distance = summary.getInt("distance");

        double distanceKm = (double) distance / 1000;
        String distanceStr = String.format("%.2f", distanceKm);

        int hour = duration / 3600;
        int minute = (duration % 3600) / 60;

        Map<String, Object> responseBody = new HashMap<>();
        responseBody.put("distance", distanceStr + "km");
        responseBody.put("duration", duration);
        responseBody.put("hour", hour);
        responseBody.put("minute", minute);
        responseBody.put("polylineCoordinates", polylineCoordinates);

        System.out.println(responseBody);

        return responseBody;
    }

}