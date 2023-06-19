package com.bit.motrip.controller.chatroom;

import com.bit.motrip.common.Page;
import com.bit.motrip.common.Search;
import com.bit.motrip.domain.ChatMember;
import com.bit.motrip.domain.ChatRoom;
import com.bit.motrip.domain.User;
import com.bit.motrip.service.chatroom.ChatMemberService;
import com.bit.motrip.service.chatroom.ChatRoomService;
import com.bit.motrip.service.tripplan.TripPlanService;
import com.bit.motrip.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@CrossOrigin
@Controller
@RequestMapping("/chatRoom/*")
public class ChatRoomController {

    @Autowired
    @Qualifier("chatRoomServiceImpl")
    private ChatRoomService chatRoomService;
    @Autowired
    @Qualifier("tripPlanServiceImpl")
    private TripPlanService tripPlanService;
    @Autowired
    @Qualifier("chatMemberServiceImpl")
    private ChatMemberService chatMemberService;
    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;
    public ChatRoomController(){
        System.out.println("==> ChatRoomController default Constructor call....");
    }//chatroom 생성자
    @GetMapping("chatRoomList")
    public String chatRoomList( @ModelAttribute("search") Search search
//                                HttpSession session
            ,Model model) throws Exception{
//        User sessionUser = (User) session.getAttribute("user");
//        System.out.println(sessionUser);
        System.out.println("searchTravelStartDate ::::: "+search.getSearchTravelStartDate());
        if(search.getCurrentPage() == 0){

            search.setCurrentPage(1);
        }
//        if(search.getSearchKeyword() == null){
//            search.setSearchKeyword('');
//        }
        System.out.println(search);
        System.out.println(search.getGender());
        int pageSize = 3;
        search.setPageSize(pageSize);

        Map<String, Object> chatRoomListData = chatRoomService.chatRoomListPage(search);

        int totalCount = (int) chatRoomListData.get("totalCount");

        // 화면 하단에 표시할 페이지 수
        int pageUnit = 3;

        // maxPage, beginUnitPage, endUnitPage 연산
        Page page = new Page(search.getCurrentPage(), totalCount, pageUnit, pageSize);

        // 총 페이지 수
        int maxPage = page.getMaxPage();

        // 화면 하단에 표시할 페이지의 시작 번호
        int beginUnitPage = page.getBeginUnitPage();

        // 화면 하단에 표시할 페이지의 끝 번호
        int endUnitPage = page.getEndUnitPage();

        model.addAttribute("list",chatRoomListData.get("list"));
        model.addAttribute("page", page);
        model.addAttribute("maxPage", maxPage);
        model.addAttribute("beginUnitPage", beginUnitPage);
        model.addAttribute("endUnitPage", endUnitPage);
        model.addAttribute("search",search);
        //model.addAttribute("user",user);
        System.out.println(page);
        System.out.println(maxPage);
        System.out.println(beginUnitPage);
        System.out.println(endUnitPage);
        System.out.println(totalCount);
        System.out.println(search);
        return "chatroom/chatRoomList2.jsp";
    }

    @PostMapping("chat")
    public String chat(@ModelAttribute("chatRoom") ChatRoom chatRoom,
//                       @RequestParam("userId") String userId,
                       HttpSession session
            , Model model) throws Exception{
        User sessionUser = (User) session.getAttribute("user");
        System.out.println(sessionUser);
        ChatRoom ch = chatRoomService.getChatRoom(chatRoom.getChatRoomNo());
        System.out.println(ch);
        ChatMember author = chatMemberService.getChatMemberAuthor(chatRoom.getChatRoomNo());
        List<ChatMember> chatMemberList = chatMemberService.chatMemberList(chatRoom.getChatRoomNo());
        System.out.println("images::"+userService.getUserById(sessionUser.getUserId()).getUserPhoto());
        //tripPlan 보내기
        System.out.println("채팅방에서 tripplan정보 가져오기 테스트:" + tripPlanService.selectTripPlan(ch.getTripPlanNo()));
        model.addAttribute("tripPlan",tripPlanService.selectTripPlan(ch.getTripPlanNo()));
        model.addAttribute("username",sessionUser.getUserId()); //유저 name으로 userId 전송
//        model.addAttribute("username",userId); //유저 name으로 userId 전송
        model.addAttribute("usernickname",sessionUser.getNickname()); //유저 name으로 userId 전송
        model.addAttribute("chatRoom",ch); //채팅방 객체 전송
        model.addAttribute("chatMembers",chatMemberList);
        model.addAttribute("author",author);
        model.addAttribute("images",userService.getUserById(sessionUser.getUserId()).getUserPhoto());
        System.out.println("chatRoomNo"+chatRoom.getChatRoomNo());
        System.out.println(author.getUserId());
        int flag = 0;
        //chatMemberService.getChatMember()
        for (ChatMember chm:chatMemberList) {
            if(chm.getUserId().equals(sessionUser.getUserId())){ //userId
                flag = 1;
                if(chm.getStatus() == 1 ){
                    flag = 2;
                }
            }
        }
        if(flag == 0){
            return "redirect:/chatRoom/chatRoomList";
        } else if (flag == 1) {
            return "chatroom/chatRoom.jsp";
        }else {
            return "redirect:/chatRoom/chatRoomList";
        }
    }

    //chatRoom/getChat?chatRoomNo=1&userId=1
    @GetMapping("getChat")
    public String getChat(@RequestParam("chatRoomNo") String chatRoomNo,
                          HttpSession session,
                          Model model) throws Exception{
        System.out.println("getChat이 돌았습니다.");
        User sessionUser = (User) session.getAttribute("user");
        System.out.println(sessionUser);
        ChatRoom chatRoom = chatRoomService.getChatRoom(Integer.parseInt(chatRoomNo));
        ChatRoom ch = chatRoomService.getChatRoom(chatRoom.getChatRoomNo());
        System.out.println(ch);
        ChatMember author = chatMemberService.getChatMemberAuthor(chatRoom.getChatRoomNo());
        List<ChatMember> chatMemberList = chatMemberService.chatMemberList(chatRoom.getChatRoomNo());
        //tripPlan 보내기
        System.out.println("채팅방에서 tripplan정보 가져오기 테스트:" + tripPlanService.selectTripPlan(ch.getTripPlanNo()));
        model.addAttribute("tripPlan",tripPlanService.selectTripPlan(ch.getTripPlanNo()));
        model.addAttribute("username",sessionUser.getUserId()); //유저 name으로 userId 전송
//        model.addAttribute("username",userId); //유저 name으로 userId 전송
        model.addAttribute("chatRoom",ch); //채팅방 객체 전송
        model.addAttribute("chatMembers",chatMemberList);
        model.addAttribute("author",author);
        System.out.println("chatRoomNo"+chatRoom.getChatRoomNo());
        System.out.println(author.getUserId());
        int flag = 0;
        //chatMemberService.getChatMember()
        for (ChatMember chm:chatMemberList) {
            if(chm.getUserId().equals(sessionUser.getUserId())){ //userId
                flag = 1;
                if(chm.getStatus() == 1 ){
                    flag = 2;
                }
            }
        }
        if(flag == 0){
            return "redirect:/chatRoom/chatRoomList";
        } else if (flag == 1) {
            return "chatroom/chatRoom.jsp";
        }else {
            return "redirect:/chatRoom/chatRoomList";
        }
    }



    // 채팅방
    //chatRoom/addChatRoom
    @GetMapping("addChatRoom")
    public String addChatRoom(@RequestParam("userId") String userId,
                              @RequestParam("tripPlanNo") int tripPlanNo,Model model) throws Exception{
        System.out.println("/chatRoom/addChatRoom/GET");
        System.out.println("userId : "+ userId);
        System.out.println("tripPlanNo : "+ tripPlanNo);
        model.addAttribute("userId",userId);
        model.addAttribute("tripPlanNo",tripPlanNo);
        return "chatroom/addChatRoom2.jsp";
    }//채팅방 생성 페이지
    @PostMapping("addChatRoom")
    public String addChatRoom(@ModelAttribute("chatRoom") ChatRoom chatRoom,
                              @RequestParam("userId") String userId,
                              @RequestParam("tripPlanNo") int tripPlanNo,
                              // @RequestParam("travelStartDateHtml") String travelStartDateHtml,
                              Model model) throws Exception{
        System.out.println("/chatRoom/addChatRoom/POST");
        //System.out.println(travelStartDateHtml);
        //Date에 값 파싱해서 넣어주는 코드
        //chatRoom.setTravelStartDate(new SimpleDateFormat("yyyy-MM-dd").parse(travelStartDateHtml));

        ChatRoom NewchatRoom = chatRoomService.getChatRoom(chatRoomService.addChatRoom(chatRoom,userId,tripPlanNo));
        model.addAttribute("chatRoom", NewchatRoom);
        model.addAttribute("chatMember",chatMemberService.getChatMember(NewchatRoom.getChatRoomNo()));
        return "redirect:/chatRoom/chatRoomList";
    }//채팅방 생성 후

    @GetMapping("updateChatRoom")
    public String updateChatRoom(@RequestParam("chatRoomNo") int chatRoomNo,
                                 Model model) throws Exception{
        System.out.println("getUpdateChatRoom");
        ChatRoom chatRoom = chatRoomService.getChatRoom(chatRoomNo); //chatroomno => chatroom

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MM/dd/yyyy");
        String strDate = simpleDateFormat.format(chatRoom.getTravelStartDate());
        chatRoom.setStrDate(strDate);

        int tripPlanNo = chatRoom.getTripPlanNo(); // chatroom => gettripplanno => chatmember에 삽입
        model.addAttribute("chatRoom",chatRoom);
        model.addAttribute("tripPlanNo",tripPlanNo);
        return "chatroom/updateChatRoom.jsp";
    }
    @PostMapping("updateChatRoom")
    public String updateChatRoom(@ModelAttribute("chatRoom") ChatRoom chatRoom,
//                                 @RequestParam("travelStartDateHtml") String travelStartDateHtml,
                                 Model model) throws Exception{
//        chatRoom.setTravelStartDate(new SimpleDateFormat("yyyy-MM-dd").parse(travelStartDateHtml));
        chatRoomService.updateChatRoom(chatRoom);
        //채팅방 이름 변경 x & 나이대,인원수,여행번호,날짜 변경 가능
        return "redirect:/chatRoom/chatRoomList";
    }

    @GetMapping("deleteChatRoom")
    public String deleteChatRoom(@RequestParam("userId") String userId,
                                 @RequestParam("chatRoomNo") int chatRoomNo ) throws Exception{
        //방장이고 채팅방 번호가 같다면 delete chatRoomNo => 멤버도 같이 삭제
        System.out.println("deleteChatRoomController");
        int flag = chatRoomService.deleteChatRoom(chatRoomNo,userId);
        if(flag == 1){
            System.out.println("success");
        }else{
            System.out.println("fail");
        }
        return "redirect:/chatRoom/chatRoomList";
    }

    @GetMapping("video")
    public String video(@ModelAttribute("chatRoom") ChatRoom chatRoom,
                        // @RequestParam("userId") String userId,
                        Model model) throws Exception{
//        ChatRoom ch2 = chatRoomService.getChatRoom(chatRoom.getChatRoomNo());
//        System.out.println(ch2);
//        ChatMember author = chatMemberService.getChatMemberAuthor(chatRoom.getChatRoomNo());
//        List<ChatMember> chatMemberList = chatMemberService.chatMemberList(chatRoom.getChatRoomNo());
//        model.addAttribute("username",userId); //유저 name으로 userId 전송
//        model.addAttribute("chatRoom",ch2); //채팅방 객체 전송
//        model.addAttribute("chatMembers",chatMemberList);
//        model.addAttribute("author",author);
//        System.out.println("chatRoomNo"+chatRoom.getChatRoomNo());
//        System.out.println("chatuserId : "+userId);
//        System.out.println(author.getUserId());

        return "chatroom/videoRoom.jsp";

    } // 채팅방

    // 완료 -> delete 완성 : 채팅방에 옮기기
    // 할 일--------------금----------------------------
    // 채팅방 -> update, ***kick  -> 오전
    // 멤버  -> 오후
    // chatRoomList -> 추가사항 적용해야 할 듯 ?
    // 사진 DB에 저장하기 (MYSQL) , 사진 불러오기 (MYSQL) !! 금방하고
    //--------------------토--------------------------
    // 추가 기능 > socket.io + webRTC 이용해서 음성채팅 구현
    // db에서 채팅방에 참여한 유저들 표시해주기
    // 현재 참여 유저 표시
    // 추가 기능 -> vision api 이용해서 검열하기

    @GetMapping("myChatRoomList")
    public String myChatRoomList( @ModelAttribute("search") Search search, HttpSession session
            ,Model model) throws Exception{
        User sessionUser = (User) session.getAttribute("user");
        System.out.println(sessionUser);

        if(search.getCurrentPage() == 0){

            search.setCurrentPage(1);
        }
//        if(search.getSearchKeyword() == null){
//            search.setSearchKeyword('');
//        }
        System.out.println(search);
        System.out.println(search.getGender());
        int pageSize = 3;
        search.setPageSize(pageSize);

        Map<String, Object> chatRoomListData = chatRoomService.myChatRoomListPage(search,sessionUser.getUserId());

        int totalCount = (int) chatRoomListData.get("totalCount");

        // 화면 하단에 표시할 페이지 수
        int pageUnit = 3;

        // maxPage, beginUnitPage, endUnitPage 연산
        Page page = new Page(search.getCurrentPage(), totalCount, pageUnit, pageSize);

        // 총 페이지 수
        int maxPage = page.getMaxPage();

        // 화면 하단에 표시할 페이지의 시작 번호
        int beginUnitPage = page.getBeginUnitPage();

        // 화면 하단에 표시할 페이지의 끝 번호
        int endUnitPage = page.getEndUnitPage();

        model.addAttribute("chatRoomList",chatRoomListData.get("list"));
        model.addAttribute("chatRoomPage", page);
        model.addAttribute("chatRoomMaxPage", maxPage);
        model.addAttribute("chatRoomBeginUnitPage", beginUnitPage);
        model.addAttribute("chatRoomEndUnitPage", endUnitPage);
        model.addAttribute("chatRoomSearch",search);
        //model.addAttribute("user",user);
        System.out.println(page);
        System.out.println(maxPage);
        System.out.println(beginUnitPage);
        System.out.println(endUnitPage);
        System.out.println(totalCount);
        System.out.println(search);
        return "user/getUser.jsp";
    }
}// ChatRoomController 종료
