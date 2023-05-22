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
    //    int addMemo(@Param("memo")Memo memo, @Param("memoAccess")MemoAccess memoAccess) throws Exception;
    Memo getMemo(int memoNo) throws Exception;
    List<Memo> getMemoList(Search search) throws Exception;
    int deleteMemo(int memoNo,String userId) throws Exception;
    int updateMemo(Memo memo);

    //memoAccess

    //다른 사람에게 공유해줌
    int addMemoAccess(MemoAccess memoAccess) throws Exception;
    //다른 사람에 대한 공유를 해제함.
    int deleteMemoAccess(MemoAccess memoAccess) throws Exception;

    List<MemoAccess> getMemoAccessListByMemoNo(int memoNo) throws Exception;
    List<MemoAccess> getMemoAccessListByUserId(String userId) throws Exception;

}
