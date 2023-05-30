package com.bit.motrip.controller;

import com.bit.motrip.common.Page;
import com.bit.motrip.common.Search;
import com.bit.motrip.domain.ChatRoom;
import com.bit.motrip.domain.User;
import com.bit.motrip.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
@RequestMapping("/user/*")
public class UserController {

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

    public UserController() {
        System.out.println(this.getClass());
    }

    @Value(value = "#{user['naver.client.id']}")
    String naverClientId;

    @Value(value = "#{user['naver.redirect.url']}")
    String naverCallbackUrl;

    @Value(value = "#{user['pageUnit']}")
    int pageUnit;
    @Value(value = "#{user['pageSize']}")
    int pageSize;

    @RequestMapping( value="login", method=RequestMethod.GET)
    public String login(HttpSession session) throws Exception{
        System.out.println("/user/login : GET");

        session.setAttribute("naverClientId", naverClientId);
        session.setAttribute("naverCallbackUrl", naverCallbackUrl);

        return "user/login.tiles";
    }

    @RequestMapping( value="naverLoginSuccess", method=RequestMethod.GET)
    public String naverLogin() throws Exception{
        System.out.println("/user/naverLoginSuccess : GET");

        return "/index.tiles";
    }

    @RequestMapping( value="login", method=RequestMethod.POST )
    public String login(@ModelAttribute("user") User user , HttpSession session, HttpServletRequest request) throws Exception{
        System.out.println("/user/login : POST");

        //Business Logic
        User dbUser=userService.getUser(user.getUserId());

        System.out.println(dbUser);

        if( user.getPwd().equals(dbUser.getPwd())){
            session.setAttribute("user", dbUser);
        }

        return "/index.tiles";
    }

    @RequestMapping( value="addUser", method=RequestMethod.POST )
    public String addUser(@ModelAttribute("user") User user) throws Exception {
        System.out.println("/user/addUser : POST");
        System.out.println("add 할 user 값은? : "+user);

        //Business Logic
        userService.addUser(user);

        return "redirect:/index.tiles";
    }

    @RequestMapping( value="naverLogin", method=RequestMethod.GET )
    public String checkUser(HttpSession session, User user) throws Exception {
        System.out.println("/user/naverLogin : GET");

        return "user/naverLoginCallback.tiles";
    }

    @RequestMapping( value="addNaverUser", method=RequestMethod.GET )
    public String addNaverUser(HttpSession session, Model model) throws Exception {
        System.out.println("/user/addNaverUser : GET");

        User user = (User) session.getAttribute("user");
        model.addAttribute("user", user);

        System.out.println("addNaverUser.jsp 로 보내질 user의 값은? => "+user);

        return "user/addNaverUser.tiles";
    }

    @RequestMapping( value="listUser" )
    public String listUser(@ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{

        System.out.println("/user/listUser : GET / POST");

        if(search.getCurrentPage() ==0 ){
            search.setCurrentPage(1);
        }
        search.setPageSize(pageSize);

        // Business logic 수행
        Map<String , Object> map=userService.getList(search);

        Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
        System.out.println(resultPage);

        // Model 과 View 연결
        model.addAttribute("list", map.get("list"));
        model.addAttribute("resultPage", resultPage);
        model.addAttribute("search", search);

        return "forward:/user/listUser.tiles";
    }

}
