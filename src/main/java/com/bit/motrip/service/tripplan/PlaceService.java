package com.bit.motrip.service.tripplan;

import com.bit.motrip.domain.Place;

import java.util.List;

public interface PlaceService {
    List<Place> getAllPlaces();
    Place getPlaceById(int placeNo);
    void addPlace(Place place);
    void updatePlace(Place place);
    void deletePlace(int placeNo);

}
