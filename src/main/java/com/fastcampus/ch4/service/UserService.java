package com.fastcampus.ch4.service;

import com.fastcampus.ch4.domain.User;
import com.fastcampus.ch4.domain.UserVO;

public interface UserService {

    void register(User user) throws Exception;
}
