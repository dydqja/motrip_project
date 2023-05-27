package com.bit.motrip.service.user;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.User;
import org.springframework.stereotype.Service;

import java.util.Map;
@Service
public interface UserService {

    // 회원가입
    public void addUser(User user) throws Exception;

    // 내정보확인 / 로그인
    public User getUser(String userId) throws Exception;

    // 회원정보리스트
    public Map<String , Object> getList(Search search) throws Exception;

    // 회원정보수정
    public void updateUser(User user) throws Exception;

    // 회원 ID 중복 확인
    public boolean checkDuplication(String userId) throws Exception;

    // 회원 탈퇴처리
    public void deleteUser(User user) throws Exception;

    public int checkId(String userId) throws  Exception;

    public int checkNickname(String nickname) throws  Exception;

}
