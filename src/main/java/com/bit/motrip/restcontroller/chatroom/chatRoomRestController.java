
package com.bit.motrip.restcontroller.chatroom;

import com.bit.motrip.common.Page;
import com.bit.motrip.common.Search;
import com.bit.motrip.domain.ChatMember;
import com.bit.motrip.domain.ChatRoom;
import com.bit.motrip.service.chatroom.ChatMemberService;
import com.bit.motrip.service.chatroom.ChatRoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;
//papago
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
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
    @RequestMapping(value="json/translate/{msg}", method= RequestMethod.POST)
    public String translate(@PathVariable String msg) throws Exception{
        String clientId = "d47k3314wx";//애플리케이션 클라이언트 아이디값";
        String clientSecret = "6UJlLVSxtsWrHcKpbJqps7Lp6w3qnEkdz9UqwOb8";//애플리케이션 클라이언트 시크릿값";
        try {
            String text = URLEncoder.encode(msg, "UTF-8");
            String apiURL = "https://naveropenapi.apigw.ntruss.com/nmt/v1/translation";
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("X-NCP-APIGW-API-KEY-ID", clientId);
            con.setRequestProperty("X-NCP-APIGW-API-KEY", clientSecret);
            // post request
            String postParams = "source=ko&target=en&text=" + text;
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            wr.writeBytes(postParams);
            wr.flush();
            wr.close();
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 오류 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            System.out.println(response.toString());
            return response.toString();
        } catch (Exception e) {
            System.out.println(e);
        }
        return msg;
    }


}
