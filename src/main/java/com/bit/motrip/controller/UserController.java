package com.bit.motrip.controller;

import com.bit.motrip.common.Page;
import com.bit.motrip.common.Search;

import com.bit.motrip.domain.EvaluateList;
import com.bit.motrip.domain.User;
import com.bit.motrip.service.evaluateList.EvaluateListService;
import com.bit.motrip.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;

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

        return "user/login.jsp";
    }

    @RequestMapping( value="naverLoginSuccess", method=RequestMethod.GET)
    public String naverLogin() throws Exception{
        System.out.println("/user/naverLoginSuccess : GET");

        return "/index.tiles";
    }

    @RequestMapping( value="login", method=RequestMethod.POST )
    public String login(@ModelAttribute("user") User user , HttpSession session, HttpServletRequest request) throws Exception{
        System.out.println("/user/login : POST");

        //사용자가 입력한 아이디값이 DB에 저장된(회원가입된) 아이디인지 확인
        User dbUser=userService.getUser(user.getUserId());
        System.out.println(dbUser);

        //아이디가 존재하지 않는경우
        if (dbUser == null) {
//            model.addAttribute("loginError", "아이디가 존재하지 않습니다.");
            return "user/login.jsp"; // 로그인 페이지로 이동
        }

        //회원가입된 아이디에 저장된 비밀번호 값과, 사용자가 입력한 비밀번호값이 같은지 확인
        if( user.getPwd().equals(dbUser.getPwd())){
            //저장된 비밀번호와 입력한 비밀번호값이 같다면, session에 아이디값 저장
            session.setAttribute("user", dbUser);
            System.out.println("user stored in session: " + session.getAttribute("user"));
        } else {
            // 비밀번호가 일치하지 않는 경우
//            model.addAttribute("loginError", "비밀번호가 일치하지 않습니다.");
            return "user/login.jsp"; // 로그인 페이지로 이동
        }

        return "/index.tiles";
    }

    @RequestMapping( value="addUser", method=RequestMethod.POST )
    public String addUser(@ModelAttribute("user") User user) throws Exception {
        System.out.println("/user/addUser : POST");
        System.out.println("add 할 user 값은? : "+user);

        //Business Logic
        userService.addUser(user);

        return "redirect:/index.jsp";
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
        System.out.println(map.get("list"));
        System.out.println(resultPage);
        System.out.println(search);

        // Model 과 View 연결
        model.addAttribute("list", map.get("list"));
        model.addAttribute("resultPage", resultPage);
        model.addAttribute("search", search);

        return "user/listUser.jsp";
    }

    @RequestMapping( value="getUser", method=RequestMethod.GET )
    public String getUser( @RequestParam("userId") String userId , Model model ) throws Exception {

        System.out.println("/user/getUser : GET");
        System.out.println(userId);
        //Business Logic
        User user = userService.getUser(userId);
        System.out.println(user);
        // Model 과 View 연결
        model.addAttribute("user", user);

        return "/user/getUser.jsp";
    }

}
