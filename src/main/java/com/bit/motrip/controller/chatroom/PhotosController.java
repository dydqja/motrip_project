package com.bit.motrip.controller.chatroom;

import com.bit.motrip.domain.Photos;
import com.bit.motrip.service.chatroom.ChatRoomService;
import com.bit.motrip.service.chatroom.PhotosService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@CrossOrigin
@Controller
@RequestMapping("/photos/*")
public class PhotosController {
    @Autowired
    @Qualifier("photosServiceImpl")
    private PhotosService photosService;
    @Autowired
    @Qualifier("chatRoomServiceImpl")
    private ChatRoomService chatRoomService;
    public PhotosController(){
        System.out.println("==> ChatRoomController default Constructor call....");
    }//chatroom 생성자
    @GetMapping("addPhotos")
    public void addPhotos() throws Exception{
        System.out.println("addPhotos");
    }//채팅방 생성 페이지

    @GetMapping("roomPhotos")
    public String roomPhotos(@RequestParam("chatRoomNo") int chatRoomNo,
                           Model model) throws Exception{
        System.out.println(photosService.listPhotos(chatRoomNo));
        model.addAttribute("photos",photosService.listPhotos(chatRoomNo));
        model.addAttribute("chatRoomTitle",chatRoomService.getChatRoom(chatRoomNo).getChatRoomTitle());
        System.out.println("roomPhotosEND");
        return "chatroom/photos2.jsp";
    }
}
