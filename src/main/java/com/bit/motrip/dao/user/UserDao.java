package com.bit.motrip.dao.user;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserDao {

    //insert
    public void addUser(User user) throws Exception;

    //select one
    public User getUserById(String userId) throws Exception;

    //select one
    public User getUserByNickname(String userNickname) throws Exception;

    //select list
    public List<User> getList(Search search) throws Exception;

    public int getTotalCount(Search search) throws Exception ;

    //update
    public void updateUser(User user) throws Exception;

    //delete
    public void secessionAndRestoreUser(User user) throws Exception;

    public int checkId(String userId) throws Exception;

    public int checkNickname(String nickname) throws Exception;

    public List<String> getNickname(List<String> blacklist) throws Exception;

    public String findId(String phone) throws Exception;

    public void updatePwd(User user) throws Exception;

}
