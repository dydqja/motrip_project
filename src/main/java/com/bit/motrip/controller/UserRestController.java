package com.bit.motrip.controller;

import com.bit.motrip.domain.User;
import com.bit.motrip.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;


@RestController
@RequestMapping("/user/*")
public class UserRestController {

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

    public UserRestController() {
        System.out.println(this.getClass());
    }

    @RequestMapping( value="checkId", method=RequestMethod.POST )
    public Integer chekcId(@RequestParam("value") String userId) throws Exception {
        System.out.println("/user/checkId : POST");

        int checkId = userService.checkId(userId);

        return checkId;
    }

    @RequestMapping( value="checkNickname", method=RequestMethod.POST )
    public Integer chekcNickname(@RequestParam("value") String nickname) throws Exception {
        System.out.println("/user/checkId : POST");

        int checkNickname = userService.checkId(nickname);

        return checkNickname;
    }

}
