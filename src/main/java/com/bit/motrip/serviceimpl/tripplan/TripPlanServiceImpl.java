package com.bit.motrip.serviceimpl.tripplan;

import com.bit.motrip.common.Search;
import com.bit.motrip.dao.evaluateList.EvaluateListDao;
import com.bit.motrip.dao.tripplan.DailyPlanDao;
import com.bit.motrip.dao.tripplan.PlaceDao;
import com.bit.motrip.dao.tripplan.TripPlanDao;
import com.bit.motrip.domain.DailyPlan;
import com.bit.motrip.domain.EvaluateList;
import com.bit.motrip.domain.Place;
import com.bit.motrip.domain.TripPlan;
import com.bit.motrip.service.tripplan.TripPlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

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


    //화면에 보여줄 리스트의 수
    @Value("${tripPlanPageSize}")
    private int tripPlanPageSize;

    @Override // 공유된 여행플랜 목록
    public List<TripPlan> selectTripPlanList(Search search) throws Exception {
        search.setPageSize(tripPlanPageSize);

        Map<String, Object> paramaters = new HashMap<>();
        paramaters.put("tripPlanAuthor", "");
        paramaters.put("search", search);

        return tripPlanDao.selectTripPlanList(paramaters);
    }

    @Override // 여행플랜 저장
    public void addTripPlan(TripPlan tripPlan) throws Exception {
        tripPlanDao.addTripPlan(tripPlan);
        List<DailyPlan> dailyPlan = tripPlan.getDailyplanResultMap();
        for(int i=0; i<dailyPlan.size(); i++) {
            dailyPlanDao.addDailyPlan(dailyPlan.get(i));
            List<Place> place = dailyPlan.get(i).getPlaceResultMap();
            for(int j=0; j<place.size(); j++){
                placeDao.addPlace(place.get(j));
            }
        }
    }

    @Override
    public int getTripPlan() throws Exception {
        return tripPlanDao.getTripPlan();
    }

    @Override // 선택한 여행플랜에 대한 조회수를 올리고 정보 가져오기
    public TripPlan selectTripPlan(int tripPlanNo) throws Exception {
        TripPlan tripPlan = tripPlanDao.selectTripPlan(tripPlanNo);
        tripPlan.setTripPlanViews(tripPlan.getTripPlanViews() + 1);
        tripPlanDao.tripPlanViews(tripPlan);
        return tripPlanDao.selectTripPlan(tripPlanNo);
    }

    @Override // 여행플랜 수정
    public TripPlan updateTripPlan(TripPlan tripPlan) throws Exception{
//        if(!tripPlan.isTripCompleted()){
//            tripPlanDao.updateTripPlan(tripPlan);
//            List<DailyPlan> dailyPlan = tripPlan.getDailyplanResultMap();
//            for(int i=0; i<dailyPlan.size(); i++){
//                dailyPlanDao.updateDailyPlan(dailyPlan.get(i));
//                List<Place> place = dailyPlan.get(i).getPlaceResultMap();
//                for(int j=0; j<place.size(); j++){
//                    placeDao.updatePlace(place.get(j));
//                }
//            }
//            tripPlanDao.selectTripPlan(tripPlan.getTripPlanNo());
//        } else {
//            System.out.println("여행이 완료된 플랜은 더이상 수정할수없습니다.");
//        }
        return tripPlan;
    }

    @Override // 여행플랜 완전삭제
    public void deleteTripPlan(int tripPlanNo) throws Exception {
        TripPlan tripPlan = tripPlanDao.selectTripPlan(tripPlanNo);
        tripPlanDao.deleteTripPlan(tripPlanNo);
    }

    @Override // 여행플랜 공유설정 (공유를 중단하면 가져가기유무도 자동으로 false)
    public void tripPlanPublic(int tripPlanNo) throws Exception {
        TripPlan tripPlan = tripPlanDao.selectTripPlan(tripPlanNo);
        if(tripPlan.isPlanPublic()){
            tripPlanDao.tripPlanPublic(tripPlan.getTripPlanNo(), false);
            tripPlanDao.tripPlanDownloadable(tripPlan.getTripPlanNo(), false);
        } else {
            tripPlanDao.tripPlanPublic(tripPlan.getTripPlanNo(), true);
        }
    }

    @Override // 여행플랜 가져가기 유무설정
    public void tripPlanDownloadable(int tripPlanNo) throws Exception {
        TripPlan tripPlan = tripPlanDao.selectTripPlan(tripPlanNo);
        if(tripPlan.isPlanDownloadable()){
            tripPlanDao.tripPlanDownloadable(tripPlan.getTripPlanNo(), false);
        } else {
            tripPlanDao.tripPlanDownloadable(tripPlan.getTripPlanNo(), true);
        }
    }

    @Override // 여행플랜 삭제유무 설정
    public void tripPlanDeleted(int tripPlanNo) throws Exception {
        TripPlan tripPlan = tripPlanDao.selectTripPlan(tripPlanNo);
        if(tripPlan.isPlanDeleted()){
            tripPlanDao.tripPlanDeleted(tripPlan.getTripPlanNo(), false);
        } else {
            tripPlanDao.tripPlanDeleted(tripPlan.getTripPlanNo(), true);
        }
    }

    @Override // 여행플랜 완료 설정 (완료 이후 권한제외 수정 불가능)
    public void tripPlanCompleted(int tripPlanNo) throws Exception {
        TripPlan tripPlan = tripPlanDao.selectTripPlan(tripPlanNo);
        tripPlanDao.tripPlanDeleted(tripPlan.getTripPlanNo(), true);
    }

    @Override // 여행플랜 추천수 증가
    public void tripPlanLikes(TripPlan tripPlan) throws Exception {
        EvaluateList evaluate = new EvaluateList();
        Map<String,Object> paramaters = new HashMap<>();
        paramaters.put("evaluatedTripPlanNo", tripPlan.getTripPlanNo());
        paramaters.put("searchCondition", "tripPlan");
        List<EvaluateList> tripPlanEvaluateList = evaluateListDao.getEvaluation(paramaters);
        for (int i=0; i<tripPlanEvaluateList.size(); i++){
            if(tripPlanEvaluateList.get(i).getEvaluaterId().equals(tripPlan.getTripPlanAuthor())){
                System.out.println("이미 추천을 누른 여행플랜입니다.");
                return;
            }
        }
        // 중복체크를 확인하여 이상이없다면 추천수를 올린다.
        evaluate.setEvaluaterId(tripPlan.getTripPlanAuthor());
        evaluate.setEvaluatedTripPlanNo(tripPlan.getTripPlanNo());
        evaluateListDao.addEvaluation(evaluate);
        // 추천수를 올리고 다시한번 조회하여 총 추천수를 저장
        tripPlan.setTripPlanLikes(evaluateListDao.getEvaluation(paramaters).size());
        tripPlan.setTripPlanNo(tripPlan.getTripPlanNo());
        tripPlanDao.tripPlanLikes(tripPlan);
    }

}
