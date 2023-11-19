package com.fastcampus.ch4.dao;

import com.fastcampus.ch4.domain.*;

public interface UserDao {
    User selectUser(String email) throws Exception;
    User selectUser2(String email) throws Exception;
    int deleteUser(String email) throws Exception;
    int insertUser(User user) throws Exception;
    int updateUser(User user) throws Exception;
    int count() throws Exception;
    void deleteAll() throws Exception;
//    User register(UserVO userVO) throws Exception;
}