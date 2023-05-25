package com.bit.motrip.serviceimpl.user;

import com.bit.motrip.common.Search;
import com.bit.motrip.dao.user.UserDao;
import com.bit.motrip.domain.User;
import com.bit.motrip.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("userServiceImpl")
public class UserServiceImpl implements UserService{

    ///Field
    @Autowired
    private UserDao userDao;
    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    ///Constructor
    public UserServiceImpl() {
        System.out.println(this.getClass());
    }

    ///Method
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

    public User getUser(String userId) throws Exception {
        return userDao.getUser(userId);
    }

    public Map<String , Object > getList(Search search) throws Exception {
        List<User> list= userDao.getList(search);
        int totalCount = userDao.getTotalCount(search);

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("list", list );
        map.put("totalCount", new Integer(totalCount));

        return map;
    }

    public void updateUser(User user) throws Exception {
        userDao.updateUser(user);
    }

    public boolean checkDuplication(String userId) throws Exception {
        boolean result=true;
        User user=userDao.getUser(userId);
        if(user != null) {
            result=false;
        }
        return result;
    }

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

}
