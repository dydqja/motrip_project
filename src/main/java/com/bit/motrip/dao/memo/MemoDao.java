package com.bit.motrip.dao.memo;

import com.bit.motrip.domain.Memo;
import com.bit.motrip.domain.MemoAccess;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MemoDao {
    //add 후 memoNo를 리턴해야 함
    int addMemo(Memo memo) throws Exception;
    Memo getMemo(int memoNo) throws Exception;
    int getMaxMemoNo() throws Exception;
    int getMaxMemoAccessNo() throws Exception;
    List<Memo> getMemoList() throws Exception;
    int deleteMemo(int memoNo) throws Exception;
    void updateMemo(Memo memo);
    int addMemoAccess(MemoAccess memoAccess) throws Exception;
}
