package com.bit.motrip.serviceimpl.user;

import com.bit.motrip.common.Search;
import com.bit.motrip.dao.user.UserDao;
import com.bit.motrip.domain.User;
import com.bit.motrip.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

}
