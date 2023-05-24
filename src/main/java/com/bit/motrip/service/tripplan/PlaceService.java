package com.bit.motrip.service.tripplan;

import com.bit.motrip.domain.Place;

import java.util.List;

public interface PlaceService {
    public List<Place> selectPlace(int dailyPlanNo) throws Exception;
    public void addPlace(Place place) throws Exception;
    public void updatePlace(Place place) throws Exception;
    public void deletePlace(int placeNo) throws Exception;
}
