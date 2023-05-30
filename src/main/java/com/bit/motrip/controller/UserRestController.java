package com.bit.motrip.controller;

import com.bit.motrip.domain.PhCodeConfirmRequest;
import com.bit.motrip.domain.SmsMessage;
import com.bit.motrip.domain.SmsResponse;
import com.bit.motrip.domain.User;
import com.bit.motrip.service.user.UserService;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.github.scribejava.core.model.OAuth2AccessToken;

import java.util.Map;


@RestController
@RequestMapping("/user/*")
public class UserRestController {

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

    public UserRestController() {
        System.out.println(this.getClass());
    }

    @RequestMapping(value = "checkId", method = RequestMethod.POST)
    public Integer chekcId(@RequestParam("value") String userId) throws Exception {
        System.out.println("/user/checkId : POST");

        int checkId = userService.checkId(userId);

        return checkId;
    }

    @RequestMapping(value = "checkNickname", method = RequestMethod.POST)
    public Integer chekcNickname(@RequestParam("value") String nickname) throws Exception {
        System.out.println("/user/checkId : POST");

        int checkNickname = userService.checkId(nickname);

        return checkNickname;
    }

    @RequestMapping(value = "fileUpload", method = RequestMethod.POST)
    public ResponseEntity<?> uploadFile(@RequestParam("file") MultipartFile file) throws Exception {
        System.out.println("/user/fileUpload : POST");

        System.out.println("client에서 넘어온 file 값은 => : " + file);
        String fileName = userService.fileUpload(file);

        System.out.println("ServiceImpl에서 리턴한 fileName => : " + fileName);

        return ResponseEntity.ok().body("/images/" + fileName);
    }

    @RequestMapping(value = "sendSms", method = RequestMethod.POST)
    public String sendSms(@RequestBody SmsMessage smsMessage) throws Exception {

        System.out.println("/sms/send :: POST");

        SmsResponse smsResponse = userService.sendSms(smsMessage);

        System.out.println("controller에 return된 SmsResponseDto값은? ==> " + smsResponse);

        String smsConfirmNum = smsResponse.getSmsConfirmNum();
        System.out.println(smsConfirmNum);

        return smsConfirmNum;
    }

    @RequestMapping(value = "phCodeConfirm", method = RequestMethod.POST)
    public String phCodeConfirm(@RequestBody PhCodeConfirmRequest request) throws Exception {

        System.out.println("/user/phCodeConfirm : POST");

        String phCodeConfirm = request.getPhCodeConfirm();
        String smsConfirmNum = request.getSmsConfirmNum();

        String result = userService.phCodeConfirm(phCodeConfirm, smsConfirmNum);

        System.out.println("controller에 return된 result값은? ==> " + result);

        return result;
    }

    //NaverLogin창에서 로그인 후 개인정보동의하면 return되는 callback url 실행
    @RequestMapping(value = "/oauth_naver")
    public String oauthNaver(HttpServletRequest request, HttpServletResponse response, Model model, User user) throws Exception {

        System.out.println("/user/oauth_naver :: GET");

        HttpSession session = request.getSession();
        //정상적인경우 error값은 null 이어야함.
        String code = request.getParameter("code");
        String state = request.getParameter("state");
        String error = request.getParameter("error");

        System.out.println("QueryString으로 온 code,state,error값은? => code:[" + code + "], state:[" + state + "], error:[" + error + "]");

        // 로그인 팝업창에서 취소버튼 눌렀을경우
        if (error != null) {
            if (error.equals("access_denied")) {
                return "redirect:/login";
            }
        }
        //세션에 저장된 state값 비교해서 토큰 발급 받는과정
        OAuth2AccessToken oauthToken;
        //토큰 발급해서 객체에 저장
        oauthToken = userService.getAccessToken(session, code, state);
        //로그인 사용자 정보를 읽어온다.
        String loginInfo = userService.getUserProfile(session, oauthToken);
        //JSON 형식의 문자열을 JSONObject로 변환
        JSONObject obj = new JSONObject(loginInfo);
        //JSONObject에서 reponse값만 추출
        JSONObject callbackResponse = obj.getJSONObject("response");
        //response 값에서 id값 추출
        String snsId = callbackResponse.getString("id");
        // response값 domain에 저장하고 controller 호출
        if (snsId != null && !snsId.equals("")) {

            Map<String, String> data = (Map<String, String>) callbackResponse;
            user = User.naverUser(data);

            session.setAttribute("user", user);

            response.sendRedirect("/user/checkUser");

            return null;
            // 네이버 정보조회 실패
        } else {
            throw new Exception("Error occurred");
        }
    }

    @RequestMapping( value="checkUser", method=RequestMethod.POST )
    public String checkUser(@RequestBody User user, HttpSession session) throws Exception {
        System.out.println("/user/checkUser : POST");

        System.out.println(user);

        //Business Logic
        User dbUser = userService.getUser(user.getUserId());

        if(dbUser == null) {
            //DB에 없는 회원이면 추가정보 입력 후 회원추가
            session.setAttribute("user", user);

            return "/user/addNaverUser";

        }else {
            //DB에 있는 회원이면 바로 로그인
            return "/user/naverLoginSuccess";
        }
    }
}


