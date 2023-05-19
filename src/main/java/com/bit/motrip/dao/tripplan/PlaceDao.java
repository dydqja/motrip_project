package com.bit.motrip.dao.tripplan;

import com.bit.motrip.domain.Place;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PlaceDao {
    public List<Place> getPlaceList(int dailyPlanNo);
    public void addPlace(Place place);
    void updatePlace(Place place);
    void deletePlace(int placeNo);
}
