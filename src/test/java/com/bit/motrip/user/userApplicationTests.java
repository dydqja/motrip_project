package com.bit.motrip.user;

import com.bit.motrip.dao.user.UserDao;
import com.bit.motrip.domain.User;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static java.lang.Boolean.FALSE;
import static java.lang.Boolean.TRUE;

@SpringBootTest
public class userApplicationTests {

    @Autowired
    private UserDao userDao;

    @Test
    public void insertTest() throws Exception {
        User user = new User();

        user.setUserId("user101");
        user.setNickname("재연소맨");
        user.setPwd("1234");
        user.setUserName("홍길동");
        user.setPhone("010-1234-1234");
        user.setAddr("서울특별시 강남구 역삼동 819-3");
        user.setAddrDetail("삼오빌딩 5-9층");
        user.setEmail("user101@bitcamp.com");
        user.setSsn("930311-1");
        user.setSelfIntro("저는 purchase 도 못한 좆밥입니다");
        user.setGender("M");
        user.setAge("30-39");
        user.setRole(1);
        user.setIsSecession(FALSE);
        user.setIsSuspension(FALSE);
        user.setWarningCount(1);
        user.setIsSelfIntroPublic(TRUE);
        user.setIsUserPhotoPublic(TRUE);
        user.setIsUsingMemoBar(TRUE);
        user.setIsListingAttachedMemo(FALSE);
        user.setIsListingSharedMemo(FALSE);

        userDao.addUser(user);
    }

}
