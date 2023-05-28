package com.bit.motrip.serviceimpl.user;

import com.bit.motrip.common.Search;
import com.bit.motrip.dao.user.UserDao;
import com.bit.motrip.domain.SmsMessage;
import com.bit.motrip.domain.SmsRequest;
import com.bit.motrip.domain.SmsResponse;
import com.bit.motrip.domain.User;
import com.bit.motrip.service.user.UserService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.http.client.ClientHttpRequestFactory;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.io.InputStream;
import java.net.URI;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDate;
import java.util.*;
import java.util.concurrent.ThreadLocalRandom;
import com.fasterxml.jackson.databind.node.ObjectNode;

import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;






@Service("userServiceImpl")
public class UserServiceImpl implements UserService{

    ///Field
    @Autowired
    private UserDao userDao;
    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }
    private Path fileStorageLocation = Paths.get("C:\\Projects\\motrip_main_project\\src\\main\\resources\\static\\images");

    @Value(value = "#{user['naver-cloud-sms.accessKey']}")
    private String accessKey;

    @Value(value = "#{user['naver-cloud-sms.secretKey']}")
    private String secretKey;

    @Value(value = "#{user['naver-cloud-sms.serviceId']}")
    private String serviceId;

    @Value(value = "#{user['naver-cloud-sms.senderPhone']}")
    private String phone;



    ///Constructor
    public UserServiceImpl() {
        System.out.println(this.getClass());
    }

    //회원가입
    public void addUser(User user) throws Exception {

        String getSsn = user.getSsn();
        String phone = user.getPhone();

        phone = phone.substring(0, 3) + "-" + phone.substring(3, 7) + "-" + phone.substring(7);

        Map<String, String> extractSsn = extractSsn(getSsn);
        String age = extractSsn.get("age");
        String gender = extractSsn.get("gender");

        user.setAge(age);
        user.setGender(gender);
        user.setPhone(phone);

        userDao.addUser(user);
    }
    
    //회원정보가져오기
    public User getUser(String userId) throws Exception {
        return userDao.getUser(userId);
    }

    //리스트 구성하기
    public Map<String , Object > getList(Search search) throws Exception {
        List<User> list= userDao.getList(search);
        int totalCount = userDao.getTotalCount(search);

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("list", list );
        map.put("totalCount", new Integer(totalCount));

        return map;
    }

    //회원정보 업데이트
    public void updateUser(User user) throws Exception {
        userDao.updateUser(user);
    }


//    public boolean checkDuplication(String userId) throws Exception {
//        boolean result=true;
//        User user=userDao.getUser(userId);
//        if(user != null) {
//            result=false;
//        }
//        return result;
//    }

    //회원 탈퇴유무 변경
    public void deleteUser(User user) throws Exception {

        userDao.deleteUser(user);
    }

    //주민등록번호 7자리에서 성별과 나이대 추출하는 메소드
    public static Map<String, String> extractSsn(String ssn) {

        int year = Integer.parseInt(ssn.substring(0, 2));
        int gender = Integer.parseInt(ssn.substring(7));

        // 나이 계산
        int age = year < 30 ? 2000 + year : 1900 + year;
        age = LocalDate.now().getYear() - age;
        String ageGroup;

        // 나이대 계산
        if(age >= 10 && age < 20) {
            ageGroup = "10-19";
        } else if(age >= 20 && age < 30) {
            ageGroup = "20-29";
        } else if(age >= 30 && age < 40) {
            ageGroup = "30-39";
        } else if(age >= 40 && age < 50) {
            ageGroup = "40-49";
        } else if(age >= 50 && age < 60) {
            ageGroup = "50-59";
        } else {
            ageGroup = "60-";
        }

        // 성별 계산
        String genderStr = (gender == 1 || gender == 3) ? "M" : "F";

        // 결과 맵 생성 및 리턴
        Map<String, String> result = new HashMap<>();
        result.put("age", ageGroup);
        result.put("gender", genderStr);

        return result;
    }

    //회원가입시 비동기방식 아이디 중복체크
    public int checkId(String userId) throws Exception {

        int checkId = userDao.checkId(userId);

        if (checkId > 0) { // 아이디가 이미 존재함
            checkId = 0;
        } else { // 사용 가능한 아이디
            checkId = 1;
        }

        return checkId;
    }

    //회원가입시 비동기방식 닉네임 중복체크
    public int checkNickname(String nickname) throws Exception {

        int checkNickname = userDao.checkId(nickname);

        if (checkNickname > 0) { // 아이디가 이미 존재함
            checkNickname = 0;
        } else { // 사용 가능한 아이디
            checkNickname = 1;
        }

        return checkNickname;
    }

    //회원가입 파일업로드
    public String fileUpload(MultipartFile file) throws Exception {

        System.out.println("UserServiceImpl 에서 fileUpload() 실행됨.");

        if (file.isEmpty()) {
            throw new Exception("Failed to store empty file");
        }

        System.out.println("받은 파일의 경로는 => : " + file.getOriginalFilename());

        String fileName = StringUtils.cleanPath(file.getOriginalFilename());
        System.out.println("파일경로에서 파일이름만 뽑은 값은 => : " + fileName);

        String uniqueFileName = UUID.randomUUID().toString() + "_" + fileName;
        System.out.println("파일이름+UUID해서 준 임의파일이름은? => : " + uniqueFileName);

        /*파일이 저장될 기본 경로(this.fileStorageLocation)에 파일이름(uniqueFileName) 을 추가(resolve) 하여,
        새로운 경로 생성(Path targetLocation)*/
        Path targetLocation = this.fileStorageLocation.resolve(uniqueFileName);
        System.out.println("기본경로+파일이름으로 생성된 새로운경로는? => : " + targetLocation);

        System.out.println("업로드파일 데이터스트림 => : "+ file.getInputStream());

        /*업로드된 파일의 데이터 스트림을 가져오고(file.getInputStream()) 이 데이터 스트림을 지정된 경로(targetLocation)로 복사(Files.copy)한다.
        복사한 위치에 동일한 이름의 파일이 있다면 기존 파일을 새 파일로 대체(StandardCopyOption.REPLACE_EXISTING)한다. */
        try (InputStream is = file.getInputStream()) {
        Files.copy(file.getInputStream(), targetLocation, StandardCopyOption.REPLACE_EXISTING);
        } catch (Exception e) {
            throw new Exception("Failed to store file " + fileName, e);
        }

        return uniqueFileName;
    }

    //회원가입시 전화번호 sms인증
    public SmsResponse sendSms(SmsMessage smsMessage) throws Exception{

        System.out.println("UserServiceImpl에서 sendSms 실행됨.===========");

        String time = Long.toString(System.currentTimeMillis());

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("x-ncp-apigw-timestamp", time);
        headers.set("x-ncp-iam-access-key", accessKey);
        headers.set("x-ncp-apigw-signature-v2", getSignature(time)); // signature 서명

        System.out.println("1========"+headers);

        List<SmsMessage> messages = new ArrayList<>();
        messages.add(smsMessage);

        final String smsConfirmNum = createSmsKey();//휴대폰 인증 번호
        System.out.println("생성된 랜덤 인증번호 = [" + smsConfirmNum + "]");

        SmsRequest request = new SmsRequest.Builder()
                .type("SMS")
                .contentType("COMM")
                .countryCode("82")
                .from(phone)
                .content("[서비스명 모여행] 인증번호 [" + smsConfirmNum + "]를 입력해주세요")
                .messages(messages)
                .build();

        System.out.println("2========"+request);

        //쌓은 바디를 json형태로 반환        
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.registerModule(new JavaTimeModule()); // LocalDateTime 객체 역'직렬화 실패로 인한 추가사항
        String body = objectMapper.writeValueAsString(request);

        // jsonBody와 헤더 조립
        HttpEntity<String> httpBody = new HttpEntity<>(body, headers);
        System.out.println("3. body+header 값은? ==========" + httpBody);

        CloseableHttpClient httpClient = HttpClients.createDefault(); // <= HttpClients를 생성하면서 문제가있는지, 이 메서드 사용하면 creating bean 에러 뜸
        //	ㄴ 필요라이브러리 버전 맞춰줌으로써 해결.	
        //CloseableHttpClient httpClient = HttpClientBuilder.create().build();

//        RequestConfig requestConfig = RequestConfig.custom()
//        	    .setConnectTimeout(5000) // 연결 시간 초과를 5초로 설정
//        	    .setSocketTimeout(5000) // 소켓 시간 초과를 5초로 설정
//        	    .build();
//
//        	CloseableHttpClient httpClient = HttpClients.custom()
//        	    .setDefaultRequestConfig(requestConfig)
//        	    .build();

        HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory(httpClient);
        RestTemplate restTemplate = new RestTemplate();
        restTemplate.setRequestFactory(factory);

//        restTemplate.setRequestFactory 확인용(삭제해도 문제없음)
        ClientHttpRequestFactory currentFactory = restTemplate.getRequestFactory();
        if (currentFactory instanceof HttpComponentsClientHttpRequestFactory) {
            System.out.println("HttpComponentsClientHttpRequestFactory is configured");
        } else {
            System.out.println("HttpComponentsClientHttpRequestFactory is not configured");
        }

        //restTemplate로 post 요청 보내고 오류가 없으면 202코드 반환        
        //SmsResponse smsResponse = restTemplate.postForObject(new URI("https://sens.apigw.ntruss.com/sms/v2/services/"+ serviceId +"/messages"), httpBody, SmsResponseDto.class);
        //HttpEntity<?> httpEntity = new HttpEntity<>(httpBody, headers);
        String url = "https://sens.apigw.ntruss.com/sms/v2/services/" + serviceId + "/messages";
        System.out.println("url값 확인용 =====> " + url);
        //System.out.println("httpEntity: " + httpEntity);

        ResponseEntity<String> responseEntity = restTemplate.exchange(new URI(url), HttpMethod.POST, httpBody, String.class);
        System.out.println("responseEntity 확인용 =====> " + responseEntity);
        // JSON 응답을 문자열로 확인
        String jsonResponse = responseEntity.getBody();
        System.out.println("JSON 응답: " + jsonResponse);
        // 이제 필요한 경우 문자열 형식의 JSON 응답을 SmsResponseDto 객체로 변환할 수 있습니다.
//        SmsResponseDto smsResponseDto = objectMapper.readValue(jsonResponse, SmsResponseDto.class);

        ObjectNode jsonNode = objectMapper.readValue(jsonResponse, ObjectNode.class);
        jsonNode.put("smsConfirmNum", smsConfirmNum);
        SmsResponse smsResponseDto = objectMapper.treeToValue(jsonNode, SmsResponse.class);

        SmsResponse smsResponse = new SmsResponse(smsConfirmNum);
        // redisUtil.setDataExpire(smsConfirmNum, messageDto.getTo(), 60 * 3L); // 유효시간 3분        

        return smsResponse;

    }

    // sendSms 에서 호출 -> 헤더 구성에 필요한 서명 작성
    public String getSignature(String time) throws Exception {

        System.out.println("getSignature method 실행됨 ==========================================");

        String space = " ";
        String newLine = "\n";
        String method = "POST";
        String url = "/sms/v2/services/"+ this.serviceId+"/messages";
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

    //sendSms 에서 호출 -> 발송할 인증번호 구성하기
    public String createSmsKey() {
        StringBuilder key = new StringBuilder();

        for (int i = 0; i < 6; i++) { // 인증코드 6자리
            key.append(ThreadLocalRandom.current().nextInt(10));
        }

        return key.toString();
    }

    //인증번호 확인
    public String phCodeConfirm(String phCodeConfirm, String smsConfirmNum) throws Exception {
        boolean result=false;

        if(phCodeConfirm != null && phCodeConfirm.equals(smsConfirmNum)) {
            result = true;
        }

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("result", result);

        return jsonObject.toString();
    }


}
