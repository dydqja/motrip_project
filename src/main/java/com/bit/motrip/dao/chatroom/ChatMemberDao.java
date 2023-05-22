package com.bit.motrip.dao.chatroom;

import com.bit.motrip.domain.ChatMember;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;
@Mapper
public interface ChatMemberDao {
    //멤버생성
    public void addChatMember(ChatMember chatMember) throws Exception;
    // 채팅방 나가기
    public void deleteChatMember(int chatRoomNo, String userId) throws Exception;
    // 멤버 강제퇴장
    public void outChatMember(int chatRoomNo, String userId, boolean isChatRoomAuthor) throws Exception;
    // 멤버리스트
    public List<ChatMember>  chatMemberList(int chatRoomNo) throws Exception;
}
