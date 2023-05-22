package com.bit.motrip.chatroom;

import com.bit.motrip.domain.Photos;
import com.bit.motrip.service.chatroom.PhotosService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
public class PhotosTests {
    @Autowired
    @Qualifier("photosServiceImpl")
    private PhotosService photosService;
    //@Test
    public void getTest() throws Exception{
        Photos photos = photosService.getPhotos(1);
        System.out.println(photos);
    }
    //@Test
    public void addTest() throws Exception{
        Photos photos = new Photos();
        photos.setPhotoId("testPhoto");
        photos.setChatRoomNo(1);
        photosService.addPhotos(photos);
    }
    //@Test
    public void deleteTest() throws Exception{
        photosService.deletePhotos(5);
    }
    //@Test
    public void listTest() throws Exception {
        List<Photos> listPhotos = photosService.listPhotos(1);
        for (Photos photo : listPhotos) {
            System.out.println(photo.getPhotoId());
        }
    }
}
