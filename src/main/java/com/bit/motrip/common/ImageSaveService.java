package com.bit.motrip.common;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;

import java.util.Date;
import java.util.List;
@Component
public class ImageSaveService {
    //constructor

    public ImageSaveService() {
    }

    @Value("${filePath}")
    String filePath;

    public String saveImage(String html, String userId, String subSystemName) throws IOException {

        Document doc = Jsoup.parse(html);
        Elements imgElements = doc.select("img");
        List<String> base64List = new ArrayList<>();
        List<String> newNameList = new ArrayList<>();

        for (Element imgElement : imgElements) {
            String src = imgElement.attr("src");
            if (src.contains("base64")) {
                //파일의 본래 이름을 갖고온다.
                String originalName = imgElement.attr("data-filename");
                // 새로운 이름 생성
                String newSrc = buildUniqueName(userId, subSystemName, originalName);
                // src 요소 교체
                imgElement.attr("src", newSrc);

                // base64 데이터를 갖고온다.
                String base64Data = src.split(",")[1];
                //리스트에 담는다.
                base64List.add(base64Data);
                newNameList.add(newSrc);

            }
        }
        //이미지를 저장할 부분
        for(int i = 0; i < base64List.size(); i++) {
            String base64Data = base64List.get(i);
            String newName = newNameList.get(i);
            String updatedFilePath = filePath + newName.replace("/imagePath/", "");
            //이미지 저장
            saveBase64Image(base64Data, updatedFilePath);
        }


        // 변환된 doc을 문자열로 반환
        String convertedHtml = doc.toString();
        return convertedHtml;
    }
    public String buildUniqueName(String userId, String subSystemName, String originalName) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String timestamp = sdf.format(new Date());

        String directoryPath = "/imagePath/" + subSystemName + "/" + userId + "/" + timestamp;
        String uniqueName = directoryPath + "/" + originalName;
        return uniqueName;
    }
    public void saveBase64Image(String base64Data, String filePath) {
        try {
            // 디렉토리 생성
            File directory = new File(filePath).getParentFile();
            if (!directory.exists()) {
                directory.mkdirs();
            }

            // Base64 데이터 디코딩
            byte[] imageData = Base64.getDecoder().decode(base64Data);

            // 파일 저장
            FileOutputStream fos = new FileOutputStream(filePath);
            fos.write(imageData);
            fos.close();

            System.out.println("이미지 저장 완료: " + filePath);
        } catch (IOException e) {
            System.out.println("이미지 저장 실패: " + filePath);
            e.printStackTrace();
        }
    }


}
