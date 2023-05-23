package com.bit.motrip.dao.tripplan;

import com.bit.motrip.domain.Place;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PlaceDao {
    public List<Place> selectPlace(int dailyPlanNo) throws Exception;
    public void addPlace(Place place) throws Exception;
    public void updatePlace(Place place) throws Exception;
    public void deletePlace(int placeNo) throws Exception;

}
