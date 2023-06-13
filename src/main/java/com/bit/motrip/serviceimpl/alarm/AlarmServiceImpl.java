package com.bit.motrip.serviceimpl.alarm;

import com.bit.motrip.common.Search;
import com.bit.motrip.dao.alarm.AlarmDao;
import com.bit.motrip.domain.*;
import com.bit.motrip.service.alarm.AlarmService;
import com.bit.motrip.service.user.UserService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.http.client.ClientHttpRequestFactory;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.net.URI;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

@Service
public class AlarmServiceImpl implements AlarmService {

    //Const inject
    public AlarmServiceImpl(AlarmDao alarmDao, UserService userService) {
        this.alarmDao = alarmDao;
        this.userService = userService;
    }

    //Field
    private final AlarmDao alarmDao;
    private final UserService userService;

    @Value(value = "#{alarm['pageSize']}")
    private int pageSize;

    @Value(value = "#{user['naver-cloud-sms.accessKey']}")
    private String accessKey;

    @Value(value = "#{user['naver-cloud-sms.secretKey']}")
    private String secretKey;

    @Value(value = "#{user['naver-cloud-sms.serviceId']}")
    private String serviceId;

    @Value(value = "#{user['naver-cloud-sms.senderPhone']}")
    private String phone;


    @Override
    public int addConfirmAlarm(User sender, User receiver, String alarmTitle, String alarmContents) {
        Alarm alarm = new Alarm();
        alarm.setAlarmLevel("2");
        alarm.setAlarmCategory("1");
        alarm.setAlarmTitle(alarmTitle);
        alarm.setAlarmContents(alarmContents);
        alarm.setAlarmReceiver(receiver.getUserId());
        alarm.setAlarmReceiverNick(receiver.getNickname());
        alarm.setAlarmSender(sender.getUserId());
        alarm.setAlarmSenderNick(sender.getNickname());

        System.out.println("AlarmServiceImpl:확인알람 추가 시도");
        System.out.println("알람 카테고리는" + alarm.getAlarmCategory());
        System.out.println("알람 레벨은" + alarm.getAlarmLevel());
        System.out.println("알람 제목은" + alarm.getAlarmTitle());
        System.out.println("알람 내용은" + alarm.getAlarmContents());
        System.out.println("알람 받는 사람은" + alarm.getAlarmReceiver());
        System.out.println("알람 받는 사람 닉네임은" + alarm.getAlarmReceiverNick());
        System.out.println("알람 보내는 사람은" + alarm.getAlarmSender());
        System.out.println("알람 보내는 사람 닉네임은" + alarm.getAlarmSenderNick());

        int isSuccess = 0;
        try {
            //알람 추가 시도해본다.
            isSuccess = alarmDao.addAlarm(alarm);
            //알람추가에 실패했다면 익셉션 발생
            if (isSuccess != 1) {
                throw new Exception("AlarmServiceImpl:확인알람 추가 실패");
            }
            //알람추가에 성공했다면 문자를 보낸다.
            String newAlarmContents = "[모여행]"+alarmContents;
            simpleSms(receiver, newAlarmContents);
            //알람추가에 성공했으니 성공 여부 반환
            return isSuccess;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }


    @Override
    public int addNavigateAlarm(User sender, User receiver, String alarmTitle, String alarmContents, String navigateUrl) {
        Alarm alarm = new Alarm();
        alarm.setAlarmLevel("2");
        alarm.setAlarmCategory("2");
        alarm.setAlarmTitle(alarmTitle);
        alarm.setAlarmContents(alarmContents);
        alarm.setAlarmReceiver(receiver.getUserId());
        alarm.setAlarmReceiverNick(receiver.getNickname());
        alarm.setAlarmSender(sender.getUserId());
        alarm.setAlarmSenderNick(sender.getNickname());
        alarm.setAlarmNaviUrl(navigateUrl);

        int isSuccess = 0;
        try {
            //알람 추가 시도해본다.
            isSuccess = alarmDao.addAlarm(alarm);
            //알람추가에 실패했다면 익셉션 발생
            if (isSuccess != 1) {
                throw new Exception("AlarmServiceImpl:네비알람 추가 실패");
            }
            //알람추가에 성공했으니 성공 여부 반환
            //알람추가에 성공했다면 문자를 보낸다.
            String newAlarmContents = "[모여행]"+alarmContents;
            simpleSms(receiver, newAlarmContents);

            return isSuccess;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }

    }

    @Override
    public int addAcceptableAlarm(User sender, User receiver, String alarmTitle, String alarmContents, String acceptUrl, String rejectUrl) {
        Alarm alarm = new Alarm();
        alarm.setAlarmLevel("2");
        alarm.setAlarmCategory("3");
        alarm.setAlarmTitle(alarmTitle);
        alarm.setAlarmContents(alarmContents);
        alarm.setAlarmReceiver(receiver.getUserId());
        alarm.setAlarmReceiverNick(receiver.getNickname());
        alarm.setAlarmSender(sender.getUserId());
        alarm.setAlarmSenderNick(sender.getNickname());
        alarm.setAlarmAcceptUrl(acceptUrl);
        alarm.setAlarmRejectUrl(rejectUrl);

        int isSuccess = 0;
        try {
            //알람 추가 시도해본다.
            isSuccess = alarmDao.addAlarm(alarm);
            //알람추가에 실패했다면 익셉션 발생
            if (isSuccess != 1) {
                throw new Exception("AlarmServiceImpl:수락/거절 알람 추가 실패");
            }
            //알람추가에 성공했으니 성공 여부 반환
            //알람추가에 성공했다면 문자를 보낸다.
            String newAlarmContents = "[모여행]"+alarmContents;
            simpleSms(receiver, newAlarmContents);

            return isSuccess;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int readAlarm(int alarmNo) {
        int isSuccess = 0;
        try {
            isSuccess = alarmDao.readAlarm(alarmNo);
            if (isSuccess != 1) {
                throw new Exception("AlarmServiceImpl:알람 읽음처리 실패");
            }
            return isSuccess;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int holdAlarm(int alarmNo) {
        int isSuccess = 0;
        try {
            isSuccess = alarmDao.holdAlarm(alarmNo);
            if (isSuccess != 1) {
                throw new Exception("AlarmServiceImpl:알람 보류처리 실패");
            }
            return isSuccess;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int removeAlarm(int alarmNo) {
        int isSuccess = 0;
        try {
            isSuccess = alarmDao.removeAlarm(alarmNo);
            if (isSuccess != 1) {
                throw new Exception("AlarmServiceImpl:알람 영구삭제 실패");
            }
            return isSuccess;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public List<Alarm> getAlarmList(String userId, int currentPage) {
        Search search = new Search();
        search.setCurrentPage(currentPage);
        search.setPageSize(pageSize);
        search.setSearchKeyword(userId);
        return alarmDao.getAlarmList(search);
    }

    @Override
    public List<Alarm> getHoldAlarmList(String userId, int currentPage) {
        Search search = new Search();
        search.setCurrentPage(currentPage);
        search.setPageSize(pageSize);
        search.setSearchKeyword(userId);
        return alarmDao.getHoldAlarmList(search);
    }

    @Override
    public Alarm getEmergencyAlarm(String userId) {
        return null;
    }

    @Override
    public int getUnreadAlarmCount(String userId) {
        return alarmDao.getUnreadAlarmCount(userId);
    }


    public void sendSms(SmsMessage smsMessage, String smsContents) throws Exception {

        System.out.println("Alarm sms 실행");
        //현재 시각을 생성한다.
        String time = Long.toString(System.currentTimeMillis());
        //현재 시각을 기준으로 유효한 signature 를 생성하고, http header에 그것을 넣는다.
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("x-ncp-apigw-timestamp", time);
        headers.set("x-ncp-iam-access-key", accessKey);
        headers.set("x-ncp-apigw-signature-v2", getSignature(time)); // signature 서명

        System.out.println("1========" + headers);

        List<SmsMessage> messages = new ArrayList<>();
        messages.add(smsMessage);

        SmsRequest request = new SmsRequest.Builder()
                .type("SMS")
                .contentType("COMM")
                .countryCode("82")
                .from(phone)
                .content(smsContents)
                .messages(messages)
                .build();

        System.out.println("2========" + request);

        //쌓은 바디를 json형태로 반환
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.registerModule(new JavaTimeModule());
        String body = objectMapper.writeValueAsString(request);

        // jsonBody와 헤더 조립
        HttpEntity<String> httpBody = new HttpEntity<>(body, headers);
        System.out.println("3. body+header 값은? ==========" + httpBody);

        CloseableHttpClient httpClient = HttpClients.createDefault(); // <= HttpClients를 생성하면서 문제가있는지, 이 메서드 사용하면 creating bean 에러 뜸

        HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory(httpClient);
        RestTemplate restTemplate = new RestTemplate();
        restTemplate.setRequestFactory(factory);

        ClientHttpRequestFactory currentFactory = restTemplate.getRequestFactory();
        if (currentFactory instanceof HttpComponentsClientHttpRequestFactory) {
            System.out.println("HttpComponentsClientHttpRequestFactory is configured");
        } else {
            System.out.println("HttpComponentsClientHttpRequestFactory is not configured");
        }

        String url = "https://sens.apigw.ntruss.com/sms/v2/services/" + serviceId + "/messages";
        System.out.println("url값 확인용 =====> " + url);

        ResponseEntity<String> responseEntity = restTemplate.exchange(new URI(url), HttpMethod.POST, httpBody, String.class);

    }

    // sendSms 에서 호출 -> 헤더 구성에 필요한 서명 작성
    public String getSignature(String time) throws Exception {

        System.out.println("getSignature method 실행됨 ==========================================");

        String space = " ";
        String newLine = "\n";
        String method = "POST";
        String url = "/sms/v2/services/" + this.serviceId + "/messages";
        String accessKey = this.accessKey;
        String secretKey = this.secretKey;

        String message = new StringBuilder()
                .append(method)
                .append(space)
                .append(url)
                .append(newLine)
                .append(time)
                .append(newLine)
                .append(accessKey)
                .toString();

        SecretKeySpec signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
        Mac mac = Mac.getInstance("HmacSHA256");
        mac.init(signingKey);

        byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
        //String encodeBase64String = Base64.encodeBase64String(rawHmac); ==> org.apache.hc.client5.http.utils.Base64 라이브러리를 이용한방법.
        String encodeBase64String = new String(Base64.getEncoder().encode(rawHmac)); // ==> java.util.Base64 라이브러리를 이용한방법.

        return encodeBase64String;
    }

    //인증번호 확인
    public String phCodeConfirm(String phCodeConfirm, String smsConfirmNum) throws Exception {
        boolean result = false;

        if (phCodeConfirm != null && phCodeConfirm.equals(smsConfirmNum)) {
            result = true;
        }

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("result", result);

        return jsonObject.toString();
    }

    //전화번호 파싱
    public String phNumberParsing(String phNumber) throws Exception {
        String result = "";
        String[] phNumberArr = phNumber.split("-");
        for (int i = 0; i < phNumberArr.length; i++) {
            result += phNumberArr[i];
        }
        return result;

    }

    //간단하게 sms 보내기
    public String simpleSms(User receiver, String contents) throws Exception {
        String result = "";
        if(receiver.isGettingSmsAlarm()){
            System.out.println("simpleSms 실행");
            String phNumber = receiver.getPhone();
            String phNumberParsing = phNumberParsing(phNumber);
            String smsContents = contents;
            SmsMessage smsMessage = new SmsMessage(phNumberParsing);
            sendSms(smsMessage, smsContents);
            result = "success";
        }else{
            result = "fail";
        }
        return result;
    }
}
