package com.fastcampus.ch4;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.validation.Valid;

import com.fastcampus.ch4.dao.UserDao;
import com.fastcampus.ch4.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.StringArrayPropertyEditor;
import org.springframework.core.convert.ConversionService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Validator;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

@Controller // ctrl+shift+o 자동 import
@RequestMapping("/registerAdd")
public class RegisterController {

    @Autowired
    UserDao userDao;

    final int FAIL = 0;



    @InitBinder
    public void toDate(WebDataBinder binder) {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(df, false));
        binder.setValidator(new UserValidator()); // UserValidator를 WebDataBinder의 로컬 validator로 등록
        //	List<Validator> validatorList = binder.getValidators();
        //	System.out.println("validatorList="+validatorList);
    }

    @GetMapping("/add")
    public String register() {
        return "loginForm"; // WEB-INF/views/registerForm.jsp
    }

    @PostMapping("/add")
    public String save1(@Valid User user, BindingResult result, Model m) throws Exception {
        System.out.println("result="+result);
        System.out.println("user="+user);

        int rowCnt = userDao.insertUser(user);

        if(rowCnt != FAIL){
            m.addAttribute("User", user);
            return "loginForm";
        }


        // User객체를 검증한 결과 에러가 있으면, registerForm을 이용해서 에러를 보여줘야 함.
        if(result.hasErrors()) {

            return "registerAdd";
        }



        // 2. DB에 신규회원 정보를 저장
        return "loginForm";
    }

    private boolean isValid(User user) {
        return true;
    }

}
