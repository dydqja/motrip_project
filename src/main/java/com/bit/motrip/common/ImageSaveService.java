package com.bit.motrip.common;
import org.apache.commons.codec.binary.Base64;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Tag;
import org.springframework.beans.factory.annotation.Value;


import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import java.io.File;
import java.util.Date;
import java.util.List;

public class ImageSaveService {
    //constructor

    public ImageSaveService() {
    }

    public ImageSaveService(String resourcePath) {
        this.resourcePath = resourcePath;

    }

    @Value("${filePath}")
    String hardPath;

    String resourcePath;

    public String saveImage(String html,String userId,String subSystemName) throws IOException {

        Document doc = Jsoup.parse(html);
        //이미지 태그를 모두 리스트에 담는다.
        List<String> imgSrcs = new ArrayList<>();
        doc.select("img").forEach(element -> {
            imgSrcs.add(element.attr("src"));
        });
        //이미지 이름을 모두 리스트에 담아서 새로운 이름으로 개명해준다.
        List<String> filenames = new ArrayList<>();
        doc.select("img").forEach(element -> {
            String filename = element.attr("data-filename");
            String newFilename = generateFilename(userId,subSystemName,filename);
            System.out.println("newFilename은" + newFilename);
            filenames.add(newFilename);
        });

        //이미지를 실제로 저장한다.
        for (int i = 0; i < imgSrcs.size(); i++) {

            String fileName = filenames.get(i);
            String base64String = extractBase64String(imgSrcs.get(i));

            System.out.println("이미지 이름은" + fileName);
            System.out.println("이미지 base64는" + base64String);

            try {
                saveBase64Image(base64String, hardPath,fileName);//TODO 이미지파일명 줘야함
                System.out.println("이미지가 성공적으로 저장되었습니다.");
            } catch (IOException e) {
                System.out.println("이미지 저장 중에 오류가 발생하였습니다: " + e.getMessage());
            }
            // 이미지 src 태그를 교체
            Element imgElement = doc.select("img").get(i);
            Element newImgElement = new Element(Tag.valueOf("img"), doc.baseUri());
            newImgElement.attr("src", "/imagePath/" + fileName);
            imgElement.replaceWith(newImgElement);

        }
        return doc.html();
    }

    public String extractExtension(String srcString) {
        int startIndex = srcString.indexOf("image/") + "image/".length();
        int endIndex = srcString.indexOf(";", startIndex);

        if (startIndex >= 0 && endIndex >= 0) {
            String extension = srcString.substring(startIndex, endIndex);
            return extension;
        }
        System.out.println("확장자를 찾을 수 없습니다.");
        return null;
    }

    public String extractBase64String(String base64Image) {
        int startIndex = base64Image.indexOf("base64,") + "base64,".length();

        if (startIndex >= 0) {
            String base64String = base64Image.substring(startIndex);
            return base64String;
        }
        System.out.println("이미지를 찾을 수 없습니다.");

        return null;
    }

    public void saveBase64Image(String base64String, String resourcePath,String fileName) throws IOException {
        byte[] decodedBytes = Base64.decodeBase64(base64String);

        File outputFile = new File(resourcePath, fileName);
        try (FileOutputStream fos = new FileOutputStream(outputFile)) {
            fos.write(decodedBytes);
        }
    }

    public String generateFilename(String userId, String subSystemName, String originalFilename) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd_HHmmss");
        String timestamp = dateFormat.format(new Date());

        // 파일 이름에 타임스탬프, subSystemName, userId를 조합
        int dotIndex = originalFilename.lastIndexOf(".");
        String filenameWithoutExtension = originalFilename.substring(0, dotIndex);
        String extension = originalFilename.substring(dotIndex);
        String newFilename = timestamp + "_" + subSystemName + "_" + userId + "_" + filenameWithoutExtension + extension;

        return newFilename;
    }








}
