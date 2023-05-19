package com.bit.motrip.dao.chatroom;

import com.bit.motrip.domain.Photos;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PhotosDao {
    public void addPhotos(Photos photos) throws Exception;

}
