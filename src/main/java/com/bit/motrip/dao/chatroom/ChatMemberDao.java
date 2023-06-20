package com.bit.motrip.dao.chatroom;

import com.bit.motrip.domain.ChatMember;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;
import java.util.List;
@Mapper
public interface ChatMemberDao {
    //멤버생성
    public void addChatMember(ChatMember chatMember) throws Exception;
    //멤버 가져오기
    public ChatMember getChatMember(int chatRoomNo) throws Exception;
    //채팅방 방장 정보 가져오기
    public ChatMember getChatMemberAuthor(int chatRoomNo) throws Exception;
    // 채팅방 나가기
    public void deleteChatMember(int chatRoomNo, String userId) throws Exception;
    // 멤버 강제퇴장
    public void kickChatMember(int chatRoomNo, String userId, boolean isChatRoomAuthor) throws Exception;
    // 멤버리스트
    public ArrayList<ChatMember> listChatMember(int chatRoomNo) throws Exception;

    public List<ChatMember> getChatRoomNumber(int tripPlanNo) throws Exception;
}
