package com.bit.motrip.dao.chatroom;

import com.bit.motrip.domain.Photos;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PhotosDao {
    public Photos getPhotos(int photoNo) throws Exception;//SELECT
    public void addPhotos(Photos photos) throws Exception;//INSERT
    public void deletePhotos(int photoNo) throws Exception;//DELETE
    public List listPhotos(int chatRoomNo) throws Exception;//LIST

}
