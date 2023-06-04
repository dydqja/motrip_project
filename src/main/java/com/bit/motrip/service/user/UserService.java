package com.bit.motrip.service.user;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.SmsMessage;
import com.bit.motrip.domain.SmsResponse;
import com.bit.motrip.domain.User;
import com.github.scribejava.core.model.OAuth2AccessToken;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
@Service
public interface UserService {

    // 회원가입
    public void addUser(User user) throws Exception;

    // 내정보확인 / 로그인
    public User getUserById(String userId) throws Exception;

    // 블랙리스트 닉네임과 회원상세보기 연결
    public User getUserByNickname(String userNickname) throws Exception;

    // 회원정보리스트
    public Map<String , Object> getList(Search search) throws Exception;

    // 회원정보수정
    public void updateUser(User user) throws Exception;

    // 회원 ID 중복 확인
//    public boolean checkDuplication(String userId) throws Exception;

    // 회원 탈퇴처리
    public void secessionAndRestoreUser(User user) throws Exception;

    public int checkId(String userId) throws  Exception;

    public int checkNickname(String nickname) throws  Exception;

    public String fileUpload(MultipartFile file) throws  Exception;

    //SMS 인증번호 발송
    SmsResponse sendSms(SmsMessage smsMessage) throws Exception;

    //발송한 인증번호와 입력받은 인증번호 확인
    public String phCodeConfirm(String phCodeConfirm, String smsConfirmNum) throws Exception;

    // NaverLogin AccessToken 발급
    OAuth2AccessToken getAccessToken(HttpSession session, String code, String state) throws Exception;

    // Token을 이용하여 사용자 프로필 정보 가져오기
    String getUserProfile(HttpSession session, OAuth2AccessToken oauthToken) throws Exception;

    //여러 아이디값으로 각각의 닉네임 가져오기
    public List<String> getNickname(List<String> blacklist) throws Exception;



}
