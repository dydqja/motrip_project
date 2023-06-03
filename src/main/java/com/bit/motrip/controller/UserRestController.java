package com.bit.motrip.controller;

import com.bit.motrip.domain.*;
import com.bit.motrip.service.evaluateList.EvaluateListService;
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

import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@RestController
@RequestMapping("/user/*")
public class UserRestController {

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

    @Autowired
    @Qualifier("evaluateListServiceImpl")
    private EvaluateListService evaluateListService;

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
        System.out.println("/user/checkNickname : POST");

        int checkNickname = userService.checkNickname(nickname);
        System.out.println(checkNickname);

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

    @RequestMapping(value = "checkUser", method = RequestMethod.POST)
    public String checkUser(@RequestBody User user, HttpSession session) throws Exception {
        System.out.println("/user/checkUser : POST");

        System.out.println(user);

        //Business Logic
        User dbUser = userService.getUserById(user.getUserId());

        if (dbUser == null) {
            //DB에 없는 회원이면 추가정보 입력 후 회원추가
            session.setAttribute("user", user);

            return "/user/addNaverUser";

        } else {
            //DB에 있는 회원이면 바로 로그인
            return "/user/naverLoginSuccess";
        }
    }

    // 유저평가값 가져와서 값에따라 버튼 비교한다
    @RequestMapping(value = "evaluateState", method = RequestMethod.POST)
    public String evaluateState(@RequestBody Map<String, String> request) throws Exception {
        System.out.println("/user/evaluateState : POST");

        String sessionUserId = request.get("sessionUserId");
        String getUserId = request.get("getUserId");


        String evaluateState = evaluateListService.evaluateState(sessionUserId, getUserId);
        System.out.println("return 된 evaluateState 값은 ? => : " + evaluateState);

        return evaluateState;
    }

    // 회원 좋아요취소 또는 싫어요취소 클릭시 평가데이터 삭제한다
    @RequestMapping(value = "userEvaluateCancle", method = RequestMethod.POST)
    public @ResponseBody String userEvaluateCancle(@RequestBody Map<String, String> request) throws Exception {
        System.out.println("/user/userEvaluateCancle : POST");

        String sessionUserId = request.get("sessionUserId");
        String getUserId = request.get("getUserId");

        //좋아요 또는 싫어요 데이터 삭제한다
        evaluateListService.userEvaluateCancle(sessionUserId, getUserId);
        //평가점수 합산해서 가져온다
        String getScorePlus = evaluateListService.getScorePlus(getUserId);
        System.out.println(getScorePlus);

        return getScorePlus;
    }

    // 회원 좋아요 또는 싫어요 클릭시 평가데이터 추가한다
    @RequestMapping(value = "addEvaluation", method = RequestMethod.POST)
    public @ResponseBody String addEvaluation(@RequestBody EvaluateList evaluateList) throws Exception {
        System.out.println("/user/addEvaluation : POST");
        System.out.println(evaluateList);
        String getUserId = evaluateList.getEvaluatedUserId();

        evaluateListService.addEvaluation(evaluateList);
        System.out.println("addEvaluation 완료");
        //평가점수 합산해서 가져온다
        String getScorePlus = evaluateListService.getScorePlus(getUserId);
        System.out.println(getScorePlus);

        return getScorePlus;
    }

    // 블랙리스트 추가
    @RequestMapping(value = "addBlacklist", method = RequestMethod.POST)
    public @ResponseBody String addBlackList(@RequestBody EvaluateList evaluateList) throws Exception {
        System.out.println("/user/addBlacklist : POST");
        System.out.println(evaluateList);

        evaluateListService.addEvaluation(evaluateList);
        System.out.println("addBlacklist 완료");

        return "";
    }

    // 블랙리스트 삭제
    @RequestMapping(value = "deleteBlacklist", method = RequestMethod.POST)
    public @ResponseBody String deleteBlacklist(@RequestBody EvaluateList evaluateList) throws Exception {
        System.out.println("/user/deleteBlacklist : POST");
        System.out.println(evaluateList);

        evaluateListService.deleteBlacklist(evaluateList);
        System.out.println("deleteBlacklist 완료");

        return "";
    }

    // 유저블랙리스트값 가져와서 값에따라 버튼 비교한다
    @RequestMapping(value = "blacklistState", method = RequestMethod.POST)
    public String blacklistState(@RequestBody Map<String, String> request) throws Exception {
        System.out.println("/user/blacklistState : POST");

        String sessionUserId = request.get("sessionUserId");
        String getUserId = request.get("getUserId");


        String blacklistState = evaluateListService.blacklistState(sessionUserId, getUserId);
        System.out.println("return 된 blacklistState 값은 ? => : " + blacklistState);

        return blacklistState;
    }

    @RequestMapping(value = "updateUser", method = RequestMethod.POST)
    public @ResponseBody User updateUser(@ModelAttribute User user) throws Exception {
        System.out.println("/user/updateUser : POST");
        System.out.println(user);

        if (user.getPhone() == null || user.getPhone() == "" || user.getPhone().equals("") || user.getPhone().equals(null)) {

            User getUser = userService.getUserById(user.getUserId());
            user.setPhone(getUser.getPhone());

        }else if (user.getPwd() == null || user.getPwd() == "" || user.getPwd().equals("") || user.getPwd().equals(null)) {

            User getUser = userService.getUserById(user.getUserId());
            user.setPwd(getUser.getPwd());
        }else {
            userService.updateUser(user);
        }

        return user;
    }

    @RequestMapping(value = "getBlacklist", method = RequestMethod.POST)
    public List<String> getBlacklist(@RequestBody Map<String, Object> evaluaterId) throws Exception {
        System.out.println("/user/getBlacklist : POST");

        List<EvaluateList> getBlacklist = evaluateListService.getEvaluation(evaluaterId);

        List<String> blacklist = new ArrayList<>();
        for (EvaluateList evaluateList1 : getBlacklist) {
            if (evaluateList1.getBlacklistedUserId() != null) {
                blacklist.add(evaluateList1.getBlacklistedUserId());
            }
        }
        System.out.println(getBlacklist);
        System.out.println(blacklist);

        List<String> getNickname = userService.getNickname(blacklist);

        System.out.println(getNickname);

        return getNickname;
    }
}





