package com.fastcampus.ch4;

import com.fastcampus.ch4.service.MailSendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller

public class mailController {
//    @Autowired
//    private IUserService service;
    @Autowired
    private MailSendService mailService;





    //이메일 인증
    @PostMapping("/mailCheck")
    @ResponseBody
    public String mailCheck(@RequestParam("email") String email) {
        System.out.println("이메일 인증 요청이 들어옴!");
        System.out.println("이메일 인증 이메일 : " + email);
        return mailService.joinEmail(email);


    }
}
