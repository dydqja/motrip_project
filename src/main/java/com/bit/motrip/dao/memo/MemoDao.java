package com.bit.motrip.dao.memo;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.Memo;
import com.bit.motrip.domain.MemoAccess;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Qualifier;

import java.util.List;

@Mapper
@Qualifier("memoDao")
public interface MemoDao {
    //memo
    int addMemo(Memo memo) throws Exception;
    Memo getMemo(int memoNo) throws Exception;
    int deleteMemo(int memoNo) throws Exception;
    int removeMemo(int memoNo) throws Exception;
    int restoreMemo(int memoNo) throws Exception;
    int updateMemo(Memo memo);
    //메모를 부착시키는 기능은 memo 의 attached 썸띵을 수정하는 것으로 update 에서 해결한다.
    int updateMemoAttach(Memo memo);



    //조건에 맞는 쿼리 3개를 준비해두고 search 조건에 따라 Service 에서 무엇을 부를지 논리를 돌릴것이다.
    //추가적으로 Page 단위로 뽑아야 하기 때문에 Page정보를 보내기 위한 search도 함께 보낸다.
    //구성할 Search의 조건
    //searchKeyword = UserId / 만약 늘어나면 keywords 로 필드를 바꾸고 어레이로 변경할 것.
    //searchCondition
    List<Memo> getMemoListByMyMemo(Search search) throws Exception;
    List<Memo> getMemoListBySharedMemo(Search search) throws Exception;
    List<Memo> getMemoListByDeletedMemo(Search search) throws Exception;


    //memoAccess 메모의 공유권한을 관리한다.

    //memo author 전용. 단, get 에서 author 정보를 이미 갖고 있기 때문에 오직 author 만 이 메소드에 접근할 수 있도록 화면단에서 컷칠 수 있다.
    int addMemoAccess(MemoAccess memoAccess) throws Exception;
    //다른 사람에게 공유해줌

    int deleteMemoAccess(MemoAccess memoAccess) throws Exception;
    //다른 사람에 대한 공유를 해제함.

    List<MemoAccess> getMemoAccessListByMemoNo(int memoNo) throws Exception;
    //현재 이 메모를 공유받고 사람이 누가 있는지 알 때 쓴다.

    int crodDelMemo(String gracePeriodDays) throws Exception;

}
