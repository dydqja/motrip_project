package com.bit.motrip.dao.memo;

import com.bit.motrip.domain.Memo;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class MemoDaoTest {
    @Autowired
    private MemoDao memoDao;

    //insert test
    @Test
    void addMemo() throws Exception{
        Memo memo = new Memo();
        memo.setMemoTitle("test1");
        memo.setMemoContents("test");
        memo.setMemoColor(0);
        memoDao.addMemo(memo);
    }
    //@Test
    //select test
    void getMemoList() throws Exception{
        Memo firstMemo = memoDao.getMemoList().get(0);
        System.out.println(firstMemo.getMemoTitle());
    }
}