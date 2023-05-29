package com.bit.motrip.common;

import com.bit.motrip.domain.Memo;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;

import java.io.File;
import java.util.List;

@Component
public class ImageSaver {
    //constructor
    public ImageSaver() throws IOException {
    }
    @Autowired
    public ImageSaver(ResourceLoader resourceLoader) {
        this.resourceLoader = resourceLoader;
    }


    ///field
    public static String path1 = "/static/images/";
    public static String path2 = "C:\\mainproject\\motrip_main_project\\static\\images\\mountpoint\\";
    private ResourceLoader resourceLoader;
    //getter & setter

    //method
    public void imageSave(byte[] imageFile, String filePath, String fileName) throws IOException {
        //저장경로 설정해주는곳
        String prefix = filePath;
        File targetFile = new File(prefix + fileName);
        FileCopyUtils.copy(imageFile, targetFile);
    }

    public void saveImage(byte[] imageBytes, String filename) throws IOException {
        //동적인 경로를 만들어낸다.
        Resource resource = resourceLoader.getResource("classpath:static/images/mountpoint/" + filename);
        File file = resource.getFile();
        FileCopyUtils.copy(imageBytes, file);
    }
    public Memo imageSave(Memo memo) throws Exception{
        String htmlContents = memo.getMemoContents();
        List<String> imageStrings = new ArrayList<>();
        //파싱해서 이미지를 저장하는 부분
        Document doc = Jsoup.parse(htmlContents);
        //이미지 부분을 다른 글귀로 변경하는 부분

        //변경된 메모를 리턴하는 부분
        return memo;
    }

}
