package com.bit.motrip.controller.user;

import com.bit.motrip.domain.User;
import com.bit.motrip.service.user.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user/*")
public class UserController {

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

    public UserController() {
        System.out.println(this.getClass());
    }

    @RequestMapping( value="login", method=RequestMethod.GET)
    public String login() throws Exception{
        System.out.println("/user/logon : GET");

        return "user/login.jsp";
    }

    @RequestMapping( value="login", method=RequestMethod.POST )
    public String login(@ModelAttribute("user") User user , HttpSession session ) throws Exception{
        System.out.println("/user/login : POST");
        System.out.println(user.getUserId());

        //Business Logic
        User dbUser=userService.getUser(user.getUserId());

        System.out.println(dbUser);

        if( user.getPwd().equals(dbUser.getPwd())){
            session.setAttribute("user", dbUser);
        }

        return "/main.jsp";
    }

    @RequestMapping( value="addUser", method=RequestMethod.POST )
    public String addUser( @ModelAttribute("user") User user ) throws Exception {
        System.out.println("/user/addUser : POST");

        //Business Logic
        userService.addUser(user);

        return "redirect:/user/mypage.jsp";
    }

}
