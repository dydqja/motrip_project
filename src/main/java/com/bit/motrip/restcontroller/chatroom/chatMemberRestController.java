package com.bit.motrip.restcontroller.chatroom;

import com.bit.motrip.domain.ChatMember;
import com.bit.motrip.domain.User;
import com.bit.motrip.service.chatroom.ChatMemberService;
import com.bit.motrip.service.chatroom.ChatRoomService;
import com.bit.motrip.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
@RestController
@RequestMapping("/chatMember/*")
public class chatMemberRestController {

    @Autowired
    @Qualifier("chatMemberServiceImpl")
    private ChatMemberService chatMemberService;
    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;
    public chatMemberRestController() {
        System.out.println(this.getClass());
    }


//    @RequestMapping(value = "/json/kickMember", method = RequestMethod.GET)
//    public void kickChatMember(@RequestParam("chatRoomNo") int chatRoomNo,
//                               @RequestParam("userId") String userId) throws Exception {
//        // 메서드 내용
//        System.out.println("GET : json/kickMember");
//        System.out.println("Chat Room No: " + chatRoomNo);
//        System.out.println("User ID: " + userId);
//
//        chatMemberService.kickChatMember(chatRoomNo, userId, true);
//    }
    @RequestMapping(value = "/json/kickMember", method = RequestMethod.POST)
    @ResponseBody
    public void  kickChatMember(@RequestBody ChatMember request) throws Exception {

            chatMemberService.kickChatMember(request.getChatRoomNo(), request.getUserId(), true);


    }

    @RequestMapping(value="json/fetchChatMembers/{chatRoomNo}" , method=RequestMethod.GET )
    public List<ChatMember> fetchChatMembers(@PathVariable int chatRoomNo) throws Exception {
        // 메서드 내용
        System.out.println("GET : json/fetchChatMembers");
        System.out.println(chatRoomNo);
        //여기서 해야하는일 for 문돌려서 가져와서 사진 찾아와서 붙여주기

        return chatMemberService.chatMemberList(chatRoomNo);
    }
    @RequestMapping(value="json/iconChatMembers/{chatRoomNo}" , method=RequestMethod.GET )
    public List<User> iconChatMembers(@PathVariable int chatRoomNo) throws Exception {
        // 메서드 내용
        System.out.println("GET : json/iconChatMembers");
        System.out.println(chatRoomNo);
        List<User> userList = new ArrayList<User>();
        //여기서 해야하는일 for 문돌려서 가져와서 사진 찾아와서 붙여주기
        for (ChatMember chm : chatMemberService.chatMemberList(chatRoomNo)) {
            userList.add(userService.getUserById(chm.getUserId()));
        }
        System.out.println(userList);
        return userList;
    }
}
