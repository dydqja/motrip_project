
package com.bit.motrip.restcontroller.chatroom;

import com.bit.motrip.domain.ChatMember;
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

    @RequestMapping(value="json/updateStatus", method= RequestMethod.POST)
    public int updateStatus(@RequestBody ChatRoom chatRoom) throws Exception{
        System.out.println("updateStatus");
        if(chatRoom.getChatRoomStatus() == 0){
            chatRoomService.changeRoomStatus(1,chatRoom.getChatRoomNo());
        }else if (chatRoom.getChatRoomStatus() == 1){
            chatRoomService.changeRoomStatus(0,chatRoom.getChatRoomNo());
        }else if (chatRoom.getChatRoomStatus() == 2){
            chatRoomService.changeRoomStatus(2,chatRoom.getChatRoomNo());
        }
        return chatRoom.getChatRoomStatus();
    }

}
