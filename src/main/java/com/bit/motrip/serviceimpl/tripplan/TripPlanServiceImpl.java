package com.bit.motrip.serviceimpl.tripplan;

import com.bit.motrip.common.ImageSaveService;
import com.bit.motrip.common.Search;
import com.bit.motrip.dao.evaluateList.EvaluateListDao;
import com.bit.motrip.dao.tripplan.DailyPlanDao;
import com.bit.motrip.dao.tripplan.PlaceDao;
import com.bit.motrip.dao.tripplan.TripPlanDao;
import com.bit.motrip.domain.*;
import com.bit.motrip.service.alarm.AlarmService;
import com.bit.motrip.service.tripplan.TripPlanService;
import com.bit.motrip.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.*;

@Service("tripPlanServiceImpl")
public class TripPlanServiceImpl implements TripPlanService {

    @Autowired
    @Qualifier("tripPlanDao")
    private TripPlanDao tripPlanDao;
    @Autowired
    @Qualifier("dailyPlanDao")
    private DailyPlanDao dailyPlanDao;
    @Autowired
    @Qualifier("placeDao")
    private PlaceDao placeDao;
    @Autowired
    @Qualifier("evaluateListDao")
    private EvaluateListDao evaluateListDao;
    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;
    @Autowired
    @Qualifier("imageSaveService")
    ImageSaveService imageSaveService;
    @Autowired
    @Qualifier("alarmServiceImpl")
    AlarmService alarmService;

    @Value(value = "${filePath}thumbnail")
    private Path fileStorageLocation; // 썸네일 경로

    @Override
    public Map<String , Object > selectTripPlanList(Map<String, Object> parameters) throws Exception {

        if(parameters.get("user") != null) {
            User dbUser = (User) parameters.get("user");
            parameters.put("tripPlanAuthor", dbUser.getUserId());
            System.out.println(dbUser.getUserId());
        } else {
            parameters.put("tripPlanAuthor", null);
        }
        Search search = (Search) parameters.get("search");
        System.out.println("서비스 임플로 들어왔을떄 : " + parameters);

        List<TripPlan> tripPlanList = tripPlanDao.selectTripPlanList(parameters);
        for (TripPlan tp : tripPlanList) {
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy년 MM월 dd일");
            String strDate = simpleDateFormat.format(tp.getTripPlanRegDate());
            tp.setStrDate(strDate);

            tp.setTripPlanNickName(userService.getUserById(tp.getTripPlanAuthor()).getNickname());
        }
        int totalCount = tripPlanDao.selectTripPlanTotalCount(search);
        System.out.println("totalCount : " + totalCount);

        Map<String, Object> map = new HashMap<String, Object>();

        map.put("list", tripPlanList );
        map.put("totalCount", new Integer(totalCount));

        return map;
    }

    @Override // 여행플랜 저장
    public void addTripPlan(TripPlan tripPlan) throws Exception {

        //tripPlan.setTripPlanRegDate(new Date()); // 날짜변경해야함

        tripPlanDao.addTripPlan(tripPlan);
        int tripPlanNo = tripPlanDao.getTripPlan();
        List<DailyPlan> dailyPlan = tripPlan.getDailyplanResultMap();
        for(int i=0; i<dailyPlan.size(); i++) {
            dailyPlan.get(i).setTripPlanNo(tripPlanNo);

            String html = dailyPlan.get(i).getDailyPlanContents();
            String changedHtml = imageSaveService.saveImage(html, tripPlan.getTripPlanAuthor(), "tripPlan");
            dailyPlan.get(i).setDailyPlanContents(changedHtml);

            dailyPlanDao.addDailyPlan(dailyPlan.get(i));
            int dailyPlanNo = dailyPlanDao.getDailyPlan();
            List<Place> place = dailyPlan.get(i).getPlaceResultMap();
            for(int j=0; j<place.size(); j++){
                place.get(j).setDailyPlanNo(dailyPlanNo);
                placeDao.addPlace(place.get(j));
            }
        }
    }

    @Override // 가장 최근에 저장된 플랜번호 확인
    public int getTripPlan() throws Exception {
        return tripPlanDao.getTripPlan();
    }

    @Override // 선택한 여행플랜에 대한 조회수를 올리고 정보 가져오기
    public TripPlan selectTripPlan(int tripPlanNo) throws Exception {
        TripPlan tripPlan = tripPlanDao.selectTripPlan(tripPlanNo);
        tripPlan.setTripPlanViews(tripPlan.getTripPlanViews() + 1);

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy년 MM월 dd일");
        String strDate = simpleDateFormat.format(tripPlan.getTripPlanRegDate());
        tripPlan.setStrDate(strDate);

        tripPlan.setTripPlanNickName(userService.getUserById(tripPlan.getTripPlanAuthor()).getNickname());

//        for(int i=0; i<tripPlan.getDailyplanResultMap().size(); i++){ // 총 이동시간을 스트링으로 바꿔출력하기 위해
//            int total = Integer.parseInt(tripPlan.getDailyplanResultMap().get(i).getTotalTripTime());
//            tripPlan.getDailyplanResultMap().get(i).setTotalTripTime(totaltime(total));
//        }

        tripPlanDao.tripPlanViews(tripPlan);
        return tripPlan;
    }

    @Override // 여행플랜 수정
    public TripPlan updateTripPlan(TripPlan tripPlan) throws Exception{

        if(!tripPlan.getisTripCompleted()){
            //tripPlan.setTripPlanRegDate(new Date());
            tripPlanDao.updateTripPlan(tripPlan);
            List<DailyPlan> dailyPlan = tripPlan.getDailyplanResultMap();
            List<DailyPlan> defaultDailyPlan = dailyPlanDao.selectDailyPlan(tripPlan.getTripPlanNo());

            // 기존 플랜수와 새로운 플랜수 비교하여 같을 경우
            if(defaultDailyPlan.size() == dailyPlan.size()) {
                for(int i=0; i<dailyPlan.size(); i++){

                    dailyPlan.get(i).setDailyPlanNo(dailyPlanDao.selectDailyPlan(tripPlan.getTripPlanNo()).get(i).getDailyPlanNo());
                    dailyPlanDao.updateDailyPlan(dailyPlan.get(i));
                    List<Place> place = dailyPlan.get(i).getPlaceResultMap();
                    List<Place> defaultPlaces = placeDao.selectPlace(dailyPlan.get(i).getDailyPlanNo()); // 업데이트전 place
                    System.out.println(place + "새로운값");
                    System.out.println(defaultPlaces + "기존값 확인");

                    for(int j=0; j<place.size(); j++){
                        if(j < defaultPlaces.size()) {
                            place.get(j).setPlaceNo(defaultPlaces.get(j).getPlaceNo());
                            placeDao.updatePlace(place.get(j));
                            if(j == (place.size()-1)) {
                                int size = defaultPlaces.size() - place.size();
                                if (defaultPlaces.size() > place.size()) {
                                    for (int p = 0; p <size; p++) {
                                        placeDao.deletePlace(defaultPlaces.get(place.size() + p).getPlaceNo());
                                    }
                                }
                            }
                        } else {
                            place.get(j).setDailyPlanNo(dailyPlan.get(i).getDailyPlanNo());
                            placeDao.addPlace(place.get(j));
                        }

                    }
                }
                System.out.println(tripPlanDao.selectTripPlan(tripPlan.getTripPlanNo()));
                tripPlanDao.selectTripPlan(tripPlan.getTripPlanNo());
                System.out.println("기존 플랜일수가 똑같습니다.");
            } else if(defaultDailyPlan.size() < dailyPlan.size()){ // 기존 플랜수 보다 새로운 플랜수가 클경우
                for(int i=defaultDailyPlan.size(); i<dailyPlan.size(); i++) {
                    dailyPlan.get(i).setTripPlanNo(tripPlan.getTripPlanNo());
                    dailyPlanDao.addDailyPlan(dailyPlan.get(i));
                    int dailyPlanNo = dailyPlanDao.getDailyPlan();
                    List<Place> place = dailyPlan.get(i).getPlaceResultMap();
                    for(int j=0; j<place.size(); j++){
                        place.get(j).setDailyPlanNo(dailyPlanNo);
                        placeDao.addPlace(place.get(j));
                    }
                }
                System.out.println("기존 플랜일수보다 많아서 새로 추가했습니다..");
            } else if(defaultDailyPlan.size() > dailyPlan.size()) {
                for(int i=dailyPlan.size(); i<defaultDailyPlan.size(); i++) {
                    List<DailyPlan> delDailyPlan = dailyPlanDao.selectDailyPlan(tripPlan.getTripPlanNo());
                    dailyPlanDao.deleteDailyPlan(delDailyPlan.get(i).getDailyPlanNo());
                }
                System.out.println("기존 플랜일수보다 적어서 삭제했습니다...");
            }

        } else {
            System.out.println("여행이 완료된 플랜은 더이상 수정할수없습니다.");
        }
        return null;
    }

    @Override // 여행플랜 완전삭제
    public void deleteTripPlan(int tripPlanNo) throws Exception {
        TripPlan tripPlan = tripPlanDao.selectTripPlan(tripPlanNo);
        tripPlanDao.deleteTripPlan(tripPlanNo);
    }

    @Override // 여행플랜 공유설정 (공유를 중단하면 가져가기유무도 자동으로 false)
    public void tripPlanPublic(int tripPlanNo) throws Exception {
        TripPlan tripPlan = tripPlanDao.selectTripPlan(tripPlanNo);
        if(tripPlan.getisPlanPublic()){
            tripPlanDao.tripPlanPublic(tripPlan.getTripPlanNo(), false);
            tripPlanDao.tripPlanDownloadable(tripPlan.getTripPlanNo(), false);
        } else {
            tripPlanDao.tripPlanPublic(tripPlan.getTripPlanNo(), true);
        }
    }

    @Override // 여행플랜 가져가기 유무설정
    public void tripPlanDownloadable(int tripPlanNo) throws Exception {
        TripPlan tripPlan = tripPlanDao.selectTripPlan(tripPlanNo);
        if(tripPlan.getisPlanDownloadable()){
            tripPlanDao.tripPlanDownloadable(tripPlan.getTripPlanNo(), false);
        } else {
            tripPlanDao.tripPlanDownloadable(tripPlan.getTripPlanNo(), true);
        }
    }

    @Override // 여행플랜 삭제유무 설정
    public void tripPlanDeleted(int tripPlanNo) throws Exception {
        TripPlan tripPlan = tripPlanDao.selectTripPlan(tripPlanNo);
        if(tripPlan.getisPlanDeleted()){
            tripPlan.setTripPlanDelDate(null);
            tripPlan.setisPlanDeleted(false);
            tripPlanDao.tripPlanDeleted(tripPlan);
        } else {
            tripPlan.setTripPlanDelDate(new Date());
            tripPlan.setisPlanDeleted(true);
            tripPlanDao.tripPlanDeleted(tripPlan);
        }
    }

    @Override // 여행플랜 완료 설정 (완료 이후 권한제외 수정 불가능)
    public void tripPlanCompleted(int tripPlanNo) throws Exception {
        TripPlan tripPlan = tripPlanDao.selectTripPlan(tripPlanNo);
        tripPlanDao.tripPlanCompleted(tripPlan.getTripPlanNo(), true);
    }

    @Override // 여행플랜 추천수 증가
    public int tripPlanLikes(Map<String, Object> tripPlanLikes) throws Exception {

        TripPlan tripPlan = new TripPlan();
        EvaluateList evaluateList = new EvaluateList();
        tripPlanLikes.put("searchCondition", "tripPlan"); // 여행플랜을 기준으로 찾기 위해

        User dbUser = (User) tripPlanLikes.get("user");
        evaluateList.setEvaluaterId(dbUser.getUserId());
        evaluateList.setEvaluatedTripPlanNo((Integer) tripPlanLikes.get("tripPlanNo"));

        List<EvaluateList> tripPlanEvaluateList = evaluateListDao.getEvaluation(tripPlanLikes);
        for (int i=0; i<tripPlanEvaluateList.size(); i++){
            if(tripPlanEvaluateList.get(i).getEvaluaterId().equals(dbUser.getUserId())){
                System.out.println("이미 추천을 누른 여행플랜입니다.");
                return -1;
            }
        }
        // 중복체크를 확인하여 이상이 없다면 새로운 테이블을 생성
        evaluateListDao.addEvaluation(evaluateList);
        // 추천수를 높이고 tripPlanEvaluateList의 숫자가 최근 추천수이기에 + 1을 더해주어 최종 저장
        tripPlan.setTripPlanLikes(tripPlanEvaluateList.size() + 1);
        tripPlan.setTripPlanNo((Integer) tripPlanLikes.get("tripPlanNo"));

        //디버그
        System.out.println("트립플랜 라이크스의 숫자를 찍어본다." + tripPlan.getTripPlanLikes());
        System.out.println("트립플랜 라이크스의 no를 찍어본다." + tripPlan.getTripPlanNo());


        //알람 코드 삽입
            //변수를 잡아둔다.
            int likes = tripPlan.getTripPlanLikes();
            User fakeSender = new User();
            //만약 추천수가 10단위라면
            if(likes % 10 == 0){
                //트립플랜의 본디 정보를 확인한다.
                TripPlan gettingTripPlan = tripPlanDao.selectTripPlan(tripPlan.getTripPlanNo());

                int tripPlanNo = tripPlan.getTripPlanNo();
                String tripPlanTitle = gettingTripPlan.getTripPlanTitle();
                String receiverId = gettingTripPlan.getTripPlanAuthor();
                User receiver = userService.getUserById(receiverId);
                String userNick = receiver.getNickname();

                //알람 내용을 작성한다.
                String alarmTitle = tripPlanTitle+"에"+likes+"회째 추천!";
                String alarmContents = userNick+"회원님의"+tripPlanTitle+"여행플랜이 벌써 " + likes + " 회나 추천되었습니다! 지금 확인해보세요.";
                String alarmNaviUrl = "/tripPlan/selectTripPlan?tripPlanNo="+gettingTripPlan.getTripPlanNo();
                //알람을 보낸다.
                alarmService.addNavigateAlarm(fakeSender,receiver,alarmTitle,alarmContents,alarmNaviUrl);
            }else if (likes == 1){
                //트립플랜의 본디 정보를 확인한다.
                TripPlan gettingTripPlan = tripPlanDao.selectTripPlan(tripPlan.getTripPlanNo());

                int tripPlanNo = tripPlan.getTripPlanNo();
                String tripPlanTitle = gettingTripPlan.getTripPlanTitle();
                String receiverId = gettingTripPlan.getTripPlanAuthor();
                User receiver = userService.getUserById(receiverId);
                String userNick = receiver.getNickname();

                //알람 내용을 작성한다.
                String alarmTitle = tripPlanTitle+"에 첫 추천!";
                String alarmContents = userNick+"회원님의"+tripPlanTitle+"여행플랜이 " + "첫 번째로 추천을 받았습니다! 지금 확인해보세요.";
                String alarmNaviUrl = "/tripPlan/selectTripPlan?tripPlanNo="+gettingTripPlan.getTripPlanNo();
                //알람을 보낸다.
                alarmService.addNavigateAlarm(fakeSender,receiver,alarmTitle,alarmContents,alarmNaviUrl);
            }

        //알람 코드 종료

        tripPlanDao.tripPlanLikes(tripPlan);
        return tripPlan.getTripPlanLikes();
    }

    @Override // 여행플랜 전체수
    public int tripPlanCount() throws Exception {
        return tripPlanDao.tripPlanCount();
    }

    @Override
    public List<TripPlan> indexTripPlanLikes() throws Exception {
        // 아이디랑 태그 가져올수있도록 할것
        return tripPlanDao.indexTripPlanLikes();
    }

    public String fileUpload(MultipartFile file) throws Exception {

        System.out.println("tripPlanfileUpload");
        // 파일이 비어있는지 체크
        if (file.isEmpty()) {
            throw new IllegalArgumentException("파일이 없습니다.");
        }

//        @Value(value = "${filePath}")
//        private Path fileStorageLocation;

        System.out.println("받은 파일의 경로는 => : " + file.getOriginalFilename());

        String fileName = StringUtils.cleanPath(file.getOriginalFilename());
        System.out.println("파일경로에서 파일이름만 뽑은 값은 => : " + fileName);

        String uniqueFileName = UUID.randomUUID().toString() + "_" + fileName;
        System.out.println("파일이름+UUID해서 준 임의파일이름은? => : " + uniqueFileName);

        /*파일이 저장될 기본 경로(this.fileStorageLocation)에 파일이름(uniqueFileName) 을 추가(resolve) 하여,
        새로운 경로 생성(Path targetLocation)*/
        Path targetLocation = this.fileStorageLocation.resolve(uniqueFileName);
        System.out.println("기본경로+파일이름으로 생성된 새로운경로는? => : " + targetLocation);

        System.out.println("업로드파일 데이터스트림 => : "+ file.getInputStream());
        /*업로드된 파일의 데이터 스트림을 가져오고(file.getInputStream()) 이 데이터 스트림을 지정된 경로(targetLocation)로 복사(Files.copy)한다.
        복사한 위치에 동일한 이름의 파일이 있다면 기존 파일을 새 파일로 대체(StandardCopyOption.REPLACE_EXISTING)한다. */
        try (InputStream is = file.getInputStream()) {
            Files.copy(is, targetLocation, StandardCopyOption.REPLACE_EXISTING);
        } catch (Exception e) {
            e.printStackTrace();
            throw new IOException("파일 저장에 실패했습니다. 파일 이름: " + fileName, e);
        }

        return uniqueFileName;
    }


//    public static String totaltime(int totalTripTimes) {
//        int totalHours = (int) Math.floor(totalTripTimes / 60);
//        int totalMinutes = totalTripTimes % 60;
//        String totalTripTime = "";
//        if(totalHours == 0){
//            totalTripTime = totalMinutes + "분";
//        } else {
//            totalTripTime = totalHours + "시간 " + totalMinutes + "분";
//        }
//        return totalTripTime;
//    }

}
