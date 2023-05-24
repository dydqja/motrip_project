package com.bit.motrip.serviceimpl.tripplan;

import com.bit.motrip.dao.tripplan.PlaceDao;
import com.bit.motrip.domain.Place;
import com.bit.motrip.service.tripplan.PlaceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("placeServiceImpl")
public class PlaceServiceImpl implements PlaceService {

    @Autowired
    @Qualifier("placeDao")
    private PlaceDao placeDao;

    @Override
    public List<Place> selectPlace(int dailyPlanNo) throws Exception {
        return placeDao.selectPlace(dailyPlanNo);
    }

    @Override
    public void addPlace(Place place) throws Exception {
        placeDao.addPlace(place);
    }

    @Override
    public void updatePlace(Place place) throws Exception {
        placeDao.updatePlace(place);
    }

    @Override
    public void deletePlace(int placeNo) throws Exception {
        placeDao.deletePlace(placeNo);
    }

}
