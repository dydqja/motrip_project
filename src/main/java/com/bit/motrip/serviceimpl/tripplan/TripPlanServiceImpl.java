package com.bit.motrip.serviceimpl.tripplan;

import com.bit.motrip.common.Search;
import com.bit.motrip.dao.tripplan.DailyPlanDao;
import com.bit.motrip.dao.tripplan.PlaceDao;
import com.bit.motrip.dao.tripplan.TripPlanDao;
import com.bit.motrip.domain.DailyPlan;
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

    private TripPlan tripPlan;
    private List<DailyPlan> dailyPlan;
    private List<Place> place;
    private Search search;

    @Value("${tripPlanPageSize}")
    private int tripPlanPageSize;

    @Override // 공유된 여행플랜 목록
    public List<TripPlan> selectPublicTripPlanList(Search search) throws Exception {
        search.setPageSize(tripPlanPageSize);
        search.setCurrentPage(search.getCurrentPage()); // 추후 스타트값 설정하였을때 변경 mapper.xml도 같이
        return tripPlanDao.selectPublicTripPlanList(search);
    }

    @Override // 나의 여행플랜 목록
    public List<TripPlan> selectMyTripPlanList(Map parameterMap) throws Exception {
        parameterMap.put("tripPlanAuthor", "user2"); // 여기 세션 들어갈거임
        parameterMap.put("currentPage", search.getCurrentPage()); // 추후 스타트값 설정하였을때 변경 변경 mapper.xml도 같이
        parameterMap.put("pageSize", search.getPageSize());
        return tripPlanDao.selectMyTripPlanList(parameterMap);
    }

    @Override // 여행플랜 저장
    public void addTripPlan(TripPlan tripPlan) throws Exception {
        tripPlanDao.addTripPlan(tripPlan);
        dailyPlan = tripPlan.getDailyplanResultMap();
        for(int i=0; i<dailyPlan.size(); i++) {
            dailyPlanDao.addDailyPlan(dailyPlan.get(i));
            place = dailyPlan.get(i).getPlaceResultMap();
            for(int j=0; j<place.size(); j++){
                placeDao.addPlace(place.get(j));
            }
        }
    }

    @Override
    public int getTripPlan() throws Exception {
        return tripPlanDao.getTripPlan();
    }

    @Override // 선택한 여행플랜에 대한 정보 가져오기
    public TripPlan selectTripPlan(int tripPlanNo) throws Exception {
        return tripPlanDao.selectTripPlan(tripPlanNo);
    }

    @Override // 여행플랜 수정
    public TripPlan updateTripPlan(TripPlan tripPlan) throws Exception{
        this.tripPlan = tripPlanDao.selectTripPlan(tripPlan.getTripPlanNo());
        if(!this.tripPlan.isTripCompleted()){
            tripPlanDao.updateTripPlan(tripPlan);
            dailyPlan = tripPlan.getDailyplanResultMap();
            for(int i=0; i<dailyPlan.size(); i++){
                dailyPlanDao.updateDailyPlan(dailyPlan.get(i));
                place = dailyPlan.get(i).getPlaceResultMap();
                for(int j=0; j<place.size(); j++){
                    placeDao.updatePlace(place.get(j));
                }
            }
            this. tripPlan = tripPlanDao.selectTripPlan(tripPlan.getTripPlanNo());
        } else {
            System.out.println("여행이 완료된 플랜은 더이상 수정할수없습니다.");
        }
        return this.tripPlan;
    }

    @Override // 여행플랜 완전삭제
    public void deleteTripPlan(int tripPlanNo) throws Exception {
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
        tripPlanDao.tripPlanDeleted(tripPlan.getTripPlanNo(), true);
    }

    @Override // 여행플랜 추천수 증가
    public void tripPlanLikes(TripPlan tripPlan) throws Exception {
        tripPlanDao.tripPlanLikes(tripPlan);
    }
}
