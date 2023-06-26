package com.bit.motrip.controller;

import com.bit.motrip.domain.User;
import com.bit.motrip.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
@Controller
@RequestMapping("/test/*")
public class TestController {

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

    @GetMapping("login/{id}")
    public String login(@PathVariable("id") String id, HttpSession session) throws Exception{
        System.out.println(id+"로 대충 로그인합니다.");
        User dbUser = userService.getUserById(id);
        session.setAttribute("user", dbUser);
        return "index.jsp";
    }
    @GetMapping("logout")
    public String login(HttpSession session) throws Exception{
        session.invalidate();
        return "index.jsp";
    }
    @GetMapping("index")
    public String test(HttpSession session) throws Exception{
        session.invalidate();
        return "index.jsp";
    }
    @GetMapping("alarmTest")
    public String alarmTest() throws Exception{

        return "alarm/alarmTest.jsp";
    }
    @GetMapping("accept")
    public String acceptUrl() throws Exception{

        return "alarm/accept.jsp";
    }
    @GetMapping("reject")
    public String rejectUrl() throws Exception{

        return "alarm/reject.jsp";
    }
    @GetMapping("what")
    public String what() throws Exception{
        System.out.println("what works");

        return "common/what.jsp";
    }

    @GetMapping("who")
    public String who() throws Exception{
        System.out.println("who works");

        return "common/who.jsp";
    }
}
