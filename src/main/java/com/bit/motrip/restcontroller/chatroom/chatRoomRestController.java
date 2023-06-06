
package com.bit.motrip.restcontroller.chatroom;

import com.bit.motrip.domain.ChatRoom;
import com.bit.motrip.service.chatroom.ChatMemberService;
import com.bit.motrip.service.chatroom.ChatRoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/chatRoom/*")
public class chatRoomRestController {
    @Autowired
    @Qualifier("chatRoomServiceImpl")
    private ChatRoomService chatRoomService;
    @Autowired
    @Qualifier("chatMemberServiceImpl")
    private ChatMemberService chatMemberService;

    @RequestMapping( value="json/getList", method= RequestMethod.POST  )
    public List<ChatRoom> getList() throws Exception{
        List<ChatRoom> li = chatRoomService.chatRoomListPage();
        return li;
    }

}
