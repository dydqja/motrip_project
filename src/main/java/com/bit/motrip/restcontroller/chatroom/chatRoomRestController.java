
package com.bit.motrip.restcontroller.chatroom;

import com.bit.motrip.domain.ChatRoom;
import com.bit.motrip.service.chatroom.ChatMemberService;
import com.bit.motrip.service.chatroom.ChatRoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/chatRoom/*")
public class chatRoomRestController {
    @Autowired
    @Qualifier("chatRoomServiceImpl")
    private ChatRoomService chatRoomService;
    @Autowired
    @Qualifier("chatMemberServiceImpl")
    private ChatMemberService chatMemberService;

//    @RequestMapping( value="json/getList", method= RequestMethod.POST  )
//    public List<ChatRoom> getList() throws Exception{
//        List<ChatRoom> li = chatRoomService.chatRoomListPage();
//
//        return li;
//    }
    @RequestMapping( value="json/getListCount", method= RequestMethod.POST  )
    public int getListCount() throws Exception{
        int count = chatRoomService.chatRoomCount();

        return count;
    }

}
