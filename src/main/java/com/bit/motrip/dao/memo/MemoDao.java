package com.bit.motrip.dao.memo;

import com.bit.motrip.domain.Memo;
import com.bit.motrip.domain.TripPlan;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MemoDao {
    //add 후 memoNo를 리턴해야 함
    public int addMemo(Memo memo) throws Exception;
    public Memo getMemo(int memoNo) throws Exception;
    public List<Memo> getMemoList() throws Exception;
    public int deleteMemo(int memoNo) throws Exception;


    public void updateMemo(Memo memo);
}
