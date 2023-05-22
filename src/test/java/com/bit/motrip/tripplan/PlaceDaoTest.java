package com.bit.motrip.tripplan;

import com.bit.motrip.domain.Place;
import com.bit.motrip.service.tripplan.PlaceService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
class PlaceDaoTest {

    @Autowired
    @Qualifier("placeServiceImpl")
    private PlaceService placeService;

    //@Test // 명소 리스트 확인
    public void selectPlace() throws Exception{
        List<Place> place = placeService.selectPlace(17);
        for(Place placeList : place){
            System.out.println("명소 번호 : " + placeList.getPlaceNo());
            System.out.println("명소 태그 : " + placeList.getPlaceTags());
            System.out.println("명소 좌표 : " + placeList.getPlaceCoordinates());
            System.out.println("명소 이미지 : " + placeList.getPlaceImage());
            System.out.println("명소 전화번호 : " + placeList.getPlacePhoneNumber());
            System.out.println("명소 카테고리 : " + placeList.getPlaceCategory());
            System.out.println("명소 이동시간 : " + placeList.getTripTime());
        }
    }

    //@Test // 명소 추가
    public void addPlace() throws Exception{
        Place place = new Place();
        place.setDailyPlanNo(1);
        place.setPlaceTags("#테스트");
        place.setPlaceCoordinates("33.242452,127.0124124");
        place.setPlaceImage("abcdef.jpg");
        place.setPlacePhoneNumber("010-1111-1111");
        place.setPlaceAddress("방학역 1번출구");
        place.setPlaceCategory(0);
        place.setTripTime(null);

        placeService.addPlace(place);
    }

    //@Test // 명소 업데이트(일차별 여행플랜번호로 가져온 명소 목록중 하나를 선택하여 내용 변경후 확인)
    public void updatePlace() throws Exception{
        List<Place> place1 = placeService.selectPlace(21);
        Place getPlace1 = place1.get(0);
        System.out.println(getPlace1.toString());
        getPlace1.setPlaceTags("제주도");
        getPlace1.setPlaceCategory(2);

        placeService.updatePlace(getPlace1);

        List<Place> place2 = placeService.selectPlace(21);
        Place getPlace2 = place2.get(0);
        System.out.println(getPlace2.toString());
    }

    //@Test // 명소 삭제
    public void deletePlace() throws Exception{
        placeService.deletePlace(69);
    }

}