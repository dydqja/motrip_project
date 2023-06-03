package com.bit.motrip.serviceimpl.user;

import com.bit.motrip.common.Page;
import com.bit.motrip.common.Search;
import com.bit.motrip.dao.user.UserDao;
import com.bit.motrip.domain.User;
import com.bit.motrip.service.user.UserService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static java.lang.Boolean.FALSE;
import static java.lang.Boolean.TRUE;
import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class UserServiceImplTest {

    @Autowired
    private UserService userService;


//    @Test
    void addUser() throws Exception {

        User user = new User();

        user.setUserId("testUser41");
        user.setNickname("조인테스트");
        user.setPwd("1234");
        user.setUserName("홍길동");
        user.setPhone("010-1234-1234");
        user.setAddr("서울특별시 강남구 역삼동 819-3");
        user.setAddrDetail("삼오빌딩 5-9층");
        user.setEmail("user101@bitcamp.com");
        user.setSsn("930311-1");
        user.setSelfIntro("블랙리스트 테스트 컬럼입니다");
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

        userService.addUser(user);
    }

//    @Test
    void getUser() throws Exception {

        User user = new User();

        user.setUserId("testUser41");

        User getUser = userService.getUserById(user.getUserId());

        System.out.println(getUser.toString());

    }

//    @Test
    void getList() throws Exception {

        Search search = new Search();
        Page page = new Page();
        int pageSize = 3;
        int pageUnit = 5;

        if(search.getCurrentPage() ==0 ){
            search.setCurrentPage(1);
        }
        search.setPageSize(pageSize);

        Map<String , Object> map=userService.getList(search);

        Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
        System.out.println(resultPage);
    }

//    @Test
    void updateUser() throws Exception {

        User user = new User();

        user.setUserId("testUser6");

        User getUser = userService.getUserById(user.getUserId());

        System.out.println(getUser.toString());

        getUser.setNickname("수정된지확인용");
        getUser.setPwd("8888");
        getUser.setSelfIntro("테스트 수정이 잘 되었다면 당근을 흔들어 주세요.");
        getUser.setSelfIntroPublic(TRUE);

        userService.updateUser(getUser);
    }

//    @Test
//    void checkDuplication() throws Exception{
//
//        boolean result=userService.checkDuplication("userTest6");
//    }

//    @Test
    void deleteUser() throws Exception{

        User user = new User();
        Timestamp suspensionDate = new Timestamp(System.currentTimeMillis());
        System.out.println("현재시간은? => " + suspensionDate);

        user.setUserId("testUser6");

        User getUser = userService.getUserById(user.getUserId());

        System.out.println(getUser.toString());

        getUser.setSuspension(TRUE);
        getUser.setSuspensionDate(suspensionDate);

        userService.secessionAndRestoreUser(getUser);
    }
}