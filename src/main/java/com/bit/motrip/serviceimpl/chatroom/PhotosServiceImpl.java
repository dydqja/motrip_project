package com.bit.motrip.serviceimpl.chatroom;

import com.bit.motrip.dao.chatroom.PhotosDao;
import com.bit.motrip.domain.Photos;
import com.bit.motrip.service.chatroom.PhotosService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("photosServiceImpl")
public class PhotosServiceImpl implements PhotosService {
    @Autowired
    @Qualifier("photosDao")
    PhotosDao photosdao;
    @Override
    public Photos getPhotos(int photoNo) throws Exception {
        System.out.println("getPhotos");
        return  photosdao.getPhotos(photoNo);
    }
    @Override
    public void addPhotos(Photos photos) throws Exception{
        System.out.println("addPhotos");
        photosdao.addPhotos(photos);
    }
    @Override
    public void deletePhotos(int photoNo) throws Exception{
        System.out.println("deletePhotos");
        photosdao.deletePhotos(photoNo);
    }

    @Override
    public List<Photos> listPhotos(int chatRoomNo) throws Exception {
        System.out.println("listPhotos");
        List<Photos> photosList = photosdao.listPhotos(chatRoomNo);
        return photosList;
    }
    //list 추가할 것
}
