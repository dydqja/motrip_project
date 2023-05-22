package com.bit.motrip.service.chatroom;

import com.bit.motrip.domain.Photos;

import java.util.List;

public interface PhotosService {
    //GET
    public Photos getPhotos(int photoNo) throws Exception;

    //INSERT
    public void addPhotos(Photos photos) throws Exception;
    //DELETE
    public void deletePhotos(int photoNo) throws Exception;
    //LIST
    public List<Photos> listPhotos(int chatRoomNo) throws Exception;
}

