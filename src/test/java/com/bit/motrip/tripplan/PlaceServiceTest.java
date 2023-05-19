package com.bit.motrip.tripplan;

import com.bit.motrip.domain.Place;
import com.bit.motrip.service.tripplan.PlaceService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class PlaceServiceTest {

    @Autowired
    @Qualifier("placeServiceImpl")
    private PlaceService placeService;

    //@Test // 명소 리스트 확인
    public void getPlaceList() {
        List<Place> place = placeService.getPlaceList(17);
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

    //@Test
    public void getPlaceById() {
    }

    //@Test // 명소 추가 확인
    public void addPlace() {
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

    //@Test
    public void updatePlace() {
    }

    //@Test
    public void deletePlace() {
    }
}