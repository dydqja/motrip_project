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
    //add 후 memoNo를 리턴해야 함
    int addMemo(Memo memo) throws Exception;
    //    int addMemo(@Param("memo")Memo memo, @Param("memoAccess")MemoAccess memoAccess) throws Exception;
    Memo getMemo(int memoNo) throws Exception;
    int getMaxMemoNo() throws Exception;
    int getMaxMemoAccessNo() throws Exception;
    List<Memo> getMemoList(String userId, Search search) throws Exception;
    int deleteMemo(int memoNo) throws Exception;
    int updateMemo(Memo memo);
    int addMemoAccess(MemoAccess memoAccess) throws Exception;
}
