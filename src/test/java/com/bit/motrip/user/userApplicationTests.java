package com.bit.motrip.user;

import com.bit.motrip.common.Search;
import com.bit.motrip.dao.user.UserDao;
import com.bit.motrip.domain.User;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static java.lang.Boolean.FALSE;
import static java.lang.Boolean.TRUE;

@SpringBootTest
public class userApplicationTests {

    @Autowired
    private UserDao userDao;

//    @Test
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
        user.setSecession(FALSE);
        user.setSuspension(FALSE);
        user.setWarningCount(1);
        user.setSelfIntroPublic(TRUE);
        user.setUserPhotoPublic(TRUE);
        user.setUsingMemoBar(TRUE);
        user.setListingAttachedMemo(FALSE);
        user.setListingSharedMemo(FALSE);

        userDao.addUser(user);
    }

//    @Test
    public void getTest() throws Exception {
        User user = new User();

        user.setUserId("user2");

        User getUser = userDao.getUser(user.getUserId());

        System.out.println(getUser.getEvaluateCount());

    }

    @Test
    public void getList() throws Exception {
        Search search = new Search();

        int pageSize = 3;
        int pageUnit = 5;

        search.setPageSize(pageSize);
        search.setCurrentPage(1);

        List<User> list = userDao.getList(search);
        int totalCount = userDao.getTotalCount(search);

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("list",list);
        map.put("totalCount", new Integer(totalCount));

        System.out.println(map);

    }
}
