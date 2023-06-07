package com.bit.motrip.restcontroller.bot;

import org.springframework.boot.configurationprocessor.json.JSONArray;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.*;

@RestController
@RequestMapping("/bot/*")
public class BotRestController {

    // NAVER Cloud SpeechToText
    @CrossOrigin
    @RequestMapping("stt")
    public static StringBuffer speechToText(@RequestPart("audio")MultipartFile audioFile) throws Exception {

        // 최종 결과값 리턴 시 사용할 인스턴스 선언
        StringBuffer response = new StringBuffer();

        // NAVER Cloud API 인증 정보 불러오기
        FileInputStream fis = new FileInputStream("src/main/resources/properties/application-secret.properties");

        Properties config = new Properties();
        config.load(fis);

        String apiUrl = config.getProperty("api.stt.url");
        String clientId = config.getProperty("api.stt.client.id");
        String clientSecret = config.getProperty("api.stt.client.secret");

        try {

            HttpURLConnection con = (HttpURLConnection) new URL(apiUrl).openConnection();

            con.setUseCaches(false);
            con.setDoOutput(true);
            con.setDoInput(true);
            con.setConnectTimeout(10000);
            con.setReadTimeout(10000);
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Length", String.valueOf(audioFile));
            con.setRequestProperty("Content-Type", "application/octet-stream");
            con.setRequestProperty("X-NCP-APIGW-API-KEY-ID", clientId);
            con.setRequestProperty("X-NCP-APIGW-API-KEY", clientSecret);

            //Client에서 넘어온 바이너리 음성 데이터 타입 변환
            InputStream inputStream = audioFile.getInputStream();

            // 네이버 API 로 바이너리 음성 파일 전송 준비
            OutputStream outputStream = con.getOutputStream();

            byte[] buffer = new byte[4096];
            int bytesRead = -1;

            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }

            //네이버 API 로 바이너리 음성 파일 전송
            outputStream.flush();
            outputStream.close();
            inputStream.close();
            fis.close();

            BufferedReader br;
            String inputLine;

            int responseCode = con.getResponseCode();

            if(responseCode == 200) {	// 정상 호출

                br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));

            }	else {					// 오류 발생

                System.out.println("error!!!!!!! responseCode= " + responseCode);
                br = new BufferedReader(new InputStreamReader(con.getErrorStream(), "UTF-8"));
            }

            if(br != null) {

                while ((inputLine = br.readLine()) != null) {

                    response.append(inputLine);
                }

                br.close();

                // 음성변환 텍스트 결과 출력
                System.out.println("::");
                System.out.println("::");
                System.out.println("::");
                System.out.println("음성변환: " + response);
            }

        }	catch (Exception e) {

            System.out.println(e);
        }

        return response;
    }

    // NAVER Cloud ChatBot
    @CrossOrigin
    @RequestMapping("chat")
    public String chatBot(@RequestBody String text) throws Exception {

        // 최종 결과값 리턴시 사용할 변수 선언
        String chatbotMessage = "";

        // NAVER Cloud API 인증 정보 불러오기
        FileInputStream fis = new FileInputStream("src/main/resources/properties/application-secret.properties");

        Properties config = new Properties();
        config.load(fis);

        String apiUrl = config.getProperty("api.bot.url");
        String secretKey = config.getProperty("api.bot.client.secret");

        // 사용자 질문 텍스트 Request
        String message = getReqMessage(text);

        System.out.println("::");
        System.out.println("입력질문: " + message);

        String encodeBase64String = makeSignature(message, secretKey);

        try {

            HttpURLConnection con = (HttpURLConnection) new URL(apiUrl).openConnection();

            con.setUseCaches(false);
            con.setDoOutput(true);
            con.setDoInput(true);
            con.setConnectTimeout(10000);
            con.setReadTimeout(10000);
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/json;UTF-8");
            con.setRequestProperty("X-NCP-CHATBOT_SIGNATURE", encodeBase64String);

            OutputStream outputStream = con.getOutputStream();

            outputStream.write(message.getBytes("UTF-8"));
            outputStream.flush();
            outputStream.close();
            fis.close();

            BufferedReader br;
            String decodedString;

            int responseCode = con.getResponseCode();

            if(responseCode == 200) {	// 정상 호출

                br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));

            }	else {					// 오류 발생

                System.out.println("error!!!!!!! responseCode= " + responseCode);
                br = new BufferedReader(new InputStreamReader(con.getErrorStream(), "UTF-8"));
            }

            if(br != null) {

                while ((decodedString = br.readLine()) != null) {

                    chatbotMessage = decodedString;
                }

                br.close();

                // 챗봇 텍스트 결과 출력
                System.out.println("::");
                System.out.println("챗봇응답: " + chatbotMessage);
            }

        }	catch (Exception e) {

            System.out.println(e);
        }

        return chatbotMessage;
    }

    public static String makeSignature(String message, String secretKey) {

        /// 최종 결과값 리턴시 사용할 변수 선언
        String encodeBase64String = "";

        try {
            byte[] secrete_key_bytes = secretKey.getBytes(StandardCharsets.UTF_8);

            SecretKeySpec signingKey  = new SecretKeySpec(secrete_key_bytes, "HmacSHA256");
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(signingKey);

            byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
//          encodeBase64String = Base64.encodeToString(rawHmac, Base64.NO_WRAP);
            encodeBase64String = Base64.getEncoder().encodeToString(rawHmac);

            return encodeBase64String;

        } catch (Exception e){

            System.out.println(e);
        }

        return encodeBase64String;
    }

    public static String getReqMessage(String text) {

        /// 최종 결과값 리턴시 사용할 변수 선언
        String requestBody = "";

        // userId 랜덤 생성
        String userId = UUID.randomUUID().toString();

        try {

            JSONObject obj = new JSONObject();

            long timestamp = new Date().getTime();

            System.out.println("::");
            System.out.println("대화시간: "+timestamp);

            obj.put("version", "v2");
            obj.put("userId", userId);
            obj.put("timestamp", timestamp);

            JSONObject bubbles_obj = new JSONObject();

            bubbles_obj.put("type", "text");

            JSONObject data_obj = new JSONObject();
            data_obj.put("description", text);

            bubbles_obj.put("type", "text");
            bubbles_obj.put("data", data_obj);

            JSONArray bubbles_array = new JSONArray();
            bubbles_array.put(bubbles_obj);

            obj.put("bubbles", bubbles_array);
            //obj.put("event", "send");

            if(Objects.equals(text, "동영상 보여줘")) {

                obj.put("event", "open");

            } else {

                obj.put("event", "send");
            }
            requestBody = obj.toString();

        } catch (Exception e){

            System.out.println("## Exception : " + e);
        }
        return requestBody;
    }

    // NAVER Cloud TextToSpeech
    @CrossOrigin
    @RequestMapping("tts")
    public static ResponseEntity<byte[]> TextToSpeech(@RequestBody String tts) throws Exception {

        // NAVER Cloud API 인증 정보 불러오기
        FileInputStream fis = new FileInputStream("src/main/resources/properties/application-secret.properties");

        Properties config = new Properties();
        config.load(fis);

        String apiUrl = config.getProperty("api.tts.url");
        String clientId = config.getProperty("api.tts.client.id");
        String clientSecret = config.getProperty("api.tts.client.secret");

        // 챗봇 응답 텍스트 Request
        String text = URLEncoder.encode(tts, "UTF-8");
        String postParams = "speaker=ngoeun&volume=0&speed=0&pitch=0&format=mp3&text=" + text;

        try {

            HttpURLConnection con = (HttpURLConnection) new URL(apiUrl).openConnection();

            con.setUseCaches(false);
            con.setDoOutput(true);
            con.setDoInput(true);
            con.setConnectTimeout(10000);
            con.setReadTimeout(10000);
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            con.setRequestProperty("X-NCP-APIGW-API-KEY-ID", clientId);
            con.setRequestProperty("X-NCP-APIGW-API-KEY", clientSecret);

            DataOutputStream wr = new DataOutputStream(con.getOutputStream());

            wr.writeBytes(postParams);
            wr.flush();
            wr.close();

            int responseCode = con.getResponseCode();
            BufferedReader br;
            String date = Long.valueOf(new Date().getTime()).toString();

            if(responseCode==200) { // 정상 호출

                InputStream is = con.getInputStream();

                int read = 0;
                byte[] bytes = new byte[1024];

                ByteArrayOutputStream bos = new ByteArrayOutputStream();

                while ((read =is.read(bytes)) != -1) {

                    bos.write(bytes, 0, read);
                }
                is.close();

                byte[] byteData = bos.toByteArray();

                HttpHeaders headers = new HttpHeaders();

                headers.setContentType(MediaType.parseMediaType("audio/mpeg"));
                headers.setContentLength(byteData.length);
                headers.setContentDispositionFormData("attachment", date + ".mp3");

                ResponseEntity<byte[]> response = new ResponseEntity<byte[]>(byteData, headers, HttpStatus.OK);

                System.out.println("::");
                System.out.println("챗봇음성: " + response);

                return response;

            } else {  // 오류 발생

                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));

                String inputLine;

                StringBuilder response = new StringBuilder();

                while ((inputLine = br.readLine()) != null) {

                    response.append(inputLine);
                }

                br.close();
                System.out.println(response.toString());
            }

        } catch (Exception e) {

            System.out.println(e);
        }
        return null;
    }

    // 페이지 내비게이션 서비스
    @CrossOrigin
    @RequestMapping("navi")
    public ResponseEntity<String[]> pageNavigation(@RequestBody(required = false) String[] text, HttpServletRequest request) throws Exception {

        if (text != null && text.length > 0) {

            // JSON 배열 생성
            String[] responseData = new String[]{text[0]};

            // JSON 배열을 클라이언트에게 반환
            return ResponseEntity.ok().body(responseData);

        } else {

            return ResponseEntity.badRequest().build();
        }
    }
}