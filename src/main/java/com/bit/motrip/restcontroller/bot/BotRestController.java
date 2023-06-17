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
import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.*;

@CrossOrigin
@RestController
@RequestMapping("/bot/*")
public class BotRestController {
    private static Properties config;
    public BotRestController() {
        // Load API configuration properties
        try {
            FileInputStream fis = new FileInputStream("src/main/resources/application.properties");
            config = new Properties();
            config.load(fis);
            fis.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // NAVER Cloud SpeechToText
    @RequestMapping("stt")
    public StringBuffer speechToText(@RequestPart("audio")MultipartFile audioFile) throws Exception {

        // 최종 결과값 리턴 시 사용할 인스턴스 선언
        StringBuffer response = new StringBuffer();

        String apiUrl = config.getProperty("api.stt.url");
        String clientId = config.getProperty("api.stt.client.id");
        String clientSecret = config.getProperty("api.stt.client.secret");

        try {

            HttpsURLConnection con = (HttpsURLConnection) new URL(apiUrl).openConnection();

            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Length", String.valueOf(audioFile.getSize()));
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

            BufferedReader br;
            String inputLine;

            int responseCode = con.getResponseCode();

            if(responseCode == 200) {	// 정상 호출

                br = new BufferedReader(new InputStreamReader(con.getInputStream(), StandardCharsets.UTF_8));

            }	else {					// 오류 발생

                System.out.println("error!!!!!!! responseCode= " + responseCode);
                br = new BufferedReader(new InputStreamReader(con.getErrorStream(), StandardCharsets.UTF_8));
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
    @RequestMapping("chat")
    public String chatBot(@RequestBody String text) throws Exception {

        // 최종 결과값 리턴시 사용할 변수 선언
        String chatbotMessage = "";

        String apiUrl = config.getProperty("api.bot.url");
        String secretKey = config.getProperty("api.bot.client.secret");

        // 사용자 질문 텍스트 Request
        String message = getReqMessage(text);

        System.out.println("::");
        System.out.println("입력질문: " + message);

        String encodeBase64String = makeSignature(message, secretKey);

        try {

            HttpsURLConnection con = (HttpsURLConnection) new URL(apiUrl).openConnection();

            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            con.setRequestProperty("X-NCP-CHATBOT_SIGNATURE", encodeBase64String);

            OutputStream outputStream = con.getOutputStream();

            outputStream.write(message.getBytes(StandardCharsets.UTF_8));
            outputStream.flush();
            outputStream.close();

            BufferedReader br;
            String decodedString;

            int responseCode = con.getResponseCode();

            if(responseCode == 200) {	// 정상 호출

                br = new BufferedReader(new InputStreamReader(con.getInputStream(), StandardCharsets.UTF_8));

            }	else {					// 오류 발생

                System.out.println("error!!!!!!! responseCode= " + responseCode);
                br = new BufferedReader(new InputStreamReader(con.getErrorStream(), StandardCharsets.UTF_8));
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

        try {
            byte[] secrete_key_bytes = secretKey.getBytes(StandardCharsets.UTF_8);

            SecretKeySpec signingKey  = new SecretKeySpec(secrete_key_bytes, "HmacSHA256");
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(signingKey);

            byte[] rawHmac = mac.doFinal(message.getBytes(StandardCharsets.UTF_8));
            return Base64.getEncoder().encodeToString(rawHmac);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
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
    @RequestMapping("tts")
    public static ResponseEntity<byte[]> textToSpeech(@RequestBody String tts) throws Exception {

        String apiUrl = config.getProperty("api.tts.url");
        String clientId = config.getProperty("api.tts.client.id");
        String clientSecret = config.getProperty("api.tts.client.secret");

        // 챗봇 응답 텍스트 Request
        String text = URLEncoder.encode(tts, "UTF-8");
        String postParams = "speaker=ngoeun&volume=0&speed=0&pitch=0&format=mp3&text=" + text;

        try {

            HttpsURLConnection con = (HttpsURLConnection) new URL(apiUrl).openConnection();

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
    @RequestMapping("navi")
    public ResponseEntity<Map<String, String[]>> pageNavigation(@RequestBody(required = false) Map<String, String[]> data, HttpServletRequest request) throws Exception {
        if (data != null && data.containsKey("url")) {
            String[] urls = data.get("url");
            if (urls != null && urls.length > 0) {
                String[] responseData = new String[]{urls[0]};

                return ResponseEntity.ok().body(Collections.singletonMap("url", responseData));
            }
        }
        return ResponseEntity.badRequest().build();
    }
}