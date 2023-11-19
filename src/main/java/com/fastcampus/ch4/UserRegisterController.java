//package com.fastcampus.ch4;
//
//import com.fastcampus.ch4.domain.UserVO;
//import com.fastcampus.ch4.domain.User;
//import com.fastcampus.ch4.service.UserService;
//import org.mindrot.jbcrypt.BCrypt;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.servlet.mvc.support.RedirectAttributes;
//
//import javax.inject.Inject;
//
//import static org.graalvm.compiler.options.OptionType.User;
//
//public class UserRegisterController {
//
//    private final UserService userService;
//
//    @Inject
//    public UserRegisterController(UserService userService) {
//        this.userService = userService;
//    }
//
//    // 회원가입 페이지
//    @RequestMapping(value = "/register", method = RequestMethod.GET)
//    public String registerGET() throws Exception {
//        return "/user/register";
//    }
//
//    // 회원가입 처리
//    @RequestMapping(value = "/register", method = RequestMethod.POST)
//    public String registerPOST(User user, RedirectAttributes redirectAttributes) throws Exception {
//
//        String hashedPw = BCrypt.hashpw(User.setpwd(), BCrypt.gensalt());
//        User.setpwd(hashedPw);
//        userService.register(user);
//        redirectAttributes.addFlashAttribute("msg", "REGISTERED");
//
//        return "redirect:/user/login";
//    }
//
//    // 로그인 페이지 (임시로 여기에 작성하고 추후 UserLoginController에서 다시 작성)
//    @RequestMapping(value = "/login", method = RequestMethod.GET)
//    public String login() throws Exception {
//        return "/user/login";
//    }
//
//}
