package com.bit.motrip.dao.user;

import com.bit.motrip.domain.User;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserDao {

    //insert
    public void addUser(User user) throws Exception;

    //select one
    public void getUser(String userId) throws Exception;

}
