package com.bit.motrip.controller;

import com.bit.motrip.domain.SmsMessage;
import com.bit.motrip.domain.SmsResponse;
import com.bit.motrip.domain.User;
import com.bit.motrip.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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

    @RequestMapping( value="fileUpload", method=RequestMethod.POST)
    public ResponseEntity<?> uploadFile(@RequestParam("file") MultipartFile file) throws Exception {
        System.out.println("/user/fileUpload : POST");

        System.out.println("client에서 넘어온 file 값은 => : " + file);
        String fileName = userService.fileUpload(file);

        System.out.println("ServiceImpl에서 리턴한 fileName => : " + fileName);

        return ResponseEntity.ok().body("/images/"+fileName);
    }

    @RequestMapping( value="sendSms", method=RequestMethod.POST )
    public SmsResponse sendSms(@RequestBody SmsMessage smsMessage) throws Exception {

        System.out.println("/sms/send :: POST");

        SmsResponse smsResponse = userService.sendSms(smsMessage);

        System.out.println("controller에 return된 SmsResponseDto값은? ==> " + smsResponse);

        return smsResponse;
    }

}
